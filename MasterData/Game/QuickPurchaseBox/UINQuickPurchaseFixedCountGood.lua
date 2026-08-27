local UINQuickPurchaseFixedCountGood = class("UINQuickPurchaseFixedCountGood", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINQuickPurchaseFixedCountGood:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuyFixedCountGood)
  UIUtil.AddButtonListener(self.ui.btn_CantBuy, self, self._OnClickCantBuy)
end

function UINQuickPurchaseFixedCountGood:SetBuyFixedCount(count)
  self.fixedCount = count
end

function UINQuickPurchaseFixedCountGood:InitPurchaseSkinUpgradeFixed(skinId, costId, costNum, buyEvent)
  self.buyEvent = buyEvent
  self.ui.btn_CantBuy.gameObject:SetActive(false)
  self.ui.btn_Buy.gameObject:SetActive(true)
  self.ui.img_SkinUpgrade:SetActive(true)
  if self.itemWithCount == nil then
    self.itemWithCount = UINBaseItemWithCount.New()
    self.itemWithCount:Init(self.ui.uINBaseItemWithCount)
    self.itemWithCount:SetNotNeedAnyJump(true)
  end
  local itemCfg = ConfigData.item[skinId]
  self.itemWithCount:InitItemWithCount(itemCfg, 1)
  self.ui.tex_Name:SetIndex(0)
  local currencyItemCfg = ConfigData.item[costId]
  local smallIcon = currencyItemCfg.small_icon
  self.ui.img_currencyIcon.sprite = CRH:GetSprite(smallIcon)
  self.ui.tex_currPrice.text = tostring(costNum)
  self.ui.tex_oldPrice.gameObject:SetActive(false)
end

function UINQuickPurchaseFixedCountGood:InitWithDataForFixedCountGood(goodData, buyEvent, ableToBuy)
  self.buyEvent = buyEvent
  self.ableToBuyEvent = ableToBuy
  self.ui.img_SkinUpgrade:SetActive(false)
  self:__RefreshGoodUI(goodData)
  self:CheckCouldBuyGood(true, goodData)
end

function UINQuickPurchaseFixedCountGood:__RefreshTotalMoney()
  if self.buyNum == 0 then
    self.ui.btn_Buy.gameObject:SetActive(false)
    self.ui.obj_cantBuy:SetActive(true)
  else
    self.ui.btn_Buy.gameObject:SetActive(true)
    self.ui.obj_cantBuy:SetActive(false)
  end
  self.ui.tex_buyCount.text = tostring(self.buyNum)
  local totalMoney = self.buyNum * self.goodData.newCurrencyNum
  self.ui.tex_totalcurrPrice.text = tostring(totalMoney)
end

function UINQuickPurchaseFixedCountGood:__RefreshGoodUI(goodData)
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.uINBaseItemWithCount)
  self.itemWithCount:SetNotNeedAnyJump(true)
  self.itemWithCount:InitItemWithCount(goodData.itemCfg, goodData.itemNum, nil)
  self.ui.tex_Name.text.text = LanguageUtil.GetLocaleText(goodData.itemCfg.name)
  local currencyItemCfg = ConfigData.item[goodData.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  self.ui.img_currencyIcon.sprite = CRH:GetSprite(smallIcon)
end

function UINQuickPurchaseFixedCountGood:__refreshPriceAndDiscount(goodData)
  self.ui.tex_currPrice.text = goodData.newCurrencyNum
  self:__refreshDiscountUIData(goodData)
end

function UINQuickPurchaseFixedCountGood:__refreshDiscountUIData(goodData)
  if goodData.discount == 100 then
    self.ui.tex_oldPrice.gameObject:SetActive(false)
  else
    self.ui.tex_oldPrice.text = goodData.oldCurrencyNum
    self.ui.tex_oldPrice.gameObject:SetActive(true)
  end
end

function UINQuickPurchaseFixedCountGood:OnClickBuyFixedCountGood()
  if self.buyEvent ~= nil then
    self.buyEvent(self.fixedCount, BindCallback(self, self.CheckCouldBuyGood, false))
  end
end

function UINQuickPurchaseFixedCountGood:_OnClickCantBuy()
  if self.ableToBuyEvent ~= nil then
    self.ableToBuyEvent(self.fixedCount, false)
  end
end

function UINQuickPurchaseFixedCountGood:CheckCouldBuyGood(ignoreMsgTip, goodData)
  local quickBuyWindow = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
  quickBuyWindow.buyNum = 0
  self:__refreshPriceAndDiscount(goodData)
  if self.ableToBuyEvent ~= nil then
    local couldBuy = self.ableToBuyEvent(self.fixedCount, ignoreMsgTip or false)
    self.ui.soldOut:SetActive(not couldBuy)
    self.ui.btn_Buy.gameObject:SetActive(couldBuy)
    return
  end
  self.ui.soldOut:SetActive(true)
  self.ui.btn_Buy.gameObject:SetActive(false)
end

function UINQuickPurchaseFixedCountGood:OnDelete()
  self.itemWithCount:OnDelete()
  base.OnDelete(self)
end

return UINQuickPurchaseFixedCountGood
