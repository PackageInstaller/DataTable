local this = {}
local homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local productsTpl = L_GameTpl:getProductsTpl()

function this:initSatietyServer()
  self:stopServer()
  self:startServer()
end

function this:stopServer()
  if not self.serverTimer then
    return
  end
  self.serverTimer:destroy()
  self.serverTimer = nil
end

function this:startServer()
  if self.serverTimer then
    return
  end
  local frequency = 1
  
  local function _run()
    self:refreshSatiety()
  end
  
  self:refreshSatiety()
  self.serverTimer = Timer.repeated(frequency, _run)
end

function this:refreshSatiety()
  print("TestRefreshSatiety")
  local allPet = L_PetStore:getPetList()
  local changedPets = {}
  for guid, pet in pairs(allPet) do
    if pet.work_status == L_Const.PetStationedWorkStatusType.PSWST_FIELD_WORK and (pet.capacity_id == L_HomeConst.homeLaborType.PLANT or pet.capacity_id == L_HomeConst.homeLaborType.WATER or pet.capacity_id == L_HomeConst.homeLaborType.HARVEST) and self:calculateSatietyForTime(pet) then
      table.insert(changedPets, guid)
    end
    if pet.work_status == L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK and pet.capacity_id == L_HomeConst.homeLaborType.COLLECTION_MANAGE and self:calculateSatietyForTime(pet) then
      table.insert(changedPets, guid)
    end
    if pet.work_status == L_Const.PetStationedWorkStatusType.PSWST_WILD_WORK and self:calculateSatietyForTime(pet) then
      table.insert(changedPets, guid)
    end
    if (pet.work_status == L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK or pet.work_status == L_Const.PetStationedWorkStatusType.PSWST_HOME_REST) and not math.isEmpty(pet.work_build) then
      local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(pet.work_build)
      if csHomeBuildData and self:dealBuildingSatiety(pet, csHomeBuildData) then
        table.insert(changedPets, guid)
      end
    end
  end
  if 0 < #changedPets then
    self:call(self.event.satiety_value_refresh, changedPets)
  end
end

function this:dealBuildingSatiety(pet, csHomeBuildData)
  local buildType = L_HomeManager:getBuildTypeById(csHomeBuildData.buildId)
  if buildType == L_Const.WorldMapBuildType.WMBT_PRODUCT then
    return self:calculateSatietyForProduct(pet, csHomeBuildData)
  end
  return false
end

function this:calculateSatietyForTime(pet)
  if pet.satiety == 0 then
    return
  end
  local startTime = pet.work_start_time
  if math.isEmpty(startTime) then
    return
  end
  if not math.isEmpty(pet.canteen_id) then
    local oldSatiety = pet.satiety
    pet.satiety = pet.satiety_val
    return oldSatiety ~= pet.satiety
  end
  local passTime = L_TimeUtil.getServerTime() - startTime + 1
  local tpl = homeLaborCapacityTpl:getTplById(pet.capacity_id)
  local costTime = homeLaborCapacityTpl:getCostSatietyTime(tpl)
  local costUnit = homeLaborCapacityTpl:getCostSatiety(tpl)
  if not costTime or not costUnit then
    return
  end
  local oldSatiety = pet.satiety
  local costRatio = math.ceil(passTime / costTime)
  if costUnit <= pet.satiety then
    pet.satiety = pet.satiety_val - costRatio * costUnit
  end
  local maxScore = L_SatietyStore:getPetMaxSatiety(pet.guid)
  pet.satiety = math.clamp(pet.satiety, 0, maxScore)
  return oldSatiety ~= pet.satiety
end

function this:calculateSatietyTimeStamp(pet)
  if table.isEmpty(pet) or pet.satiety == 0 then
    return 0
  end
  local startTime = pet.work_start_time
  if math.isEmpty(pet.capacity_id) then
    return 0
  end
  local tpl = homeLaborCapacityTpl:getTplById(pet.capacity_id)
  local satietyScore = homeLaborCapacityTpl:getSatietyScore(tpl)
  if table.isEmpty(satietyScore) then
    return 0
  end
  if math.isEmpty(startTime) then
    startTime = L_TimeUtil.getServerTime()
  end
  local costSatietyPetSec = satietyScore[1] / satietyScore[2]
  local endTimeStamp = startTime + costSatietyPetSec * pet.satiety
  return endTimeStamp
end

function this:calculateSatietyForProduct(pet, csHomeBuildData)
  if pet.satiety == 0 then
    return
  end
  if not math.isEmpty(pet.canteen_id) or pet.work_pause then
    return
  end
  local csHomeBuildProductDataList = csHomeBuildData.products
  local oldSatiety = pet.satiety
  if csHomeBuildProductDataList and 0 < csHomeBuildProductDataList.Count then
    for i = 0, csHomeBuildProductDataList.Count - 1 do
      local csHomeBuildProductData = csHomeBuildProductDataList[i]
      if csHomeBuildProductData.productId ~= 0 then
        local finishCount = csHomeBuildProductData.finishCount
        local costUnit = L_ProductManager:getProductSatietyScore(csHomeBuildProductData.productId) or 0
        if costUnit <= pet.satiety then
          pet.satiety = pet.satiety_val - finishCount * costUnit
        end
      end
    end
  end
  local maxScore = L_SatietyStore:getPetMaxSatiety(pet.guid)
  pet.satiety = math.clamp(pet.satiety, 0, maxScore)
  return oldSatiety ~= pet.satiety
end

return this
