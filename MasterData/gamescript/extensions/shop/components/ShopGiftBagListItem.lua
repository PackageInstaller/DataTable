local ShopGiftBagListItem, Super = NewViewComponent("ShopGiftBagListItem")

function ShopGiftBagListItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Recharge_Courtesy_ItemResource(uiNode)
  self.data = data
  self.shopConfig = ShopExtModel.Instance:GetShopConfig(self.data.tid)
end

function ShopGiftBagListItem:RegisterNotifications()
end

function ShopGiftBagListItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Image_Quality, System.fn(self, self._OnClick))
end

function ShopGiftBagListItem:OnEnterComponent()
  self:_Refresh()
end

function ShopGiftBagListItem:_Refresh()
  self:_RefreshNameAndIcon()
  self:_RefreshPrice()
  self:_RefreshLimitBuy()
  self:_RefreshLockState()
  self:_RefreshSoldOut()
  self:_RefreshAdditionalReward()
  self:_RefreshTimeUI()
end

function ShopGiftBagListItem:_RefreshNameAndIcon()
  local goodsTid = self:_GetGoodsTid()
  self:SetText(self.ui.Text_Name, ItemDataUtils.GetItemName(goodsTid))
  local currencyTid = self:_GetCurrencyTid()
  local currencyIcon = ItemDataUtils.GetIcon(currencyTid)
  self:SetImage(self.ui.Image_Currency_Icon, currencyIcon)
  local quality = DT.Item[goodsTid].Quality
  local qualityImage = DT.ItemQuality[quality].GiftBagQualityRes or ""
  self:SetImage(self.ui.Image_Quality, qualityImage)
  local goodsIcon = ItemDataUtils.GetItemIcon(goodsTid)
  self:SetImage(self.ui.Image_Icon, goodsIcon)
end

function ShopGiftBagListItem:_RefreshPrice()
  self:SetText(self.ui.Text_Price, self.data.price)
  local ownCurrency = ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(self.data.tid)) or 0
  local colorType = CommonDefine.ColorType.Light
  if ownCurrency >= self.data.price then
    colorType = CommonDefine.ColorType.Dark
  end
  self:SetTextColorType(self.ui.Text_Price, colorType)
  local oriPriceText = self.shopConfig.OriginalPrice
  local showOriPrice = oriPriceText and oriPriceText > 0
  self.ui.Text_OriginalPrice:SetActive(showOriPrice)
  if not showOriPrice then
    oriPriceText = ""
  end
  self:SetText(self.ui.Text_OriginalPrice, oriPriceText)
  if showOriPrice then
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Text_OriginalPrice)
  end
end

function ShopGiftBagListItem:_RefreshLimitBuy()
  local buyLimitNum = MainShopDataUtils.GetLimitNum(self.data)
  local isLock = self:IsLock()
  self.ui.Text_Remainder:SetActive(isLock or not buyLimitNum)
  if buyLimitNum and not isLock then
    local left = math.min(self.data.maxBuyCount, buyLimitNum) - self.data.buyCount
    if 0 ~= self.shopConfig.PricingModel then
      left = 1
    end
    local buyLimitText = LT.Textf("Shop_Buy_Str_BuyLimit", math.max(left, 0), 0)
    self:SetText(self.ui.Text_Remainder, buyLimitText)
  end
end

function ShopGiftBagListItem:_RefreshLockState()
  local isLock = self:IsLock()
  self.ui.Image_Mask_Lock:SetActive(isLock)
  if isLock then
    local lockStr = MainShopDataUtils.GetLockShopStr(self.data.tid)
    self:SetText(self.ui.Text_Lock_Desc, lockStr)
  end
end

function ShopGiftBagListItem:_RefreshSoldOut()
  local buyCount = self.data.buyCount
  local buyLimit = MainShopDataUtils.GetLimitNum(self.data)
  local isSoldOut = buyLimit and buyCount >= buyLimit
  local isHaved = DT.Item[self.data.itemTid].SubType == CommonDefine.ZoneFeature.AwakerSkin and AwakerSkinUtils.IsOwnSkin(self.data.tid)
  self.ui.Image_Mask_Sellout:SetActive(isSoldOut)
  self.ui.Image_Mask_Haved:SetActive(not isSoldOut and isHaved)
end

function ShopGiftBagListItem:_RefreshAdditionalReward()
  local goodsTid = self.data.itemList[1]
  local itemConfig = ItemDataUtils.GetItemConfig(goodsTid)
  if not itemConfig then
    self.ui.Image_Gradient:SetActive(false)
    return
  end
  local hasDiamond = false
  local dropTid = itemConfig.SpParam and itemConfig.SpParam[1]
  local dropList = DT.Drop[dropTid] and DT.Drop[dropTid].data_list or {}
  for _, dropItem in pairs(dropList) do
    if dropItem.DropItem == DT.GetConstant("DiamondItemTid") then
      hasDiamond = true
      self:SetText(self.ui.Text_Additional, dropItem.DropNum)
      self:SetImage(self.ui.Image_Additional_Icon, ItemDataUtils.GetItemIcon(dropItem.DropItem))
      break
    end
  end
  self.ui.Image_Gradient:SetActive(hasDiamond)
end

function ShopGiftBagListItem:_RefreshTimeUI()
  local hasDeadline = MainShopDataUtils.CheckSHopItemHasDeadline(self.data)
  local hasRefreshTime = self.data.refreshTime and self.data.refreshTime > 0
  local isSoldOut = MainShopDataUtils.IsShopSellOut(self.data)
  local showCountdown = (hasDeadline or hasRefreshTime) and not isSoldOut
  self.ui.Image_Countdown_1:SetActive(showCountdown)
  self.ui.Image_Countdown_2:SetActive(showCountdown)
  self.ui.Image_Countdown_3:SetActive(showCountdown)
  self:_ClearTimer()
  if showCountdown then
    self.timer = self:BindTimer(1, -1, System.fn(self, self._TimerFixedUpdate))
    self:_TimerFixedUpdate()
  end
end

function ShopGiftBagListItem:_TimerFixedUpdate()
  local offSaleTime = self.shopConfig.OffSaleDate
  if self.data.expireTs and self.data.expireTs > 0 then
    offSaleTime = self.data.expireTs
  end
  local timeText = ""
  local now = TimeUtils.GetServerTime()
  if offSaleTime and offSaleTime > now then
    timeText = MainShopDataUtils.GetDeadline(offSaleTime)
  elseif self.data.refreshTime and now < self.data.refreshTime then
    timeText = MainShopDataUtils.GetNextFreshTime(self.data.refreshTime)
  else
    self:_ClearTimer()
  end
  self:SetText(self.ui.Text_Countdown_1, timeText)
  self:SetText(self.ui.Text_Countdown_2, timeText)
  self:SetText(self.ui.Text_Countdown_3, timeText)
end

function ShopGiftBagListItem:_ClearTimer()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
end

function ShopGiftBagListItem:IsLock()
  do return MainShopDataUtils.GetShopItemLockedReason end
  return MainShopDataUtils.GetShopItemLockedReason, self.data.tid
end

function ShopGiftBagListItem:_OnClick()
  UIManager.Instance:Reopen(Urls.MainShopGiftBagBuyConfirmPanel, self.data, self.shopConfig.ShopType, {})
end

function ShopGiftBagListItem:_GetCurrencyTid()
  return self.shopConfig.Price[1]
end

function ShopGiftBagListItem:_GetGoodsTid()
  return self.data.itemList[1]
end

function ShopGiftBagListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return ShopGiftBagListItem
