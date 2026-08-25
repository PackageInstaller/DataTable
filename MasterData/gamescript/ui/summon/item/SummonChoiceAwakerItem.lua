local SummonChoiceAwakerItem, Super = System.NewComponent("SummonChoiceAwakerItem")
SummonChoiceAwakerItem.uiResCls = UI_Summon_Item_OptionalLimitResource

function SummonChoiceAwakerItem:ctor(obj, itemData)
  Super.ctor(self)
  self.ui = SummonChoiceAwakerItem.uiResCls(obj)
  self.itemData = itemData
  self.itemTid = itemData.itemTid
  self.awakerTid = itemData.awakerTid
  self.awakerData = itemData.awakerData
end

function SummonChoiceAwakerItem:OnBind(binder)
  self.binder = binder
  local awakerTid = self.awakerTid
  local itemTid = self.itemTid
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local icon = AwakerDataUtils.GetAwakerBust(awakerTid, 0)
  local quality = AwakerDataUtils.GetAwakerQualityColor(awakerTid)
  local schoolIcon = awakerCfg.School and AwakerDataUtils.GetSchoolIcon(awakerCfg.School) or ""
  local name = LT.Text(awakerCfg.Name)
  local maxPotency = ItemDataUtils.IsAwakerChipOverFlow(itemTid)
  if self.ui.Image_Icon then
    self.ui.Image_Icon:SetActive(false)
  end
  if self.ui.Image_Awaker then
    self.ui.Image_Awaker:SetActive(true)
    binder:SetImage(self.ui.Image_Awaker, icon)
  end
  if self.ui.Image_Quality then
    binder:SetImage(self.ui.Image_Quality, quality)
  end
  if self.ui.Image_Career then
    self.ui.Image_Career:SetActive(true)
    binder:SetImage(self.ui.Image_Career, schoolIcon or "")
  end
  if self.ui.Image_Full then
    self.ui.Image_Full:SetActive(maxPotency)
  end
  if self.ui.Text_Name then
    binder:SetText(self.ui.Text_Name, name)
  end
  if self.ui.Text_C_Full then
    binder:SetText(self.ui.Text_C_Full, LT.Text("MaxPotencyAwakerShopTips"))
  end
  self:_BindPotencyShow(binder)
  self:_BindMaskShow(binder)
  if self.ui.Image_Selected then
    binder:BindToVisible(self.ui.Image_Selected, function()
      do return self._IsSelected end
      return self._IsSelected, self
    end)
  end
  if self.ui.Btn_Click then
    binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self._OnLongPress), System.fn(self, self._OnClick), 0.3)
  end
end

function SummonChoiceAwakerItem:_OnLongPress()
  SummonUiUtils.ShowAwakerDetailByItemTid(self.itemTid)
end

function SummonChoiceAwakerItem:_OnClick()
  if self.itemData.clickFunc then
    self.itemData.clickFunc()
  end
end

function SummonChoiceAwakerItem:_IsSelected()
  return self.itemData.selectBgFunc ~= nil and self.itemData.selectBgFunc() == true
end

function SummonChoiceAwakerItem:_GetConflictTips()
  if self:_IsSelected() then
    return nil
  end
  local tips = self.itemData.conflictTipsFunc and self.itemData.conflictTipsFunc()
  if not tips or "" == tips then
    return nil
  end
  return tips
end

function SummonChoiceAwakerItem:_BindMaskShow(binder)
  if self.ui.Image_Have then
    binder:BindToVisible(self.ui.Image_Have, function()
      if self:_GetConflictTips() then
        return false
      end
      return not ItemDataUtils.IsAwakerChipOverFlow(self.itemTid) and AwakerDataUtils.HasOwnedAwaker(self.awakerTid)
    end)
  end
  if self.ui.Image_Conflict then
    binder:BindToVisible(self.ui.Image_Conflict, function()
      return self:_GetConflictTips() ~= nil
    end)
  end
  if self.ui.Text_Conflict then
    binder:BindToText(self.ui.Text_Conflict, function()
      return self:_GetConflictTips() or ""
    end)
  end
end

function SummonChoiceAwakerItem:_BindPotencyShow(binder)
  if not self.ui.UI_Common_Item_Potency then
    return
  end
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    local awakerData = self.awakerData or AwakerDataUtils.GetAwakerData(self.awakerTid)
    if not awakerData then
      return {}
    end
    return {
      self.awakerTid,
      awakerData.potency
    }
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Potency, function()
    do return AwakerDataUtils.HasOwnedAwaker end
    return AwakerDataUtils.HasOwnedAwaker, self.awakerTid
  end)
  if self.ui.Image_Mask then
    binder:BindToVisible(self.ui.Image_Mask, function()
      do return AwakerDataUtils.HasOwnedAwaker end
      return AwakerDataUtils.HasOwnedAwaker, self.awakerTid
    end)
  end
end

return SummonChoiceAwakerItem
