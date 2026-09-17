local this = class("moduleStationBuildingTop", G_UIModuleBase)
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _HomeRanchTpl = L_GameTpl:getHomeRanchTpl()
local _blockTpl = L_GameTpl:getHomeBlockTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _homeBuildingHomecollectionTpl = L_GameTpl:getHomeBuildingHomecollectionTpl()
local _HomeBuildingProductTpl = L_GameTpl:getHomeBuildingProductionTpl()

function this.bind()
  return {
    txt_buildName = "",
    txt_buildLevel = "",
    toggle_lvMax = false,
    active_imgOnhover = false,
    active_levelUpBtn = false,
    active_levelDec = false
  }
end

function this.methods()
  return {
    onClick_upgradeBtn = function(self)
      if self._params.stationBuildingType == L_HomeConst.StationBuildingType.Ranch then
        local ranchData = C_HomeManager:GetHomeStore():GetRanchData(self._params.blockId)
        local currLv = ranchData and ranchData.lv or 1
        if currLv >= _HomeRanchTpl:getMaxLv() then
          L_FlyMsgManager:showNormalMsgByKey("ui_pageHomeRanch_02")
          return
        end
        L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
        L_UI:open("pageBuildingUpgrade", {
          ranchBlockId = self._params.blockId
        })
        return
      end
      if self.bind.toggle_lvMax then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_manage_13"))
        return
      end
      L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
      L_UI:open("pageBuildingUpgrade", {
        guid = self._params.buildingGuid,
        collectionId = self._params.collectionId,
        focusOnBuildMainUIAfterClose = true
      })
    end,
    onPointEnter_upgradeBtn = function(self)
      self.bind.active_imgOnhover = true
    end,
    onPointExit_upgradeBtn = function(self)
      self.bind.active_imgOnhover = false
    end
  }
end

function this:open(options)
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshAll, self)
  self._params = {}
end

function this:close(options)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshAll, self)
  self.super.close(self, options)
end

function this:initModule(params)
  self._params = params or {}
  self:refreshAll()
end

function this:refreshAll()
  if self._params.stationBuildingType == L_HomeConst.StationBuildingType.Ranch then
    self:refreshRanchBuildingInfo(self._params.blockId)
  elseif self._params.stationBuildingType == L_HomeConst.StationBuildingType.Collection then
    self:refreshCollectionBuildingInfo(self._params.collectionId)
  elseif self._params.stationBuildingType == L_HomeConst.StationBuildingType.HomeCollection then
    self:refreshHomeCollectionBuildingInfo(self._params.buildId)
  else
    self:refreshHomeBuildingInfo(self._params.buildingGuid)
  end
end

function this:refreshHomeBuildingInfo(buildingGuid)
  if math.isEmpty(buildingGuid) then
    return
  end
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  local buildTpl = _HomeBuildingTpl:getTplById(serverData.build_id)
  local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
  local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
  local isMax = math.isEmpty(_HomeBuildingTpl:getNextLevel(buildTpl))
  local homeBuilding = _HomeBuildingProductTpl:getTplById(serverData.build_id)
  if homeBuilding then
    local buildGroupType = L_ProductManager:onGetHomeBuildFunctionType(homeBuilding.groupId)
    if buildGroupType == L_HomeConst.HomeBuildFunctionType.EQUIP then
      if L_DeviceTpl:getIsPc() then
        self.bindComponents.rect_root.anchoredPosition = C_Vector2(59.5, 42.7)
      else
        self.bindComponents.rect_root.anchoredPosition = C_Vector2(15.1, -50)
      end
    end
  end
  self.bind.txt_buildName = _HomeBuildingGroupTpl:getName(groupTpl)
  self.bind.toggle_lvMax = isMax
  self.bind.active_levelDec = isMax
  self.bind.active_levelUpBtn = not isMax
  self.bind.txt_buildLevel = string.concat("Lv.", _HomeBuildingTpl:getLevel(buildTpl))
end

function this:refreshRanchBuildingInfo(blockId)
  local tpl = _blockTpl:getTplById(blockId)
  local ranchData = C_HomeManager:GetHomeStore():GetRanchData(self._params.blockId)
  local lv = ranchData and ranchData.lv or 1
  local nextTpl = _HomeRanchTpl:getTplById(lv + 1)
  local isMax = not nextTpl
  self.bind.txt_buildName = L_WordsTpl:getValue("ui_modulePetInfoNew", {
    [0] = _blockTpl:getSequence(tpl)
  })
  self.bind.toggle_lvMax = isMax
  self.bind.active_levelDec = isMax
  self.bind.active_levelUpBtn = not isMax
  self.bind.txt_buildLevel = "Lv." .. lv
end

function this:refreshCollectionBuildingInfo(collectionId)
  if math.isEmpty(collectionId) then
    return
  end
  local csHomeStore = L_HomeStore:getCsHomeStore()
  local buildId = csHomeStore.WorldCollectModule:GetCollectIdByGuid(collectionId)
  if buildId == 0 then
    return
  end
  local tpl_building = _homeBuildingCollectionTpl:getTplById(buildId)
  local isMax = true
  self.bind.txt_buildName = _homeBuildingCollectionTpl:getName(tpl_building)
  self.bind.toggle_lvMax = isMax
  self.bind.active_levelDec = isMax
  self.bind.active_levelUpBtn = not isMax
  self.bind.txt_buildLevel = string.concat("Lv.", _homeBuildingCollectionTpl:getLevel(tpl_building))
end

function this:refreshHomeCollectionBuildingInfo(buildId)
  if math.isEmpty(buildId) then
    return
  end
  local tpl_building = _homeBuildingHomecollectionTpl:getTplById(buildId)
  local isMax = true
  self.bind.txt_buildName = _homeBuildingHomecollectionTpl:getName(tpl_building)
  self.bind.toggle_lvMax = isMax
  self.bind.active_levelDec = isMax
  self.bind.active_levelUpBtn = not isMax
  self.bind.txt_buildLevel = string.concat("Lv.", _homeBuildingHomecollectionTpl:getLevel(tpl_building))
end

return this
