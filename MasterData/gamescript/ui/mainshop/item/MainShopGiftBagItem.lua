local MainShopGiftBagItem, Super = System.NewComponent("MainShopGiftBagItem")

function MainShopGiftBagItem:ctor(uiNode, viewData)
  Super.ctor(self)
  self.ui = UI_Recharge_Courtesy_ItemResource(uiNode)
  self.viewData = viewData
end

function MainShopGiftBagItem:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Image_Quality, System.fn(self, self.OnBtnBuyClick))
  self:PriceBind()
  self:OnBindShopCurrencyIcon()
  self:OriPriceBind()
  self:RefreshTimeBind()
  self:ConditionUnLockBind()
  self:_OnBindShopItemIcon()
  self:OnBindAdditionalReward()
  self:OnBindRedComp()
  self:OnBindPerGoodsNum()
  self:BindSpecialTimeSale()
end

function MainShopGiftBagItem:OnBindPerGoodsNum()
  self.binder:SetActive(self.ui.Text_PerGoods_num, false)
end

function MainShopGiftBagItem:PriceBind()
  local binder = self.binder
  local itemData = self.viewData.shopItemData
  self:OnBindTextPrice()
  binder:BindToRaw(function(cbinder, data)
    cbinder:BindToVisible(self.ui.Image_Mask_Sellout, function()
      local isSoldOut = MainShopDataUtils.IsShopSellOut(data.shopItemData)
      return isSoldOut
    end)
    cbinder:BindToVisible(self.ui.Image_Mask_Haved, function()
      local isSoldOut = MainShopDataUtils.IsShopSellOut(data.shopItemData)
      local isHaved = MainShopDataUtils.IsOwnSkinInSale(data.shopItemData.tid)
      return not isSoldOut and isHaved
    end)
  end, function()
    return self.viewData
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, itemData.itemList[1]
  end)
  local shopCfgId = self.viewData.shopItemData.tid
  local shopItemCfg = DT.Shop[shopCfgId]
  local buyLimitNum = MainShopDataUtils.GetLimitNum(self.viewData.shopItemData)
  if buyLimitNum and not self:IsLock() then
    self.ui.Text_Remainder:SetActive(true)
    binder:BindToText(self.ui.Text_Remainder, function()
      local left = math.min(self.viewData.shopItemData.maxBuyCount, buyLimitNum) - self.viewData.shopItemData.buyCount
      if 0 ~= shopItemCfg.PricingModel then
        left = 1
      end
      do return LT.Textf, "Shop_Buy_Str_BuyLimit", (math.max(left, 0)) end
      return LT.Textf, "Shop_Buy_Str_BuyLimit", math.max(left, 0), 0, 0
    end)
  else
    self.ui.Text_Remainder:SetActive(false)
  end
  binder:BindToText(self.ui.Text_Tag, function()
    return shopItemCfg.TagText or ""
  end)
  self.binder:BindToVisible(self.ui.Group_Tag, function()
    return shopItemCfg.TagText
  end)
end

function MainShopGiftBagItem:BindSpecialTimeSale()
  self.binder:BindToRaw(function(cBinder, isInSpecialTimeSale)
    cBinder:SetActive(self.ui.Tag_Activity, isInSpecialTimeSale)
    if isInSpecialTimeSale then
      cBinder:SetText(self.ui.Text_Tag_Activity, LT.Text("ShopLimitTimeActivity"))
    end
  end, function()
    local sellout = MainShopDataUtils.IsShopSellOut(self.viewData.shopItemData)
    local isInSpecialTimeSale = self:IsInSpecialTimeSale()
    if isInSpecialTimeSale and not sellout then
      return true
    end
  end)
end

function MainShopGiftBagItem:OnBindTextPrice()
  local binder = self.binder
  local itemData = self.viewData.shopItemData
  binder:BindToRaw(function(cbinder, nVT)
    if self:IsInSpecialTimeSale() then
      self:_SetSpecialPrice(cbinder)
      local timer
      timer = cbinder:BindTimer(1, -1, function()
        if not self:IsInSpecialTimeSale() then
          self:_SetNormalPrice(cbinder)
          cbinder:StopTimer(timer)
        end
      end)
    else
      self:_SetNormalPrice(cbinder)
    end
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Text_Price)
  end, function()
    return {
      ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(itemData.tid)),
      itemData.price
    }
  end)
  local groupCoinTrams = self.ui.Group_Coin.transform
  CS.Framework.TransformUtil.SetLocalPos(groupCoinTrams, 0, groupCoinTrams.localPosition.y, groupCoinTrams.localPosition.z)
end

function MainShopGiftBagItem:_SetNormalPrice(cbinder)
  local _, price = self:GetNormalCostAndNum()
  cbinder:SetText(self.ui.Text_Price, price)
  cbinder:BindToTextColor(self.ui.Text_Price, function()
    local colorType = self:IsCanOfford() and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
    return colorType
  end)
end

function MainShopGiftBagItem:_SetSpecialPrice(cbinder)
  local _, costNum = self:GetSpecialSaleCostAndNum()
  cbinder:SetText(self.ui.Text_Price, costNum)
  cbinder:BindToTextColor(self.ui.Text_Price, function()
    local colorType = self:IsCanOfford() and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
    return colorType
  end)
end

function MainShopGiftBagItem:OriPriceBind()
  local goodsConfig = DT.Shop[self.viewData.shopItemData.tid]
  local showOri = goodsConfig.OriginalPrice and true or false
  self.binder:BindToVisible(self.ui.Text_OriginalPrice, function()
    return showOri
  end)
  self.binder:BindToRaw(function(_, n)
    self.binder:SetText(self.ui.Text_OriginalPrice, n)
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Text_OriginalPrice)
  end, function()
    return goodsConfig.OriginalPrice
  end)
end

function MainShopGiftBagItem:RefreshTimeBind()
  local function checkResult()
    local itemData = self.viewData.shopItemData
    
    local HasDeadline = MainShopDataUtils.CheckSHopItemHasDeadline(self.viewData.shopItemData)
    local goodsConfig = DT.Shop[self.viewData.shopItemData.tid]
    local hasRefreshTime = itemData.refreshTime and itemData.refreshTime > 0
    local sellout = MainShopDataUtils.IsShopSellOut(itemData)
    local now = TimeUtils.GetServerTime()
    local isSpecialSale = goodsConfig.SpecialSalesEndTime and now < goodsConfig.SpecialSalesEndTime
    if sellout then
      return
    end
    return HasDeadline or hasRefreshTime or isSpecialSale
  end
  
  self.binder:BindToVisible(self.ui.Image_Countdown_1, checkResult)
  self.binder:BindToVisible(self.ui.Image_Countdown_2, checkResult)
  self.binder:BindToVisible(self.ui.Image_Countdown_3, checkResult)
  if checkResult() then
    self:OnFixedUpdate()
    self.cntDownTimer = self.binder:BindTimer(1, -1, System.fn(self, self.OnFixedUpdate))
  end
end

function MainShopGiftBagItem:GetRefreshTimeText()
  local itemData = self.viewData.shopItemData
  local curTime = TimeUtils.GetServerTime()
  if itemData.refreshTime and curTime < itemData.refreshTime then
    do return MainShopDataUtils.GetNextFreshTime end
    return MainShopDataUtils.GetNextFreshTime, itemData.refreshTime
  end
end

function MainShopGiftBagItem:GetOffSaleTimeText()
  local itemData = self.viewData.shopItemData
  local goodsConfig = DT.Shop[self.viewData.shopItemData.tid]
  local curTime = TimeUtils.GetServerTime()
  local offSaleTime = goodsConfig.OffSaleDate
  offSaleTime = itemData.expireTs and itemData.expireTs or offSaleTime
  if offSaleTime and curTime < offSaleTime then
    do return MainShopDataUtils.GetDeadline end
    return MainShopDataUtils.GetDeadline, offSaleTime
  end
end

function MainShopGiftBagItem:GetSpecialSaleTimeText()
  local shopItemCfg = self:GetShopItemConfig()
  local specialSaleEndTime = shopItemCfg.SpecialSalesEndTime
  local now = TimeUtils.GetServerTime()
  if specialSaleEndTime and specialSaleEndTime > now then
    do return MainShopDataUtils.GetSpecialSaleTimeText end
    return MainShopDataUtils.GetSpecialSaleTimeText, specialSaleEndTime
  end
end

function MainShopGiftBagItem:ConditionUnLockBind()
  self.binder:BindToRaw(function(_, isLock)
    self.ui.Image_Mask_Lock:SetActive(isLock)
    if isLock then
      local str = MainShopDataUtils.GetLockShopStr(self.viewData.shopItemData.tid)
      self.binder:SetText(self.ui.Text_Lock_Desc, str)
    end
  end, function()
    do return self.IsLock end
    return self.IsLock, self
  end)
end

function MainShopGiftBagItem:IsLock()
  do return MainShopDataUtils.GetShopItemLockedReason end
  return MainShopDataUtils.GetShopItemLockedReason, self.viewData.shopItemData.tid
end

function MainShopGiftBagItem:_OnBindShopItemIcon()
  self.ui.Image_Icon:SetActive(true)
  self.ui.Image_AwakerSkin:SetActive(false)
  self.binder:BindToImage(self.ui.Image_Icon, function()
    local itemCfg = ItemCfgUtils.GetCfg(self.viewData.shopItemData.itemList[1]) or {}
    return itemCfg.SpIcon or itemCfg.Icon
  end)
  self.binder:BindToImage(self.ui.Image_Quality, function()
    local quality = DT.Item[self.viewData.shopItemData.itemList[1]].Quality
    return DT.ItemQuality[quality].GiftBagQualityRes or ""
  end)
end

function MainShopGiftBagItem:OnBindShopCurrencyIcon()
  self.binder:BindToRaw(function(cbinder, tid)
    if not self:IsInSpecialTimeSale() then
      cbinder:SetImage(self.ui.Image_Currency_Icon, self:GetNormalCostIcon())
      cbinder:SetActive(self.ui.Group_CoinNormal, false)
    else
      cbinder:SetActive(self.ui.Group_CoinNormal, false)
      cbinder:SetImage(self.ui.Image_Currency_Icon, self:GetSpecialCostIcon())
      cbinder:BindTimer(1, -1, function()
        if not self:IsInSpecialTimeSale() then
          cbinder:SetImage(self.ui.Image_Currency_Icon, self:GetNormalCostIcon())
        end
      end)
    end
  end, function()
    return self.viewData.shopItemData.tid
  end)
  self.binder:SetActive(self.ui.Image_Currency_Icon, true)
end

function MainShopGiftBagItem:IsInSpecialTimeSale()
  local specialSaleEndTime = self:GetSpecialSaleEndTime()
  local now = TimeUtils.GetServerTime()
  return specialSaleEndTime > now
end

function MainShopGiftBagItem:IsCanOfford()
  if not self:IsInSpecialTimeSale() then
    local costTid, costNum = self:GetNormalCostAndNum()
    local totalCurrency = ItemDataUtils.GetItemNum(costTid) or 0
    return costNum <= totalCurrency
  else
    local costTid, costNum = self:GetSpecialSaleCostAndNum()
    local totalCurrency = ItemDataUtils.GetItemNum(costTid) or 0
    return costNum <= totalCurrency
  end
end

function MainShopGiftBagItem:GetSpecialSaleEndTime()
  local shopItemCfg = self:GetShopItemConfig()
  local specialSaleEndTime = shopItemCfg.SpecialSalesEndTime or 0
  return specialSaleEndTime
end

function MainShopGiftBagItem:GetSpecialSaleCostAndNum()
  local shopItemCfg = self:GetShopItemConfig()
  local specialSalePrice = shopItemCfg.SpecialSalesPrice
  local costTid, costNum = table.unpack(specialSalePrice)
  return costTid, costNum
end

function MainShopGiftBagItem:GetNormalCostAndNum()
  local tid = self.viewData.shopItemData.tid
  local shopItemCfg = DT.Shop[tid]
  local moneyTid = shopItemCfg.Price[1]
  local price = self.viewData.shopItemData.price
  return moneyTid, price
end

function MainShopGiftBagItem:GetNormalCostIcon()
  local tid, _ = self:GetNormalCostAndNum()
  do return ItemDataUtils.GetIcon end
  return ItemDataUtils.GetIcon, tid
end

function MainShopGiftBagItem:GetSpecialCostIcon()
  local tid, _ = self:GetSpecialSaleCostAndNum()
  do return ItemDataUtils.GetIcon end
  return ItemDataUtils.GetIcon, tid
end

function MainShopGiftBagItem:GetShopItemConfig()
  return DT.Shop[self.viewData.shopItemData.tid] or {}
end

function MainShopGiftBagItem:GetSingleSellItemTid()
  do return ShopCfgUtils.GetShopSellingItemTid end
  return ShopCfgUtils.GetShopSellingItemTid, self.viewData.shopItemData.tid
end

function MainShopGiftBagItem:IsOnlySellSkin()
  do return ShopCfgUtils.IsClothShopType end
  return ShopCfgUtils.IsClothShopType, self.viewData.shopItemData.tid
end

function MainShopGiftBagItem:IsOwnedSellSkin()
  if not self:IsOnlySellSkin() then
    return false
  end
  local singleSellItemTid = self:GetSingleSellItemTid()
  do return AwakerSkinUtils.IsOwnSkin end
  return AwakerSkinUtils.IsOwnSkin, singleSellItemTid
end

function MainShopGiftBagItem:OnFixedUpdate()
  local specialSaleTimeText = self:GetSpecialSaleTimeText()
  local offSaleTimeText = self:GetOffSaleTimeText()
  local refreshTimeText = self:GetRefreshTimeText()
  local showText = specialSaleTimeText or offSaleTimeText or refreshTimeText
  self.binder:SetText(self.ui.Text_Countdown_1, showText)
  self.binder:SetText(self.ui.Text_Countdown_2, showText)
  self.binder:SetText(self.ui.Text_Countdown_3, showText)
  self.binder:SetActive(self.ui.Image_Time, nil ~= refreshTimeText)
  if not showText then
    self.binder:StopTimer(self.cntDownTimer)
    self.cntDownTimer = nil
    EventMgr.Instance.MainShopUpdateEvent:Dispatch()
  end
end

function MainShopGiftBagItem:OnBtnBuyClick()
  if self.viewData.buyFunc then
    self.viewData.buyFunc(self.viewData.shopItemData)
  end
  local shopTid = self.viewData.shopItemData.tid
  local goodsConfig = DT.Shop[shopTid]
  if goodsConfig.UnlockCondType == CommonDefine.ShopUnlockType.StageFirstClear then
    RedPointDataUtils.ClearStageFirstClearGoodFirstOpen(shopTid)
  elseif goodsConfig.OnSaleDate then
    RedPointDataUtils.ClearLimitGoodFirstOpen(shopTid)
  end
end

function MainShopGiftBagItem:OnBindRedComp()
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Dot, nil, nil, function()
    local shopTid = self.viewData.shopItemData.tid
    local goodsConfig = DT.Shop[shopTid]
    if goodsConfig.UnlockCondType == CommonDefine.ShopUnlockType.StageFirstClear then
      do return RedPointDataUtils.IsStageFirstClearGoodFirstOpen end
      return RedPointDataUtils.IsStageFirstClearGoodFirstOpen, shopTid
    elseif goodsConfig.OnSaleDate then
      do return RedPointDataUtils.IsLimitGoodFirstOpen end
      return RedPointDataUtils.IsLimitGoodFirstOpen, shopTid
    end
    if MainShopDataUtils.IsFreeShopItem(self.viewData.shopItemData) then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end))
end

function MainShopGiftBagItem:OnBindAdditionalReward()
  local itemCfg = DT.Item[self.viewData.shopItemData.itemList[1]]
  if not itemCfg or not itemCfg.SpParam then
    self.ui.Image_Gradient:SetActive(false)
    return
  end
  local haveDiamond = false
  local dropID = itemCfg.SpParam[1]
  local dropList = DT.Drop[dropID] and DT.Drop[dropID].data_list or {}
  for _, dropItem in pairs(dropList) do
    if dropItem.DropItem == DT.GetConstant("DiamondItemTid") then
      haveDiamond = true
      UIAdditionalRewardUtils.BindAdditionalReward(self.binder, self.ui.Text_Additional, self.ui.Image_Additional_Icon, dropItem.DropItem, dropItem.DropNum)
      break
    end
  end
  self.ui.Image_Gradient:SetActive(haveDiamond)
end

return MainShopGiftBagItem
