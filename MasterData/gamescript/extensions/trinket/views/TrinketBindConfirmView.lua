local TrinketBindConfirmView, Super = NewClass("TrinketBindConfirmView", BaseView)
TrinketBindConfirmView.uiResCls = UI_Awaker_Popup_BindTrinketResource

function TrinketBindConfirmView:ctor(awakerTid, pos, uid, costTrinketUids, onConfirm)
  Super.ctor(self)
  self.awakerTid = awakerTid
  self.pos = pos
  self.uid = uid
  self.costTrinketUids = costTrinketUids or {}
  self.onConfirm = onConfirm
end

function TrinketBindConfirmView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
end

function TrinketBindConfirmView:OnEnterView()
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("UniversalConfirmButton"))
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  self:_RefreshTargetTrinketIcon()
end

function TrinketBindConfirmView:_RefreshTargetTrinketIcon()
  local itemData = ItemDataUtils.GetItemByUid(self.uid)
  if not itemData then
    return
  end
  local iconData = {
    itemTid = itemData.tid,
    itemUid = self.uid,
    clickFunc = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.UI_Common_Item_WuPin_Type2, self.uid, itemData.tid)
    end
  }
  self:AddViewComponent(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, iconData)
  self:_RefreshMainAttrIcon(itemData)
end

function TrinketBindConfirmView:_RefreshMainAttrIcon(itemData)
  local itemUi = UI_Common_Item_WuPin_Type2Resource(self.ui.UI_Common_Item_WuPin_Type2)
  if not itemUi.Image_Michi then
    return
  end
  local mainAttr = AwakerTrinketDataUtils.GetMainAttrByItemData(itemData)
  if not mainAttr then
    itemUi.Image_Michi:SetActive(false)
    return
  end
  itemUi.Image_Michi:SetActive(true)
  local attrType = DT.ActorAttrType[mainAttr.attrId]
  if attrType and attrType.Icon and itemUi.Image_Icon then
    self:SetImage(itemUi.Image_Icon, attrType.Icon)
  end
end

function TrinketBindConfirmView:_OnClickConfirm()
  if self.onConfirm then
    self.onConfirm()
  end
  if self.uid and self.uid > 0 then
    local targetTrinkets = {
      [self.pos] = self.uid
    }
    AwakerTrinketController.Instance:ReqBatchBindTrinket(self.awakerTid, targetTrinkets, self.costTrinketUids)
  end
  self:Close()
end

return TrinketBindConfirmView
