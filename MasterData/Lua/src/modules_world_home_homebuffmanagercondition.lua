local this = {}
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _petRaceTpl = L_GameTpl:getPetRaceTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _petEggTpl = L_GameTpl:getPetEggTpl()
local _HomeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _HomeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()

function this:getConditionTargetName(condtionId, targetId)
  if condtionId == L_HomeConst.buffConditionType.SEED_TYPE then
    local _TypeTpl = L_GameTpl:getHomeCropTypeTpl()
    local tpl = _TypeTpl:getTplById(targetId)
    return _TypeTpl:getCropType(tpl)
  elseif condtionId == L_HomeConst.buffConditionType.COLLECTION_GROUP then
    for _, tpl in pairs(_HomeCollectionWorldTpl.data) do
      if _HomeCollectionWorldTpl:getGroupId(tpl) == targetId then
        return _HomeCollectionWorldTpl:getName(tpl)
      end
    end
  elseif condtionId == L_HomeConst.buffConditionType.PRODUCT_TYPE then
    for _, tpl in pairs(_HomeBuildingProductionTpl.data) do
      if _HomeBuildingProductionTpl:getType(tpl) == targetId then
        local buildTpl = _HomeBuildingTpl:getTplById(_HomeBuildingProductionTpl:getId(tpl))
        local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
        local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
        local homeBuffType = _HomeBuildingGroupTpl:getHomeBuffType(groupTpl)
        return homeBuffType ~= "" and homeBuffType or _HomeBuildingGroupTpl:getName(groupTpl)
      end
    end
  elseif condtionId == L_HomeConst.buffConditionType.PETEGG_ELEMENT then
    local tpl = _elementTypeTpl:getTplById(targetId)
    return _elementTypeTpl:getAbbrName(tpl)
  elseif condtionId == L_HomeConst.buffConditionType.PRODUCT_ELEMENT then
    local tpl = _elementTypeTpl:getTplById(targetId)
    return _elementTypeTpl:getAbbrName(tpl)
  elseif condtionId == L_HomeConst.buffConditionType.HOME_DROP_ELEMENT then
    local tpl = _elementTypeTpl:getTplById(targetId)
    return _elementTypeTpl:getAbbrName(tpl)
  elseif condtionId == L_HomeConst.buffConditionType.HOME_DROP_RACE then
    local tpl = _petRaceTpl:getTplById(targetId)
    return _petRaceTpl:getRaceType(tpl)
  end
end

function this:getCropCondition(seedId)
  local seedTpl = _homeSeedTpl:getTplById(seedId)
  local conditions = {
    [L_HomeConst.buffConditionType.FIELD_TYPE] = _homeSeedTpl:getFieldType(seedTpl),
    [L_HomeConst.buffConditionType.SEED_TYPE] = _homeSeedTpl:getCropType(seedTpl),
    [L_HomeConst.buffConditionType.SEED_ID] = seedId
  }
  return conditions
end

function this:getFieldCondition(fieldType)
  local conditions = {
    [L_HomeConst.buffConditionType.FIELD_TYPE] = fieldType
  }
  return conditions
end

function this:getPetEggHatchCondition(petEggConfigId)
  self.petEggConfigId2PetEggHatchCondition = self.petEggConfigId2PetEggHatchCondition or {}
  if self.petEggConfigId2PetEggHatchCondition[petEggConfigId] == nil then
    local petEggTpl = _petEggTpl:getTplById(petEggConfigId)
    local conditions = {
      [L_HomeConst.buffConditionType.PETEGG_ELEMENT] = _petEggTpl:getElement(petEggTpl)
    }
    self.petEggConfigId2PetEggHatchCondition[petEggConfigId] = conditions
  end
  return self.petEggConfigId2PetEggHatchCondition[petEggConfigId]
end

return this
