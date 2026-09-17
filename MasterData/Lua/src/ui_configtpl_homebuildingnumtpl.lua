local this = class("homeBuildingNumTpl")

function this:init(config)
  self.data = config
  self.buildingGroupId2ConfigIdList = {}
  for configId, tpl in pairs(config) do
    local buildingGroupId = tpl.groupId
    self.buildingGroupId2ConfigIdList[buildingGroupId] = self.buildingGroupId2ConfigIdList[buildingGroupId] or {}
    table.insert(self.buildingGroupId2ConfigIdList[buildingGroupId], configId)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getId(tpl)
  return tpl.id
end

function this:getUnlockConditionGroup(tpl)
  return tpl.unlockCondition
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getAddNum(tpl)
  return tpl.addNum
end

function this:getUnlockDesc(tpl)
  return L_Config:provider(tpl.unlockDesc)
end

function this:getFirstUnlockBuildingTplByGroupId(groupId)
  for _, v in pairs(self.data) do
    local tplGroupId = v.groupId
    local isFirst = v.isFirst
    if tplGroupId == groupId and isFirst == true then
      return v
    end
  end
  return nil
end

function this:getConfigIdListByBuildingGroupId(buildingGroupId)
  return self.buildingGroupId2ConfigIdList[buildingGroupId]
end

function this:getCurMaxCanBuildNumByBuildingGroupId(buildingGroupId)
  local configIdList = self.buildingGroupId2ConfigIdList[buildingGroupId]
  if configIdList == nil then
    return 0
  end
  local curMaxCanBuildNum = 0
  for _, configId in pairs(configIdList) do
    local unlockConditionGroup = self:getUnlockConditionGroup(self:getTplById(configId))
    local isComplete = L_ConditionManager:isComplete(unlockConditionGroup)
    if isComplete then
      curMaxCanBuildNum = curMaxCanBuildNum + self:getAddNum(self:getTplById(configId))
    else
      break
    end
  end
  return curMaxCanBuildNum
end

function this:getCurMaxCanBuildNumByBuildingType(buildingType)
  local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
  local buildingGroupIdList = _homeBuildingGroupTpl:getBuildingGroupIdListByBuildingType(buildingType)
  local result = 0
  for _, buildingGroupId in pairs(buildingGroupIdList) do
    local curMaxCanBuildNum = self:getCurMaxCanBuildNumByBuildingGroupId(buildingGroupId)
    result = result + curMaxCanBuildNum
  end
  return result
end

return this
