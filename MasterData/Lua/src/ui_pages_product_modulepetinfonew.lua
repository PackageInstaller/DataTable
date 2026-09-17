local this = class("modulePetInfoNew", G_UIModuleBase)
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _HomeRanchTpl = L_GameTpl:getHomeRanchTpl()
local _blockTpl = L_GameTpl:getHomeBlockTpl()
local CoolieEnvType = {
  BUILDING = 1,
  COLLECTION = 2,
  CROP = 3,
  RANCH_GATHER = 4,
  RANCH_PRODUCT = 5,
  SATIETY_RESTORE = 6,
  COLLECTION_MANAGE = 7
}

function this.bind()
  return {
    txt_buildName = "",
    txt_buildLevel = "",
    toggle_lvMax = false,
    active_upgradeBtn = true,
    active_canUpgrade = false,
    petLayoutActive = false,
    petIconActive = false,
    addPetActive = false,
    saietyCurScore = "",
    saietyMaxScore = "",
    module_petIcon = {
      moduleName = "pages/pet/modulePetFrameIcon"
    },
    module_buildFrameTexture = L_Const.ModuleInfo.FrameTexture,
    img_build = ""
  }
end

function this.methods()
  return {
    onClick_addPetBtn = function(self)
      if C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petStationed) then
        self:dealChangePet()
      end
      L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
    end,
    onClick_switchPetBtn = function(self)
      self:dealChangePet()
    end,
    onClick_switchPetBtn2 = function(self)
      self:dealChangePet()
    end,
    onClick_upgradeBtn = function(self)
      if self._envType == CoolieEnvType.RANCH_GATHER then
        local ranchData = C_HomeManager:GetHomeStore():GetRanchData(self._blockId)
        local currLv = ranchData and ranchData.lv or 1
        if currLv >= _HomeRanchTpl:getMaxLv() then
          L_FlyMsgManager:showNormalMsgByKey("ui_pageHomeRanch_02")
          return
        end
        L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
        L_UI:open("pageBuildingUpgrade", {
          ranchBlockId = self._blockId
        })
        return
      end
      if self.bind.toggle_lvMax then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_manage_13"))
        return
      end
      L_ProductStore:call(L_ProductStore.event.closeTargetInfo)
      L_UI:open("pageBuildingUpgrade", {
        guid = self._guid,
        focusOnBuildMainUIAfterClose = true
      })
    end
  }
end

function this:dealChangePet()
  local function func(petGuid)
    if self._envType == CoolieEnvType.RANCH_GATHER then
      C_HomeManager:GetHomeStore():ReqSetGatherPet(self._blockId, petGuid, handler(self, self.refreshPet))
    elseif self._envType == CoolieEnvType.COLLECTION or self._envType == CoolieEnvType.BUILDING or self._envType == CoolieEnvType.COLLECTION_MANAGE then
      self._souceBuildGuid = self._souceBuildGuid or 0
      L_PetStore:req_CSProtoPetStationed(petGuid, self._buildType, self._buildGuid, self._souceBuildGuid, handler(self, self.refreshPet))
    end
  end
  
  if self._envType == CoolieEnvType.RANCH_GATHER then
    L_UI:open("pageStation", {
      capacityId = self._capacityId,
      needLaborType = self._needLaborType,
      selectGuid = self._selectGuid,
      petSize = self._petSize,
      blockId = self._blockId,
      callback = func
    })
  elseif self._envType == CoolieEnvType.COLLECTION or self._envType == CoolieEnvType.BUILDING or self._envType == CoolieEnvType.COLLECTION_MANAGE then
    L_UI:open("pageStation", {
      capacityId = self._capacityId,
      needLaborType = self._needLaborType,
      selectGuid = self._selectGuid,
      petSize = self._petSize,
      buildGuid = self._buildGuid,
      callback = func
    })
  end
end

function this:open()
  L_SatietyStore:listenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshSatiety, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.refreshView, self)
end

function this:close()
  L_SatietyStore:unListenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshSatiety, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshPet, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.refreshView, self)
end

function this:refreshPet()
  if self._envType == CoolieEnvType.RANCH_GATHER then
    self:initRanch(self._blockId)
  elseif self._envType == CoolieEnvType.BUILDING then
    self:initModule(self._buildGuid)
  elseif self._envType == CoolieEnvType.COLLECTION then
  elseif self._envType == CoolieEnvType.COLLECTION_MANAGE then
    self:setCollectionManageModule(self._buildGuid)
  end
end

function this:initRanch(blockId)
  self._envType = CoolieEnvType.RANCH_GATHER
  self._capacityId = L_HomeConst.homeLaborType.RANCH_GATHER
  self._needLaborType = L_HomeConst.HomeLaborId.ZHAO_LIAO
  self._petSize = {
    1,
    2,
    3,
    4
  }
  local blockRanchData = C_HomeManager:GetHomeStore():GetRanchData(blockId)
  self._blockId = blockId
  self._selectGuid = blockRanchData and blockRanchData.harvestPetGuid or 0
  self.modules.module_buildFrameTexture:setFrameId(1)
  self:refreshRanchBuildInfo(blockId)
  self:refreshView()
end

function this:initModule(buildingGuid)
  self._guid = buildingGuid
  self._envType = CoolieEnvType.BUILDING
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  printf("HomeDebug 设置建筑入住宠物", buildingGuid, serverData)
  local tpl = _homeBuildingProductionTpl:getTplById(serverData.build_id)
  self._capacityId = _homeBuildingProductionTpl:getPetHomeAttribute(tpl)
  self._needLaborType = _homeBuildingProductionTpl:getLaborType(tpl)
  self._petSize = _homeBuildingProductionTpl:getPetSize(tpl)
  self._buildType = L_Const.PetStationedWorkStatusType.PSWST_HOME_REST
  self._buildGuid = buildingGuid
  self._selectGuid = serverData.station_pet_guid
  local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
  if serverData.product and #serverData.product > 0 and 0 < serverData.product[#serverData.product].total_count then
    local frameId = homeBuildingTpl:getFrameTexture(homeBuildingTpl:getTplById(serverData.build_id))
    self.modules.module_buildFrameTexture:setFrameId(frameId)
    self.bind.img_build = ""
  else
    self.modules.module_buildFrameTexture:setFrameId(0)
    self.bind.img_build = homeBuildingTpl:getBuildingPixelIcon(homeBuildingTpl:getTplById(serverData.build_id))
  end
  self:refreshBuildInfo(buildingGuid, serverData.build_id)
  self:refreshView()
end

function this:setCollectionManageModule(buildingGuid)
  self._guid = buildingGuid
  self._envType = CoolieEnvType.COLLECTION_MANAGE
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  self._capacityId = L_HomeConst.homeLaborType.COLLECTION_MANAGE
  self._petSize = {
    1,
    2,
    3,
    4
  }
  self._buildType = L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK
  self._buildGuid = buildingGuid
  self._selectGuid = serverData.station_pet_guid
  self.bind.img_build = _HomeBuildingTpl:getBuildingPixelIcon(_HomeBuildingTpl:getTplById(serverData.build_id))
  self:refreshBuildInfo(buildingGuid, serverData.build_id)
  self:refreshView()
end

function this:refreshView()
  self.bind.petLayoutActive = not math.isEmpty(self._selectGuid)
  self.bind.emptyActive = math.isEmpty(self._selectGuid)
  self.bind.petIconActive = not math.isEmpty(self._selectGuid)
  self.modules.module_petIcon:setGuid(self._selectGuid, true)
  self.bind.addPetActive = math.isEmpty(self._selectGuid)
  if self.bind.addPetActive then
    self.bind.addPetActive = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petStationed) or C_IntegrateMgr.SystemUnlockModule:CanButtonShow(L_SystemConst.enum.petStationed)
  end
  if math.isEmpty(self._selectGuid) then
  else
    self:refreshSatiety()
  end
end

function this:refreshBuildInfo(buildingGuid, build_id)
  if not build_id then
    return
  end
  local buildTpl = _HomeBuildingTpl:getTplById(build_id)
  local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
  local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
  local isMax = math.isEmpty(_HomeBuildingTpl:getNextLevel(buildTpl))
  self.bind.txt_buildName = _HomeBuildingGroupTpl:getName(groupTpl)
  self.bind.toggle_lvMax = isMax
  self.bind.active_upgradeBtn = not isMax
  self.bind.txt_buildLevel = string.concat("Lv.", _HomeBuildingTpl:getLevel(buildTpl))
  self.bind.active_canUpgrade = false
end

function this:refreshRanchBuildInfo(blockId)
  local tpl = _blockTpl:getTplById(blockId)
  self.bind.txt_buildName = L_WordsTpl:getValue("ui_modulePetInfoNew", {
    [0] = _blockTpl:getSequence(tpl)
  })
  local ranchData = C_HomeManager:GetHomeStore():GetRanchData(self._blockId)
  local lv = ranchData and ranchData.lv or 1
  self.bind.txt_buildLevel = "Lv." .. lv
  local nextTpl = _HomeRanchTpl:getTplById(lv + 1)
  local isMax = not nextTpl
  self.bind.toggle_lvMax = isMax
end

function this:refreshSatiety()
  local currentSaity = L_SatietyStore:getPetSatiety(self._selectGuid)
  local maxSaity = L_SatietyStore:getPetMaxSatiety(self._selectGuid)
  self.bind.saietyCurScore = string.format("%s", currentSaity)
  self.bind.saietyMaxScore = string.format("/%s", maxSaity)
end

return this
