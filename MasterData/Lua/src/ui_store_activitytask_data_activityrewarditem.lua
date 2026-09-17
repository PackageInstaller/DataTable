local this = class("activityRewardItem")

function this:ctor()
  self.id = nil
  self.canReward = 0
  self.requireActivity = nil
  self.isFinish = false
  self.taskType = nil
  self.reward = {}
end

return this
