local this = class("noviceTaskGroupTpl")
local commonItemTpl = L_GameTpl:getCommonItemTpl()

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTaskGroupTiltleById(id)
  return L_Config:provider(self:getTplById(id).name)
end

function this:getTaskGroupTitleDescById(id)
  return L_Config:provider(self:getTplById(id).desc)
end

function this:getTaskGroupUnLockCondition(id)
  return self:getTplById(id).unlockContidion
end

function this:getTaskGroupType(id)
  return self:getTplById(id).type
end

function this:getMaxTaskGroup(type)
  local maxTaskGroup = 1
  for k, v in pairs(self.data) do
    if v.type == type and maxTaskGroup < v.id then
      maxTaskGroup = v.id
    end
  end
  return maxTaskGroup
end

function this:getTaskGroupLockTips(id, index)
  return L_Config:provider(self:getTplById(id).lockTips[index])
end

function this:getTaskGroupRewardById(id)
  local rewardList = table.clone(self:getTplById(id).reward)
  table.sort(rewardList, function(left, right)
    local leftItemId = left[2]
    local rightItemId = right[2]
    local leftType = left[1]
    local rightType = right[1]
    local leftConf = L_ItemTplManager:getItemConfig(leftType, leftItemId)
    local rightConf = L_ItemTplManager:getItemConfig(rightType, rightItemId)
    local leftQuality = leftConf.quality
    local rightQuality = rightConf.quality
    if leftQuality ~= rightQuality then
      return leftQuality > rightQuality
    elseif leftType ~= rightType then
      return leftType < rightType
    else
      return leftItemId < rightItemId
    end
  end)
  return rewardList
end

return this
