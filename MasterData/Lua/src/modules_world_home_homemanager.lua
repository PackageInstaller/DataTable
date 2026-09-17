local this = class("homeManager", G_EventManagerBase)
require("modules.world.home.homeConst")
this.event = {
  triggerBuilding = "triggerBuilding",
  cropPlayExp = "cropPlayExp",
  petStationedStateChange = "petStationedStateChange"
}
local _homeObjTpl = L_GameTpl:getHomeObjTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()

function this:ctor()
  this.super.ctor(self)
  self._homeRoot = nil
  self._homePool = nil
  self._indexToBlockEntity = {}
  self._lastInteractBuildGuid = nil
  self._currInteractBuildGuid = 0
  self.selectedCropItemId = 0
end

function this:setCurrInteractId(id, forceRefresh)
  self._currInteractBuildGuid = id
  if self._lastInteractBuildGuid == self._currInteractBuildGuid and not forceRefresh then
    return
  end
  self._lastInteractBuildGuid = self._currInteractBuildGuid
  self:sendEvent(L_HomeManager.event.triggerBuilding)
end

function this:getCurrInteractId()
  return self._currInteractBuildGuid
end

function this:setCropPlayExp(pos, num)
  self:sendEvent(L_HomeManager.event.cropPlayExp, {pos = pos, num = num})
end

function this:setPetStationedSelected(petGuid)
  self:sendEvent(L_HomeManager.event.petStationedStateChange, petGuid)
end

function this:getBlockEntityByIndex(blockIndex)
  return self._indexToBlockEntity[blockIndex]
end

function this:setHomeRootActive(isActive)
  printf("设置家园宠物", isActive)
  AzurWorld.HomeMgr:SetAllPetHide(not isActive, "luaHomeManager")
  AzurWorld.HomeMgr:SetRootActive(isActive)
end

function this:_resetRoot()
  if L_CommonUtil.isValid(self._homeRoot.gameObject) then
    self._homeRoot.transform.position = L_Vector3.getTemp()
    self._homeRoot.transform:SetRelativeEulerAngles(L_Vector3.getTemp())
  end
  for _, block in pairs(self._indexToBlockEntity) do
    block:onResetRoot()
  end
end

function this:homeSpawn(path)
  return self._homePool:spawn(path)
end

function this:homeDespawn(go)
  self._homePool:despawn(go)
end

function this:asyncSpawnById(id, callback)
  local tpl = _homeObjTpl:getTplById(id)
  local path = _homeObjTpl:getObjPath(tpl)
  self._homePool:asyncSpawn(path, callback, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function this:getBuildingEntityByGuid(guid)
  for i, v in pairs(self._indexToBlockEntity) do
    if v.buildPart and v.buildPart:getAllBuildingEntity()[guid] then
      return v.buildPart:getAllBuildingEntity()[guid]
    end
  end
end

function this:setEditMode(homeMode, editPart)
  self._homeMode = homeMode
  for i, v in pairs(self._indexToBlockEntity) do
    if v.blockType == L_HomeConst.blockType.BUILD then
      v.buildPart:showPlayerEdit(homeMode == L_Const.HomeEditorMode.playerEditor and editPart == v.editPart)
    end
  end
end

function this:getHomeMode()
  return self._homeMode
end

function this:getBuildTypeById(buildId)
  local tpl_building = _homeBuildingTpl:getTplById(buildId)
  local groupId = _homeBuildingTpl:getGroupId(tpl_building)
  local tpl_buildingGroup = _homeBuildingGroupTpl:getTplById(groupId)
  local buildingType = _homeBuildingGroupTpl:getType(tpl_buildingGroup)
  return buildingType
end

function this:registerBuildingUpgradeConditionGroupByBuildingId(buildingId)
  self.buildingId2ConditionGroupNode = {}
  local homeBuildingTpl = _homeBuildingTpl:getTplById(buildingId)
  local nextLevelBuildingId = _homeBuildingTpl:getNextLevel(homeBuildingTpl)
  local nextLevelHomeBuildingTpl = _homeBuildingTpl:getTplById(nextLevelBuildingId)
  if nextLevelHomeBuildingTpl == nil then
    printf("HomeDebug", string.format("家园建筑id:%d 所配置的下一级建筑id:%d 没有对应配置", buildingId, nextLevelBuildingId))
    return
  end
  local upgradeConditionGroup = _homeBuildingTpl:getUpgradeCondition(nextLevelHomeBuildingTpl)
  L_ConditionManager:registGroup(string.format("HomeBuildingUpgradeConditionGroup_%d", buildingId), upgradeConditionGroup, function()
    AzurWorld.HomeMgr.HudModule:OnHomeBuildingUpgradeConditionComplete(buildingId)
  end)
end

return this
