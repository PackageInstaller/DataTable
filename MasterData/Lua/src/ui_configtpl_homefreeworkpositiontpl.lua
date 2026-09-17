local this = class("homeFreeWorkPositionTpl")

function this:init(config)
  self.data = config
  self.maxFreeWorkNum = 0
  self.freeWorkPosId2UnlockConditionList = {}
  for _, tpl in pairs(config) do
    local unlockCondition = tpl.unlockCondition
    local unlockMaxNum = tpl.num
    for i = 1, unlockMaxNum do
      self.freeWorkPosId2UnlockConditionList[i] = self.freeWorkPosId2UnlockConditionList[i] or unlockCondition
    end
    if unlockMaxNum > self.maxFreeWorkNum then
      self.maxFreeWorkNum = unlockMaxNum
    end
  end
end

function this:getTplById(configId)
  return self.data[configId]
end

function this:getUnlockConditionList(tpl)
  return tpl.unlockCondition
end

function this:getMaxFreeWorkNum()
  return self.maxFreeWorkNum
end

function this:getFreeWorkPosId2UnlockConditionList()
  return self.freeWorkPosId2UnlockConditionList
end

function this:getUnlockConditionListByFreeWorkPositionId(freeWorkPosId)
  return self.freeWorkPosId2UnlockConditionList[freeWorkPosId]
end

function this:getAllUnlockConditionList()
  local allConditionList = {}
  for _, tpl in pairs(self.data) do
    local conditionList = tpl.unlockCondition
    table.insert(allConditionList, conditionList)
  end
  return allConditionList
end

return this
