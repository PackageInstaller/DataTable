local CompFreeChoiceChestItem, Super = NewViewComponent("CompFreeChoiceChestItem")

function CompFreeChoiceChestItem:ctor(uiNode, view, chestModel, itemInfo, idx, isPreview)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Events_Item_OptionalResource(uiNode)
  self._chestModel = chestModel
  self._itemInfo = itemInfo
  self._idx = idx
  self._isPreview = isPreview or false
end

function CompFreeChoiceChestItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnFreeChoiceChestSelectionChanged, self._OnSelectionChanged, self)
end

function CompFreeChoiceChestItem:RegisterEvents()
  if self._isPreview then
    self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._ShowDetail))
  else
    self:SetLongPressButtonIntervalTime(self.ui.Btn_Click, 0.5)
    self:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self._OnShortPress))
    self:AddLongPressButtonListener(self.ui.Btn_Click, System.fn(self, self._ShowDetail))
  end
end

function CompFreeChoiceChestItem:OnEnterComponent()
  self:_RefreshText()
  self:_RefreshImage()
  self:_RefreshVisible()
  self:_RefreshPotency()
end

function CompFreeChoiceChestItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CompFreeChoiceChestItem:_RefreshText()
  local itemType = self._itemInfo.itemType
  if itemType == CommonDefine.ItemType.AwakerItem then
    self:SetText(self.ui.Text_Name, self._itemInfo.name)
    self:SetText(self.ui.Text_C_Full, LT.Text("MaxPotencyAwakerShopTips"))
  elseif itemType == CommonDefine.ItemType.Weapon then
    self:SetText(self.ui.Text_Name, self._itemInfo.name)
    self:SetText(self.ui.Text_C_Full, LT.Text("MaxLevelWeaponShopTips"))
  else
    self:SetText(self.ui.Text_Name, self._itemInfo.name)
    self:SetText(self.ui.Text_C_Full, LT.Text("MaxPotencyAwakerShopTips"))
  end
end

function CompFreeChoiceChestItem:_RefreshImage()
  local itemType = self._itemInfo.itemType
  if itemType == CommonDefine.ItemType.AwakerItem then
    self:SetImage(self.ui.Image_Awaker, self._itemInfo.icon)
    self:SetImage(self.ui.Image_Quality, self._itemInfo.quality)
    self:SetImage(self.ui.Image_Career, self._itemInfo.schoolIcon)
  elseif itemType == CommonDefine.ItemType.Weapon then
    self:SetImage(self.ui.Image_Icon, self._itemInfo.icon)
    self:SetImage(self.ui.Image_Quality, self._itemInfo.quality)
  else
    self:SetImage(self.ui.Image_Awaker, self._itemInfo.icon)
    self:SetImage(self.ui.Image_Quality, self._itemInfo.quality)
    self:SetImage(self.ui.Image_Career, self._itemInfo.schoolIcon)
  end
end

function CompFreeChoiceChestItem:_RefreshVisible()
  local itemType = self._itemInfo.itemType
  local isOwned = self._itemInfo.alreadyOwned
  if itemType == CommonDefine.ItemType.AwakerItem then
    self.ui.Image_Icon:SetActive(false)
    self.ui.Image_Awaker:SetActive(true)
    self.ui.Image_Career:SetActive(true)
    self.ui.Image_Have:SetActive(not self._itemInfo.maxPotency and isOwned)
    self.ui.Image_Full:SetActive(self._itemInfo.maxPotency)
  elseif itemType == CommonDefine.ItemType.Weapon then
    self.ui.Image_Awaker:SetActive(false)
    self.ui.Image_Icon:SetActive(true)
    self.ui.Image_Mask:SetActive(isOwned)
    self.ui.Image_Career:SetActive(false)
    self.ui.Image_Have:SetActive(isOwned)
    self.ui.Image_Full:SetActive(MainShopDataUtils.IsMaxPotencyByItemId(self._itemInfo.tid))
  else
    self.ui.Image_Icon:SetActive(false)
    self.ui.Image_Awaker:SetActive(true)
    self.ui.Image_Career:SetActive(true)
    self.ui.Image_Have:SetActive(not self._itemInfo.maxPotency and isOwned)
    self.ui.Image_Full:SetActive(self._itemInfo.maxPotency)
  end
  local isSelect = not self._isPreview and self._idx == self._chestModel:GetCurrSelectedIdx()
  self.ui.Image_Selected:SetActive(isSelect)
end

function CompFreeChoiceChestItem:_RefreshPotency()
  local itemType = self._itemInfo.itemType
  if itemType == CommonDefine.ItemType.Weapon then
    self:_RefreshWeaponPotency()
  else
    self:_RefreshAwakerPotency()
  end
end

function CompFreeChoiceChestItem:_RefreshWeaponPotency()
  local isOwn = self._itemInfo.alreadyOwned
  local weaponData = isOwn and ItemDataUtils.GetItemByTid(self._itemInfo.tid) or nil
  local refineLevel = weaponData and weaponData.level or 0
  self.ui.UI_Common_Item_Potency:SetActive(true)
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompWeaponPotencyItem, {potency = refineLevel})
end

function CompFreeChoiceChestItem:_RefreshAwakerPotency()
  local isOwn = self._itemInfo.alreadyOwned or false
  self.ui.UI_Common_Item_Potency:SetActive(isOwn)
  self.ui.Image_Mask:SetActive(isOwn)
  local awakerData = AwakerDataUtils.GetAwakerData(self._itemInfo.awakerTid)
  if not awakerData then
    return
  end
  local viewData = {
    awakerTid = self._itemInfo.awakerTid,
    potency = awakerData.potency
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompAwakerPotencyItem, viewData)
end

function CompFreeChoiceChestItem:_OnShortPress()
  self._chestModel:SetCurrSelectedIdx(self._idx)
end

function CompFreeChoiceChestItem:_OnSelectionChanged()
  self:_RefreshVisible()
end

function CompFreeChoiceChestItem:_ShowDetail()
  local itemInfo = self._itemInfo
  if itemInfo.SubType == CommonDefine.ItemSubType.AwakerChip or itemInfo.itemType == CommonDefine.ItemType.AwakerItem then
    FuncJumpManager.JumpToFuncPanel(nil, function()
      local awakerBasePanelData = {}
      awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
      awakerBasePanelData.specialAwakerList = {
        AwakerDataUtils.GetAwakerData(itemInfo.awakerTid)
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    end)
  else
    ItemDataUtils.ShowItemDetailTips(self.view.binder, self.ui.Btn_Click, nil, itemInfo.tid)
  end
end

return CompFreeChoiceChestItem
