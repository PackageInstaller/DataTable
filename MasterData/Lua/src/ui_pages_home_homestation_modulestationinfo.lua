local this = class("moduleStationInfo", G_UIModuleBase)
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _homeBuildingHomecollectionTpl = L_GameTpl:getHomeBuildingHomecollectionTpl()
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _homeBuffTpl = L_GameTpl:getHomeBuffTpl()
local _homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local _homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _homeLaborEfficiencyTpl = L_GameTpl:getHomeLaborEfficiencyTpl()
local _commonPetSatiety = L_GameTpl:getCommonPetSatietyTpl()
local _BuildingTypeTpl = L_GameTpl:getHomeBuildingTypeTpl()
local Color = C_Color
local ColorCache = {
  [1] = Color(0.7764705882352941, 0.24313725490196078, 0.2235294117647059, 1.0),
  [2] = Color(0.8862745098039215, 0.5843137254901961, 0 / 255.0, 1.0),
  [3] = Color(0.1803921568627451, 0.6352941176470588, 0.6078431372549019, 1.0)
}
local StationBuildingType2LaborDescIndex = {
  [L_HomeConst.StationBuildingType.HomeBuilding] = 1,
  [L_HomeConst.StationBuildingType.Collection] = 2,
  [L_HomeConst.StationBuildingType.Ranch] = 3,
  [L_HomeConst.StationBuildingType.Crop] = 4,
  [L_HomeConst.StationBuildingType.HomeCollection] = 1
}
local path_talentFrame = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_bg_talent_bg1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_bg_talent_bg2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_bg_talent_bg3.png"
}
local path_talentLight = {
  [1] = "UI/Atlas/PetTalentObsolute/tex_dec_talent_light1.png",
  [2] = "UI/Atlas/PetTalentObsolute/tex_dec_talent_light2.png",
  [3] = "UI/Atlas/PetTalentObsolute/tex_dec_talent_light3.png"
}
local levelText = {
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V"
}

function this.bind()
  return {
    module_stationBuildingTop = {
      moduleName = "pages/home/homeStation/moduleStationBuildingTop"
    },
    petIconActive = false,
    petIconOutLineActive = false,
    toggle_hasPet = false,
    addPetActive = false,
    go_progress = false,
    active_saiety_accessory = false,
    module_petIcon = {
      moduleName = "pages/pet/modulePetFrameIcon"
    },
    module_petIconOutLine = {
      moduleName = "pages/pet/modulePetFrameIcon"
    },
    module_buildFrameTexture = L_Const.ModuleInfo.FrameTexture,
    img_build = "",
    img_talentFrameBg = "",
    img_talentIcon = "",
    img_talentIconLight = "",
    txt_talentLevel = "",
    txt_talentDesc = "",
    list_petHomeLaborTag = {
      moduleName = "pages/Pet/cellTagPetHomeLabor"
    },
    img_accessoryIcon = "",
    txt_accessoryTip = "",
    active_accessoryTip = false,
    img_satiety = "",
    active_imgSatiety = false,
    active_workDesc = false,
    txt_workDesc = ""
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
    end
  }
end

function this:refreshWorkDesc()
  local txt
  if self._previewPetSelected then
    txt = L_WordsTpl:getValue("ui_homebuilding_setstate_01")
  else
    local csPetData = self._selectGuid and L_PetStore:getCsPetData(self._selectGuid)
    if csPetData and csPetData:GetIsStationLock() then
      txt = L_WordsTpl:getValue("ui_homebuilding_setstate_03")
    elseif self._stationType == L_HomeConst.StationType.Ranch then
      if not math.isEmpty(self._selectGuid) then
        txt = L_WordsTpl:getValue("ui_homebuilding_setstate_02")
      end
    elseif not math.isEmpty(self._buildGuid) and not math.isEmpty(self._selectGuid) then
      txt = L_WordsTpl:getValue("ui_homebuilding_setstate_02")
    end
  end
  if not txt then
    self.bind.active_workDesc = false
    if self.parent and self.parent.refreshPreviewPetGuid then
      self.parent:refreshPreviewPetGuid()
    end
    return
  end
  self.bind.active_workDesc = true
  self.bind.txt_workDesc = txt
  if self.parent and self.parent.refreshPreviewPetGuid then
    self.parent:refreshPreviewPetGuid()
  end
end

function this:checkStationedPetSatiety(petGuid, buildingGuid, isShowTip)
  local isProduct = L_ProductManager:isBuildingOnProducing(buildingGuid)
  if not isProduct then
    return true
  end
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  if not csHomeBuildData then
    return false
  end
  local totalCount = 0
  local productId = 0
  local productList = csHomeBuildData.products
  if table.isEmpty(productList) then
    return true
  end
  for i = 0, productList.Count - 1 do
    local csHomeBuildProductData = productList[i]
    if csHomeBuildProductData ~= nil and 0 < csHomeBuildProductData.totalCount then
      totalCount = csHomeBuildProductData.totalCount
      productId = csHomeBuildProductData.productId
      break
    end
  end
  if totalCount <= 0 then
    return true
  end
  local needSatiety = L_ProductManager:getProductSatietyScore(productId)
  local curPetSatiety = L_SatietyStore:getPetSatiety(petGuid)
  if needSatiety <= curPetSatiety then
    return true
  end
  local totalSatiety = L_SatietyManager:getCurTotalSatiety()
  if needSatiety <= totalSatiety + curPetSatiety then
    return true
  end
  if isShowTip then
    L_FlyMsgManager:showNormalMsgByKey("home_pet_dispatch_ban")
  end
  return false
end

function this:dealChangePet()
  if false and self._stationType == L_HomeConst.StationType.HomeBuilding and self._buildGuid and self._buildingType == L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT and L_ProductManager:isBuildingOnProducing(self._buildGuid) and self._selectGuid ~= 0 then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_accessory_product_kibo_change"),
      confirmCallback = function()
        self:unloadPetAndOpenStationPage()
      end
    })
    return
  end
  self:openStationPage()
end

function this:unloadPetAndOpenStationPage()
  if not self._buildGuid then
    return
  end
  local serverData = L_HomeStore:getHomeBuildingByGuid(self._buildGuid)
  local petGuid = serverData.station_pet_guid
  if not math.isEmpty(petGuid) then
    L_PetStore:req_CSProtoPetStationed(petGuid, self._buildType, self._buildGuid, self._souceBuildGuid, false, function()
      self._selectGuid = 0
      self:openStationPage()
    end)
  else
    self:openStationPage()
  end
end

function this:openStationPage()
  local function func(petGuid, isOutHomeHub, capacityId)
    if self._stationType == L_HomeConst.StationType.Ranch then
      C_HomeManager:GetHomeStore():ReqSetGatherPet(self._blockId, petGuid, handler(self, self.refreshPet), isOutHomeHub)
    elseif self._stationType == L_HomeConst.StationType.HomeBuilding or self._stationType == L_HomeConst.StationType.CollectionManage or self._stationType == L_HomeConst.StationType.HomeCollection then
      self._souceBuildGuid = self._souceBuildGuid or 0
      L_PetStore:req_CSProtoPetStationed(petGuid, self._buildType, self._buildGuid, self._souceBuildGuid, isOutHomeHub, handler(self, self.refreshPet))
    elseif self._stationType == L_HomeConst.StationType.Collection then
      L_PetStore:req_CSProtoPetStationed(petGuid, self._buildType, self._collectionId, self._souceBuildGuid, isOutHomeHub, handler(self, self.refreshPet))
    end
  end
  
  L_UI:open("pageStation", {
    capacityId = self._capacityId,
    needLaborType = self._needLaborType,
    selectGuid = not self._previewPetSelected and self._selectGuid or 0,
    petSize = self._petSize,
    stationType = self._stationType,
    buildGuid = self._buildGuid,
    callback = func
  })
end

function this:open()
  self._moduleBuildingTop = self.modules.module_stationBuildingTop
  L_SatietyStore:listenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshSatiety, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetDatas, self.refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.refreshView, self)
  self:registerShortCutKey("moduleStationInfo")
  self:refreshShortKeyFlag()
end

function this:close()
  L_SatietyStore:unListenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshSatiety, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshPet, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.refreshView, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetDatas, self.refreshPet, self)
  self:unregisterShortCutKey("moduleStationInfo")
  self:clearShortKeyFlag()
end

function this:needLaborType()
  return self._needLaborType
end

function this:refreshPet()
  self.bind.active_accessoryTip = false
  if self._stationType == L_HomeConst.StationType.Ranch then
    self:initRanch(self._blockId)
  elseif self._stationType == L_HomeConst.StationType.HomeBuilding then
    self:initBuilding(self._buildGuid, self._previewPet)
  elseif self._stationType == L_HomeConst.StationType.Collection then
  elseif self._stationType == L_HomeConst.StationType.HomeCollection then
    self:setHomeCollectionModule(self._buildGuid, self._homeCollectionBuildId)
  elseif self._stationType == L_HomeConst.StationType.CollectionManage then
    self:setCollectionManageModule(self._buildGuid)
  end
  if self._buildingType == L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT then
    L_ProductStore:call(L_ProductStore.event.refreshAccessory)
    self.bind.active_accessoryTip = true
  end
end

function this:isStationed(petGuid)
  local csPetData = L_PetStore:getCsPetData(petGuid)
  return csPetData:GetIsInHomeHub()
end

function this:getPreviewPetGuid()
  local allPets = L_PetStore:getPetList()
  local dataList = {}
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  for i, v in pairs(allPets) do
    if self:isStationed(v.guid) then
      local tpl_pet_talent = _petHomeTalentTpl:getTplById(v.id)
      local C_PetData = C_PetStore:GetPet(v.guid)
      local C_LaborInfoList = C_PetData:GetLaborInfoList()
      if tpl_pet_talent and C_LaborInfoList.Count > 0 then
        local size = _petHomeTalentTpl:getSizeType(tpl_pet_talent)
        local node, index = table.ipairsFind(self._petSize, function(value)
          return value == size
        end)
        if index then
          if self._needLaborType then
            for i = 0, C_LaborInfoList.Count - 1 do
              local laborInfo = C_LaborInfoList[i]
              local laborId = laborInfo.laborId
              local isMatch = false
              if type(self._needLaborType) == "table" then
                for _, needType in ipairs(self._needLaborType) do
                  if needType == laborId then
                    isMatch = true
                    break
                  end
                end
              else
                isMatch = self._needLaborType == laborId
              end
              if isMatch and v:getGameplayStatus() == L_Const.PetState.PET_HUB then
                table.insert(dataList, {
                  guid = v.guid,
                  laborGrade = laborInfo.laborGrade,
                  level = v.lv
                })
              end
            end
          else
            do
              local talent = v.talent_id or {}
              local node1, index1 = table.ipairsFind(talent, function(value)
                local tpl_talent = _homeTalentTpl:getTplById(value)
                local capacityId = _homeTalentTpl:getLaborCapacityId(tpl_talent)
                return capacityId == self._needCapacityId
              end)
              if index1 and v:getGameplayStatus() == L_Const.PetState.PET_HUB then
                table.insert(dataList, {
                  guid = v.guid,
                  laborGrade = v.laborGrade,
                  level = v.lv
                })
              end
            end
          end
        end
      end
    end
  end
  if 0 < #dataList then
    L_CommonUtil.multipleSortByKey(dataList, {"laborGrade", "level"})
    return dataList[1].guid
  end
  return 0
end

function this:isPreviewPet()
  return self._previewPetSelected and self._selectGuid or 0
end

function this:initBuilding(buildingGuid, previewPet)
  self._guid = buildingGuid
  self._stationType = L_HomeConst.StationType.HomeBuilding
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  printf("HomeDebug 设置建筑入住宠物", buildingGuid, serverData)
  local tpl = _homeBuildingProductionTpl:getTplById(serverData.build_id)
  self._capacityId = _homeBuildingProductionTpl:getPetHomeAttribute(tpl)
  self._needLaborType = _homeBuildingProductionTpl:getLaborType(tpl)
  self._petSize = _homeBuildingProductionTpl:getPetSize(tpl)
  self._buildType = L_Const.PetStationedWorkStatusType.PSWST_HOME_REST
  self._buildGuid = buildingGuid
  self._selectGuid = serverData.station_pet_guid
  self._previewPet = previewPet
  self._previewPetSelected = false
  if self._previewPet and math.isEmpty(self._selectGuid) then
    self._selectGuid = self:getPreviewPetGuid()
    self._previewPetSelected = not math.isEmpty(self._selectGuid)
  end
  local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
  self._buildingType = C_HomeUtil.GetBuildingType(buildingGuid)
  if self._buildingType == L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT then
    local tpl_capacity = _homeLaborCapacityTpl:getTplById(self._capacityId)
    self.bind.img_accessoryIcon = _homeLaborTypeTpl:getLaborIcon(_homeLaborTypeTpl:getTplById(_homeLaborCapacityTpl:getLaborType(tpl_capacity)))
    self.bind.txt_accessoryTip = _homeLaborTypeTpl:getLaborName(_homeLaborTypeTpl:getTplById(_homeLaborCapacityTpl:getLaborType(tpl_capacity)))
    self.bind.active_accessoryTip = true
  end
  if serverData.product and #serverData.product > 0 and 0 < serverData.product[#serverData.product].total_count then
    local frameId = homeBuildingTpl:getFrameTexture(homeBuildingTpl:getTplById(serverData.build_id))
    self.modules.module_buildFrameTexture:setFrameId(frameId)
    self.bind.img_build = ""
  else
    self.modules.module_buildFrameTexture:setFrameId(0)
    self.bind.img_build = homeBuildingTpl:getBuildingPixelIcon(homeBuildingTpl:getTplById(serverData.build_id))
  end
  self._moduleBuildingTop:initModule({
    stationBuildingType = L_HomeConst.StationType.HomeBuilding,
    buildingGuid = buildingGuid
  })
  self:refreshView()
end

function this:initRanch(blockId)
  self._stationType = L_HomeConst.StationType.Ranch
  self._capacityId = L_HomeConst.homeLaborType.RANCH_GATHER
  self._needLaborType = L_HomeConst.HomeLaborId.ZHAO_LIAO
  self._petSize = {
    1,
    2,
    3,
    4
  }
  local C_HomeManager = AzurWorld.HomeMgr
  local blockRanchData = C_HomeManager:GetHomeStore():GetRanchData(blockId)
  self._blockId = blockId
  self._buildingType = 53
  self._selectGuid = blockRanchData and blockRanchData.harvestPetGuid or 0
  self.modules.module_buildFrameTexture:setFrameId(17)
  self._moduleBuildingTop:initModule({
    stationBuildingType = L_HomeConst.StationType.Ranch,
    blockId = blockId
  })
  self:refreshView()
end

function this:setHomeCollectionModule(buildingGuid, homeCollectionBuildId)
  self._guid = buildingGuid
  self._stationType = L_HomeConst.StationType.HomeCollection
  self._homeCollectionBuildId = homeCollectionBuildId
  self._buildingType = C_HomeUtil.GetBuildingType(buildingGuid)
  local buildId = homeCollectionBuildId
  local tpl_building = _homeBuildingHomecollectionTpl:getTplById(buildId)
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  self._capacityId = _homeBuildingHomecollectionTpl:getPetCapacity(tpl_building)
  self._needLaborType = _homeBuildingHomecollectionTpl:getLaborType(tpl_building)
  self._petSize = _homeBuildingHomecollectionTpl:getPetSize(tpl_building)
  self._buildType = L_Const.PetStationedWorkStatusType.PSWST_HOME_REST
  self._buildGuid = buildingGuid
  self._selectGuid = serverData.station_pet_guid
  self._previewPetSelected = false
  if self._previewPet and math.isEmpty(self._selectGuid) then
    self._selectGuid = self:getPreviewPetGuid()
    self._previewPetSelected = not math.isEmpty(self._selectGuid)
  end
  local csHomeStore = L_HomeStore:getCsHomeStore()
  local isWorking = csHomeStore.HomeCollectModule:LuaGetHomeCollectionIsWorking(self._buildGuid)
  if isWorking then
    local frameId = _homeBuildingHomecollectionTpl:getFrameTexture(tpl_building)
    self.modules.module_buildFrameTexture:setFrameId(frameId)
    self.bind.img_build = ""
  else
    local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
    self.modules.module_buildFrameTexture:setFrameId(0)
    self.bind.img_build = homeBuildingTpl:getBuildingPixelIcon(homeBuildingTpl:getTplById(buildId))
  end
  self._moduleBuildingTop:initModule({
    stationBuildingType = L_HomeConst.StationBuildingType.HomeCollection,
    buildId = buildId
  })
  self:refreshView()
end

function this:setCollectionManageModule(buildingGuid)
  self._guid = buildingGuid
  self._stationType = L_HomeConst.StationType.CollectionManage
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
  self._moduleBuildingTop:initModule({
    stationBuildingType = L_HomeConst.StationType.HomeBuilding,
    buildingGuid = buildingGuid
  })
  self:refreshView()
end

function this:refreshView()
  self.bind.emptyActive = math.isEmpty(self._selectGuid)
  self.bind.petIconActive = not math.isEmpty(self._selectGuid)
  self.bind.petIconOutLineActive = not math.isEmpty(self._selectGuid)
  self.bind.toggle_hasPet = not math.isEmpty(self._selectGuid)
  self.bind.addPetActive = math.isEmpty(self._selectGuid)
  if self.bind.addPetActive then
    self.bind.addPetActive = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petStationed) or C_IntegrateMgr.SystemUnlockModule:CanButtonShow(L_SystemConst.enum.petStationed)
  end
  if math.isEmpty(self._selectGuid) then
  else
    self.modules.module_petIcon:setGuid(self._selectGuid, true)
    self.modules.module_petIconOutLine:setGuid(self._selectGuid, true)
    self:refreshPetTalent(self._selectGuid)
    self:refreshHomeLaborTag()
  end
  self:refreshSatiety()
  self:refreshWorkDesc()
  self:refreshShortKeyFlag()
end

function this:refreshSatiety()
  if math.isEmpty(self._selectGuid) then
    self.bind.active_saiety_accessory = false
    self.bind.active_imgSatiety = false
    return
  end
  local currentSaity = L_SatietyStore:getPetSatiety(self._selectGuid)
  local maxSaity = L_SatietyStore:getPetMaxSatiety(self._selectGuid)
  if false and self._buildingType == L_Const.WorldMapBuildType.WMBT_PRO_ORNAMENT then
    self.bind.active_saiety_accessory = true
    local percent = math.clamp(currentSaity / maxSaity, 0, 1)
    self:setChargeProgressColor(percent)
  else
    self.bind.active_saiety_accessory = false
    local level1SatietyMax = _commonPetSatiety:getSatietyLevel(1).max * maxSaity
    local level2SatietyMax = _commonPetSatiety:getSatietyLevel(2).max * maxSaity
    self.bind.active_imgSatiety = currentSaity <= level2SatietyMax
    if currentSaity <= level1SatietyMax then
      self.bind.img_satiety = "UI/Atlas/PageHomeBuilding/tex_homebuilding_dec_kibohungry_fx1.png"
    elseif currentSaity <= level2SatietyMax then
      self.bind.img_satiety = "UI/Atlas/PageHomeBuilding/tex_homebuilding_dec_kibohungry_fx2.png"
    end
  end
end

function this:refreshPetTalent(petGuid)
  if not self._buildingType then
    error("refreshPetTalent no _buildingType")
    return
  end
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local laborGrade = 0
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local id = C_LaborInfo.laborId
    local isMatch = false
    if type(self._needLaborType) == "table" then
      for _, needType in ipairs(self._needLaborType) do
        if needType == id then
          isMatch = true
          break
        end
      end
    else
      isMatch = id == self._needLaborType
    end
    if isMatch then
      laborGrade = C_LaborInfo.laborGrade
    end
  end
  if math.isEmpty(laborGrade) then
    error("refreshPetTalent no laborGrade")
    return
  end
  local typeTpl = _BuildingTypeTpl:getTplById(self._buildingType)
  local labordesc = _BuildingTypeTpl:getLaborDesc(typeTpl)
  local buffValue = L_HomeBuffManager:getBuildingLaborBuffValue(self._buildingType, laborGrade) / 10000
  local showBuffValue = buffValue * 100
  local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
  local showBuffValue = showBuffValueIntPart
  local textOfBuffValue = showBuffValue .. "%"
  self.bind.txt_talentDesc = L_Lang:get(labordesc, {
    [0] = textOfBuffValue
  })
end

function this:refreshPetTalent_toDelete(petGuid)
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local C_TalentIds = C_PetData.talentIds
  local talentId, laborId
  local laborGrade = 0
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local id = C_LaborInfo.laborId
    local isMatch = false
    if type(self._needLaborType) == "table" then
      for _, needType in ipairs(self._needLaborType) do
        if needType == id then
          isMatch = true
          break
        end
      end
    else
      isMatch = id == self._needLaborType
    end
    if isMatch then
      laborId = id
      laborGrade = C_LaborInfo.laborGrade
      if 0 < C_TalentIds.Count then
        talentId = C_TalentIds[0]
      end
    end
  end
  if not laborId then
    local needLaborTypeStr = type(self._needLaborType) == "table" and table.concat(self._needLaborType, ",") or tostring(self._needLaborType)
    errorf("数据错误! 无工种数据 请检查配表，工种Type id:" .. needLaborTypeStr)
    return
  end
  local laborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local buffId
  local stationType = self._stationType or L_HomeConst.StationType.HomeBuilding
  if talentId then
    local tpl = _homeTalentTpl:getTplById(talentId)
    self.bind.img_talentFrameBg = path_talentFrame[_homeTalentTpl:getTalentLevel(tpl)]
    self.bind.img_talentIcon = _homeTalentTpl:getTypeIcon(tpl)
    self.bind.img_talentIconLight = path_talentLight[_homeTalentTpl:getTalentLevel(tpl)]
    self.bind.txt_talentLevel = levelText[_homeTalentTpl:getTalentLevel(tpl)]
    local talentTpl = _homeTalentTpl:getTplById(talentId)
    local buffs, _, _, _ = _homeTalentTpl:getBuffInfo(talentTpl)
    buffId = buffs[1]
  else
    local buffIdList = _homeLaborTypeTpl:getHomeBuffIdList(laborTypeTpl)
    local descDetailList = _homeLaborTypeTpl:getLaborDescDetailList(laborTypeTpl)
    local noTalentDesc = descDetailList[StationBuildingType2LaborDescIndex[stationType]]
    local notEmptyDescDetailList = {}
    for _, descDetail in pairs(descDetailList) do
      if descDetail ~= nil and descDetail ~= " " and descDetail ~= "" then
        table.insert(notEmptyDescDetailList, descDetail)
      end
    end
    local buffIdIndex
    for i, notEmptyDescDetail in pairs(notEmptyDescDetailList) do
      if notEmptyDescDetail == noTalentDesc then
        buffIdIndex = i
        break
      end
    end
    buffId = buffIdList[buffIdIndex]
  end
  if buffId and 0 < buffId then
    local talentDesc = _homeLaborTypeTpl:getLaborDescList(laborTypeTpl)[StationBuildingType2LaborDescIndex[stationType]]
    local homeBuffTpl = _homeBuffTpl:getTplById(buffId)
    local buffValueType = _homeBuffTpl:getType(homeBuffTpl)
    local buffValue = L_HomeBuffManager:getLaborBuffValue(laborId, laborGrade, buffId)
    buffValue = 10000 / (10000 - buffValue) - 1
    local textOfBuffValue = ""
    if buffValueType == L_HomeConst.buffValueType.PERCENT then
      local showBuffValue = buffValue * 100
      local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
      local showBuffValueFloatPart = showBuffValue % 1
      showBuffValue = showBuffValueIntPart
      textOfBuffValue = showBuffValue .. "%"
    else
      local showBuffValue = buffValue
      local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
      local showBuffValueFloatPart = showBuffValue % 1
      showBuffValue = showBuffValueIntPart
      textOfBuffValue = tostring(showBuffValue)
    end
    self.bind.txt_talentDesc = L_Lang:get(talentDesc, {
      [0] = textOfBuffValue
    })
  else
    local needLaborTypeStr = type(self._needLaborType) == "table" and table.concat(self._needLaborType, ",") or tostring(self._needLaborType)
    errorf("数据错误! 无Buff数据 请检查配表，工种Type id:" .. needLaborTypeStr .. " talentId = " .. tostring(talentId) .. " stationType " .. tostring(stationType))
  end
end

function this:refreshHomeLaborTag()
  local petGuid = self._selectGuid
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local showParamsList = {}
  local needLaborId
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local laborId = C_LaborInfo.laborId
    local isMatch = false
    if type(self._needLaborType) == "table" then
      for _, needType in ipairs(self._needLaborType) do
        if needType == laborId then
          needLaborId = laborId
          isMatch = true
          break
        end
      end
    else
      isMatch = laborId == self._needLaborType
      if isMatch then
        needLaborId = laborId
      end
    end
    if isMatch then
      local C_TalentIds = C_PetData.talentIds
      local talentId
      if 0 < C_TalentIds.Count then
        for i = 0, C_TalentIds.Count - 1 do
          local id = C_TalentIds[i]
          local tpl = _homeTalentTpl:getTplById(id)
          local talenLaborId = _homeTalentTpl:getLaborTypeIdOfTalent(tpl)
          if talenLaborId == needLaborId then
            talentId = id
          end
        end
      end
      self.selectLaborGrade = C_LaborInfo.laborGrade
      local showParams = {
        petId = C_PetData.configId,
        laborId = C_LaborInfo.laborId,
        laborGrade = C_LaborInfo.laborGrade,
        talentId = talentId,
        upperLaborGrade = C_LaborInfo.upperLaborGrade
      }
      table.insert(showParamsList, showParams)
    end
  end
  self.bind.list_petHomeLaborTag:clear()
  self.bind.list_petHomeLaborTag:insert_array(showParamsList)
end

function this:setChargeProgressColor(percent)
  local minKey = 1
  local key
  if 0 < percent and percent <= 0.33 then
    key = 1
  elseif 0.33 < percent and percent <= 0.66 then
    key = 2
  elseif 0.66 < percent and percent <= 1 then
    key = 3
  end
  key = key or minKey
  local mat = self.bindComponents.meshRenderer_goProgress.material
  mat:SetFloat("_wave_progress", math.lerp(0, 1, percent))
  mat:SetColor("_Color0", ColorCache[key])
  mat.renderQueue = 2999
  if 0 < percent then
    self.bind.go_progress = true
  else
    self.bind.go_progress = false
  end
end

function this:setQualityAccessory()
  if self._selectGuid and self._selectGuid ~= 0 then
    self:refreshPetTalent(self._selectGuid)
  end
end

function this:setAttributionProduct(isProduct)
  self.isProduct = isProduct
end

function this:setGamepadShortCutEnable(bEnable)
  self._gamepadShortCutEnable = bEnable
  self:refreshShortKeyFlag()
end

function this:registerShortCutKey(pageName)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EModuleStationInfoKiboAdd, function()
    if not self._gamepadShortCutEnable then
      return
    end
    if not self.parent or not self.parent.isTop then
      return
    end
    if self.bind.addPetActive then
      self.methods.onClick_addPetBtn(self)
    else
      self.methods.onClick_switchPetBtn(self)
    end
  end)
end

function this:unregisterShortCutKey(pageName)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EModuleStationInfoKiboAdd)
end

function this:refreshShortKeyFlag()
  L_ShortCutManager:removeShortKeyFlag(self, "UI_ModuleStationInfoKiboAdd")
  if self._gamepadShortCutEnable then
    if self.bind.addPetActive then
      L_ShortCutManager:addShortKeyFlag(self, "UI_ModuleStationInfoKiboAdd", L_Const.AnchorType.Middle, self.bindComponents.rect_addBtn, L_Vector3.new(-85, 10))
    else
      L_ShortCutManager:addShortKeyFlag(self, "UI_ModuleStationInfoKiboAdd", L_Const.AnchorType.Middle, self.bindComponents.rect_switchBtn, L_Vector3.new(-50, 30))
    end
  end
end

function this:clearShortKeyFlag()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
