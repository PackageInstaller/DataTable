local this = class("conditionNode_12039", require(L_R.condition .. "conditionNode"))
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()

function this.checkFunc(condition)
  local buildingGroupId = condition[2]
  local level = condition[3]
  local tpl = _homeBuildingTpl:getGroupData(buildingGroupId)[level]
  local buildingId = _homeBuildingTpl:getId(tpl)
  return L_HomeStore:getHomeBuildingByConfigId(buildingId) ~= nil
end

function this.descFunc(key, condition)
  local buildingGroupId = condition[2]
  local level = condition[3]
  local tpl = _homeBuildingGroupTpl:getTplById(buildingGroupId)
  return L_Lang:get(key, {
    name = _homeBuildingGroupTpl:getName(tpl),
    level = level
  })
end

return this
