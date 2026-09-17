local this = class("modulePetInfo", G_UIModuleBase)
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _petTpl = L_GameTpl:getPetTpl()
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
    petLayoutActive = false,
    emptyActive = false,
    petIconActive = false,
    addPetActive = false,
    petName = "",
    saietyScore = "",
    petIcon = "",
    buildIcon = ""
  }
end

function this.methods()
  return {
    onClick_addPetBtn = function(self)
      self:dealChangePet()
    end,
    onClick_addPetBtn2 = function(self)
      self:dealChangePet()
    end,
    onClick_switchPetBtn = function(self)
      self:dealChangePet()
    end,
    onClick_switchPetBtn2 = function(self)
      self:dealChangePet()
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
  
  L_UI:open("pageStation", {
    capacityId = self._capacityId,
    needLaborType = self._needLaborType,
    selectGuid = self._selectGuid,
    petSize = self._petSize,
    callback = func
  })
end

function this:open()
  L_SatietyStore:listenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshSatiety, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.refreshView, self)
end

function this:close()
  L_SatietyStore:unListenCallFunc(L_SatietyStore.event.satiety_value_refresh, self.refreshSatiety, self)
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
  self._petSize = {
    1,
    2,
    3,
    4
  }
  self._needLaborType = L_HomeConst.HomeLaborId.ZHAO_LIAO
  local blockRanchData = C_HomeManager:GetHomeStore():GetRanchData(blockId)
  self._blockId = blockId
  self._selectGuid = blockRanchData and blockRanchData.harvestPetGuid or 0
  self:refreshView()
end

function this:initModule(buildingGuid)
  self._envType = CoolieEnvType.BUILDING
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  printf("HomeDebug 设置建筑入住宠物", buildingGuid, serverData)
  local tpl = _homeBuildingProductionTpl:getTplById(serverData.build_id)
  self._capacityId = _homeBuildingProductionTpl:getPetHomeAttribute(tpl)
  self._petSize = _homeBuildingProductionTpl:getPetSize(tpl)
  self._needLaborType = _homeBuildingProductionTpl:getLaborType(tpl)
  self._buildType = L_Const.PetStationedWorkStatusType.PSWST_HOME_REST
  self._buildGuid = buildingGuid
  self._selectGuid = serverData.station_pet_guid
  local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
  self.bind.buildIcon = homeBuildingTpl:getBuildingPixelIcon(homeBuildingTpl:getTplById(serverData.build_id))
  self.bindComponents.buildIcon:SetNativeSize()
  self:refreshView()
end

function this:setCollectionManageModule(buildingId)
  self._envType = CoolieEnvType.COLLECTION_MANAGE
  local serverData = L_HomeStore:getHomeBuildingByGuid(buildingId)
  self._capacityId = L_HomeConst.homeLaborType.COLLECTION_MANAGE
  self._petSize = {
    1,
    2,
    3,
    4
  }
  self._buildType = L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK
  self._buildGuid = buildingId
  self._selectGuid = serverData.station_pet_guid
  local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
  self.bind.buildIcon = homeBuildingTpl:getBuildingPixelIcon(homeBuildingTpl:getTplById(serverData.build_id))
  self.bindComponents.buildIcon:SetNativeSize()
  self:refreshView()
end

function this:refreshView()
  self.bind.petLayoutActive = not math.isEmpty(self._selectGuid)
  self.bind.emptyActive = math.isEmpty(self._selectGuid)
  self.bind.petIconActive = not math.isEmpty(self._selectGuid)
  self.bind.addPetActive = math.isEmpty(self._selectGuid)
  if math.isEmpty(self._selectGuid) then
  else
    local pet = L_PetStore:getPetItem(self._selectGuid)
    local configData = L_ItemTplManager:getPetItem(pet.id, pet:isSpecialPet())
    self.bind.petIcon = _petTpl:getPetPixelIcon(_petTpl:getTplById(pet.id), pet:isSpecialPet())
    self.bind.petName = pet.pet_name
    self:refreshSatiety()
  end
end

function this:refreshSatiety()
  local currentSaity = L_SatietyStore:getPetSatiety(self._selectGuid)
  local maxSaity = L_SatietyStore:getPetMaxSatiety(self._selectGuid)
  local color = L_Const.colorHtml.grey003
  if currentSaity == 0 then
    color = L_Const.colorHtml.red002
  end
  self.bind.saietyScore = L_GameUtil.fillColor(string.format("%s/%s", currentSaity, maxSaity), color)
end

return this
