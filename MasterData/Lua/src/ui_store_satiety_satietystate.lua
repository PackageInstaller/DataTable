local this = {}
local _commonPetSatietyTpl = L_GameTpl:getCommonPetSatietyTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()

function this:init()
  this.super.init(self)
end

function this:getPetSatiety(petGuid)
  if math.isEmpty(petGuid) then
    return 0
  end
  local petItem = L_PetStore:getPetItem(petGuid)
  if not petItem then
    return 0
  end
  return petItem.satiety
end

function this:getPetMaxSatiety(petGuid)
  if math.isEmpty(petGuid) then
    return math.maxinteger
  end
  local pet = L_PetStore:getPetItem(petGuid)
  if not pet then
    return math.maxinteger
  end
  local talentTpl = _petHomeTalentTpl:getTplById(pet.petId)
  if talentTpl then
    local petMaxSatiety = _petHomeTalentTpl:getSatietyScore(talentTpl)
    return petMaxSatiety
  end
  return math.maxinteger
end

function this:getPetSatietyPercent(petGuid)
  return self:getPetSatiety(petGuid) / self:getPetMaxSatiety(petGuid)
end

function this:getPetSatietyStatus(petGuid, satietyPer)
  local percent = satietyPer ~= nil and satietyPer ~= -1 and satietyPer or self:getPetSatietyPercent(petGuid)
  for _, v in pairs(_commonPetSatietyTpl:getValue()) do
    for min, max in pairs(v.satiety) do
      if percent >= min / 10000 and percent <= max / 10000 then
        return v.id
      end
    end
  end
  return L_PetConst.SatietyStatus.FULL
end

function this:isBuildingPause(buildingGuid)
  local buildData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  if buildData and not math.isEmpty(buildData.station_pet_guid) then
    return self:isWorkPause(buildData.station_pet_guid) or self:isEating(buildData.station_pet_guid)
  end
  return false
end

function this:isSatietyPause(buildingGuid, productGuid)
  if not buildingGuid or not productGuid then
    return false
  end
  local buildData = L_HomeStore:getHomeBuildingByGuid(buildingGuid)
  if buildData then
    local buildId = buildData.build_id
    if not buildId then
      return false
    end
    local needPreReduce = _homeBuildingProductionTpl:getReduceSatietyScoreBefore(_homeBuildingProductionTpl:getTplById(buildId))
    if not needPreReduce then
      return false
    end
    local petGuid = buildData.station_pet_guid
    if petGuid then
      local pet = L_PetStore:getPetItem(petGuid)
      if pet then
        local csHomeBuildProductData = L_ProductManager:getProductByGuid(buildingGuid, productGuid)
        if csHomeBuildProductData then
          local costUnit = L_ProductManager:getProductSatietyScore(csHomeBuildProductData.productId) or 0
          local satietyVal = self:getPetSatiety(petGuid)
          return costUnit > satietyVal
        end
      end
    end
  end
  return false
end

function this:isWorkPause(petGuid)
  if self:isEating(petGuid) then
    return true
  end
  local pet = L_PetStore:getPetItem(petGuid)
  if pet then
    return pet.work_pause
  else
    printf("satietyState:isWorkPause", string.format("警告：无法找到具有给定petGuid %s 的宠物服务器数据。", petGuid))
    return false
  end
end

function this:isEating(petGuid)
  local pet = L_PetStore:getPetItem(petGuid)
  if pet then
    return not math.isEmpty(pet.canteen_id)
  end
  return false
end

return this
