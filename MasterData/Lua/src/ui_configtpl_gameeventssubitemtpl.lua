local this = class("gameeventssubitemTpl")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getName(tpl)
  return tpl.name
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getUnlockTime(tpl)
  return tpl.unlockTime
end

function this:getTaskOrder(tpl)
  return tpl.TaskOrder
end

function this:getCommonJump(tpl)
  return tpl.commonJump
end

function this:getReward(tpl)
  return tpl.reward
end

return this
