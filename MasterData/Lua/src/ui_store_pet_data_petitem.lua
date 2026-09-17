local this = class("petItem")

function this:ctor()
  self.pet_name = nil
  self.guid = nil
  self.id = nil
  self.feature = nil
  self.comprehension = nil
  self.petTalentId = 0
  self.tpl = nil
  self.skills = nil
  self.lv = nil
  self.rank = nil
  self.exp = nil
  self.hero_id = nil
  self.petId = nil
  self.catchLevel = nil
  self.work_status = nil
  self.work_build = nil
  self.talent_id = {}
  self.capacity_id = nil
  self.roulette_pos = nil
  self.satiety_val = nil
  self.canteen_id = nil
  self.work_start_time = nil
  self.work_pause = nil
  self.base_lv = nil
  self.satiety = nil
  self.box_id = nil
  self.laborInfoList = {}
  self.special = L_Const.PetSpecialType.PST_NORMAL
  self.colorMatId = 0
  self.enemyType = 0
  self.tour_state = 0
  self.stage = 1
  self.node = 1
  self.canNotRelease = false
  self.wear_skin_id = 0
end

function this:isWorking()
  return self.work_status == L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK or self.work_status == L_Const.PetStationedWorkStatusType.PSWST_RANCH_WORK or self.work_status == L_Const.PetStationedWorkStatusType.PSWST_FIELD_WORK or self.work_status == L_Const.PetStationedWorkStatusType.PSWST_WILD_WORK
end

function this:isRest()
  return self.work_status == L_Const.PetStationedWorkStatusType.PSWST_HOME_REST or self.work_status == L_Const.PetStationedWorkStatusType.PSWST_WILD_REST or not math.isEmpty(self.canteen_id)
end

function this:isFreeWork()
  local csPetData = L_PetStore:getCsPetData(self.guid)
  return L_PetStore:getPetIsFreeWork(csPetData)
end

function this:isCollectionWorking()
  return self.work_status == L_Const.PetStationedWorkStatusType.PSWST_WILD_WORK or self.work_status == L_Const.PetStationedWorkStatusType.PSWST_WILD_REST
end

function this:isInMountRoulette()
  return not math.isEmpty(self.roulette_pos)
end

function this:isInCanteen()
  return not math.isEmpty(self.canteen_id)
end

function this:getGameplayStatus()
  if self:isWorking() then
    return L_Const.PetState.PET_WORKING
  elseif self:isRest() then
    return L_Const.PetState.PET_RESTING
  elseif self:isFreeWork() then
    return L_Const.PetState.PET_HUB
  elseif not math.isEmpty(self.roulette_pos) then
    return L_Const.PetState.PET_ROULETTE
  elseif not math.isEmpty(self.hero_id) then
    return L_Const.PetState.PET_HERO
  else
    return L_Const.PetState.PET_NORMAL
  end
end

function this:isOnHero()
  return not math.isEmpty(self.hero_id)
end

function this:isSpecialPet()
  return self.color
end

function this:hasFlashGene()
  return self.special == L_Const.PetSpecialType.PST_FLASH or self.special == L_Const.PetSpecialType.PST_FLASH_COLOR or self.special == L_Const.PetSpecialType.PST_FLASH_COLORFUL
end

function this:getIsSpecialPet()
  return self.special == L_Const.PetSpecialType.PST_COLOR or self.special == L_Const.PetSpecialType.PST_FLASH_COLOR
end

function this:isStarColorPet()
  return self.colorMatId > 0
end

function this:getPetName()
  return self.pet_name
end

function this:petCfgId()
  return self.id
end

function this:petGuid()
  return self.guid
end

function this:petLv()
  return self.lv
end

function this:getCatchLevel()
  return self.catchLevel
end

function this:getExp()
  return self.exp
end

function this:petCatchItemId()
  return self.catch_item or 0
end

function this:petFavorVal()
  return self.favor_val or 0
end

function this:petFavorLv()
  return self.favor_lv or 0
end

function this:getHeroId()
  return self.hero_id
end

function this:getIsTrial()
  return C_DataUtil.GetUuid2FightObjType(self.guid) == L_Const.FightObjType.FO_Trial_Pet
end

function this:getPetGrade()
  return self.grade or 0
end

function this:getTargetAttributeComprehension(attrEnumNum)
  if not self.comprehension then
    return nil
  end
  if type(self.comprehension) == "userdata" and self.comprehension.Count ~= nil then
    for i = 0, self.comprehension.Count - 1 do
      local comprehension = self.comprehension[i]
      local attrId = comprehension.attr_id or comprehension.attrId
      if attrId == attrEnumNum then
        return comprehension
      end
    end
    return nil
  end
  for _, comprehension in pairs(self.comprehension) do
    local attrId = comprehension.attr_id or comprehension.attrId
    if attrId == attrEnumNum then
      return comprehension
    end
  end
  return nil
end

function this:getWorkBuilding()
  return self.work_build
end

function this:hasMutationGene()
  if table.isEmpty(self.mutation_info) then
    return false
  end
  return self.mutation_info.pos > 0
end

function this:getMutationInfo()
  return self.mutation_info
end

function this:haveMutationNum()
  return not math.isEmpty(self.mutation_times) and self.mutation_times > 0
end

function this:getLaborInfoList()
  return self.laborInfoList
end

function this:getPetAbilityAllAttriDecay(catchCurrencyNum)
  if catchCurrencyNum == nil then
    catchCurrencyNum = L_PlayerStore:getCurrencyNum(L_Const.currencyType.catchForce)
  end
  local catchLevel = self.catchLevel
  if catchLevel == nil or catchCurrencyNum >= catchLevel then
    return 0
  end
  local lvDif = catchLevel - catchCurrencyNum
  local petLevelDecayTpl = L_GameTpl:getPetLevelDecayTpl()
  local decayTpl = petLevelDecayTpl:getTplByLvDif(lvDif)
  if decayTpl == nil then
    return 0
  end
  local enemyType = self.enemyType or 0
  if enemyType == L_Const.enemyType.elite then
    return petLevelDecayTpl:getEliteAttriDown(decayTpl) or 0
  elseif enemyType == L_Const.enemyType.boss then
    return petLevelDecayTpl:getBossAttriDown(decayTpl) or 0
  end
  return petLevelDecayTpl:getNormalAttriDown(decayTpl) or 0
end

function this:getPetAbilityLimited()
  return self:getPetAbilityAllAttriDecay() ~= 0
end

function this:getNoAnnoyMinCatchForce()
  local catchLevel = self.catchLevel
  if catchLevel == nil or catchLevel <= 0 then
    return 0
  end
  for catchCurrencyNum = 0, catchLevel do
    if self:getPetAbilityAllAttriDecay(catchCurrencyNum) == 0 then
      return catchCurrencyNum
    end
  end
  return catchLevel
end

function this:haveSkinConfig()
  if not C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(L_SystemConst.enum.petDecoration) then
    return false
  end
  local petSkinTpl = L_GameTpl:getPetSkinTpl()
  local petSkinConfig = petSkinTpl:getAllTpl()
  if math.isEmpty(self.id) or table.isEmpty(petSkinConfig) then
    return false
  end
  local kiboId = self.id
  for _, skinConfig in pairs(petSkinConfig) do
    if skinConfig and petSkinTpl:getKiboId(skinConfig) == kiboId then
      return true
    end
  end
  return false
end

function this:isWearSkin()
  return self.wear_skin_id ~= nil and self.wear_skin_id ~= 0
end

function this:getSkinInfo()
  if self:isWearSkin() then
    local petSkinConfig = L_GameTpl:getPetSkinTpl()
    local petSkinConfigData = petSkinConfig:getTplById(self.wear_skin_id)
    return {
      skinId = self.wear_skin_id,
      unitSuffix = petSkinConfig:getUnitSuffix(petSkinConfigData),
      animatorSuffix = petSkinConfig:getAnimatorSuffix(petSkinConfigData)
    }
  end
  return nil
end

function this:checkCanEvo()
  if math.isEmpty(self.id) then
    return false
  end
  local petRankTpl = L_GameTpl:getPetRankTpl()
  local rankData = petRankTpl:getchildren(self.id)
  if table.isEmpty(rankData) then
    return false
  end
  if math.isEmpty(rankData.nextPetId) then
    return false
  end
  if self:getPetAbilityLimited() then
    return false
  end
  local levelNeed = rankData.levelNeed
  if levelNeed == nil or levelNeed > self.lv then
    return false
  end
  local costItems = rankData.rankBreakthroughItem or {}
  for i = 1, #costItems do
    local itemInfo = costItems[i]
    local itemType, itemId, itemCount
    if #itemInfo == 2 then
      itemType = L_Const.resType.commonItem
      itemId = itemInfo[1]
      itemCount = itemInfo[2]
    elseif #itemInfo == 3 then
      itemType = itemInfo[1]
      itemId = itemInfo[2]
      itemCount = itemInfo[3]
    end
    if not math.isEmpty(itemId) then
      local hasNum = L_ItemTplManager:getItemNum(itemType, itemId)
      if itemCount > hasNum then
        return false
      end
    end
  end
  return true
end

return this
