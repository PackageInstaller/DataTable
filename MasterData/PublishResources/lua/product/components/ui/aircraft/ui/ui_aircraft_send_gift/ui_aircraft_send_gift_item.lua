_class("UIAircraftSendGiftItem", UICustomWidget)
UIAircraftSendGiftItem = UIAircraftSendGiftItem

function UIAircraftSendGiftItem:OnShow(uiParams)
  self._maxSelectedCount = Cfg.cfg_global.ui_pet_up_level_mat_cast_count_max.IntValue or 99
  self._addCountPerSecond = Cfg.cfg_global.pet_up_level_add_count_per_second.IntValue
  self._pressTime = 500
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.PetFavorability)
  self.uiItem:SetClickCallBack(function()
    self:OnClicked()
  end)
  self.uiItem:SetLongPressCallBack(function()
    self:OnClicked()
    return self._giftData and self._giftData.giftData:GetCount() or 0
  end, nil, self._addCountPerSecond, true)
  self.uiItem:SetData({
    reduceCallBack = function()
      self:MinusGiveAwayCountButtonOnClick()
    end
  })
  self.uiItem:SetReduceLongPressCallBack(self._addCountPerSecond)
end

function UIAircraftSendGiftItem:Refresh(petData, giftData, itemClickCallback, longPressCallback, longPressUpCallback, isFavorableGift)
  self._itemClickCallback = itemClickCallback
  self._longPressCallback = longPressCallback
  self._longPressUpCallback = longPressUpCallback
  self._isFavorableGift = isFavorableGift
  self._petData = petData
  self._giftData = giftData
  if self._giftData == nil then
    self.uiItem:SetData({
      showLove = false,
      reduceNum = 0,
      quality = 0,
      icon = "",
      text1 = ""
    })
    self.uiItem:SetBtnImage(false)
    return
  end
  local icon = ""
  local quality = 0
  local showLove = false
  local text1 = 0
  local reduceNum = 0
  text1 = self._giftData.giftData:GetCount()
  self._templateData = self._giftData.giftData:GetTemplate()
  local itemId = self._templateData.ID
  quality = self._templateData.Color
  if self._isFavorableGift then
    showLove = self._isFavorableGift(self._giftData)
  end
  icon = self._templateData.Icon
  reduceNum = self._giftData and self._giftData.selectedCount or 0
  local changePos = false
  if self._reduceNum ~= reduceNum then
    self._reduceNum = reduceNum
    changePos = true
  end
  local isUp = true
  if 0 < reduceNum then
    isUp = false
  end
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    showLove = showLove,
    text1 = text1,
    reduceNum = reduceNum,
    itemId = itemId,
    changePos = changePos,
    isUp = isUp
  })
  self.uiItem:SetBtnImage(true)
end

function UIAircraftSendGiftItem:_RefreshSelectedStatus()
  local reduceNum = self._giftData and self._giftData.selectedCount or 0
  local changePos = false
  if self._reduceNum ~= reduceNum then
    self._reduceNum = reduceNum
    changePos = true
  end
  local isUp = true
  if 0 < reduceNum then
    isUp = false
  end
  self.uiItem:SetData({
    reduceNum = reduceNum,
    changePos = changePos,
    isUp = isUp
  })
end

function UIAircraftSendGiftItem:OnClicked(go)
  if self._giftData == nil then
    return
  end
  local currentSelectedCount = self._giftData.selectedCount
  if currentSelectedCount >= self._maxSelectedCount or currentSelectedCount >= self._giftData.giftData:GetCount() then
    return
  end
  local success = self._itemClickCallback(self._giftData, true)
  if success then
    self._giftData.isSelected = true
    self._giftData.selectedCount = self._giftData.selectedCount + 1
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
    self:_RefreshSelectedStatus()
  end
end

function UIAircraftSendGiftItem:LongPress()
  if self._giftData == nil then
    return
  end
  if self._longPressCallback then
    self._longPressCallback(self._giftData.giftData:GetTemplateID(), self:GetGameObject().transform.position)
  end
end

function UIAircraftSendGiftItem:LongPressUp()
  if self._giftData == nil then
    return
  end
  if self._longPressUpCallback then
    self._longPressUpCallback()
  end
end

function UIAircraftSendGiftItem:MinusGiveAwayCountButtonOnClick(go)
  if self._giftData == nil then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
  local currentSelectedCount = self._giftData.selectedCount
  if currentSelectedCount <= 0 then
    return
  end
  self._giftData.selectedCount = currentSelectedCount - 1
  if self._giftData.selectedCount <= 0 then
    self._giftData.isSelected = false
    self._giftData.selectedCount = 0
  end
  self:_RefreshSelectedStatus()
  self._itemClickCallback(self._giftData, false)
end
