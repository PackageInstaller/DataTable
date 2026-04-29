_class("UIPetIntimacyMainController", UIController)
UIPetIntimacyMainController = UIPetIntimacyMainController
local PetIntimacyWindowType = {
  FilesPanel = 1,
  VoicePanel = 2,
  GiftPanel = 3,
  ImageRecallPanel = 4
}
_enum("PetIntimacyWindowType", PetIntimacyWindowType)

function UIPetIntimacyMainController:Constructor()
  self.Element2ImageName = {
    [ElementType.ElementType_Blue] = "str_shop_pet_shui",
    [ElementType.ElementType_Red] = "str_shop_pet_huo",
    [ElementType.ElementType_Green] = "str_shop_pet_sen",
    [ElementType.ElementType_Yellow] = "str_shop_pet_lei",
    [ElementType.ElementType_AnyNone] = "str_tale_pet_att_none"
  }
  self.ElementNameTable = {
    [ElementType.ElementType_Blue] = "str_pet_element_name_blue",
    [ElementType.ElementType_Red] = "str_pet_element_name_red",
    [ElementType.ElementType_Green] = "str_pet_element_name_green",
    [ElementType.ElementType_Yellow] = "str_pet_element_name_yellow",
    [ElementType.ElementType_AnyNone] = "str_pet_detail_element_6"
  }
  self.ElementDesStr = "str_pet_first_and_second_element_des"
  self.ElementSpriteName = {
    [ElementType.ElementType_Blue] = "bing_color",
    [ElementType.ElementType_Red] = "huo_color",
    [ElementType.ElementType_Green] = "sen_color",
    [ElementType.ElementType_Yellow] = "lei_color",
    [ElementType.ElementType_AnyNone] = "wu_color"
  }
  self._animName = {
    [PetIntimacyWindowType.FilesPanel] = {
      IN = "uieff_SpiritIntimacy_File_In",
      OUT = "uieff_SpiritIntimacy_File_Out"
    },
    [PetIntimacyWindowType.VoicePanel] = {
      IN = "uieff_SpiritIntimacy_VoicePanel_In",
      OUT = "uieff_SpiritIntimacy_VoicePanel_Out"
    },
    [PetIntimacyWindowType.GiftPanel] = {
      IN = "uieff_SpiritIntimacy_Gift_In",
      OUT = "uieff_SpiritIntimacy_Gift_Out"
    },
    [PetIntimacyWindowType.ImageRecallPanel] = {
      IN = "uieff_SpiritIntimacy_Recall_In",
      OUT = "uieff_SpiritIntimacy_Recall_Out"
    }
  }
end

function UIPetIntimacyMainController:RequestAllPetInfos()
  self._listShowItemCount = table.count(self._petInfos)
end

function UIPetIntimacyMainController:FindOpenPetIndex(petid)
  if self._petInfos then
    for index = 1, #self._petInfos do
      if self._petInfos[index]:GetTemplateID() == petid then
        return index
      end
    end
  end
  return 1
end

function UIPetIntimacyMainController:OnShow(uiParams)
  AudioHelperController.RequestUISound(CriAudioIDConst.SoundSwitch)
  local petid = uiParams[1]
  self._petModule = self:GetModule(PetModule)
  self._petInfos = self._petModule.uiModule:GetSortedPets()
  self:RequestAllPetInfos()
  self._currIndex = self:FindOpenPetIndex(petid)
  self._petData = self._petInfos[self._currIndex]
  self._oldPetID = petid
  local backBtns = self:GetUIComponent("UISelectObjectPath", "BackBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._preWindowType == nil or self._currentWindowType ~= PetIntimacyWindowType.GiftPanel then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, true)
      self:CloseDialog()
    else
      self:_ClosePlayVoicePanel()
      self:_RefreshPetIntimacyInfo()
      local petChanged = false
      if self._oldPetID and self._oldPetID == self._petData:GetTemplateID() then
      else
        petChanged = true
      end
      self:_OpenWindow(self._preWindowType, nil, petChanged)
    end
  end, nil)
  self._petModeLoader = self:GetUIComponent("RawImageLoader", "PetModel")
  self._nameCHLabel = self:GetUIComponent("UILocalizationText", "NameCH")
  self._nameENLabel = self:GetUIComponent("UILocalizationText", "NameEN")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._starPool = self:GetUIComponent("UISelectObjectPath", "StarPool")
  self._attr = self:GetUIComponent("UILocalizationText", "Attr")
  self._buttonFilesOn = self:GetGameObject("ButtonFilesOn")
  self._buttonVoiceOn = self:GetGameObject("ButtonVoiceOn")
  self._buttonRecallOn = self:GetGameObject("ButtonRecallOn")
  self._buttonFilesOff = self:GetGameObject("ButtonFilesOff")
  self._buttonVoiceOff = self:GetGameObject("ButtonVoiceOff")
  self._buttonAudoOff = self:GetGameObject("ButtonAudoOff")
  self._playVoicePanel = self:GetGameObject("PlayVoice")
  self._petInfoPanel = self:GetGameObject("PetInfo")
  self._normalVoiceIconGo = self:GetGameObject("NormalVoiceIcon")
  self._inteimacyVoiceIconGo = self:GetGameObject("IntimacyVoiceIcon")
  self._voiceContent = self:GetUIComponent("UILocalizationText", "VoiceContent")
  self._firstElementGo = self:GetGameObject("MainElement")
  self._firstElementImg = self:GetUIComponent("Image", "MainElement")
  self._secondElementGo = self:GetGameObject("SecondElement")
  self._secondElementImg = self:GetUIComponent("Image", "SecondElement")
  self._leftPanelGo = self:GetGameObject("LeftPanel")
  self._intimacyLevelLabel = self:GetUIComponent("UILocalizationText", "IntimacyLevel")
  self._intimacyProgressImg = self:GetUIComponent("Image", "IntimacyProgress")
  self._outAnim = self:GetUIComponent("Animation", "OutAnim")
  self._intAnim = self:GetUIComponent("Animation", "InAnim")
  self._giftPanelAnim = self:GetUIComponent("Animation", "GiftPanelAnim")
  self._effLevelUp = self:GetGameObject("effLevelUp")
  self._effLevelUp:SetActive(false)
  self._giftCanvasGroup = self:GetUIComponent("CanvasGroup", "GiftPanel")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  local s = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._OnlyAlpha1 = self:GetUIComponent("CanvasGroup", "GiftPanel")
  self._OnlyAlpha2 = self:GetUIComponent("CanvasGroup", "randomEventTips")
  self._left = self:GetUIComponent("Transform", "left")
  self._right = self:GetUIComponent("Transform", "right")
  self._center = self:GetUIComponent("Transform", "center")
  self._petScrollRect = self:GetUIComponent("ScrollRect", "PetScrollView")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self:InitPetScrollView()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self._rawImageLoaderHelper = RawImageLoaderHelper:New()
  self._rawImageLoaderHelper:Init(1)
  self._windows = {}
  self._windows[PetIntimacyWindowType.FilesPanel] = UIPetIntimacyFiles:New(self, self._petData)
  self._windows[PetIntimacyWindowType.VoicePanel] = UIPetIntimacyVoice:New(self, self._petData)
  self._windows[PetIntimacyWindowType.GiftPanel] = UIPetIntimacyGift:New(self, self._petData)
  self._windows[PetIntimacyWindowType.ImageRecallPanel] = UIPetIntimacyImageRecall:New(self, self._petData)
  self._currentWindowType = nil
  self._preWindowType = nil
  self:_RefreshPetInfo()
  self:_ClosePlayVoicePanel()
  self:_OpenWindow(uiParams[2], true)
  local imageLoader = self:GetUIComponent("RawImageLoader", "BgLoader")
  UICommonHelper:GetInstance():ChangePetTagBackground(self._petData:GetTemplateID(), imageLoader, true)
end

function UIPetIntimacyMainController:InitPetScrollView()
  self._itemTable = {}
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "PetScrollView", "UIPetIntimacyDetailItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end, function(index, uiwidget)
    return self:_OnHideItem(index, uiwidget)
  end)
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._listShowItemCount then
      return
    end
    self:_ShowCurrIndexInfo(index + 1)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetListIndexChanged, self._petData:GetTemplateID())
  end)
  self._scrollViewHelper:SetValueChangedCallback(function(group, value, contentSize, itemSize)
    self:_OnValueChangedCallBack(group + 1, value, contentSize, itemSize)
  end)
  self._scrollRectWidth = self:GetUIComponent("RectTransform", "PetScrollView").sizeDelta.x
  local safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._scrollViewHelper:Init(self._listShowItemCount, self._currIndex, safeArea.rect.size)
  self._scrollViewHelper:SetNextPageOffset(0.12)
end

function UIPetIntimacyMainController:_OnShowItem(index, uiwidget)
  if self._itemTable[index] == nil then
    self._itemTable[index] = uiwidget
  end
  local petData = self._petInfos[index]
  uiwidget:SetData(index, petData, self._currIndex)
end

function UIPetIntimacyMainController:_OnHideItem(index, uiwidget)
  if self._itemTable[index] == nil then
    return
  end
  uiwidget:OnHideCallBack()
end

function UIPetIntimacyMainController:_ShowCurrIndexInfo(index)
  local isCurrent = false
  if self._currIndex == index then
    isCurrent = true
  end
  self._currIndex = index
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BreakCheckIsCurrent, self._currIndex)
  self._petData = self._petInfos[index]
  if not isCurrent then
    self:_RefreshPetInfo()
    self._windows[PetIntimacyWindowType.GiftPanel]:PetDataChanged(self._petData)
  end
end

function UIPetIntimacyMainController:_OnValueChangedCallBack(group, value, contentSize, itemSize)
  local di = contentSize - itemSize
  if di <= 0 then
    return
  end
  local rate = itemSize / (contentSize - itemSize)
  if rate <= 0 then
    return
  end
  local centerRate = group * rate - 0.5 * rate
  local distance = value - centerRate
  local a = math.abs(distance) / (rate * 0.5) + 0.05
  a = 1.0 - a
  if a < 0 then
    a = 0
  elseif 1 < a then
    a = 1
  end
  self._OnlyAlpha1.alpha = a
  self._OnlyAlpha2.alpha = a
  local leftRightDis = math.abs(self._left.position.x - self._right.position.x)
  local centerPosition = self._center.position
  for i = self._currIndex - 1, self._currIndex + 1 do
    if self._itemTable[i] then
      self._itemTable[i]:ChangeCanvasGroupAlpha(leftRightDis, centerPosition.x)
    end
  end
  if 0 < self._content.localPosition.x or self._content.localPosition.x < -self._content.sizeDelta.x + self._scrollRectWidth then
    return
  end
end

function UIPetIntimacyMainController:OnUpdate(deltaTimeMS)
  for k, v in pairs(self._windows) do
    v:Update()
  end
end

function UIPetIntimacyMainController:OnHide()
  for k, v in pairs(self._windows) do
    v:Destroy()
  end
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.SoundSwitch)
  if self._playVoiceTask then
    GameGlobal.TaskManager():KillTask(self._playVoiceTask)
    self._playVoiceTask = nil
  end
  if self._rawImageLoaderHelper then
    self._rawImageLoaderHelper:Dispose()
  end
end

function UIPetIntimacyMainController:_RefreshPetInfo()
  if not self._petData then
    return
  end
  self._nameCHLabel:SetText(StringTable.Get(self._petData:GetPetName()))
  self._nameENLabel:SetText(StringTable.Get(self._petData:GetPetEnglishName()))
  local itemIcon = self._petData:GetPetItemIcon(PetSkinEffectPath.ITEM_ICON_PET_INTIMACY)
  self.uiItem:SetData({
    icon = itemIcon,
    itemId = self._petData:GetTemplateID()
  })
  local grade = self._petData:GetPetAwakening()
  local star = self._petData:GetPetStar()
  self._starPool:SpawnObjects("UIPetIntimacyStar", star)
  local petIntimacyStars = self._starPool:GetAllSpawnList()
  for i = 1, #petIntimacyStars do
    local isOn = false
    if i <= grade then
      isOn = true
    end
    petIntimacyStars[i]:Refresh(isOn)
  end
  local firstElement = self._petData:GetPetFirstElement()
  local secondElement = self._petData:GetPetSecondElement()
  local elementDes = ""
  if secondElement ~= nil and secondElement ~= 0 then
    elementDes = StringTable.Get(self.ElementNameTable[firstElement]) .. "  " .. StringTable.Get(self.ElementNameTable[secondElement])
  else
    elementDes = StringTable.Get(self.Element2ImageName[firstElement])
  end
  self._attr:SetText(elementDes)
  self._firstElementImg.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self.ElementSpriteName[firstElement]))
  if secondElement ~= nil and secondElement ~= 0 then
    self._secondElementGo:SetActive(true)
    self._secondElementImg.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self.ElementSpriteName[secondElement]))
  else
    self._secondElementGo:SetActive(false)
  end
  self:_RefreshPetIntimacyInfo()
end

function UIPetIntimacyMainController:_RefreshPetIntimacyInfo()
  local level = self._petData:GetPetAffinityLevel()
  local maxLevel = self._petData:GetPetAffinityMaxLevel()
  self._intimacyLevelLabel.text = level
  if level >= maxLevel then
    self._intimacyProgressImg.fillAmount = 1
  else
    local exp = self._petData:GetPetAffinityExp()
    local maxExp = self._petData:GetPetAffinityMaxExp(level)
    local curExp = exp - Cfg.cfg_pet_affinity_exp[level].NeedAffintyExp
    local percent = curExp / maxExp
    self._intimacyProgressImg.fillAmount = percent
  end
end

function UIPetIntimacyMainController:_RefreshPanelState(isFirstOpen)
  self:_HideAllPanel()
  self:_SetPanelVisible()
  if isFirstOpen then
    return
  end
  GameGlobal.TaskManager():StartTask(self._PlayPanelAnim, self, isFirstOpen)
end

function UIPetIntimacyMainController:_PlayPanelAnim(TT, isFirstOpen)
  self:Lock("PlayPanelAnim")
  if self._preWindowType == PetIntimacyWindowType.GiftPanel then
    self:GetGameObject("GiftPanel"):SetActive(true)
  end
  local outAnimName = self._animName[self._preWindowType].OUT
  local inAnimName = self._animName[self._currentWindowType].IN
  if self._currentWindowType == PetIntimacyWindowType.GiftPanel then
    self._giftPanelAnim:Play(inAnimName)
  end
  self._outAnim:Play(outAnimName)
  self._intAnim:Play(inAnimName)
  YIELD(TT, 500)
  if self._preWindowType == PetIntimacyWindowType.GiftPanel then
    self._giftCanvasGroup.alpha = 1
    self:_HideAllPanel()
    self:_SetPanelVisible()
  end
  self:UnLock("PlayPanelAnim")
end

function UIPetIntimacyMainController:_HideAllPanel()
  self:GetGameObject("FilesPanel"):SetActive(false)
  self:GetGameObject("VoicePanel"):SetActive(false)
  self:GetGameObject("GiftPanel"):SetActive(false)
  self:GetGameObject("ImageRecallPanel"):SetActive(false)
end

function UIPetIntimacyMainController:_SetPanelVisible()
  if self._currentWindowType == PetIntimacyWindowType.FilesPanel then
    self:GetGameObject("FilesPanel"):SetActive(true)
    self._leftPanelGo:SetActive(true)
    self._petInfoPanel:SetActive(true)
  elseif self._currentWindowType == PetIntimacyWindowType.VoicePanel then
    self:GetGameObject("VoicePanel"):SetActive(true)
    self._leftPanelGo:SetActive(true)
    self._petInfoPanel:SetActive(true)
  elseif self._currentWindowType == PetIntimacyWindowType.GiftPanel then
    self:GetGameObject("GiftPanel"):SetActive(true)
    self._leftPanelGo:SetActive(false)
  elseif self._currentWindowType == PetIntimacyWindowType.ImageRecallPanel then
    self:GetGameObject("ImageRecallPanel"):SetActive(true)
    self._leftPanelGo:SetActive(true)
    self._petInfoPanel:SetActive(true)
  end
end

function UIPetIntimacyMainController:_RefreshButtonStatus()
  self._buttonFilesOn:SetActive(false)
  self._buttonVoiceOn:SetActive(false)
  self._buttonRecallOn:SetActive(false)
  self._buttonFilesOff:SetActive(true)
  self._buttonVoiceOff:SetActive(true)
  self._buttonAudoOff:SetActive(true)
  if self._currentWindowType == PetIntimacyWindowType.FilesPanel then
    self._buttonFilesOn:SetActive(true)
    self._buttonFilesOff:SetActive(false)
  elseif self._currentWindowType == PetIntimacyWindowType.VoicePanel then
    self._buttonVoiceOn:SetActive(true)
    self._buttonVoiceOff:SetActive(false)
  elseif self._currentWindowType == PetIntimacyWindowType.ImageRecallPanel then
    self._buttonRecallOn:SetActive(true)
    self._buttonAudoOff:SetActive(false)
  end
end

function UIPetIntimacyMainController:_OpenWindow(windowType, isFirstOpen, isPetChanged)
  if self._currentWindowType == windowType then
    return
  end
  if self._currentWindowType then
    self._windows[self._currentWindowType]:CloseWindow()
  end
  self._preWindowType = self._currentWindowType
  self._currentWindowType = windowType
  self:_RefreshButtonStatus()
  self:_RefreshPanelState(isFirstOpen)
  if isPetChanged then
    self._windows[PetIntimacyWindowType.FilesPanel]:PetDataChanged(self._petData)
    self._windows[PetIntimacyWindowType.VoicePanel]:PetDataChanged(self._petData)
    self._windows[PetIntimacyWindowType.ImageRecallPanel]:PetDataChanged(self._petData)
    self._oldPetID = self._petData:GetTemplateID()
  end
  self._windows[windowType]:Refresh()
  local scrollEnable = self._currentWindowType == PetIntimacyWindowType.GiftPanel
  self._petScrollRect.enabled = scrollEnable
end

function UIPetIntimacyMainController:OnItemCountChanged()
  if self._currentWindowType ~= PetIntimacyWindowType.GiftPanel then
    return
  end
  local window = self._windows[PetIntimacyWindowType.GiftPanel]
  window:Refresh()
end

function UIPetIntimacyMainController:_ShowPlayVoicePanel(voiceContent, isNormal)
  if isNormal then
    self._normalVoiceIconGo:SetActive(true)
    self._inteimacyVoiceIconGo:SetActive(false)
  else
    self._normalVoiceIconGo:SetActive(false)
    self._inteimacyVoiceIconGo:SetActive(true)
  end
  self._voiceContent.text = voiceContent
  self._voiceContent.transform.localPosition = Vector3.zero
  self._playVoicePanel:SetActive(true)
  self._petInfoPanel:SetActive(false)
  local inAnimName = "uieff_SpiritIntimacy_PlayVoice_In"
  self._intAnim:Play(inAnimName)
end

function UIPetIntimacyMainController:_ClosePlayVoicePanel(isPlayAnim)
  if isPlayAnim then
    self._playVoiceTask = GameGlobal.TaskManager():StartTask(self._PlayVoicePanelCloseAnim, self)
  else
    self._playVoicePanel:SetActive(false)
  end
  if self._currentWindowType ~= PetIntimacyWindowType.GiftPanel then
    self._petInfoPanel:SetActive(true)
  end
end

function UIPetIntimacyMainController:_PlayVoicePanelCloseAnim(TT)
  local inAnimName = "uieff_SpiritIntimacy_PlayVoice_Out"
  self._intAnim:Play(inAnimName)
  YIELD(TT, 200)
  self._playVoicePanel:SetActive(false)
  self._playVoiceTask = nil
end

function UIPetIntimacyMainController:PlayVoice(voiceContent, isNormal)
  self:_ShowPlayVoicePanel(voiceContent, isNormal)
end

function UIPetIntimacyMainController:StopPlayVoice(isPlayAnim)
  self:_ClosePlayVoicePanel(isPlayAnim)
end

function UIPetIntimacyMainController:ShowItemTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIPetIntimacyMainController:CloseItemTips()
  self._tips:closeOnClick()
end

function UIPetIntimacyMainController:ButtonMaskOnClick(go)
  self:_ClosePlayVoicePanel(true)
end

function UIPetIntimacyMainController:ButtonFilesOnClick(go)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundSwitch)
  self:_OpenWindow(PetIntimacyWindowType.FilesPanel)
end

function UIPetIntimacyMainController:ButtonVoiceOnClick(go)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundSwitch)
  self:_OpenWindow(PetIntimacyWindowType.VoicePanel)
end

function UIPetIntimacyMainController:ButtonGiftOnClick(go)
  if GameSingle then
    return
  end
  self:_OpenWindow(PetIntimacyWindowType.GiftPanel)
end

function UIPetIntimacyMainController:ButtonRecallOnClick(go)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundSwitch)
  self:_OpenWindow(PetIntimacyWindowType.ImageRecallPanel)
end

function UIPetIntimacyMainController:imgStumblesOnClick(go)
  self:ShowDialog("UIPetIntimacyStumbles", self._petData)
end
