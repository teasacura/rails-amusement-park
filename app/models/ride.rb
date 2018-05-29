class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if self.user.height < self.attraction.min_height && self.user.tickets < self.attraction.tickets
      message("You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}.")
    elsif self.user.height < self.attraction.min_height
      message("You are not tall enough to ride the #{self.attraction.name}.")
    elsif self.user.tickets < self.attraction.tickets
      message("You do not have enough tickets to ride the #{self.attraction.name}.")
    else
      # byebug
      self.user.tickets -= self.attraction.tickets
      self.user.nausea += self.attraction.nausea_rating
      self.user.happiness += self.attraction.happiness_rating
      self.user.save
    end
  end

  def message(str)
    "Sorry. #{str}"
  end
end
