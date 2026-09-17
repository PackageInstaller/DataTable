local this = class("modulePetBoxName", G_UIModuleBase)
local petLevelTpl = L_GameTpl:getPetLevelTpl()
local petTalentTpl = L_GameTpl:getPetTalentTpl()
local petTpl = L_GameTpl:getPetTpl()
local AdaptiveMaxWidth = 261.2
local AdaptiveMinWidth = 14.4
local TextNameMaxWidth = 216.01
local LvNormalColor = C_Color(1, 1, 1, 1)
local LvLimitColor = C_Color(0.8666666666666667, 0.40784313725490196, 0.40784313725490196, 1)

function this.bind()
  return {
    pet_name = "",
    show_modifyBtn = true,
    showLockModule = true,
    isLock = false,
    lv = "",
    lv_color = LvNormalColor,
    maxLv = "",
    go_commonLv = true,
    go_limitLv = false,
    limitLv = "",
    limitMaxLv = "",
    active_crown = false,
    img_crown = "",
    img_crownBg = ""
  }
end

function this.methods()
  return {
    onClick_modify = function(self)
      local systemId = L_SystemConst.enum.renameKibo
      if L_SystemBreakManager:checkBanSystemAndTip(systemId) then
        return
      end
      local pet = L_PetStore:getPetItem(self.petId)
      local tpl = petTpl:getTplById(pet.id)
      local canRename = petTpl:getIsRename(tpl)
      if not canRename then
        L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_01")
        return
      end
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
              self:setGuid(self.petId)
              L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_05")
            end
          end)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end,
    onClick_lockPet = function(self)
      local pet = L_PetStore:getPetItem(self.petId)
      if not self.bind.showLockModule then
        return
      end
      if pet.is_lock == true then
        L_PetStore:req_lockPet(self.petId, false, function()
          self:setGuid(self.petId)
          self:playLockStateAnimation(false)
          L_FlyMsgManager:showNormalMsgByKey("notice_pagePetGet_02")
        end)
      else
        L_PetStore:req_lockPet(self.petId, true, function()
          self:setGuid(self.petId)
          self:playLockStateAnimation(true)
          L_FlyMsgManager:showNormalMsgByKey("notice_pagePetGet_03")
          if L_PetReleaseManager:getIsReleaseMode() and L_PetReleaseManager:isPetSelected(self.petId) then
            L_PetReleaseManager:dealSelectPet(self.petId)
          end
        end)
      end
    end
  }
end

function this:playAnimation(animationComponent)
  if animationComponent == nil then
    return
  end
  if animationComponent.Play then
    animationComponent:Play()
    return
  end
  if animationComponent.play then
    animationComponent.play()
  end
end

function this:snapLockState(isLock)
  local anim = isLock and self.bindComponents.unlockStateAnimation or self.bindComponents.lockStateAnimation
  if anim and anim.clip then
    anim.clip:SampleAnimation(anim.gameObject, anim.clip.length)
  end
end

function this:playLockStateAnimation(isLock)
  if isLock then
    self:playAnimation(self.bindComponents.unlockStateAnimation)
  else
    self:playAnimation(self.bindComponents.lockStateAnimation)
  end
end

function this:open()
  L_PetStore:listenCallFunc(L_PetStore.event.setPetReleaseMode, self.onChangePetReleaseMode, self)
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.setPetReleaseMode, self.onChangePetReleaseMode, self)
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  local abilityLimit = pet:getPetAbilityLimited()
  self.petId = guid
  self.maxLv = L_PetStore:getPetMaxLevel(true)
  self.lv = pet.lv
  self.limitMaxLv = pet.catchLevel
  self:refreshPetName(pet.pet_name)
  self.bind.go_commonLv = true
  self.bind.go_limitLv = false
  printf("[modulePetBoxName] setGuid", "guid:", tostring(guid), "lv:", tostring(pet.lv), "abilityLimit:", tostring(abilityLimit), "lvColor:", abilityLimit and "#dd6868" or "#ffffff")
  self:refreshCrownIcon(guid)
  self:refreshPetLv(tostring(pet.lv), string.format("/%d", self.maxLv), abilityLimit and LvLimitColor or LvNormalColor)
  self.bind.isLock = pet.is_lock
  self:snapLockState(pet.is_lock)
  self:onChangePetReleaseMode()
end

function this:setConfigId(configId, isDetail)
  local tpl = petTpl:getTplById(configId)
  self.maxLv = L_PetStore:getPetMaxLevel()
  self.lv = 1
  self:refreshPetName(petTpl:getName(tpl))
  self:refreshModifyBtnActive(false)
  self:refreshEditorBtnActive(false)
  if isDetail then
    self:refreshPetLv("??", "/??")
  else
    self:refreshPetLv(tostring(self.lv), string.format("/%d", self.maxLv))
  end
end

function this:onChangePetReleaseMode()
  self:refreshModifyBtnActive(not L_PetReleaseManager:getIsReleaseMode())
end

function this:adaptNameFontSize(needAdapt)
  if needAdapt then
    self.bindComponents.contentSizeFitter.enabled = false
    self.bindComponents.horizantolLayoutGroup.enabled = false
    self.bindComponents.textNameTMP.autoSizeTextContainer = true
  else
    self.bindComponents.textNameTMP.autoSizeTextContainer = false
    self.bindComponents.horizantolLayoutGroup.enabled = true
    self.bindComponents.contentSizeFitter.enabled = true
  end
end

function this:adaptLayoutChange()
  self:adaptNameFontSize(false)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectHorizantolName)
  local nameWidth = self.bindComponents.rectTextName.sizeDelta.x
  local lvWidth = self.bindComponents.rectPanelLv.sizeDelta.x
  if AdaptiveMaxWidth - (nameWidth + lvWidth) >= AdaptiveMinWidth then
    self:adaptNameFontSize(false)
    self.bindComponents.adaptLayout.preferredWidth = AdaptiveMaxWidth - (nameWidth + lvWidth)
  else
    self:adaptNameFontSize(true)
    self.bindComponents.rectTextName.sizeDelta = C_Vector2(TextNameMaxWidth, self.bindComponents.rectTextName.sizeDelta.y)
    self.bindComponents.adaptLayout.preferredWidth = AdaptiveMinWidth
  end
end

function this:refreshCrownIcon(guid)
  self.bind.img_crown = ""
  self.bind.img_crownBg = ""
  self.bind.active_crown = false
  local petData
  if guid then
    petData = L_PetStore:getPetItem(guid)
  end
  if not petData or not petData.comprehension then
    return
  end
  local totalIV = L_PetStore:getPetSixDimPotentialQualification(petData)
  local talentGradeTpl = L_PetStore:getPetTalentGradeTplByTotalIV(totalIV)
  if talentGradeTpl then
    local pixelIcon = petTalentTpl:getPixelIcon(talentGradeTpl)
    local nameBg = petTalentTpl:getNameBg(talentGradeTpl)
    self.bind.img_crown = pixelIcon or ""
    self.bind.img_crownBg = nameBg or ""
    self.bind.active_crown = not string.isEmpty(pixelIcon)
    if self.bind.active_crown then
      local talentId = petTalentTpl:getId(talentGradeTpl)
      self:refreshCrownFX(talentId)
    end
  end
end

local CrownFXMap = {
  [3] = "FX_03",
  [4] = "FX_02",
  [5] = "FX_01",
  [6] = "FX_00"
}
local CrownFXNodes = {
  "FX_00",
  "FX_01",
  "FX_02",
  "FX_03"
}

function this:refreshCrownFX(talentId)
  local targetNode = CrownFXMap[talentId]
  for _, key in ipairs(CrownFXNodes) do
    local node = self.bindComponents[key]
    if node then
      node.gameObject:SetActive(key == targetNode)
    end
  end
end

function this:refreshPetLv(_lv, _maxlv, _lvColor)
  self.bind.lv = _lv
  self.bind.lv_color = _lvColor or LvNormalColor
  self.bind.maxLv = _maxlv
  printf("[modulePetBoxName] refreshPetLv", "lv:", tostring(_lv), "maxLv:", tostring(_maxlv), "lvColor:", tostring(_lvColor), "bindLvColor:", tostring(self.bind.lv_color))
  self:adaptLayoutChange()
end

function this:refreshPetLimitLv(_lv, _maxlv)
  self.bind.limitLv = _lv
  self.bind.limitMaxLv = _maxlv
  self:adaptLayoutChange()
end

function this:refreshPetName(petName)
  self.bind.pet_name = petName
  self:adaptLayoutChange()
end

function this:refreshModifyBtnActive(isShow)
  local placeWithShowWidth = 2.46
  local placeWithUnShowWidth = 77.36
  self.bind.show_modifyBtn = isShow
  if isShow then
    self.bindComponents.Placeholder_Lock.preferredWidth = placeWithShowWidth
  else
    self.bindComponents.Placeholder_Lock.preferredWidth = placeWithUnShowWidth
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectHorizantolName)
end

function this:refreshEditorBtnActive(isShow)
  local placeWithShowWidth = 4.1
  local placeWithUnShowWidth = 27.1
  self.bind.show_modifyBtn = isShow
  if isShow then
    self.bindComponents.Placeholder_EditorBtn.preferredWidth = placeWithShowWidth
  else
    self.bindComponents.Placeholder_EditorBtn.preferredWidth = placeWithUnShowWidth
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectHorizantolName)
end

return this
