local FreeChoiceChestItem, Super = System.NewComponent("FreeChoiceChestItem")

function FreeChoiceChestItem:ctor(obj, chestModel, itemInfo, idx, isPreview)
  Super.ctor(self)
  self.ui = UI_Events_Item_OptionalResource(obj)
  self.chestModel = chestModel
  self.itemInfo = itemInfo
  self.idx = idx
  self.isPreview = isPreview or false
end

function FreeChoiceChestItem:OnBind(binder)
  if self.itemInfo.itemType == CommonDefine.ItemType.AwakerItem then
    self.ui.Image_Icon:SetActive(false)
    self.ui.Image_Awaker:SetActive(true)
    binder:SetImage(self.ui.Image_Awaker, self.itemInfo.icon)
    binder:SetImage(self.ui.Image_Quality, self.itemInfo.quality)
    self.ui.Image_Career:SetActive(true)
    binder:SetImage(self.ui.Image_Career, self.itemInfo.schoolIcon)
    self.ui.Image_Have:SetActive(not self.itemInfo.maxPotency and self.itemInfo.alreadyOwned)
    self.ui.Image_Full:SetActive(self.itemInfo.maxPotency)
    binder:SetText(self.ui.Text_Name, self.itemInfo.name)
    binder:SetText(self.ui.Text_C_Full, LT.Text("MaxPotencyAwakerShopTips"))
    self:_BindPotencyShow(binder)
  elseif self.itemInfo.itemType == CommonDefine.ItemType.Weapon then
    local weaponData = ItemDataUtils.GetItemByTid(self.itemInfo.tid)
    local isOwn = self.itemInfo.alreadyOwned
    local refineLevel = isOwn and weaponData.level or 0
    binder:BindComponent(CommonWeaponPotencyItem(self.ui.UI_Common_Item_Potency, {potency = refineLevel}))
    self.ui.Image_Mask:SetActive(false)
    self.ui.Image_Awaker:SetActive(false)
    self.ui.Image_Icon:SetActive(true)
    binder:SetImage(self.ui.Image_Icon, self.itemInfo.icon)
    binder:SetImage(self.ui.Image_Quality, self.itemInfo.quality)
    self.ui.Image_Mask:SetActive(isOwn)
    self.ui.Image_Career:SetActive(false)
    self.ui.Image_Have:SetActive(self.itemInfo.alreadyOwned)
    self.ui.Image_Full:SetActive(MainShopDataUtils.IsMaxPotencyByItemId(self.itemInfo.tid))
    binder:SetText(self.ui.Text_Name, self.itemInfo.name)
    binder:SetText(self.ui.Text_C_Full, LT.Text("MaxLevelWeaponShopTips"))
  else
    self.ui.Image_Icon:SetActive(false)
    self.ui.Image_Awaker:SetActive(true)
    binder:SetImage(self.ui.Image_Awaker, self.itemInfo.icon)
    binder:SetImage(self.ui.Image_Quality, self.itemInfo.quality)
    self.ui.Image_Career:SetActive(true)
    binder:SetImage(self.ui.Image_Career, self.itemInfo.schoolIcon)
    self.ui.Image_Have:SetActive(not self.itemInfo.maxPotency and self.itemInfo.alreadyOwned)
    self.ui.Image_Full:SetActive(self.itemInfo.maxPotency)
    binder:SetText(self.ui.Text_Name, self.itemInfo.name)
    binder:SetText(self.ui.Text_C_Full, LT.Text("MaxPotencyAwakerShopTips"))
    self:_BindPotencyShow(binder)
  end
  binder:BindToVisible(self.ui.Image_Selected, function()
    return not self.isPreview and self.idx == self.chestModel.currSelectedIdx
  end)
  
  local function _ShowDetail()
    local itemInfo = self.itemInfo
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
      ItemDataUtils.ShowItemDetailTips(binder, self.ui.Btn_Click, nil, itemInfo.tid)
    end
  end
  
  if self.isPreview then
    binder:BindButtonClick(self.ui.Btn_Click, _ShowDetail)
  else
    binder:BindLongPressButton(self.ui.Btn_Click, _ShowDetail, function()
      self.chestModel:SelectItem(self.idx)
    end, 0.5)
  end
end

function FreeChoiceChestItem:_BindPotencyShow(binder)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.itemInfo.awakerTid)
    if not awakerData then
      return {}
    end
    return {
      self.itemInfo.awakerTid,
      awakerData.potency
    }
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Potency, function()
    return self.itemInfo.alreadyOwned or false
  end)
  binder:BindToVisible(self.ui.Image_Mask, function()
    return self.itemInfo.alreadyOwned or false
  end)
end

return FreeChoiceChestItem
