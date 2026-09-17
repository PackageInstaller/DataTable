local this = class("modulePetPixelIcon", G_UIModuleBase)
local MaxFrame = 8
local IconPath = "UI/Icon/PetPixelIcon/tex_icon_pet_%s_%d.png"
local IconPathNew = "UI/Icon/PetPixelIcon/tex_icon_pet_%s_{0}.png"
local GifPath = "UI/Texture/PetPixelIcon/tex_icon_pet_%s_%d.png"
local ColorGifPath = "UI/Texture/PetPixelIcon/tex_icon_pet_ys%s%s_%d.png"
local GifPathNew = "UI/Texture/PetPixelIcon/tex_icon_pet_%s_{0}.png"
local BasePath = "UI/Texture/PetPixelBase/tex_bg_pixelbase_%s.png"
local StarColorIconComponentNames = {
  "starColor_img_icon_outline",
  "select_starColot_img_icon_outline"
}
local _petGradeTpl = L_GameTpl:getPetGradeTpl()
local _petTalentTpl = L_GameTpl:getPetTalentTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()

function this.bind()
  return {
    active_baseShadow = false,
    img_base = nil,
    color_base = C_Color(1, 1, 1, 1),
    img_base_outline = nil,
    selectRoot = false,
    selectRoot_starColor = false,
    imgTransActive = true,
    modulesPetFlashEft = {
      type = "toggleModule",
      modulePetFlashEft = {
        moduleName = "pages/pet/modulePetFlashEft",
        assetName = "UI/Pages/Pet/modulePetFlashEft"
      }
    },
    togglePetFlashEft = "",
    active_frameImage_back_petUseItemEffect = false,
    textureName_frameImage_back_petUseItemEffect = "",
    frameCountPerRow_frameImage_back_petUseItemEffect = nil,
    frameCountPerCol_frameImage_back_petUseItemEffect = nil,
    frameCount_frameImage_back_petUseItemEffect = nil,
    frameAnimParamsComplete_frameImage_back_petUseItemEffect = false,
    active_frameImage_front_petUseItemEffect = false,
    textureName_frameImage_front_petUseItemEffect = "",
    frameCountPerRow_frameImage_front_petUseItemEffect = nil,
    frameCountPerCol_frameImage_front_petUseItemEffect = nil,
    frameCount_frameImage_front_petUseItemEffect = nil,
    frameAnimParamsComplete_frameImage_front_petUseItemEffect = false,
    active_img_glow_petUseItemEffect = false,
    modulePetFrame = {
      moduleName = "pages/pet/modulePetPixelPropertyFrame"
    },
    active_annoy = false,
    go_starColor = false
  }
end

function this.methods()
  return {
    modulePetFrame = {
      finishedPlaying = function(self)
        self.isPlayingEffect = false
      end
    }
  }
end

function this:open()
  self.isGray = false
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  self.imgGlowMaterial = C_UnityObject.Instantiate(self.bindComponents.img_glow_petUseItemEffect.material)
  self.frameCountHasPlayed2AlphaOfImgGlow = {
    [1] = 0.25,
    [2] = 0.5,
    [3] = 1
  }
  self.frontFrameImage = self.bindComponents.frameImage_front_petUseItemEffect
  self._initFrameIcon = nil
end

function this:refresh()
  if self.bind.isLongTap ~= true then
    self:setIconAlpha(1)
  end
end

function this:hide()
  if self.isPlayingEffect then
    self:closePetFeedItemEffect()
    self.modules.modulePetFrame:closePetFeedItemEffect()
  end
end

function this:clearTimer()
  L_TimerManager:clearTimer(self)
end

function this:close()
  self.isGray = false
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  self:clearTimer()
  self:stopTimer("playGif")
  self:setStarColorActive(false)
  if self.imgGlowMaterial then
    C_UnityObject.Destroy(self.imgGlowMaterial)
    self.imgGlowMaterial = nil
  end
end

function this:ReloadGif(frameIcon)
  local isFrameIconReady = frameIcon == self._initFrameIcon and L_CommonUtil.isValid(self.bindComponents.img_icon.sprite)
  local isStarColorReady = not self._isStarColorPet or self._starColorFrameIcon == frameIcon
  if isFrameIconReady and isStarColorReady then
    return
  end
  local needClearFrameSprites = self.isInitFrameIcon == true or not isFrameIconReady
  local needClearStarColorFrameSprites = self._isStarColorPet and (needClearFrameSprites or not isStarColorReady)
  self._initFrameIcon = frameIcon
  self._lastOutlineIconPath = nil
  self._lastOutlineGifPath = nil
  self._curFrame = 1
  self.isInitFrameIconEffect = false
  self.isInitFrameIcon = false
  if not self._isStarColorPet then
    self._starColorFrameIcon = nil
  end
  self._defaultPixelId = string.match(frameIcon, "(%d+_s%d+)_%d+%.png$") or string.match(frameIcon, "(%d+)_%d+%.png$")
  self._iconPathNew = string.format(IconPathNew, self._defaultPixelId)
  self._gifPathNew = string.format(GifPathNew, self._defaultPixelId)
  self._iconPathFrame1 = string.format(IconPath, self._defaultPixelId, 1)
  self._gifPathFrame1 = string.format(GifPath, self._defaultPixelId, 1)
  local pet = self._refreshPetData or L_PetStore:getPetItem(self.bind.guid)
  local iconPath = string.format(GifPath, self._defaultPixelId, self._curFrame)
  if pet then
    local color = pet.color or 0
    if color == 1 then
      iconPath = string.format(ColorGifPath, "", self._defaultPixelId, self._curFrame)
    elseif 1 < color then
      iconPath = string.format(ColorGifPath, tostring(color), self._defaultPixelId, self._curFrame)
    end
  end
  if needClearFrameSprites then
    self.bindComponents.img_icon:ClearFrameSprites()
    self.bindComponents.img_icon_outline:ClearFrameSprites()
  end
  if needClearStarColorFrameSprites then
    self:clearStarColorIconFrameSprites()
  end
  local expectedFrameIcon = frameIcon
  
  local function loadFrameIcons()
    if not self.isBind or self._initFrameIcon ~= expectedFrameIcon then
      return
    end
    self.bindComponents.img_icon:LoadSprite(expectedFrameIcon)
    if self._isStarColorPet then
      self.bindComponents.starColor_img_icon_outline:LoadSprite(expectedFrameIcon)
      self._starColorFrameIcon = expectedFrameIcon
    end
    self.bindComponents.img_icon_outline:LoadSprite(iconPath, false)
  end
  
  loadFrameIcons()
  if IS_EDITOR then
    FrameScheduler.add(loadFrameIcons, 1)
  end
  if self._isStarColorPet then
    self:loadStarColorIconSprite(self._initFrameIcon)
  end
  self.bind.active_baseShadow = not string.isEmpty(self._initFrameIcon)
end

function this:setStarColorActive(isStarColorPet)
  self._isStarColorPet = isStarColorPet == true
  if self.bind.go_starColor ~= self._isStarColorPet then
    self.bind.go_starColor = self._isStarColorPet
  end
  local root = self:getStarColorRoot()
  if root and root.gameObject.activeSelf ~= self._isStarColorPet then
    root.gameObject:SetActive(self._isStarColorPet)
  end
  self:setSelectRootActive(self._isSelectRootShow)
end

function this:getFrameAnimImageComponent(component)
  if component and component.ClearFrameSprites then
    return component
  end
  if component and component.GetComponent then
    return component:GetComponent("Lens.Framework.UI.LFrameAnimImage") or component:GetComponent("LFrameAnimImage")
  end
end

function this:getStarColorIconComponents()
  if self._starColorIcons then
    return self._starColorIcons
  end
  self._starColorIcons = {}
  if not self.bindComponents then
    return self._starColorIcons
  end
  for _, componentName in ipairs(StarColorIconComponentNames) do
    local icon = self:getFrameAnimImageComponent(self.bindComponents[componentName])
    if icon then
      table.insert(self._starColorIcons, icon)
    end
  end
  return self._starColorIcons
end

function this:getStarColorIconComponent()
  local icons = self:getStarColorIconComponents()
  return icons[1]
end

function this:getStarColorRoot()
  local icon = not self:getStarColorIconComponent() and self.bindComponents and self.bindComponents.starColor_img_icon_outline
  local trans = icon and (icon.transform or icon)
  return trans and trans.parent
end

function this:clearStarColorIconFrameSprites()
  for _, icon in ipairs(self:getStarColorIconComponents()) do
    if icon.ClearFrameSprites then
      icon:ClearFrameSprites()
    end
  end
end

function this:loadStarColorIconSprite(iconPath)
end

function this:setStarColorIconSprites(iconPath, cb)
  local icons = self:getStarColorIconComponents()
  if not self._isStarColorPet or #icons == 0 then
    if cb then
      cb()
    end
    return
  end
  local waitCount = 0
  for _, icon in ipairs(icons) do
    if icon.SetSprites then
      waitCount = waitCount + 1
    end
  end
  if waitCount == 0 then
    if cb then
      cb()
    end
    return
  end
  
  local function onComplete()
    waitCount = waitCount - 1
    if waitCount <= 0 and cb then
      cb()
    end
  end
  
  for _, icon in ipairs(icons) do
    if icon.SetSprites then
      icon:SetSprites(iconPath, MaxFrame, onComplete)
    end
  end
end

function this:setStarColorIconFrame(frame)
  for _, icon in ipairs(self:getStarColorIconComponents()) do
    if icon.SetFrame then
      icon:SetFrame(frame)
    end
  end
end

function this:resetStarColorIconFrame()
  for _, icon in ipairs(self:getStarColorIconComponents()) do
    if icon.ResetFrame then
      icon:ResetFrame()
    end
  end
end

function this:setSelectRootActive(isShow)
  self._isSelectRootShow = isShow == true
  local selectRoot = self._isSelectRootShow and not self._isStarColorPet
  local selectRootStarColor = self._isSelectRootShow and self._isStarColorPet
  if self.bind.selectRoot ~= selectRoot then
    self.bind.selectRoot = selectRoot
  end
  if self.bind.selectRoot_starColor ~= selectRootStarColor then
    self.bind.selectRoot_starColor = selectRootStarColor
  end
end

function this:refreshView()
  if not self.isBind then
    return
  end
  if not self.isPlayingEffect then
    self:clearTimer()
  end
  self:setSelectRootActive(false)
  if self.petShowInfo then
    local special = tonumber(self.petShowInfo.special)
    local bFlash = special == L_Const.PetSpecialType.PST_FLASH or special == L_Const.PetSpecialType.PST_FLASH_COLOR or special == L_Const.PetSpecialType.PST_FLASH_COLORFUL
    if bFlash then
      self.bind.togglePetFlashEft = "modulePetFlashEft"
      self.modules.modulesPetFlashEft.modulePetFlashEft:setModulePetHasFlashEft(true)
    else
      self.bind.togglePetFlashEft = ""
    end
  elseif L_PetStore:judgePetHasSpecialGene(self.bind.guid) then
    self.bind.togglePetFlashEft = "modulePetFlashEft"
    self.modules.modulesPetFlashEft.modulePetFlashEft:setModulePetHasFlashEft(true)
  else
    self.bind.togglePetFlashEft = ""
  end
  if math.isEmpty(self.bind.guid) then
    self:cancelPetShow()
    return
  end
  local displayInfo = self._refreshPetDisplayInfo
  local tpl, isSpecial, gradeTpl
  local isStarColorPet = false
  if self.petShowInfo then
    tpl = _petTpl:getTplById(self.petShowInfo.id)
    isSpecial = self.petShowInfo.color
    local showPetCfg = _petTpl:getTplById(self.petShowInfo.id)
    local showPetRank = showPetCfg and _petTpl:getPetStage(showPetCfg) or 1
    local showPetRare = showPetCfg and showPetCfg.petrare or 0
    gradeTpl = _petGradeTpl:getTplById(L_PetStore:calGradeRank(self.petShowInfo.grade, showPetRank, showPetRare))
    local starColorId = self.petShowInfo.starColorId or self.petShowInfo.colorMatId or self.petShowInfo.colorful
    isStarColorPet = not math.isEmpty(starColorId)
  else
    local pet = self._refreshPetData or L_PetStore:getPetItem(self.bind.guid)
    if not pet then
      C_MJLog.LogError("pet guid: " .. tostring(self.bind.guid) .. " no data")
      self:setStarColorActive(false)
      return
    end
    tpl = _petTpl:getTplById(pet.id)
    isSpecial = pet:isSpecialPet()
    isStarColorPet = pet:isStarColorPet()
    if self.parent and self.parent.SetTagActive then
      local isShow = self.parent:isInHouse() or self.parent:isInFormation()
      self.parent:SetTagActive(L_PetConst.TagEnum.Annoy, pet:getPetAbilityLimited() and isShow)
    else
      self.bind.active_annoy = pet:getPetAbilityLimited()
    end
  end
  self:setStarColorActive(isStarColorPet)
  local icon = _petTpl:getPetPixelIcon(tpl, isSpecial)
  self:ReloadGif(icon)
  local basePath
  if displayInfo and not string.isEmpty(displayInfo.talentPixelBase) then
    basePath = displayInfo.talentPixelBase
  elseif not self.petShowInfo and not math.isEmpty(self.bind.guid) then
    local petData = self._refreshPetData or L_PetStore:getPetItem(self.bind.guid)
    if petData and petData.comprehension then
      local totalIV = L_PetStore:getPetSixDimPotentialQualification(petData)
      local talentGradeTpl = L_PetStore:getPetTalentGradeTplByTotalIV(totalIV)
      if talentGradeTpl then
        basePath = _petTalentTpl:getPetPixelBase(talentGradeTpl)
      end
    end
  end
  if string.isEmpty(basePath) then
    if not gradeTpl and displayInfo and displayInfo.gradeTpl then
      gradeTpl = displayInfo.gradeTpl
    end
    if not gradeTpl then
      local _, gradeRank = L_PetStore:getPetGradeNew(self.bind.guid)
      gradeTpl = _petGradeTpl:getTplById(gradeRank)
    end
    basePath = _petGradeTpl:getPetPixelBase(gradeTpl)
  end
  if self.bind.img_base ~= basePath then
    self.bind.img_base = basePath
  end
  if self._lastBasePath ~= basePath then
    self._lastBasePath = basePath
    local baseOutline = string.match(basePath, "%a*%d")
    self.basePath = string.format(BasePath, baseOutline)
    self.bindComponents.img_base_outline:LoadSprite(self.basePath, false)
  end
  local offSetPos = _petTpl:getPetPixelPosition(tpl, isSpecial)
  if offSetPos then
    local offsetX = offSetPos[1]
    local offsetY = offSetPos[2]
    if self._lastOffsetX ~= offsetX or self._lastOffsetY ~= offsetY then
      self._lastOffsetX = offsetX
      self._lastOffsetY = offsetY
      local anchoredPosition = L_Vector3.new(offsetX, offsetY)
      self.bindComponents.rect_img_icon.anchoredPosition = anchoredPosition
      self.bindComponents.rect_icon_outline.anchoredPosition = anchoredPosition
    end
  end
  if self.bind.autoPlay then
    self:playPixelGif()
  end
end

function this:setPetInfo(info)
  self.petShowInfo = info
end

function this:setGuid(guid, autoPlay, petData, displayInfo)
  self.bind.guid = guid
  self.bind.autoPlay = autoPlay
  self._refreshPetData = petData
  self._refreshPetDisplayInfo = displayInfo
  self:refreshView()
  self._refreshPetData = nil
  self._refreshPetDisplayInfo = nil
end

function this:cancelPetShow()
  self:stopPixelGif()
  self.bind.active_baseShadow = false
  self:setStarColorActive(false)
end

function this:refreshPreviewPet(isSpecial)
  if not self.isBind then
    return
  end
  self:clearTimer()
  self.bind.img_base = ""
  self.bind.img_base_outline = ""
  self:setSelectRootActive(false)
  if math.isEmpty(self.bind.configId) then
    self:cancelPetShow()
    return
  end
  local tpl = _petTpl:getTplById(self.bind.configId)
  local petData = not math.isEmpty(self.bind.guid) and L_PetStore:getPetItem(self.bind.guid) or nil
  self:setStarColorActive(petData and petData:isStarColorPet() or false)
  local icon = _petTpl:getPetPixelIcon(tpl, isSpecial)
  self:ReloadGif(icon)
  local gradeTpl = _petGradeTpl:getTplById(1)
  local basePath = _petGradeTpl:getPetPixelBase(gradeTpl)
  if not math.isEmpty(self.bind.guid) and petData and petData.comprehension then
    local totalIV = L_PetStore:getPetSixDimPotentialQualification(petData)
    local talentGradeTpl = L_PetStore:getPetTalentGradeTplByTotalIV(totalIV)
    if talentGradeTpl and not string.isEmpty(_petTalentTpl:getPetPixelBase(talentGradeTpl)) then
      basePath = _petTalentTpl:getPetPixelBase(talentGradeTpl)
    end
  end
  self.bind.img_base = basePath
  local baseOutline = string.match(basePath, "%a*%d")
  self.basePath = string.format(BasePath, baseOutline)
  self.bindComponents.img_base_outline:LoadSprite(self.basePath, false)
  local offSetPos = _petTpl:getPetPixelPosition(tpl, 0)
  self.bindComponents.rect_img_icon.anchoredPosition = L_Vector3.new(offSetPos[1], offSetPos[2])
  self.bindComponents.rect_icon_outline.anchoredPosition = L_Vector3.new(offSetPos[1], offSetPos[2])
  if self.bind.autoPlay then
    self:playPixelGif()
  end
end

function this:setConfigId(configId, autoPlay, isSpecial)
  self.bind.configId = configId
  self.bind.autoPlay = autoPlay
  self:refreshPreviewPet(isSpecial)
end

function this:getIsInitFrameIcon()
  return self.isInitFrameIcon
end

function this:playPixelGif()
  self:setSelectRootActive(true)
  self.bindComponents.img_base_outline:LoadSprite(self.basePath, false)
  if not self.isInitFrameIcon then
    local iconPath = self._iconPathNew or string.format(IconPathNew, self._defaultPixelId)
    local gifPath = self._gifPathNew or string.format(GifPathNew, self._defaultPixelId)
    self.bindComponents.img_icon:SetSprites(iconPath, MaxFrame, function()
      if not (self.isBind and self.bindComponents) or not self._isSelectRootShow then
        return
      end
      self:setStarColorIconSprites(iconPath, function()
        if not (self.isBind and self.bindComponents) or not self._isSelectRootShow then
          return
        end
        self.bindComponents.img_icon_outline:SetSprites(gifPath, MaxFrame, function()
          if not (self.isBind and self.bindComponents) or not self._isSelectRootShow then
            return
          end
          self:_DoPlayGift()
        end)
      end)
    end)
    self.isInitFrameIcon = true
  else
    self:_DoPlayGift()
  end
end

function this:stopShowPixelIcon()
  self:stopTimer("playGif")
  self.bindComponents.img_icon:SetFrame(1)
  self:setStarColorIconFrame(1)
  self.bindComponents.img_icon_outline:SetFrame(1)
end

function this:_DoPlayGift()
  self:newOrResetTimer("playGif", function()
    if not self.isBind or not self.bindComponents then
      return
    end
    if self._curFrame == nil then
      self._curFrame = 1
    end
    self._curFrame = self._curFrame % MaxFrame + 1
    self.bindComponents.img_icon:SetFrame(self._curFrame)
    self:setStarColorIconFrame(self._curFrame)
    self.bindComponents.img_icon_outline:SetFrame(self._curFrame)
    if self.isPlayingEffect then
      self.bindComponents.img_glow_petUseItemEffect:SetFrame(self._curFrame)
    end
  end, 0.1, -1)
end

function this:outLineShow(isShow)
  self:setSelectRootActive(isShow)
  if isShow then
    local iconPath = self._iconPathFrame1 or string.format(IconPath, self._defaultPixelId, 1)
    local gifPath = self._gifPathFrame1 or string.format(GifPath, self._defaultPixelId, 1)
    if self._lastOutlineIconPath ~= iconPath or self._lastOutlineGifPath ~= gifPath then
      self.bindComponents.img_icon:LoadSprite(iconPath)
      if self._isStarColorPet then
        self.bindComponents.starColor_img_icon_outline:LoadSprite(iconPath)
        self:loadStarColorIconSprite(iconPath)
      end
      self.bindComponents.img_icon_outline:LoadSprite(gifPath, false)
      self._lastOutlineIconPath = iconPath
      self._lastOutlineGifPath = gifPath
    end
  else
    self._lastOutlineIconPath = nil
    self._lastOutlineGifPath = nil
  end
end

function this:stopPixelGif()
  self:stopTimer("playGif")
  self.bindComponents.img_icon:ResetFrame()
  self:resetStarColorIconFrame()
  self.bindComponents.img_icon_outline:ResetFrame()
  self:setSelectRootActive(false)
end

function this:setIconAlpha(alpha)
  self.bindComponents.img_icon.color = C_Color(1, 1, 1, alpha)
end

function this:onEvent_refreshPet(entity)
  if not self.isBind then
    return
  end
  if entity.guid == self.bind.guid then
    self:refreshView()
  end
end

function this:setIconBlack(isBlack)
  if isBlack then
    self:setSelectRootActive(true)
    self.bind.imgTransActive = false
    self.bindComponents.img_icon_outline.color = C_Color(0.2549, 0.2588, 0.2352, 1)
    self.bind.color_base = C_Color(0.2549, 0.2588, 0.2352, 0.6)
  else
    self:setSelectRootActive(false)
    self.bind.imgTransActive = true
    self.bindComponents.img_icon_outline.color = C_Color(1, 1, 1, 1)
    self.bind.color_base = C_Color(1, 1, 1, 1)
  end
end

function this:setIconBlack2(isBlack, hasOutline)
  if isBlack then
    self:setSelectRootActive(true)
    self.bind.imgTransActive = false
    self.bindComponents.img_icon_outline.color = C_Color(0.058823529411764705, 0.10196078431372549, 0.14901960784313725, 1)
    self.bind.color_base = C_Color(0.058823529411764705, 0.10196078431372549, 0.14901960784313725, 1)
  else
    self:setSelectRootActive(false)
    self.bind.imgTransActive = true
    self.bindComponents.img_icon_outline.color = C_Color(1, 1, 1, 1)
    self.bind.color_base = C_Color(1, 1, 1, 1)
  end
end

function this:playPetFeedItemEffect(params)
  if self.isPlayingEffect == true then
    return
  end
  params = params or {}
  local pixelEffectPathList, frameTextureConfigInfos = self:getPetEatItemEffectConfigInfo(params)
  if pixelEffectPathList and frameTextureConfigInfos then
    local frontPixelEffectPath = pixelEffectPathList.frontPixelEffectPath
    local backPixelEffectPath = pixelEffectPathList.backPixelEffectPath
    local frontFrameTextureConfigInfo = frameTextureConfigInfos.frontFrameTextureConfigInfo
    local backFrameTextureConfigInfo = frameTextureConfigInfos.backFrameTextureConfigInfo
    self.bind.textureName_frameImage_back_petUseItemEffect = backPixelEffectPath
    self.bind.frameCountPerRow_frameImage_back_petUseItemEffect = backFrameTextureConfigInfo.colNum
    self.bind.frameCountPerCol_frameImage_back_petUseItemEffect = backFrameTextureConfigInfo.rowNum
    self.bind.frameCount_frameImage_back_petUseItemEffect = backFrameTextureConfigInfo.iconNum
    self.bind.textureName_frameImage_front_petUseItemEffect = frontPixelEffectPath
    self.bind.frameCountPerRow_frameImage_front_petUseItemEffect = frontFrameTextureConfigInfo.colNum
    self.bind.frameCountPerCol_frameImage_front_petUseItemEffect = frontFrameTextureConfigInfo.rowNum
    self.bind.frameCount_frameImage_front_petUseItemEffect = frontFrameTextureConfigInfo.iconNum
    self.bindComponents.img_glow_petUseItemEffect.material = self.imgGlowMaterial
    self.bind.frameAnimParamsComplete_frameImage_back_petUseItemEffect = true
    self.bind.frameAnimParamsComplete_frameImage_front_petUseItemEffect = true
    self.bind.active_frameImage_back_petUseItemEffect = true
    self.bind.active_frameImage_front_petUseItemEffect = true
    self.bind.active_img_glow_petUseItemEffect = true
    if not self.isInitFrameIconEffect then
      self.isInitFrameIconEffect = true
      self.bindComponents.img_glow_petUseItemEffect:SetSprites(string.format(IconPathNew, self._defaultPixelId), MaxFrame, function()
        self.isPlayingEffect = true
        self:_DoPlayGift()
      end)
    end
    L_TimerManager:newOrResetTimer(self, "playPetFeedItemEffect", function()
      self:updatePetFeedItemEffect()
    end, 0.05, -1)
    self.isPlayingEffect = true
    self:updatePetFeedItemEffect()
  end
end

function this:updatePetFeedItemEffect()
  self.frameCountHasPlayed2AlphaOfImgGlow = self.frameCountHasPlayed2AlphaOfImgGlow or {
    [1] = 0.25,
    [2] = 0.5,
    [3] = 1
  }
  self.frontFrameImage = self.frontFrameImage or self.bindComponents.frameImage_front_petUseItemEffect
  local curFrameIndex = self.frontFrameImage.curFrameIndex
  local alphaOfImgGlow = self.frameCountHasPlayed2AlphaOfImgGlow[curFrameIndex] or 0
  self.imgGlowMaterial:SetFloat("_Alpha", alphaOfImgGlow)
  if curFrameIndex >= self.bind.frameCount_frameImage_front_petUseItemEffect - 1 then
    self:closePetFeedItemEffect()
  end
end

function this:closePetFeedItemEffect()
  L_TimerManager:stopTimer(self, "playPetFeedItemEffect")
  self.bind.frameAnimParamsComplete_frameImage_back_petUseItemEffect = false
  self.bind.frameAnimParamsComplete_frameImage_front_petUseItemEffect = false
  self.bind.active_frameImage_back_petUseItemEffect = false
  self.bind.active_frameImage_front_petUseItemEffect = false
  self.bind.active_img_glow_petUseItemEffect = false
  self.isPlayingEffect = false
end

function this:getPetEatItemEffectConfigInfo(params)
  params = params or {}
  local isPetLevelUp = params.isPetLevelUp
  local attrIdList = params.attrIdList or {}
  if isPetLevelUp then
    if not self._petExpEffectCache then
      local petFruitPixelEffectPathInfo = {}
      petFruitPixelEffectPathInfo.frontPixelEffectPath = _gameConstTpl:getData("PET_EXP_EFFECT_RESOURCEFR", L_Const.GameTplType.string)
      petFruitPixelEffectPathInfo.backPixelEffectPath = _gameConstTpl:getData("PET_EXP_EFFECT_RESOURCEBK", L_Const.GameTplType.string)
      local frameTextureConfigInfos = {}
      local rawFrameTextureConfigInfos = _gameConstTpl:getData("PET_EXP_EFFECT_FRAME", L_Const.GameTplType.list_list_int)
      for i, rawFrameTextureConfigInfo in pairs(rawFrameTextureConfigInfos) do
        local frameTextureConfigInfo = {}
        frameTextureConfigInfo.rowNum = rawFrameTextureConfigInfo[1]
        frameTextureConfigInfo.colNum = rawFrameTextureConfigInfo[2]
        frameTextureConfigInfo.iconNum = rawFrameTextureConfigInfo[3]
        if i == 1 then
          frameTextureConfigInfos.frontFrameTextureConfigInfo = frameTextureConfigInfo
        else
          frameTextureConfigInfos.backFrameTextureConfigInfo = frameTextureConfigInfo
        end
      end
      self._petExpEffectCache = {petFruitPixelEffectPathInfo = petFruitPixelEffectPathInfo, frameTextureConfigInfos = frameTextureConfigInfos}
    end
    return self._petExpEffectCache.petFruitPixelEffectPathInfo, self._petExpEffectCache.frameTextureConfigInfos
  else
    self.modules.modulePetFrame:updatePropertyFrame(attrIdList)
    self.isPlayingEffect = true
    L_AudioUtil.playSound("Play_SFX_System_UI_Qibo_Stat_LevelUp")
  end
end

function this:setImgTranScale(scale)
  if self.bindComponents.imgTrans then
    L_Vector3.setSize(self.bindComponents.imgTrans, scale)
  end
end

function this:setGray(isGray)
  self.bindComponents.img_icon:SetGray(isGray)
  self.isGray = isGray
end

function this:hideSelf()
  self:stopShowPixelIcon()
  self.bindComponents.img_icon:ClearFrameSprites()
  self:clearStarColorIconFrameSprites()
  self._initFrameIcon = ""
end

function this:SetAnnoyActive(active)
  self.bind.active_annoy = active
end

return this
