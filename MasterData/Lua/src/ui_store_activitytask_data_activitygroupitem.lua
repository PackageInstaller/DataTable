local this = class("activityGroupItem")

function this:ctor()
  self.groupId = nil
  self.finishState = 0
  self.count = nil
  self.maxCount = nil
  self.curStage = 1
  self.maxStage = 1
  self.taskType = nil
  self.curActivityId = nil
  self.child = {}
end

return this
