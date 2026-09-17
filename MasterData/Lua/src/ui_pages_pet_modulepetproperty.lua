local this = class("modulePetProperty", G_UIModuleBase)
local _gameTpl = L_GameTpl:getGameConstTpl()
local petLevelTpl = L_GameTpl:getPetLevelTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local ratio = _gameTpl:getData("PET_LEVELUP_GOLD", L_Const.GameTplType.int) / 10000
local PROPID = {
  402000,
  402001,
  402002,
  402003
}

function this.bind()
  return {
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    active_info = true,
    pet_name = "",
    lockPetImage = "",
    active_rename = false,
    module_simpleTags = {
      moduleName = "pages/Pet/modulePetSimpleTags"
    },
    txt_height = "183.5m",
    petPropertyList = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    module_homeTags = {
      moduleName = "pages/Pet/modulePetHomeTags"
    },
    tagList = {
      moduleName = "pages/Pet/cellTagItem"
    },
    module_petSkills = {
      moduleName = "pages/Pet/modulePetSkills"
    },
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    module_petCommonInfo = {
      moduleName = "pages/pet/modulePetCommonInfo"
    },
    showChangePropertyButton = false,
    active_tagTip = false,
    list_tagTip = {
      moduleName = "pages/Pet/cellTagTipItem"
    },
    size_tipBoard = C_Vector2(592, 853),
    active_exp = false,
    currentLv = "",
    currentLv_ani = "",
    current_exp = "0",
    next_exp = "0",
    lvSlider = 0,
    addExpSlider = 0,
    gold = true,
    goldNum = "",
    expPropItem = {
      moduleName = "modulePages/cellIconCircle"
    },
    go_activeItemList = false,
    go_activeHeroLevelUpArea = false,
    go_activeMaxLvTips = false,
    go_activeMaxLabel = false,
    go_activeExpArea = false,
    petPreviewPropertyList = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    expBgActive = true,
    unlockDesText = "",
    unlockDesActive = false,
    ani_module = ""
  }
end

function this.methods()
  return {
    onClick_tagTip = function(self)
      self.bind.active_tagTip = true
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.tagTipNode)
      self.bind.size_tipBoard = C_Vector2(592, math.min(self.bindComponents.tagTipNode.sizeDelta.y + 34, 598))
      L_UI:open("pageBlank", {
        callback = function()
          self.bind.active_tagTip = false
        end
      })
    end,
    onClick_openExp = function(self)
      if tonumber(self:getPetLv()) >= tonumber(L_PetStore:getPetMaxLevel()) then
        L_PetManager:petHintInfo(5)
        return
      else
        self:changeMode(false)
        self:setCurrentExp()
        self:setExpBp()
        self.parent:setUpBg(false)
        self.parent:setCommonTopData(handler(self, self.closeExp), L_WordsTpl:getValue("residual_code_modulepetproperty_01"))
      end
    end,
    onClick_reset = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      if self.lv ~= pet.lv then
        self:playFxSoundByLevelChange(true)
      end
      self:setExpBp()
      self:refreshPetProperty(L_PetStore:getCurSelectPetId())
    end,
    onClick_autoSelect = function(self)
      if self:getPetLv() >= L_PetStore:getPetMaxLevel() then
        L_PetManager:petHintInfo(5)
        return
      end
      if self.lv >= L_PetStore:getPetMaxLevel(true) then
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_levelmax"))
        return
      end
      if self:getPetLv() >= L_PetStore:getPetMaxLevel(true) then
        L_FlyMsgManager:showNormalMsg(self.bind.unlockDesText)
        return
      end
      self:autoLvUpSet()
    end,
    onClick_lvUp = function(self)
      local selectedInfo = self:getSelectedInfo()
      if selectedInfo[1] == nil then
        L_PetManager:petHintInfo(6)
        return
      end
      if L_PlayerStore:getCurrency(L_Const.currencyType.gold) and L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) < self.goldNum then
        L_PetManager:petHintInfo(1)
        return
      end
      self:reqLevelUp(self.petId, selectedInfo)
    end,
    onClick_modify = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      local data = {
        txtTitle = L_WordsTpl:getValue("notice_petInheritance_05"),
        placeHolder = L_WordsTpl:getValue("ui_modulePetBoxName_03"),
        limit = 7,
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
      if self.changeShowPropertyMode == true then
        self.changeShowPropertyMode = false
      else
        self.changeShowPropertyMode = true
      end
      self:refreshPetProperty(self.petId)
    end,
    onClick_detailsBtn = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      local affectByHero = false
      if not math.isEmpty(pet.hero_id) then
        affectByHero = true
      end
      local switchProperty = self.changeShowPropertyMode == true and affectByHero == true
      L_UI:open("pageProperty", {
        petData = pet,
        switchMode = switchProperty,
        detailId = L_Const.propertyDetail.kiBo
      })
    end,
    onClick_reduce = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      local petLv = pet.lv
      local lv = self:getCurrentLv()
      if petLv >= lv then
        local tempExpAll = self:getExpAll()
        if tempExpAll <= 0 then
          L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_levelmin"))
          return
        end
        self:autoSetItemToTargetLevel(lv, true)
      else
        self:autoSetItemToTargetLevel(lv - 1, true)
      end
    end,
    onClick_add = function(self)
      local lv = self:getCurrentLv()
      local maxLv = self:getMaxLv()
      if lv >= maxLv then
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_levelmax"))
        return
      end
      self:autoSetItemToTargetLevel(lv + 1)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  self.uiCamera = C_CameraManager.uiCamera
  self.screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
  self.recoverLimit = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
  self.recoverPoint = tonumber(L_GameTpl:getGameConstTpl():getData("PET_ENERGYRECOVER", L_Const.GameTplType.int))
  self.scale = tonumber(L_GameTpl:getGameConstTpl():getData("PET_ENERGYPERSEC", L_Const.GameTplType.int))
end

function this:open()
  self.bind.active_info = true
  self.bind.ani_module = "anim_pet_property_in"
  self.changeShowPropertyMode = false
  self:refreshPetProperty(L_PetStore:getCurSelectPetId())
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  L_PetStore:listenCallFunc(L_PetStore.event.getNewPetSkill, self.onEvent_showPetSkillInfo, self)
  L_PetStore:listenCallFunc(L_PetStore.event.updatePetSkill, self.onEvent_showPetSkillInfo, self)
  L_PetStore:listenCallFunc(L_PetStore.event.convertPetSkill, self.onEvent_showPetSkillInfo, self)
  self._ESyncMountRouletteServerDataHandler = handler(self, self.onEvent_mountSync)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
  self._expAnimator = self.bindComponents.expAnimator
end

local ModuleMode = {INFO = true, EXP = false}

function this:changeMode(mode)
  L_TimerManager:stopTimer(self, "changeani")
  if mode == ModuleMode.INFO then
    self.bind.ani_module = "anim_pet_property_toinfo"
    self.bind.ani_module = ""
    self.bind.active_info = true
    L_TimerManager:newOrResetTimer(self, "changeani", function()
      self.bind.active_exp = false
    end, 0.333)
  else
    self.bind.ani_module = "anim_pet_property_toEXP"
    self.bind.ani_module = ""
    self.bind.active_exp = true
    L_TimerManager:newOrResetTimer(self, "changeani", function()
      self.bind.active_info = false
    end, 0.333)
  end
end

function this:close()
  self:killTween()
  L_TimerManager:clearTimer(self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
  L_PetStore:unListenCallFunc(L_PetStore.event.getNewPetSkill, self.onEvent_showPetSkillInfo)
  L_PetStore:unListenCallFunc(L_PetStore.event.updatePetSkill, self.onEvent_showPetSkillInfo)
  L_PetStore:unListenCallFunc(L_PetStore.event.convertPetSkill, self.onEvent_showPetSkillInfo)
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.petId then
    return
  end
  self:checkRefreshPet()
end

function this:stopCellAnim()
  for i, module in ipairs(self.modules.petPreviewPropertyList) do
    module:stopAni()
  end
  self._upgradeAnimating = false
end

function this:checkRefreshPet()
  local pet = L_PetStore:getPetItem(self.petId)
  if self._upgradeAnimating then
    return
  end
  if pet.lv >= self.maxLv then
    self:changeMode(true)
    self.parent:setUpBg(true)
  end
  self:refreshPetProperty(self.petId)
end

function this:onEvent_setCurPetId(petId)
  if self.bind.advanceModuleName == "advanceModule" then
    self:closePetAdvance()
  end
  self:refreshPetProperty(petId)
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
    L_TimerManager:newOrResetTimer(self, "newskill", function()
      L_UI:open("pagePetSkillNewInfo", {
        skillInfo = skillInfo,
        type = type,
        guid = self.petId
      })
    end, 0.5)
  end
end

function this:refreshPetProperty(petId)
  if petId == 0 or petId == nil then
    return
  end
  local pet = L_PetStore:getPetItem(petId)
  local petTpl = petInfoTpl:getTplById(pet.id)
  self.bind.active_rename = petInfoTpl:getIsRename(petTpl)
  self.modules.module_simpleTags:setGuid(petId)
  self.modules.module_homeTags:setGuid(petId)
  self.modules.module_petSkills:setGuid(petId)
  self.modules.module_pixelIcon:setGuid(petId)
  self.modules.module_petCommonInfo:setGuid(petId)
  local size = petInfoTpl:getSize(petTpl)
  if math.isEmpty(size) then
    self.bind.txt_height = "???"
  else
    local integer, float = math.modf(tonumber(string.format("%.1f", size / 10000)))
    if float == 0 then
      self.bind.txt_height = string.format("%dcm", integer)
    else
      self.bind.txt_height = string.format("%.1fcm", size / 10000)
    end
  end
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.petStrength)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
  self.petId = petId
  self.expTable = {}
  self.configId = pet.id
  self.maxLv = L_PetStore:getPetMaxLevel(true)
  self.lv = pet.lv
  local property = L_PetStore:getPetOriginalProperty(pet)
  local showWarning = false
  local petLv_limit_switch = L_GameConstTpl:getData("PET_LEVEL_LIMIT_SWITCH", L_Const.GameTplType.int)
  if not math.isEmpty(pet.hero_id) then
    local hero = L_HeroStore:getHero(pet.hero_id)
    local heroLevel = L_HeroStore:getHeroLevel(hero)
    self.parent:showMasterIcon(true, heroLevel, hero)
    property = L_PetStore:getPetProperty(pet)
    if petLv_limit_switch == 1 then
      showWarning = heroLevel < pet.lv and true or false
      self.bind.showChangePropertyButton = heroLevel < pet.lv and true or false
      if self.changeShowPropertyMode == true then
      end
    else
      showWarning = false
      self.bind.showChangePropertyButton = false
    end
  else
    showWarning = false
    self.bind.showChangePropertyButton = false
    self.parent:showMasterIcon(false)
  end
  self.parent:showWarning(showWarning)
  local comprehensionGroup = property.comprehensionRank
  local comprehension = {}
  for i = 1, #comprehensionGroup do
    local tpl = petLearningAblityTpl:getTplById(comprehensionGroup[i].id)
    local score = petLearningAblityTpl:getScore(tpl)
    comprehension[comprehensionGroup[i].enumId] = score
  end
  local gradeTpl = petGradeTpl:getTplById(property.gradeRank)
  self.bind.petGradeIcon = petGradeTpl:getIcon(gradeTpl)
  self.bind.txt_grade = L_HeroManager:addComma(property.grade)
  self.bind.tagList:clear()
  self.bind.list_tagTip:clear()
  local tagData = {}
  local tagTipData = {}
  local featureList = L_PetStore:getPetFeatureSkill(pet)
  for i, v in ipairs(featureList) do
    table.insert(tagData, {
      type = (v.skillElement[1] or 0) % 3 + 1,
      label = string.format("%s", v.skillName)
    })
    table.insert(tagTipData, {
      type = (v.skillElement[1] or 0) % 3 + 1,
      label = string.format("%s", v.skillName),
      txt_desc = string.isEmpty(v.describe) and L_WordsTpl:getValue("residual_code_modulepetproperty_02") or v.describe
    })
  end
  self.bind.tagList:insert_array(tagData)
  self.bind.list_tagTip:insert_array(tagTipData)
  self.bind.lockPetImage = pet.is_lock == true and "Page/BSCommon/tex_common_icon_lock02" or "Page/BSCommon/tex_common_icon_lock01"
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
  if self.bindComponents.name.preferredWidth > 305 then
    self.bindComponents.nameTrans.sizeDelta = C_Vector2(305, 60)
    self.bindComponents.contentSizeFitter.enabled = false
  else
    self.bindComponents.contentSizeFitter.enabled = true
  end
  local rankLv = petRankTpl:getchildren(self.configId)
  if rankLv ~= nil then
    self.evolutionLv = rankLv.levelNeed
  else
    self.evolutionLv = 0
  end
  self.bind.currentLv_ani = tostring(math.floor(pet.lv))
  L_TimerManager:newOrResetTimer(self, "anilv", function()
    self.bind.currentLv = self.bind.currentLv_ani
  end, 0.033)
  local tpl = petLevelTpl:getTplById(pet.lv)
  local next_exp = petLevelTpl:getExp(tpl)
  local showExpButton = next_exp ~= 0 and true or false
  self.modules.module_petCommonInfo:showOpenExpButton(showExpButton)
  if pet.lv == L_PetStore:getPetMaxLevel() then
    self.bind.lvSlider = 1
    local maxTpl = petLevelTpl:getTplById(pet.lv - 1)
    local maxExp = petLevelTpl:getExp(maxTpl)
    self.bind.current_exp = tostring(maxExp)
    self.bind.next_exp = tostring(maxExp)
  else
    if self.lv == self.maxLv then
      local maxTpl = petLevelTpl:getTplById(pet.lv - 1)
      local maxExp = petLevelTpl:getExp(maxTpl)
      self.bind.current_exp = tostring(maxExp)
      self.bind.next_exp = tostring(maxExp)
    else
      self.bind.current_exp = tostring(pet.exp)
      self.bind.next_exp = tostring(next_exp)
    end
    self.bind.lvSlider = 1
  end
  self.bind.addExpSlider = 0
  if self.bind.active_exp then
    self:setCurrentExp()
  end
  self:checkMaxLevel(petId)
end

function this:checkMaxLevel(petId)
  local pet = L_PetStore:getPetItem(petId)
  if pet.lv >= L_PetStore:getPetMaxLevel() then
    self.bind.expBgActive = true
    self.bind.unlockDesActive = false
    self.bind.go_activeItemList = false
    self.bind.go_activeHeroLevelUpArea = false
    self.bind.go_activeExpArea = false
    self.bind.go_activeMaxLvTips = true
    self.bind.go_activeMaxLabel = true
    return
  end
  self.bind.go_activeItemList = true
  self.bind.go_activeHeroLevelUpArea = true
  self.bind.go_activeExpArea = true
  self.bind.go_activeMaxLvTips = false
  self.bind.go_activeMaxLabel = false
  local tpl = petLevelTpl:getTplById(pet.lv + 1)
  local condition = petLevelTpl:getCondition(tpl)
  local bCompelte = true
  if not table.isEmpty(condition) then
    bCompelte = L_ConditionManager:singleIsComplete(condition)
  end
  self.bind.expBgActive = bCompelte
  self.bind.unlockDesActive = not bCompelte
  if not bCompelte then
    self.bind.unlockDesText = L_ConditionManager:getSingleDesc(condition)
  end
end

function this:setExpBp()
  self.bind.expPropItem:clear()
  local data = {}
  for i = 1, #PROPID do
    local item = L_ItemManager:parseCommonItem(PROPID[i])
    if item.num > 99999 then
      item.num = 99999
    end
    local str = ""
    if item.num == 0 then
      str = L_GameUtil.fillColor(0, L_Const.colorHtml.red001)
    end
    table.insert(data, {
      mutiSelect = true,
      itemId = PROPID[i],
      itemNum = item.num,
      itemType = L_Const.resType.commonItem,
      selectCallback = function()
        local currlv = self.lv
        self:petInfoChange()
        if currlv < self.lv then
          self:playFxSoundByLevelChange(false)
        elseif currlv > self.lv then
          self:playFxSoundByLevelChange(true)
        end
      end,
      validateSelectFunc = function(oldv, newv)
        if oldv < newv and self:getCurrentLv() >= L_PetStore:getPetMaxLevel() then
          L_PetManager:petHintInfo(5)
          return false
        end
        if oldv < newv and self:getCurrentLv() >= L_PetStore:getPetMaxLevel(true) then
          L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_levelmax"))
          return false
        end
        if self:getPetLv() >= L_PetStore:getPetMaxLevel(true) then
          L_FlyMsgManager:showNormalMsg(self.bind.unlockDesText)
          return false
        end
        return true
      end
    })
  end
  self.bind.expPropItem:insert_array(data)
  self.bind.goldNum = ""
end

function this:getCurrentLv()
  return self.lv
end

function this:getPetLv()
  local pet = L_PetStore:getPetItem(self.petId)
  return pet.lv
end

function this:getMaxLv()
  return self.maxLv
end

function this:getEvolutionLv()
  return self.evolutionLv
end

function this:playFxSoundByLevelChange(isReduce)
  if isReduce then
    C_AudioManager.Play("Play_SFX_System_UI_Qibo_Level_Down_FX")
  else
    C_AudioManager.Play("Play_SFX_System_UI_Qibo_Level_Up_FX")
  end
  self._expAnimator:SetTrigger("Change0")
end

function this:getExpAll()
  local tempExpAll = 0
  for _, module in ipairs(self.modules.expPropItem) do
    local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(module.bind.itemId))[1]
    tempExpAll = tempExpAll + module:getSelectNum() * exp
  end
  return tempExpAll
end

function this:getPetExpAll(targetLv)
  local maxLv = self.maxLv
  if not math.isEmpty(targetLv) then
    maxLv = targetLv
  end
  local pet = L_PetStore:getPetItem(self.petId)
  local petExpAll = 0 - pet.exp
  for i = pet.lv, maxLv - 1 do
    petExpAll = petExpAll + petLevelTpl:getExp(petLevelTpl:getTplById(i))
  end
  return petExpAll
end

function this:getSelectedInfo()
  local tempExp = {}
  for _, module in ipairs(self.modules.expPropItem) do
    if module:getSelectNum() > 0 then
      local data = {}
      data = {
        item_id = module.bind.itemId,
        item_num = module:getSelectNum()
      }
      table.insert(tempExp, data)
    end
  end
  return tempExp
end

function this:petInfoChange()
  local pet = L_PetStore:getPetItem(self.petId)
  self.bind.gold = false
  self.bind.goldNum = ""
  if self:getSelectedInfo()[1] then
  else
    self:setPetInfo(pet.lv, pet.exp)
    return
  end
  local tempExpAll = self:getExpAll()
  local petExpAll = self:getPetExpAll()
  if tempExpAll > petExpAll then
    self.goldNum = math.modf(tempExpAll * ratio)
    self.bind.goldNum = tostring(math.modf(tempExpAll * ratio))
  else
    self.goldNum = math.modf(tempExpAll * ratio)
    self.bind.goldNum = tostring(math.modf(tempExpAll * ratio))
  end
  if L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) < self.goldNum then
    self.bind.goldNum = string.format("%d", math.modf(tempExpAll * ratio))
  end
  local tempExp = tempExpAll + pet.exp
  local tempLv = pet.lv
  for i = tempLv, self.maxLv - 1 do
    if tempExp - petLevelTpl:getExp(petLevelTpl:getTplById(i)) < 0 then
      break
    end
    tempLv = i + 1
    tempExp = tempExp - petLevelTpl:getExp(petLevelTpl:getTplById(i))
  end
  self:setPetInfo(tempLv, tempExp)
end

function this:setPetInfo(lv, exp)
  self.lv = lv
  local pet = L_PetStore:getPetItem(self.petId)
  local old_property = L_PetStore:getPetOriginalProperty(pet)
  local property = L_PetStore:getPetOriginalProperty(pet, lv)
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
  self.bind.petPreviewPropertyList:clear()
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
    local old_value = L_PetStore:getPetAttFinalValue(old_property, enumId)
    local value = L_PetStore:getPetAttFinalValue(property, enumId)
    local cur_num = battleInfoTpl:getShowTxtComma(enumId, old_value)
    table.insert(propertyData, {
      value = cur_num,
      name = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrIcon = petLearningEnumTpl:getNewIcon(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrId = id,
      showId = enumId,
      showAddBg = pet.lv ~= lv,
      currentValue = math.floor(old_value),
      addValue = math.floor(value),
      addValueText = battleInfoTpl:getShowTxtComma(enumId, value)
    })
  end
  self.bind.petPreviewPropertyList:insert_array(propertyData)
  self.bind.lvSlider = 1
  if lv >= self.maxLv then
    self.bind.addExpSlider = 1
    self.bind.currentLv_ani = tostring(math.floor(lv))
    self.bind.current_exp = tostring(petLevelTpl:getExp(petLevelTpl:getTplById(lv - 1)))
    self.bind.next_exp = tostring(petLevelTpl:getExp(petLevelTpl:getTplById(lv - 1)))
  elseif lv == pet.lv then
    self.bind.currentLv_ani = tostring(math.floor(lv))
    self.bind.addExpSlider = exp / petLevelTpl:getExp(petLevelTpl:getTplById(lv))
    self.bind.current_exp = tostring(exp)
    self.bind.next_exp = tostring(petLevelTpl:getExp(petLevelTpl:getTplById(lv)))
  else
    self.bind.currentLv_ani = tostring(math.floor(lv))
    self.bind.addExpSlider = exp / petLevelTpl:getExp(petLevelTpl:getTplById(lv))
    self.bind.current_exp = tostring(exp)
    self.bind.next_exp = tostring(petLevelTpl:getExp(petLevelTpl:getTplById(lv)))
  end
  L_TimerManager:newOrResetTimer(self, "anilv", function()
    self.bind.currentLv = self.bind.currentLv_ani
  end, 0.033)
end

function this:autoLvUpSet()
  local tempExpAll = 0
  local data = {}
  for _, module in ipairs(self.modules.expPropItem) do
    local itemId = module.bind.itemId
    local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
    tempExpAll = tempExpAll + C_BagMgr:getItemNumByItemId(itemId) * exp
    data[exp] = C_BagMgr:getItemNumByItemId(itemId)
  end
  if tempExpAll == 0 then
    L_PetManager:petHintInfo(3)
    return
  end
  local petExpAll = self:getPetExpAll()
  local exp = 0
  if tempExpAll >= petExpAll then
    exp = petExpAll
  else
    exp = tempExpAll
  end
  for _, module in ipairs(self.modules.expPropItem) do
    module:setSelectNum(0, true)
  end
  for k, v in pairs(L_PetManager:autoLvUp(data, exp)) do
    for _, module in ipairs(self.modules.expPropItem) do
      local itemId = module.bind.itemId
      local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
      if exp == k and v ~= 0 then
        module:setSelectNum(v, true)
      end
    end
  end
  self:petInfoChange()
  self:playFxSoundByLevelChange(false)
end

function this:autoSetItemToTargetLevel(targetLv, reduce)
  local maxLv = self:getMaxLv()
  if maxLv <= targetLv - 1 or self:getPetLv() == maxLv then
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_levelmin"))
    return
  end
  local tempExpAll = 0
  local data = {}
  local curItemData = {}
  for _, module in ipairs(self.modules.expPropItem) do
    local itemId = module.bind.itemId
    local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
    tempExpAll = tempExpAll + C_BagMgr:getItemNumByItemId(itemId) * exp
    data[exp] = C_BagMgr:getItemNumByItemId(itemId)
    curItemData[exp] = module:getSelectNum()
  end
  local petExpAll = self:getPetExpAll(targetLv)
  local exp = 0
  if petExpAll <= 0 then
  elseif tempExpAll >= petExpAll then
    exp = petExpAll
  else
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_lackitem"))
    return
  end
  local newItemData = L_HeroManager:autoLvUp(data, exp)
  if reduce and table.same(curItemData, newItemData) then
    for i, v in pairs(newItemData) do
      if 0 < v then
        newItemData[i] = newItemData[i] - 1
        break
      end
    end
  end
  for _, module in ipairs(self.modules.expPropItem) do
    module:setSelectNum(0, true)
  end
  self:petInfoChange()
  for k, v in pairs(newItemData) do
    for _, module in ipairs(self.modules.expPropItem) do
      local itemId = module.bind.itemId
      local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
      if exp == k and v ~= 0 then
        module:setSelectNum(v, true)
      end
    end
  end
  self:playFxSoundByLevelChange(reduce)
  self:petInfoChange()
end

function this:setCurrentExp()
  local pet = L_PetStore:getPetItem(self.petId)
  self:setPetInfo(pet.lv, pet.exp)
end

function this:closePetAdvance()
  self.parent:setUpBg(true)
  self.bind.active_info = true
  self.bind.advanceModuleName = ""
end

function this:closeExp()
  self:refreshPetProperty(L_PetStore:getCurSelectPetId())
  self:changeMode(true)
  self.parent:setUpBg(true)
end

function this:reqLevelUp(petId, selectedInfo)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PetUpgrade))
    return
  end
  self:killTween()
  L_TimerManager:clearTimer(self)
  local pet = L_PetStore:getPetItem(self.petId)
  local isChange1 = self.lv - pet.lv >= 10
  self._upgradeAnimating = true
  local preLv = pet.lv
  local afterLv = self.lv
  L_PetStore:req_changeLvUpPet(petId, selectedInfo, function()
    if 1 <= afterLv - preLv then
      L_PetStore:playPetVoiceSound(self.configId, L_PetConst.PetSystemVoiceType.Upgrade)
      L_UI:open("pageHeroLevelUpgrade", {
        petId = self.petId,
        oldLevel = preLv,
        newLevel = afterLv,
        callback = function()
          self:stopCellAnim()
          self:setCurrentExp()
        end
      })
    end
    self:checkMaxLevel(self.petId)
    self:setExpBp()
    if isChange1 then
      C_AudioManager.Play("Play_SFX_System_UI_Qibo_Level_Upgrade_FX_Long")
      self._expAnimator:SetTrigger("Change1")
      self.bind.currentLv = tostring(afterLv)
      self.bind.currentLv_ani = tostring(preLv)
      
      local function getter()
        return preLv
      end
      
      local function setter(v)
        self.bind.currentLv_ani = tostring(math.ceil(v))
      end
      
      self._tween = DOTween.To(getter, setter, afterLv, 0.6):SetEase(Tweening.Ease.OutQuad)
      L_TimerManager:newOrResetTimer(self, "upani", function()
        for i, module in ipairs(self.modules.petPreviewPropertyList) do
          module:playLevelUpAni(i - 1)
        end
      end, 0.5)
      L_UI:open("pageBlank", {
        timeClose = 1.2,
        callback = function()
        end
      })
    else
      C_AudioManager.Play("Play_SFX_System_UI_Qibo_Level_Upgrade_FX_Short")
      self._expAnimator:SetTrigger("Change2")
      self.bind.currentLv = tostring(afterLv)
      self.bind.currentLv_ani = tostring(afterLv)
      L_TimerManager:newOrResetTimer(self, "upani", function()
        for i, module in ipairs(self.modules.petPreviewPropertyList) do
          module:playLevelUpAni(i - 1)
        end
      end, 0.1)
      L_UI:open("pageBlank", {
        timeClose = 1.2,
        callback = function()
        end
      })
    end
  end)
end

function this:killTween()
  if self._tween then
    self._tween:Kill()
    self._tween = nil
  end
end

return this
