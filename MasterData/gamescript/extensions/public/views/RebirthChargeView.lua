local RebirthChargeView, Super = NewClass("RebirthChargeView", BaseView)
RebirthChargeView.uiResCls = UI_Battle_Popup_RebirthTipResource

function RebirthChargeView:ctor(viewData)
  Super.ctor(self)
  self.viewData = viewData
  self.costItemTid = viewData.costItemTid
  self.rebirthItemId = viewData.rebirthItemId
  self.shopCfg = viewData.shopCfg
  self.costNum = viewData.costNum
  self.needBuyCount = viewData.needBuyCount or 1
  self.isAbyssChallenge = viewData.isAbyssChallenge
  self.shopItemData = viewData.shopItemData
  self.remainNum = MainShopDataUtils.GetGoodRemaining(self.shopItemData)
end

function RebirthChargeView:OnEnterView()
  self:RefreshView()
end

function RebirthChargeView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self.RefreshView, self)
end

function RebirthChargeView:_OnClickCancel()
  self:Close()
  if self.viewData.cancelFunc then
    self.viewData.cancelFunc()
  end
end

function RebirthChargeView:_OnClickConfirm()
  local ownedNum = ItemDataUtils.GetItemNum(self.costItemTid)
  if ownedNum < self.costNum then
    Alert.ShowStr(LT.Textf("Shop_Buy_Lack_Money", ItemNumUtils.GetNameStr(self.costItemTid)))
    return
  end
  local shopTid = self.shopCfg.ID
  local shopTypeTid = MainShopDataUtils.GetShopTypeIDByTag(CommonDefine.MainShopTypeTag.HiddenShop)
  MainShopDataUtils.ReqOnShopBuyGoods(shopTid, shopTypeTid, self.needBuyCount, function()
    if self.viewData.confirmFunc then
      self.viewData.confirmFunc()
    end
    self:Close()
  end)
end

function RebirthChargeView:RefreshView()
  self:_RefreshConfirmTipsInfo()
  self:_RefreshCurrency()
  self:_RefreshCostItemInfo()
end

function RebirthChargeView:_RefreshConfirmTipsInfo()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm),
    stateFunc = function()
      local ownedNum = ItemDataUtils.GetItemNum(self.costItemTid)
      if ownedNum < self.costNum then
        return CommonDefine.BtnType.Unclickable
      end
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickCancel),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_S, CompPublicPopupConfirmTips, viewData)
end

function RebirthChargeView:_RefreshCurrency()
  local currencyList = {
    self.costItemTid,
    self.rebirthItemId
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
end

function RebirthChargeView:_RefreshCostItemInfo()
  self:SetText(self.ui.Text_CostNum, self.costNum)
  self:SetText(self.ui.Text_CostNum2, self.costNum)
  self:_RefreshCostItemTextColor()
  if self.isAbyssChallenge and self.ui.Text_C_CostTips then
    self:SetText(self.ui.Text_C_CostTips, LT.Text("AbyssChallengeRevivalCostTips"))
  end
  self:SetText(self.ui.Text_C_Tips, LT.Textf("ResurrectionCoinPurchaseTips", self.remainNum))
  local costItemIcon = ItemDataUtils.GetItemIcon(self.costItemTid)
  self:SetImage(self.ui.Image_Item, costItemIcon)
  self:SetImage(self.ui.Image_Cost, costItemIcon)
  local viewData = {
    itemTid = self.rebirthItemId
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, viewData)
end

function RebirthChargeView:_RefreshCostItemTextColor()
  local ownedNum = ItemDataUtils.GetItemNum(self.costItemTid)
  if ownedNum >= self.costNum then
    self:SetTextColorByHtml(self.ui.Text_CostNum2, CommonDefine.Color.Content)
  else
    self:SetTextColorByHtml(self.ui.Text_CostNum2, CommonDefine.Color.Negative)
  end
end

return RebirthChargeView
