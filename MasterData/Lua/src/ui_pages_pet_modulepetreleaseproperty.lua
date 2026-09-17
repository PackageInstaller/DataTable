local this = class("modulePetReleaseProperty", G_UIModuleBase)
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    pet_name = "",
    petPropertyList = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    module_simpleTags = {
      moduleName = "pages/pet/modulePetSimpleTags"
    },
    module_homeTags = {
      moduleName = "pages/pet/modulePetHomeTags"
    },
    module_petSkills = {
      moduleName = "pages/pet/modulePetSkills"
    },
    module_petGenes = {
      moduleName = "pages/pet/modulePetGeneInfo"
    },
    module_petCommonInfo = {
      moduleName = "pages/pet/modulePetCommonInfo"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  self.uiCamera = C_CameraManager.uiCamera
  self.screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
  self.recoverLimit = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
  self.recoverPoint = tonumber(L_GameTpl:getGameConstTpl():getData("PET_ENERGYRECOVER", L_Const.GameTplType.int))
  self.scale = tonumber(L_GameTpl:getGameConstTpl():getData("PET_ENERGYPERSEC", L_Const.GameTplType.int))
  self.activeBaseInfo = true
  self:activeSkillListFuntion(true)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  self._ESyncMountRouletteServerDataHandler = handler(self, self.onEvent_mountSync)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.petId then
    return
  end
  self:refreshPetProperty(self.petId)
end

function this:onEvent_setCurPetId(petId)
  if petId ~= self.petId then
    return
  end
  self:refreshPetProperty(self.petId)
end

function this:onEvent_mountSync()
  if math.isEmpty(self.petId) then
    return
  end
  self:refreshPetProperty(self.petId)
end

function this:onEvent_showPetSkillInfo(skillInfo, type)
  if L_PetStore:getIsPlayingTimeLine() then
    local queue = L_PetStore:getPetSkillInfoQueue()
    local data = {skillInfo = skillInfo, type = type}
    queue:enQueue(data)
  else
    L_UI:open("pagePetSkillNewInfo", {
      skillInfo = skillInfo,
      type = type,
      guid = self.petId
    })
  end
end

function this:refreshPetProperty(petId, hideMode)
  if math.isEmpty(petId) then
    return
  end
  local pet = L_PetStore:getPetItem(petId)
  self.petId = petId
  self.expTable = {}
  self.configId = pet.id
  self.maxLv = L_PetStore:getPetMaxLevel()
  self.lv = pet.lv
  local property = L_PetStore:getPetOriginalProperty(pet)
  local showWarning = false
  local petLv_limit_switch = L_GameConstTpl:getData("PET_LEVEL_LIMIT_SWITCH", L_Const.GameTplType.int)
  if not math.isEmpty(pet.hero_id) then
    local hero = L_HeroStore:getHero(pet.hero_id)
    local heroLevel = L_HeroStore:getHeroLevel(hero)
    property = L_PetStore:getPetProperty(pet)
    if petLv_limit_switch == 1 then
      showWarning = heroLevel < pet.lv and true or false
    else
      showWarning = false
    end
  else
    showWarning = false
  end
  local comprehensionGroup = property.comprehensionRank
  local comprehension = {}
  for i = 1, #comprehensionGroup do
    local tpl = petLearningAblityTpl:getTplById(comprehensionGroup[i].id)
    local score = petLearningAblityTpl:getScore(tpl)
    comprehension[comprehensionGroup[i].enumId] = score
    local enumName = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(comprehensionGroup[i].enumId))
    local rank = petLearningAblityTpl:getLevel(tpl)
    printf("宠物guid:" .. pet.guid .. "  |宠物id:" .. pet.id .. " |宠物名:" .. pet.pet_name .. " |宠物属性" .. enumName .. " |悟性rank:" .. rank)
  end
  self.modules.module_simpleTags:setGuid(petId)
  self.modules.module_homeTags:setGuid(petId)
  self.modules.module_petSkills:setGuid(petId)
  self.modules.module_petGenes:setGuid(petId)
  self.modules.module_petCommonInfo:setGuid(petId)
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
  self.bind.petPropertyList:clear()
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum(true)
  for i, v in ipairs(all_Attribute) do
    local enumId = petLearningEnumTpl:getEnumNum(v)
    local id = 0
    for n, k in pairs(topRankComprehension) do
      if k.attr_id == enumId then
        id = k.rankId
        break
      end
    end
    table.insert(propertyData, {
      attrIcon = petLearningEnumTpl:getNewIcon(petLearningEnumTpl:getTplByEnumId(enumId)),
      value = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(property, enumId, petId)),
      name = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrId = id
    })
  end
  self.bind.petPropertyList:insert_array(propertyData)
  self.bind.pet_name = pet.pet_name
end

function this:getPetLv()
  local pet = L_PetStore:getPetItem(self.petId)
  return pet.lv
end

function this:activeSkillListFuntion(bool)
  self.bind.btnHideSkillDetail_active = bool == false
  self.bind.skillListScroll_active = bool
end

return this
