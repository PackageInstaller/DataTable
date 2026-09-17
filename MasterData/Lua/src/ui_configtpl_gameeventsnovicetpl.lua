local this = class("gameEventsNoviceTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if self.groupData[self:getSystemId(v)] == nil then
      self.groupData[self:getSystemId(v)] = {}
    end
    table.insert(self.groupData[self:getSystemId(v)], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTaskOrder(tpl)
  return tpl.TaskOrder
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getTaskName(tpl)
  return L_Config:provider(tpl.taskName)
end

function this:getUnlockTime(tpl)
  return tpl.unlockTime
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getSystemId(tpl)
  return tpl.systemId
end

function this:getLockParam(tpl)
  return tpl.lockParam
end

function this:getId(tpl)
  return tpl.id
end

function this:getLockDesc(tpl, index)
  if index then
    return L_Config:provider(tpl.lockDesc[index])
  end
  local res = {}
  for i = 1, #tpl.lockDesc do
    res[i] = L_Config:provider(tpl.lockDesc[i])
  end
  return res
end

function this:getTplBySystemId(systemId)
  return self.groupData[systemId] or {}
end

return this
