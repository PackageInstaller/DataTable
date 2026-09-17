local this = class("modulePetCard", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local bgOffset = 12
local PET_CARD_SHOW_ANIM = "anim_pet_card_show"

function this.bind()
  return {
    frame = "",
    back = "",
    glow = "",
    bgEffect = "",
    petCard = "",
    frontEffect = "",
    elementIcon = "",
    elementFrame = "",
    subElementFrame = "",
    subElementIcon = "",
    bgIcon = "",
    bgExtends = "",
    show_shiningToggle = false,
    show_frontEffect = true,
    show_bgEffect = true,
    show_petCard = true,
    show_bg = true,
    show_tips = false,
    show_element = true,
    show_subElement = false,
    show_cardRoot = true,
    show_shiningFx = false,
    show_shiningFrame = false,
    go_petNormal = false,
    go_petStarColor = false
  }
end

function this:open()
  if L_DeviceTpl:getIsPc() then
    self.updateHandle = handler(self, self.update)
    C_UpdateSource.AddUpdateEventHandler(self.updateHandle)
  end
end

function this:close()
  if self.updateHandle then
    C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  end
  L_TimerManager:clearTimer(self)
  L_AudioUtil.stopSound(self._petVoiceWrap)
  self._petVoiceWrap = nil
end

function this:setPetCardTypeActive(isStarColorPet)
  local isStarColor = isStarColorPet == true
  self.bind.go_petStarColor = isStarColor
  self.bind.go_petNormal = not isStarColor
end

function this:getIsStarColorPet(pet)
  return pet and pet.isStarColorPet and pet:isStarColorPet() or false
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.pet = pet
  local tpl = _petTpl:getTplById(pet.id)
  if tpl then
    self.init = true
    self:setPetCardTypeActive(self:getIsStarColorPet(pet))
    self.bind.show_shiningFx = pet:hasFlashGene()
    self.bind.show_shiningFrame = pet:hasFlashGene()
    self.bind.show_shiningToggle = pet:hasFlashGene()
    local petCardPath = _petTpl:getKiboBoxCardIcon(tpl, 5, pet:isSpecialPet())
    if string.isEmpty(petCardPath) then
      self.bind.show_tips = true
      self.bind.show_element = false
      self.bind.show_bg = false
      self.bind.show_petCard = false
      self.bind.show_frontEffect = false
      self.bind.show_bgEffect = false
      self.bind.frame = "UI/Texture/PetBoxCard/tex_pet_card_element_0.png"
      self.bind.back = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
      self.bind.glow = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
    else
      self:initCommonBack()
      self:initCommonInfo(tpl)
    end
  end
end

function this:update()
end

function this:setInitRdy()
  self.init = true
end

function this:playShowAnim()
  local anim = self.bindComponents and self.bindComponents.anim
  if anim then
    anim:Play(PET_CARD_SHOW_ANIM)
    local animState = anim.get_Item and anim:get_Item(PET_CARD_SHOW_ANIM)
    if animState then
      animState.normalizedTime = 0
      animState.time = 0
    end
    anim:Sample()
  end
end

function this:stopAnimToLastFrame()
  if self.bindComponents.anim.isPlaying then
    local animEnum = self.bindComponents.anim:GetEnumerator()
    while animEnum:MoveNext() do
      local state = animEnum.Current
      state.normalizedTime = 1
    end
    self.bindComponents.anim:Sample()
  end
  self.bindComponents.anim:Stop()
end

function this:setPidWithAnim(petId, SpecialId, isFlash)
  self.isPlayAnim = false
  local tpl = _petTpl:getTplById(petId)
  if tpl then
    self.pet = {
      isSpecialPet = function()
        return SpecialId
      end
    }
    self:setPetCardTypeActive(false)
    self.bind.show_shiningFx = isFlash
    self.bind.show_shiningFrame = isFlash
    self.bind.show_shiningToggle = isFlash
    self:stopAnimToLastFrame()
    self.bindComponents.anim:Play("anim_pet_card_switch")
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Select")
    self.isPlayAnim = true
    local petCardPath = _petTpl:getKiboBoxCardIcon(tpl, 5, SpecialId)
    if string.isEmpty(petCardPath) then
      L_TimerManager:clearTimer(self)
      self.bind.show_tips = true
      self.bind.show_element = false
      self.bind.show_bg = false
      self.bind.show_petCard = false
      self.bind.show_frontEffect = false
      self.bind.show_bgEffect = false
      self.bind.frame = "UI/Texture/PetBoxCard/tex_pet_card_element_0.png"
      self.bind.back = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
      self.bind.glow = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
    else
      self:initCommonBack()
      L_TimerManager:newOrResetTimer(self, "delayInitInfo", function()
        self:initCommonInfo(tpl)
        self.isPlayAnim = false
      end, 0.15)
    end
  end
end

function this:setGuidWithAnim(guid)
  local pet = L_PetStore:getPetItem(guid)
  self.pet = pet
  self.isPlayAnim = false
  local tpl = _petTpl:getTplById(pet.id)
  if tpl then
    self:stopAnimToLastFrame()
    self.bindComponents.anim:Play("anim_pet_card_switch")
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Select")
    L_AudioUtil.stopSound(self._petVoiceWrap)
    self._petVoiceWrap = L_PetStore:playPetVoiceSound(pet.id, L_PetConst.PetSystemVoiceType.PropertyDetail)
    self.isPlayAnim = true
    self:setPetCardTypeActive(self:getIsStarColorPet(pet))
    self.bind.show_shiningFx = pet:hasFlashGene()
    self.bind.show_shiningFrame = pet:hasFlashGene()
    self.bind.show_shiningToggle = pet:hasFlashGene()
    local petCardPath = _petTpl:getKiboBoxCardIcon(tpl, 5, pet:isSpecialPet())
    if string.isEmpty(petCardPath) then
      L_TimerManager:clearTimer(self)
      self.bind.show_tips = true
      self.bind.show_element = false
      self.bind.show_bg = false
      self.bind.show_petCard = false
      self.bind.show_frontEffect = false
      self.bind.show_bgEffect = false
      self.bind.frame = "UI/Texture/PetBoxCard/tex_pet_card_element_0.png"
      self.bind.back = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
      self.bind.glow = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
    else
      self:initCommonBack()
      L_TimerManager:newOrResetTimer(self, "delayInitInfo", function()
        self:initCommonInfo(tpl)
        self.isPlayAnim = false
      end, 0.15)
    end
  end
end

function this:initCommonBack()
  self.bind.show_tips = false
  self.bind.show_element = true
  self.bind.show_bg = true
  self.bind.show_petCard = true
  local catchItemId = self.pet.catch_item
  if math.isEmpty(catchItemId) then
    self.bind.back = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
    self.bind.glow = "UI/Texture/PetBoxCard/tex_icon_petcard_quality_1.png"
  else
    local commonItemTpl = _commonItemTpl:getTplById(catchItemId)
    local subId = _commonItemTpl:getSubId(commonItemTpl)
    local catchItemTpl = _petCatchItemTpl:getTplById(subId)
    self.bind.back = _petCatchItemTpl:getCardBgImg(catchItemTpl)
    self.bind.glow = _petCatchItemTpl:getCardBgImg(catchItemTpl)
  end
end

function this:initCommonInfo(tpl)
  self:setPetCardTypeActive(self:getIsStarColorPet(self.pet))
  local petElement = _petTpl:getElement(tpl)
  local elementTpl = _elementTypeTpl:getTplById(petElement[1])
  self.bind.frame = _elementTypeTpl:getKiBoCardElementBg(elementTpl, 3)
  self.bind.elementFrame = _elementTypeTpl:getKiBoCardElementBg(elementTpl, 4)
  self.bind.elementIcon = _elementTypeTpl:getKiboBoxCardEleIcon(elementTpl)
  if 1 < #petElement then
    self.bind.show_subElement = true
    local subElementTpl = _elementTypeTpl:getTplById(petElement[2])
    self.bind.subElementFrame = _elementTypeTpl:getKiBoCardElementBg(subElementTpl, 4)
    self.bind.subElementIcon = _elementTypeTpl:getKiboBoxCardEleIcon(subElementTpl)
  else
    self.bind.show_subElement = false
  end
  local syncType = CS.Azur.Gameplay.UI.ELImageLoadType.ForceSync
  self.bindComponents.petCard:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 5, self.pet:isSpecialPet()), false, syncType)
  self.bindComponents.PetStarColorOutline:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 5, self.pet:isSpecialPet()), false, syncType)
  self.bindComponents.PetStarColorBase:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 5, self.pet:isSpecialPet()), false, syncType)
  self.bindComponents.PetStarColor2:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 5, self.pet:isSpecialPet()), false, syncType)
  self.bindComponents.PetStarColor3:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 5, self.pet:isSpecialPet()), false, syncType)
  self.bindComponents.bgIcon:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 3, self.pet:isSpecialPet()), false, syncType)
  self.bindComponents.bgExtends:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 4, self.pet:isSpecialPet()), false, syncType)
  local showBgEffect = C_LuaUtility.ExistsAsset(_petTpl:getKiboBoxCardIcon(tpl, 1))
  self.bind.show_bgEffect = showBgEffect
  if self.bind.show_bgEffect then
    self.bindComponents.bgEffect:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 1), false, syncType)
  end
  local showFrontEffect = C_LuaUtility.ExistsAsset(_petTpl:getKiboBoxCardIcon(tpl, 2))
  self.bind.show_frontEffect = showFrontEffect
  if self.bind.show_frontEffect then
    self.bindComponents.frontEffect:LoadSprite(_petTpl:getKiboBoxCardIcon(tpl, 2), false, syncType)
  end
end

function this:enableCard(bool)
  self.bind.show_cardRoot = bool
end

return this
