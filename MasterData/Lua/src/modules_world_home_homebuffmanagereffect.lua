local this = {}
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _homeFieldTpl = L_GameTpl:getHomeFieldtypeTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeLaborEfficiencyTpl = L_GameTpl:getHomeLaborEfficiencyTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _gameTpl = L_GameTpl:getGameConstTpl()
local _accessoryProductTpl = L_GameTpl:getAccessoryProductTpl()
local StationBuildingType2LaborDescIndex = {
  [L_HomeConst.StationBuildingType.HomeBuilding] = 1,
  [L_HomeConst.StationBuildingType.Collection] = 2,
  [L_HomeConst.StationBuildingType.Ranch] = 3,
  [L_HomeConst.StationBuildingType.Crop] = 4,
  [L_HomeConst.StationBuildingType.HomeCollection] = 1
}

function this:getCropGrowParam(seedId, conditions, params)
  local buffData = self:getBuff(L_HomeConst.buffId.CROP_REDUCE_TIME_PERCENT, conditions, params)
  local tpl = _homeSeedTpl:getTplById(seedId)
  local growTime = _homeSeedTpl:getGrowTime(tpl)
  local preHarTime = _homeSeedTpl:getHarvestTime(tpl)
  local growTime = math.floor(growTime * (1 - buffData.buffValue))
  local preHarTime = math.floor(preHarTime * (1 - buffData.buffValue))
  return growTime, preHarTime
end

function this:getCropGrowParamTable(seedId, conditions, params)
  local buffData = self:getBuff(L_HomeConst.buffId.CROP_REDUCE_TIME_PERCENT, conditions, params)
  local tpl = _homeSeedTpl:getTplById(seedId)
  local growTime = _homeSeedTpl:getGrowTime(tpl)
  local preHarTime = _homeSeedTpl:getHarvestTime(tpl)
  local growTime = math.floor(growTime * (1 - buffData.buffValue))
  local preHarTime = math.floor(preHarTime * (1 - buffData.buffValue))
  return {growTime = growTime, preHarTime = preHarTime}
end

function this:getProductTplTime(productId)
  local accessoryProductTpl = _accessoryProductTpl:getTplById(productId)
  if accessoryProductTpl then
    return _accessoryProductTpl:getTime(accessoryProductTpl)
  end
  local productTpl = _productsTpl:getTplById(productId)
  if productTpl then
    return _productsTpl:getTime(productTpl)
  end
  return 0
end

function this:getProductProduceTime(productId, conditions, params)
  local staticTimeBuffData = self:getBuff(L_HomeConst.buffId.PRODUCT_STATIC_TIME_VALUE, conditions, params)
  if staticTimeBuffData.buffValue ~= 0 then
    return staticTimeBuffData.buffValue
  end
  local buffData = self:getBuff(L_HomeConst.buffId.PRODUCT_REDUCE_TIME_PERCENT, conditions, params)
  local onceTime = self:getProductTplTime(productId)
  local finalTime = 0
  local buffValue = buffData.buffValue
  local wildWorldBuffData = self:getWildBuffBuildDataByBuffId(L_HomeConst.buffId.PRODUCT_REDUCE_TIME_PERCENT, conditions)
  if wildWorldBuffData then
    buffValue = buffValue + wildWorldBuffData.buffValue
  end
  local laborBuff = 0
  if params.isProduct and onceTime ~= 0 then
    local onceTimeAfterQualityReduct = self:getQualityTimeReduct(nil, params, onceTime)
    laborBuff = (onceTime - onceTimeAfterQualityReduct) / onceTime
  end
  finalTime = onceTime * (1 - buffValue) * (1 - laborBuff)
  if finalTime <= tonumber(L_GameTpl:getGameConstTpl():getData("HOME_PROCESS_PRODUCT_TIME", L_Const.GameTplType.int)) then
    finalTime = tonumber(L_GameTpl:getGameConstTpl():getData("HOME_PROCESS_PRODUCT_TIME", L_Const.GameTplType.int))
  end
  if finalTime < 1 and 0 < finalTime then
    finalTime = 1
  end
  finalTime = math.floor(finalTime)
  return finalTime
end

function this:getPetEggHatchTimeValue(petEggId, conditions, params)
  local buffData = self:getBuff(L_HomeConst.buffId.PETEGG_HATCHTIME_DECREASE_VALUE, conditions, params)
  local buffValue = buffData.buffValue
  local wildWorldBuffData = self:getWildBuffBuildDataByBuffId(L_HomeConst.buffId.PETEGG_HATCHTIME_DECREASE_VALUE, conditions)
  if wildWorldBuffData then
    buffValue = buffValue + wildWorldBuffData.buffValue
  end
  return buffValue
end

function this:getPetEggHatchTimePercent(petEggId, conditions, params)
  local buffData = self:getBuff(L_HomeConst.buffId.PETEGG_HATCHTIME_DECREASE_PERCENT, conditions, params)
  local buffValue = buffData.buffValue
  local wildWorldBuffData = self:getWildBuffBuildDataByBuffId(L_HomeConst.buffId.PETEGG_HATCHTIME_DECREASE_PERCENT, conditions)
  if wildWorldBuffData then
    buffValue = buffValue + wildWorldBuffData.buffValue
  end
  return buffValue
end

function this:getPetEggHatchTimeReduct(params)
  if not params.petGuid or params.petGuid == 0 then
    return 0
  end
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(params.petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local _needLaborType = params.laborType
  local laborGrade = 0
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local id = C_LaborInfo.laborId
    local isMatch = false
    if type(_needLaborType) == "table" then
      for _, needType in ipairs(_needLaborType) do
        if needType == id then
          isMatch = true
          break
        end
      end
    else
      isMatch = id == _needLaborType
    end
    if isMatch then
      laborGrade = C_LaborInfo.laborGrade
    end
  end
  local homeLaborEfficiencyTpl = _homeLaborEfficiencyTpl:getTplById(laborGrade)
  local time = _homeLaborEfficiencyTpl:getTimeReduct(homeLaborEfficiencyTpl) / 10000
  return time
end

local LaborBuffId2ValueGetFunc = {
  [L_HomeConst.buffId.PRODUCT_REDUCE_TIME_PERCENT] = "getTimeReduct",
  [L_HomeConst.buffId.CROP_SEED_SAVE_PROB] = "getSeedRecycle",
  [L_HomeConst.buffId.CROP_HARVEST_SEED_HARVEST] = "getSeedHarvest",
  [L_HomeConst.buffId.CROP_REDUCE_TIME_PERCENT] = "getWaterTimeReduct",
  [L_HomeConst.buffId.ACCESSORY_REDUCE_TIME_PERCENT] = "getAccessoryTimeReduct",
  [L_HomeConst.buffId.COLLECT_REDUCE_TIME_PERCENT] = "getGatherTimeReduct",
  [L_HomeConst.buffId.EGG_REDUCE_TIME_PERCENT] = "getEggTimeReduct",
  [L_HomeConst.buffId.RANCH_REDUCE_TIME_PERCENT] = "getPastureTimeReduct"
}
local BuildType2ValueGetFunc = {
  [2] = "getTimeReduct",
  [8] = "getAccessoryTimeReduct",
  [10] = "getTimeReduct",
  [24] = "getGatherTimeReduct",
  [55] = "getGatherTimeReduct",
  [12] = "getEggTimeReduct",
  [53] = "getPastureTimeReduct"
}
local LaborBuffId2ValueDecreaseKey = {
  [L_HomeConst.buffId.PRODUCT_REDUCE_TIME_PERCENT] = "HOME_LABOR_PROCESS_DECREASE",
  [L_HomeConst.buffId.CROP_SEED_SAVE_PROB] = "HOME_LABOR_PLANT_DECREASE",
  [L_HomeConst.buffId.CROP_HARVEST_SEED_HARVEST] = "HOME_LABOR_HARVEST_DECREASE",
  [L_HomeConst.buffId.CROP_REDUCE_TIME_PERCENT] = "HOME_LABOR_WATERING__DECREASE",
  [L_HomeConst.buffId.ACCESSORY_REDUCE_TIME_PERCENT] = "HOME_LABOR_ACCESSORY_DECREASE",
  [L_HomeConst.buffId.COLLECT_REDUCE_TIME_PERCENT] = "HOME_LABOR_GATHER_DECREASE",
  [L_HomeConst.buffId.EGG_REDUCE_TIME_PERCENT] = "HOME_LABOR_EGG_DECREASE",
  [L_HomeConst.buffId.RANCH_REDUCE_TIME_PERCENT] = "HOME_LABOR_PASTURE_DECREASE"
}
local BuildType2ValueDecreaseKey = {
  [2] = "HOME_LABOR_PROCESS_DECREASE",
  [8] = "HOME_LABOR_PROCESS_DECREASE",
  [10] = "HOME_LABOR_PROCESS_DECREASE",
  [24] = "HOME_LABOR_GATHER_DECREASE",
  [55] = "HOME_LABOR_GATHER_DECREASE",
  [12] = "HOME_LABOR_EGG_DECREASE",
  [53] = "HOME_LABOR_PASTURE_DECREASE"
}

function this:getBuildingLaborBuffValue(buildType, laborGrade)
  if buildType and BuildType2ValueGetFunc[buildType] then
    local tpl = _homeLaborEfficiencyTpl:getTplById(laborGrade)
    local funcName = BuildType2ValueGetFunc[buildType]
    local buffValue = _homeLaborEfficiencyTpl[funcName](_homeLaborEfficiencyTpl, tpl)
    if funcName == "SeedRecycle" or funcName == "SeedHarvest" then
    else
      buffValue = (10000 / (10000 - buffValue) - 1) * 10000
    end
    return buffValue
  end
  return 0
end

function this:getLaborBuffValueWithFunc(funcName, laborGrade)
  if funcName then
    local tpl = _homeLaborEfficiencyTpl:getTplById(laborGrade)
    local buffValue = _homeLaborEfficiencyTpl["get" .. funcName](_homeLaborEfficiencyTpl, tpl)
    if funcName == "SeedRecycle" or funcName == "SeedHarvest" then
    else
      buffValue = (10000 / (10000 - buffValue) - 1) * 10000
    end
    return buffValue
  end
  return 0
end

function this:getQualityTimeReduct(productTpl, params, finalTime)
  if not params.petGuid or params.petGuid == 0 then
    return finalTime
  end
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(params.petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local _needLaborType = params.laborType
  local laborGrade = 0
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local id = C_LaborInfo.laborId
    local isMatch = false
    if type(_needLaborType) == "table" then
      for _, needType in ipairs(_needLaborType) do
        if needType == id then
          isMatch = true
          break
        end
      end
    else
      isMatch = id == _needLaborType
    end
    if isMatch then
      laborGrade = C_LaborInfo.laborGrade
    end
  end
  local buildType = params.buildType
  if buildType and BuildType2ValueGetFunc[buildType] then
    local tpl = _homeLaborEfficiencyTpl:getTplById(laborGrade)
    local buffValue = _homeLaborEfficiencyTpl[BuildType2ValueGetFunc[buildType]](_homeLaborEfficiencyTpl, tpl)
    if C_PetData.satietyVal <= _gameTpl:getData("PET_HOME_TIRED_SATIETY") and BuildType2ValueDecreaseKey[buildType] then
      buffValue = buffValue * (_gameTpl:getData(BuildType2ValueDecreaseKey[buildType]) or 0) / 10000
    end
    if math.isEmpty(buffValue) or buffValue < 0 then
      buffValue = 0
    end
    local time = buffValue / 10000
    local overTime = finalTime - finalTime * time
    return overTime
  end
  return finalTime
end

function this:getHomeCollectionTimeReduct(homeBuildingHomeCollectionId, petGuid, originTime)
  local finalTime = originTime
  if not petGuid or petGuid == 0 then
    return finalTime
  end
  local homeBuildingHomecollectionTpl = L_GameTpl:getHomeBuildingHomecollectionTpl()
  local tpl = homeBuildingHomecollectionTpl:getTplById(homeBuildingHomeCollectionId)
  local laborType = homeBuildingHomecollectionTpl:getLaborType(tpl)
  local buildType = L_Const.WorldMapBuildType.WMBT_HOME_COLLECT
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(petGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local _needLaborType = laborType
  local laborGrade = 0
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local id = C_LaborInfo.laborId
    local isMatch = false
    if type(_needLaborType) == "table" then
      for _, needType in ipairs(_needLaborType) do
        if needType == id then
          isMatch = true
          break
        end
      end
    else
      isMatch = id == _needLaborType
    end
    if isMatch then
      laborGrade = C_LaborInfo.laborGrade
    end
  end
  if buildType and BuildType2ValueGetFunc[buildType] then
    local tpl = _homeLaborEfficiencyTpl:getTplById(laborGrade)
    local buffValue = _homeLaborEfficiencyTpl[BuildType2ValueGetFunc[buildType]](_homeLaborEfficiencyTpl, tpl)
    if C_PetData.satietyVal <= _gameTpl:getData("PET_HOME_TIRED_SATIETY") and BuildType2ValueDecreaseKey[buildType] then
      buffValue = buffValue * (_gameTpl:getData(BuildType2ValueDecreaseKey[buildType]) or 0) / 10000
    end
    if math.isEmpty(buffValue) or buffValue < 0 then
      buffValue = 0
    end
    local time = buffValue / 10000
    local overTime = finalTime - finalTime * time
    return overTime
  end
  return finalTime
end

return this
