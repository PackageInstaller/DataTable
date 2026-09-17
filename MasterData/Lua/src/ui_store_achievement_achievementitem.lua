local this = class("achievementItem")

function this:ctor()
  self.guid = nil
  self.achievementId = nil
  self.groupId = nil
  self.isReward = nil
  self.count = nil
  self.finishTime = nil
  self.version = nil
end

return this
