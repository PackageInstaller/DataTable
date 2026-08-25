local notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
local CopySpecialShopBaseItem, Super = NewViewComponent("CopySpecialShopBaseItem")

function CopySpecialShopBaseItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dbgcopy_Item_Shop_GoodsResource(uiNode)
  self.goodsData = viewData.goodsData or {}
  self.shopData = viewData.shopData or {}
  self.specialShopCfgInfo = viewData.specialShopCfgInfo or {}
  self.slot = viewData.slot
end

function CopySpecialShopBaseItem:_RefreshGoodsInfo()
end

function CopySpecialShopBaseItem:_OnBtnBuy()
end

function CopySpecialShopBaseItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Flushed, System.fn(self, self._OnBtnFlushed))
  self:AddButtonClickListener(self.ui.Image_Bg, System.fn(self, self._OnBtnBuy))
end

function CopySpecialShopBaseItem:_OnBtnFlushed()
  self:_ReqGoodsRefresh()
end

function CopySpecialShopBaseItem:OnEnterComponent()
  self:_RefreshGoodsInfo()
  self:_RefreshRefeshInfo()
  self:_RefreshCostInfo()
  self:_RefreshSoldOutInfo()
end

function CopySpecialShopBaseItem:_RefreshCostInfo()
  local basePrice = self.goodsData.basePrice or 0
  local price = self.goodsData.price or 0
  local isGift = false
  local moneyText = price
  if 0 == price then
    local ShopEnchantAsGiftState = DT.GetConstant("ShopEnchantAsGift")
    local layer = StateDataUtils.GetLayer(ShopEnchantAsGiftState)
    if layer > 0 then
      moneyText = LT.Text("ShopEnchantGiftText")
      isGift = true
    end
  end
  self:SetText(self.ui.Text_Money, moneyText)
  self:SetTextColorByHtml(self.ui.Text_Money, self:_CheckCurencyEnough(price) and "#FFFFFF" or notEnoughColor)
  local isDiscount = basePrice > price
  self:SetActive(self.ui.Text_Offset, isDiscount and not isGift)
  if isDiscount then
    self:SetText(self.ui.Text_Offset, basePrice)
  end
end

function CopySpecialShopBaseItem:_RefreshRefeshInfo()
  if self.specialShopCfgInfo.refreshType == CommonDefine.WorldStageSpecialShopRefreshType.RefreshAll then
    self:SetActive(self.ui.Btn_Flushed, false)
    return
  end
  local refreshNum = self.shopData.refreshCount or 0
  local maxRefreshNum = self.shopData.maxRefreshCount or 0
  if refreshNum >= maxRefreshNum then
    self:SetActive(self.ui.Btn_Flushed, false)
    return
  end
  self:SetActive(self.ui.Btn_Flushed, true)
  local refreshCost = self.shopData.refreshPrice or 0
  local isEnough = refreshCost <= WorldstageDMoneyDataUtils.GetGold()
  self:SetText(self.ui.Text_IconNum, refreshCost)
  self:SetTextColorByHtml(self.ui.Text_IconNum, isEnough and "#000000" or notEnoughColor)
  self:SetText(self.ui.Text_Flushed, LT.Text("Refresh"))
end

function CopySpecialShopBaseItem:_RefreshSoldOutInfo()
  local isSoldOut = ShopDataUtils.CheckGoodsSoldOut(self.goodsData.uid)
  self:SetActive(self.ui.Group_SellOut, isSoldOut)
  self:SetText(self.ui.Text_Sellout, LT.Text("Shop_Sell_Out_Tips"))
end

function CopySpecialShopBaseItem:_CheckCurencyEnough(price)
  local ownMoney = WorldstageDMoneyDataUtils.GetGold()
  price = math.abs(price)
  return ownMoney >= price
end

function CopySpecialShopBaseItem:_ReqGoodsRefresh()
  WorldstageReqUtils.ReqOnShopRefresh({
    index = self.slot
  }, System.fn(self, self._RefreshGoodsInfo))
end

function CopySpecialShopBaseItem:_CheckPriceValid(price)
  return price and price > 0
end

return CopySpecialShopBaseItem
