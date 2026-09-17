local this = class("fishFinish")

function this:ctor()
  self.fish_id = 0
  self.fish_weight = 0
  self.fish_status = 0
  self.rewards = nil
  self.event_id = 0
end

function this:getFishId()
  return self.fish_id
end

function this:getFishWeight()
  return self.fish_weight
end

function this:getFishStatus()
  return self.fish_status
end

function this:getRewards()
  return self.rewards.rewards
end

function this:getEventId()
  return self.event_id
end

return this
