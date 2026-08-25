local MainShopItem, Super = System.NewComponent("MainShopItem")

function MainShopItem:ctor(uiNode, viewData)
  Super.ctor(self)
  self.ui = UI_Shop_Item_CommodityResource(uiNode)
  self.viewData = viewData
end

function MainShopItem:OnBind(binder)
  self.binder = binder
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, function()
    local data = self.viewData.shopItemData
    return 0 == data.price and data.isSell == false and false == data.lock
  end))
  binder:BindButtonClick(self.ui.Btn_Pay, System.fn(self, self.OnBtnBuyClick))
  self.ui.Group_Title:SetActive(true)
  self:PriceBind()
  self:OriPriceBind()
  self:RefreshTimeBind()
  self:TagResBind()
  self:ConditionUnLockBind()
  self:_OnBindShopItemIcon()
  self:_OnBindHeadShow()
  self:PayButtonBind()
  self:AwakerPotencyMaxBind()
  self:TimeColorBind()
end

function MainShopItem:_GetMainItemTid()
  local shopItemData = self.viewData and self.viewData.shopItemData
  local itemList = shopItemData and shopItemData.itemList
  return itemList and itemList[1] or nil
end

function MainShopItem:_IsPlayerAvatarItem()
  local tid = self:_GetMainItemTid()
  if not tid then
    return false
  end
  local itemCfg = DT.Item[tid]
  return nil ~= itemCfg and itemCfg.SubType == CommonDefine.ItemSubType.PlayerAvatar
end

function MainShopItem:_OnBindHeadShow()
  local isPlayerAvatar = self:_IsPlayerAvatarItem()
  self.ui.Group_Head:SetActive(isPlayerAvatar)
  self.ui.Image_Item:SetActive(not isPlayerAvatar)
  if not isPlayerAvatar then
    return
  end
  self.ui.Group_Awaker:SetActive(false)
  self.binder:BindToImage(self.ui.Image_Head, function()
    local tid = self:_GetMainItemTid()
    local itemCfg = tid and DT.Item[tid]
    return itemCfg and itemCfg.Icon or ""
  end)
end

function MainShopItem:_IsPlayerAvatarOwned()
  do return MainShopDataUtils.IsPlayerAvatarOwned end
  return MainShopDataUtils.IsPlayerAvatarOwned, self.viewData and self.viewData.shopItemData
end

function MainShopItem:IsLock()
  do return MainShopDataUtils.GetShopItemLockedReason end
  return MainShopDataUtils.GetShopItemLockedReason, self.viewData.shopItemData.tid
end

function MainShopItem:TimeColorBind()
  self.binder:BindToTextColor(self.ui.Text_Time, function()
    if self:IsLock() then
      return CommonDefine.ColorType.Dark
    else
      return CommonDefine.ColorType.Light
    end
  end)
  self.binder:BindToImageColor(self.ui.Image_Time, function()
    local textComp = self.binder:GetTextComp(self.ui.Text_Time)
    return textComp.color
  end)
end

function MainShopItem:ConditionUnLockBind()
  self.binder:BindToRaw(function(_, isLock)
    self.ui.Group_Technology:SetActive(isLock)
    if isLock then
      local str = MainShopDataUtils.GetLockShopStr(self.viewData.shopItemData.tid)
      self.binder:SetText(self.ui.Text_Technology_Desc, str)
    end
  end, function()
    do return self.IsLock end
    return self.IsLock, self
  end)
end

function MainShopItem:RefreshTimeBind()
  local itemData = self.viewData.shopItemData
  local isLimitByMaxPotency = ShopCfgUtils.IsLimitByMaxPotency(self.viewData)
  local result = not isLimitByMaxPotency and itemData.refreshTime and itemData.refreshTime > 0
  self.binder:BindToVisible(self.ui.Group_Time, function()
    return result
  end)
  if result then
    self:OnFixedUpdate()
    self.cntDownTimer = self.binder:BindTimer(1, -1, System.fn(self, self.OnFixedUpdate))
  end
end

function MainShopItem:TagResBind()
  local goodsConfig = DT.Shop[self.viewData.shopItemData.tid]
  local showTag = goodsConfig.TagRes and true or false
  self.ui.Group_Overbalance:SetActive(showTag)
  if showTag then
    self.binder:BindToImage(self.ui.Image_OverBalance, function()
      return goodsConfig.TagRes
    end)
    self.binder:SetText(self.ui.Text_OverBalance, goodsConfig.TagText)
  end
end

function MainShopItem:OnFixedUpdate()
  local itemData = self.viewData.shopItemData
  if itemData.refreshTime and itemData.refreshTime > TimeUtils.GetServerTime() then
    self.binder:SetActive(self.ui.Text_Time, true)
    self.binder:SetText(self.ui.Text_Time, MainShopDataUtils.GetNextFreshTime(itemData.refreshTime))
  else
    self.binder:SetText(self.ui.Text_Time, "")
    self.binder:SetActive(self.ui.Text_Time, false)
    self.binder:StopTimer(self.cntDownTimer)
    self.cntDownTimer = nil
  end
end

function MainShopItem:_OnBindShopItemIcon()
  local binder = self.binder
  binder:BindToVisible(self.ui.Text_Residue, function()
    local rst = not self:IsLock()
    if false == rst then
      return rst
    end
    local data = self.viewData.shopItemData
    rst = not MainShopDataUtils.IsShopSellOut(data)
    return rst
  end)
  binder:BindToImage(self.ui.Image_Bg1, function()
    local quality = DT.Item[self.viewData.shopItemData.itemList[1]].Quality
    return DT.ItemQuality[quality].MainShopGoodsBgColor or ""
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    local tid = self.viewData.shopItemData.tid
    local shopItemCfg = DT.Shop[tid]
    local moneyTid = shopItemCfg.Price[1]
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, moneyTid
  end, false)
  binder:BindToVisible(self.ui.Image_PlayerAvatar, function()
    local tid = self.viewData.shopItemData.itemList[1]
    local subType = ItemDataUtils.GetItemSubType(tid)
    return "PlayerAvatar" == subType
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local quality = DT.Item[self.viewData.shopItemData.itemList[1]].Quality
    return DT.ItemQuality[quality].ShopItemQualityRes or ""
  end)
  binder:BindToImage(self.ui.Image_Item, function()
    local itemCfg = DT.Item[self.viewData.shopItemData.itemList[1]]
    return itemCfg.Icon
  end)
end

function MainShopItem:PriceBind()
  local binder = self.binder
  local itemData = self.viewData.shopItemData
  binder:BindToRaw(function(_, nVT)
    binder:SetText(self.ui.Text_Price, itemData.price)
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Text_Price)
  end, function()
    return {
      ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(itemData.tid)),
      itemData.price
    }
  end)
  binder:BindToTextColorOld(self.ui.Text_Price, function()
    local totalCurrency = ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(itemData.tid)) or 0
    if totalCurrency < itemData.price then
      return DT.ColorConfig.Red.Light
    else
      return DT.ColorConfig.UXDefault.Light
    end
  end)
  binder:BindToRaw(function(_, isDone)
    if isDone then
      binder:SetActive(self.ui.Group_Done, true)
    else
      binder:SetActive(self.ui.Group_Done, false)
      binder:SetButtonInteractable(self.ui.Btn_Pay, true)
    end
  end, function()
    if MainShopDataUtils.IsMaxPotencyByShopId(self.viewData.shopItemData.tid) then
      return false
    end
    if MainShopDataUtils.IsShopSellOut(self.viewData.shopItemData) then
      return true
    end
    do return self._IsPlayerAvatarOwned end
    return self._IsPlayerAvatarOwned, self
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, itemData.itemList[1]
  end)
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_Name, 32, 260)
  local buyLimitNum = MainShopDataUtils.GetLimitNum(self.viewData.shopItemData)
  if buyLimitNum then
    binder:BindToText(self.ui.Text_Residue, function()
      local left = MainShopDataUtils.GetGoodRemaining(self.viewData.shopItemData)
      do return LT.Textf, "Shop_Buy_Str_BuyLimit", (math.max(left, 0)) end
      return LT.Textf, "Shop_Buy_Str_BuyLimit", math.max(left, 0), 0, 0
    end)
  else
    self.ui.Group_Title:SetActive(false)
  end
  binder:BindToText(self.ui.Text_Quantity, function()
    do return LT.Textf, ItemNumUtils.GetStr(self.viewData.shopItemData.num) end
    return LT.Textf, ItemNumUtils.GetStr(self.viewData.shopItemData.num)
  end)
  self.binder:BindToRaw(function(_, show, _)
    self.ui.Text_Quantity:SetActive(show)
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Text)
  end, function()
    return 1 ~= self.viewData.shopItemData.num
  end)
  binder:BindToText(self.ui.Text_Tips_Empty, function()
    if MainShopDataUtils.IsShopSellOut(self.viewData.shopItemData) then
      do return LT.Text end
      return LT.Text, "Event_Shop_String_5"
    end
    if self:_IsPlayerAvatarOwned() then
      do return LT.Text end
      return LT.Text, "Owned"
    end
    do return LT.Text end
    return LT.Text, "Event_Shop_String_5"
  end)
end

function MainShopItem:OriPriceBind()
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

function MainShopItem:PayButtonBind()
end

function MainShopItem:AwakerPotencyMaxBind()
  local itemTid = self.viewData.shopItemData.itemList[1]
  local isAwakerChip = ItemDataUtils.IsAwakerChip(itemTid)
  local textKey = isAwakerChip and "MaxPotencyAwakerShopTips" or "MaxLevelWeaponShopTips"
  self.binder:SetText(self.ui.Text_C_Max, LT.Text(textKey))
  self.binder:BindToVisible(self.ui.Group_Max, function()
    return MainShopDataUtils.IsMaxPotencyByShopId(self.viewData.shopItemData.tid) and not self:IsLock()
  end)
end

function MainShopItem:OnBtnBuyClick()
  if self.viewData.buyFunc then
    self.viewData.buyFunc(self.viewData.shopItemData)
  end
end

return MainShopItem
