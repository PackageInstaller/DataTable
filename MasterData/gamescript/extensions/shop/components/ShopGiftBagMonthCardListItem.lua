local ShopGiftBagMonthCardListItem, Super = NewViewComponent("ShopGiftBagMonthCardListItem", ShopGiftBagListItem)

function ShopGiftBagMonthCardListItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view, data)
  self.ui = UI_Recharge_Courtesy_ItemResource(uiNode)
  self.data = data
end

function ShopGiftBagMonthCardListItem:RegisterNotifications()
end

function ShopGiftBagMonthCardListItem:RegisterEvents()
  Super.RegisterEvents(self)
end

function ShopGiftBagMonthCardListItem:OnEnterComponent()
  Super.OnEnterComponent(self)
end

function ShopGiftBagMonthCardListItem:_RefreshPrice()
  self:SetText(self.ui.Text_Price, self.data.price)
  local currencyTid = self:_GetCurrencyTid()
  local ownCurrency = ItemDataUtils.GetItemNum(currencyTid) or 0
  local colorType = CommonDefine.ColorType.Light
  if ownCurrency >= self.data.price then
    colorType = CommonDefine.ColorType.Dark
  end
  self:SetTextColorType(self.ui.Text_Price, colorType)
  self.ui.Text_OriginalPrice:SetActive(false)
end

function ShopGiftBagMonthCardListItem:_RefreshLimitBuy()
  self.ui.Text_Remainder:SetActive(false)
end

function ShopGiftBagMonthCardListItem:_RefreshLockState()
  self.ui.Image_Mask_Lock:SetActive(false)
end

function ShopGiftBagMonthCardListItem:_RefreshSoldOut()
  self.ui.Image_Mask_Sellout:SetActive(false)
  self.ui.Image_Mask_Haved:SetActive(false)
end

function ShopGiftBagMonthCardListItem:_RefreshAdditionalReward()
  local diamondData = DT.GetOriginalConstant("EnergyMonthlyCardReward")
  local tid = diamondData[1]
  local num = diamondData[2]
  if not tid or tid ~= DT.GetConstant("DiamondItemTid") then
    self.ui.Image_Gradient:SetActive(false)
    return
  end
  self.ui.Image_Gradient:SetActive(true)
  self:SetText(self.ui.Text_Additional, num)
  self:SetImage(self.ui.Image_Additional_Icon, ItemDataUtils.GetItemIcon(tid))
end

function ShopGiftBagMonthCardListItem:_RefreshTimeUI()
  local endTs = MainShopDataUtils.GetEnergyMonthCardTs()
  local timeText = LT.Textf("EnergyMonthCardCountDownDesc", MainShopDataUtils.GetMonthCardRemainDays(endTs))
  self:SetText(self.ui.Text_Countdown_1, timeText)
  local state = MainShopDataUtils.GetEnergyMonthCardState()
  self.ui.Image_Countdown_1:SetActive(state == CommonDefine.MonthCardState.InEffect)
end

function ShopGiftBagMonthCardListItem:IsLock()
  do return MainShopDataUtils.GetShopItemLockedReason end
  return MainShopDataUtils.GetShopItemLockedReason, self.data.tid
end

function ShopGiftBagMonthCardListItem:_OnClick()
  MainShopDataUtils.OpenEnergyMonthCardExchangePanel()
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.EnergyCardExpire, RedPointDataUtils.RedAttrType.IsNew)
end

function ShopGiftBagMonthCardListItem:_GetCurrencyTid()
  return self.data.costItemTid
end

function ShopGiftBagMonthCardListItem:_GetGoodsTid()
  return self.data.itemTid
end

function ShopGiftBagMonthCardListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return ShopGiftBagMonthCardListItem
