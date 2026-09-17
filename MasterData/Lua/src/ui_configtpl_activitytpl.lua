local this = class("activityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPara(tpl)
  return tpl.para
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getDescription(tpl)
  return L_Config:provider(tpl.description)
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getId(tpl)
  return tpl.id
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getGroupOrder(tpl)
  return tpl.groupOrder
end

function this:getFinishCondition(tpl)
  return tpl.finishCondition
end

function this:getNextTask(tpl)
  return tpl.nextTask
end

function this:getTaskType(tpl)
  return tpl.taskType
end

function this:getActivityRewardDisplay(tpl)
  return tpl.activityRewardDisplay
end

function this:getSystemJump(tpl)
  return tpl.systemJump
end

function this:getUnlockSystemId(tpl)
  return tpl.system
end

function this:getAllData(index)
  if index == nil then
    return self.data
  else
    local data = {}
    if index == 1 then
      for i, v in pairs(self.data) do
        if v.taskType == 1 then
          table.insert(data, v)
        end
      end
    else
      for i, v in pairs(self.data) do
        if v.taskType == 2 then
          table.insert(data, v)
        end
      end
    end
    return data
  end
end

return this
