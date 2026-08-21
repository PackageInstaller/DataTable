_class("UIPetIntimacyGiftItem", UICustomWidget)
UIPetIntimacyGiftItem = UIPetIntimacyGiftItem

function UIPetIntimacyGiftItem:OnShow(uiParams)
  self._maxSelectedCount = Cfg.cfg_global.ui_pet_up_level_mat_cast_count_max.IntValue or 99
  self._addCountPerSecond = Cfg.cfg_global.pet_up_level_add_count_per_second.IntValue
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

function UIPetIntimacyGiftItem:Refresh(intimacyMainController, intimacyGift, petData, giftData)
  self._intimacyMainController = intimacyMainController
  self._intimacyGift = intimacyGift
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
  showLove = self._intimacyGift:IsFavorableGift(self._giftData)
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

function UIPetIntimacyGiftItem:_RefreshSelectedStatus()
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

function UIPetIntimacyGiftItem:OnClicked(go)
  if self._giftData == nil then
    return
  end
  local currentSelectedCount = self._giftData.selectedCount
  if currentSelectedCount >= self._maxSelectedCount or currentSelectedCount >= self._giftData.giftData:GetCount() then
    return
  end
  local success = self._intimacyGift:OnItemClicked(self._giftData, true)
  if success then
    self._giftData.isSelected = true
    self._giftData.selectedCount = self._giftData.selectedCount + 1
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
    self:_RefreshSelectedStatus()
  end
end

function UIPetIntimacyGiftItem:LongPress(go)
  if self._giftData == nil then
    return
  end
  self._intimacyMainController:ShowItemTips(self._giftData.giftData:GetTemplateID(), self:GetGameObject().transform.position)
end

function UIPetIntimacyGiftItem:LongPressUp(go)
  if self._giftData == nil then
    return
  end
  self._intimacyMainController:CloseItemTips()
end

function UIPetIntimacyGiftItem:MinusGiveAwayCountButtonOnClick(go)
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
  self._intimacyGift:OnItemClicked(self._giftData, false)
end
