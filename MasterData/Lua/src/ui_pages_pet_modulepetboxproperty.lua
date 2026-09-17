local this = class("modulePetBoxProperty", G_UIModuleBase)
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
    },
    showChangePropertyButton = false,
    show_nameModify = true,
    modEuler = Unity.Vector3.zero,
    petModule = "",
    modScale = Unity.Vector3.one,
    modOffest = Unity.Vector3.zero,
    go_master = false,
    img_master = nil,
    txt_masterName = nil,
    txt_masterLevel = nil,
    go_btnIntoFormation = false
  }
end

function this.methods()
  return {
    onClick_replaceBox = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      if pet then
        local index = pet.box_id // 100
        L_UI:open("pagePetBoxSelect", {
          initBoxIndex = index,
          petGuid = self.petId
        })
      end
    end,
    onClick_detail = function(self)
      L_UI:open("pagePet", {
        petId = self.petId
      })
    end,
    onClick_modify = function(self)
      local data = {
        txtTitle = L_WordsTpl:getValue("ui_modulePetBoxName_02"),
        placeHolder = L_WordsTpl:getValue("ui_modulePetBoxName_03"),
        limit = 7,
        keepPageOpen = true,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        confirmCallback = function(txt)
          if string.isEmpty(string.trim(txt)) then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_03")
            return
          end
          if string.gsub(txt, " ", "") ~= txt then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_02")
            return
          end
          
          local function contains_special_char(str)
            local special_char_pattern = "[^%w一-龥]"
            return string.find(str, special_char_pattern) ~= nil
          end
          
          local hasSpecial = contains_special_char(txt)
          if hasSpecial == true then
            L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_04")
            return
          end
          L_PetStore:req_changePetName(txt, self.petId, function(name)
            if name == nil then
              L_UI:close("pageCommonTextBox")
              self:refreshPetProperty(self.petId)
              L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_05")
            end
          end)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end,
    onClick_lockPetFunction = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      if pet.is_lock == true then
        L_PetStore:req_lockPet(self.petId, false, function()
          L_FlyMsgManager:showNormalMsgByKey("notice_pagePetGet_02")
        end)
      else
        L_PetStore:req_lockPet(self.petId, true, function()
          L_FlyMsgManager:showNormalMsgByKey("notice_pagePetGet_03")
        end)
      end
    end,
    onClick_changeShowPropertyMode = function(self)
    end,
    onClick_intoFormation = function(self)
      if self._callbackFromFormation then
        L_UI:close("pagePetBox", nil, function()
          self._callbackFromFormation(self.petId)
        end)
      end
    end
  }
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
  L_PhotoManager:clearPhotoEntity(self.bindComponents.img_head)
  self:openLight(false)
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

function this:openLight(bool)
  self.bindComponents.light.gameObject:ActiveTrans(bool)
  self.bindComponents.pet.gameObject:ActiveTrans(bool)
end

function this:refreshPetProperty(petId)
  if math.isEmpty(petId) then
    return
  end
  local pet = L_PetStore:getPetItem(petId)
  self.petId = petId
  self.expTable = {}
  if math.isEmpty(self.configId) or self.configId ~= pet.id then
    self:initMod(pet)
  end
  self.configId = pet.id
  self.maxLv = L_PetStore:getPetMaxLevel()
  self.lv = pet.lv
  local property = L_PetStore:getPetOriginalProperty(pet)
  local showWarning = false
  local petLv_limit_switch = L_GameConstTpl:getData("PET_LEVEL_LIMIT_SWITCH", L_Const.GameTplType.int)
  if not math.isEmpty(pet.hero_id) then
    local hero = L_HeroStore:getHero(pet.hero_id)
    local heroLevel = L_HeroStore:getHeroLevel(hero)
    local item_hero = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(hero))
    property = L_PetStore:getPetProperty(pet)
    if petLv_limit_switch == 1 then
      showWarning = heroLevel < pet.lv and true or false
      self.bind.showChangePropertyButton = false
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
    printf("宠物guid:" .. pet.guid .. "  |宠物id:" .. pet.id .. " |宠物名:" .. pet.pet_name .. " |宠物属性" .. enumName .. " |悟性rank:" .. rank, "宠物天赋值:", pet.comprehension)
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
  local needShowMaster = not math.isEmpty(pet.hero_id)
  self.bind.go_master = needShowMaster
  if needShowMaster then
    local serverData = L_HeroStore:getHero(pet.hero_id)
    self.bind.txt_masterLevel = tostring(L_HeroStore:getHeroLevel(serverData))
    self.bind.txt_masterName = L_HeroManager:getHeroName(pet.hero_id)
    if pet.hero_id == L_HeroStore:getDefaultHeroGuid() then
      L_PhotoManager:newOrBindPhotoEntity(self.bindComponents.img_head, self.bindComponents.img_head, L_PlayerStore:getPlayerModHeadImgName())
    else
      local tplData = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(serverData))
      self.bind.img_master = tplData.icon
    end
  end
end

function this:getPetLv()
  local pet = L_PetStore:getPetItem(self.petId)
  return pet.lv
end

function this:activeSkillListFuntion(bool)
  self.bind.btnHideSkillDetail_active = bool == false
  self.bind.skillListScroll_active = bool
end

function this:initMod(pet)
  local tpl = petInfoTpl:getTplById(pet.id)
  local unitID = petInfoTpl:getUnitID(tpl)
  local all_stage_scale = 1
  if unitID then
    local unitTpl = L_GameTpl:getUnitTpl()
    local unit = unitTpl:getTplById(unitID)
    local path = unitTpl:getModel(unit, 1, pet:isSpecialPet())
    local worldScale = unitTpl:getModelScale(unit)
    local scale = all_stage_scale / 10000
    local height = Unity.Screen.height
    local width = Unity.Screen.width
    local factor = 1
    if 1.7777777777777777 < width / height then
      factor = 0.926 * (width / height) - 0.65
    end
    self.bind.modScale = Unity.Vector3(scale * worldScale, scale * worldScale, scale * worldScale)
    self.bind.petModule = path
    self.bind.modEuler = L_Vector3.zero
    self.bind.modOffest = L_Vector3.zero
    if not L_CommonUtil.isValid(self.bindComponents.Pet.prefab) then
      return
    end
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), self.bindComponents.Pet.prefab)
    if biologyData then
      biologyData:UsePreviewLodLevelByInt()
    end
    self.animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.bindComponents.Pet.prefab)
    self.animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    self.animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
    if self.controllerAssetHandle then
      C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    end
    local needAnimaList = {"Idle"}
    local loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), #needAnimaList)
    for i = 1, #needAnimaList do
      loadNames[i - 1] = needAnimaList[i]
    end
    self.controllerAssetHandle = C_LuaUtility.LoadPlayableController(unitTpl:getAnimatorConfig(unit, L_Const.avatarAnimatorConfigIndex.uiPreview), loadNames)
    self.animator.defaultAnimatorController = self.controllerAssetHandle.config
    if self.petEntity then
      self.petEntity:Destroy()
      self.petEntity = nil
    end
    self.petEntity = L_EntityManager:generatePreviewPet(pet.guid, self.bindComponents.Pet.prefab, pet, needAnimaList)
    self.animator:Play("Idle")
  end
end

function this:destroy()
  this.super.destroy(self)
  if self.petEntity then
    self.petEntity:Destroy()
    self.petEntity = nil
  end
  if self.controllerAssetHandle then
    C_LuaUtility.ReleasePlayableController(self.controllerAssetHandle)
    self.controllerAssetHandle = nil
  end
end

return this
