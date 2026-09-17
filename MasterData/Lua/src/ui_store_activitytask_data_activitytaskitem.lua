local this = class("activityTaskItem")

function this:ctor()
  self.id = nil
  self.reward = nil
  self.groupId = nil
  self.isFinish = nil
  self.targetCount = nil
  self.describe = nil
  self.groupOrder = nil
end

return this
