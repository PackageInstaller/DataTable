local ShopGoodsListItemBase, Super = NewViewComponent("ShopGoodsListItemBase")
local MainShopTypeTag = CommonDefine.MainShopTypeTag

function ShopGoodsListItemBase:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Shop_Item_CommodityResource(uiNode)
  self.data = data
  self.shopConfig = ShopExtModel.Instance:GetShopConfig(self.data.tid)
end

function ShopGoodsListItemBase:RegisterNotifications()
end

function ShopGoodsListItemBase:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Pay, System.fn(self, self._OnClick))
end

function ShopGoodsListItemBase:OnEnterComponent()
  self:_Refresh()
end

function ShopGoodsListItemBase:_RefreshBaseInfo()
  local goodsTid = self.data.itemList[1]
  local goodsName = ItemDataUtils.GetItemName(goodsTid)
  self:SetText(self.ui.Text_Name, goodsName)
  local goodsConfig = ItemDataUtils.GetItemConfig(goodsTid)
  local isAwaker = goodsConfig.SubType == cd.ItemSubType.Awaker
  if isAwaker then
    self:SetActive(self.ui.Image_Item, false)
    self:SetActive(self.ui.Group_Awaker, true)
    local awakerTid = goodsConfig.SpParam and goodsConfig.SpParam[1]
    if not self.awakerPortraitComp then
      local portraitAlign = CommonDefine.PortraitAlign.Center
      self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Root_Awaker, awakerTid, nil, nil, portraitAlign))
    else
      self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
    end
  else
    self:SetActive(self.ui.Image_Item, true)
    self:SetActive(self.ui.Group_Awaker, false)
    self:SetImage(self.ui.Image_Item, goodsConfig.Icon)
  end
  local qualityConfig = ItemDataUtils.GetItemQualityConfig(goodsConfig and goodsConfig.Quality)
  self:SetImage(self.ui.Image_Bg1, qualityConfig.MainShopGoodsBgColor)
  self:SetImage(self.ui.Image_Quality, qualityConfig.ShopItemQualityRes)
  local currencyTid = self.shopConfig.Price[1]
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(currencyTid))
  local showPlayerAvatar = ItemDataUtils.GetItemSubType(goodsTid) == CommonDefine.ItemSubType.PlayerAvatar
  self.ui.Image_PlayerAvatar:SetActive(showPlayerAvatar)
  self:SetText(self.ui.Text_Quantity, LT.Textf(ItemNumUtils.GetStr(self.data.num)))
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Text)
end

function ShopGoodsListItemBase:_RefreshPriceShow()
  self:SetText(self.ui.Text_Price, self.data.price)
  local ownCurrency = ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(self.data.tid)) or 0
  local priceColor = DT.ColorConfig.UXDefault.Light
  if ownCurrency < self.data.price then
    priceColor = DT.ColorConfig.Red.Light
  end
  self:SetTextColorByHtml(self.ui.Text_Price, priceColor)
  local showOri = self.shopConfig.OriginalPrice ~= nil
  self.ui.Text_OriginalPrice:SetActive(showOri)
  if showOri then
    self:SetText(self.ui.Text_OriginalPrice, self.shopConfig.OriginalPrice)
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Btn_Pay)
end

function ShopGoodsListItemBase:_RefreshSoldOutUI()
  local isSoldOut = MainShopDataUtils.IsShopSellOut(self.data)
  self.ui.Group_Done:SetActive(isSoldOut)
  self:SetButtonInteractable(self.ui.Btn_Pay, not isSoldOut)
  self:SetText(self.ui.Text_Tips_Empty, LT.Text("Event_Shop_String_5"))
end

function ShopGoodsListItemBase:_RefreshLimitBuyUI()
  local buyLimitNum = MainShopDataUtils.GetLimitNum(self.data)
  self.ui.Group_Title:SetActive(buyLimitNum)
  if buyLimitNum then
    local left = math.min(self.data.maxBuyCount, buyLimitNum) - self.data.buyCount
    if 0 ~= self.shopConfig.PricingModel then
      left = 1
    end
    local limitNumText = LT.Textf("Shop_Buy_Str_BuyLimit", math.max(left, 0), 0)
    self:SetText(self.ui.Text_Residue, limitNumText)
  end
end

function ShopGoodsListItemBase:_RefreshPotencyMaxUI()
  self:SetText(self.ui.Text_C_Max, LT.Text("MaxLevelWeaponShopTips"))
  if MainShopDataUtils.IsShopSellOut(self.data) then
    self:SetActive(self.ui.Group_Max, false)
    return
  end
  self:SetActive(self.ui.Group_Max, MainShopDataUtils.IsMaxPotencyByShopId(self.data.tid) and not self.data.lock)
end

function ShopGoodsListItemBase:_RefreshTagResUI()
  local goodsConfig = ItemDataUtils.GetItemConfig(self.data.itemList[1])
  local showTag = goodsConfig.TagRes ~= nil
  self.ui.Group_Overbalance:SetActive(showTag)
  if showTag then
    self:SetImage(self.ui.Image_OverBalance, goodsConfig.TagRes)
    self:SetText(self.ui.Text_OverBalance, goodsConfig.TagText)
  end
end

function ShopGoodsListItemBase:_RefreshRedPoint()
  local showRed = 0 == self.data.price and self.data.isSell == false and false == self.data.lock
  if not self.redCom then
    self.redCom = self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot)
  end
  self.redCom:SetRedDotShow(CommonDefine.RedDotType.Dot, showRed)
end

function ShopGoodsListItemBase:_RefreshTimeUI()
  local showTime = self.data.refreshTime and self.data.refreshTime > 0
  self.ui.Text_Time:SetActive(showTime)
  self.ui.Group_Time:SetActive(showTime)
  self:_ClearTimer()
  if showTime then
    self.timer = self:BindTimer(1, -1, System.fn(self, self._TimerFixedUpdate))
    self:_TimerFixedUpdate()
  end
end

function ShopGoodsListItemBase:_TimerFixedUpdate()
  local showTime = self.data.refreshTime and self.data.refreshTime > 0
  if showTime then
    self:SetText(self.ui.Text_Time, MainShopDataUtils.GetNextFreshTime(self.data.refreshTime))
  else
    self:SetText(self.ui.Text_Time, "")
    self.ui.Text_Time:SetActive(false)
    self:_ClearTimer()
  end
end

function ShopGoodsListItemBase:_ClearTimer()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
end

function ShopGoodsListItemBase:_Refresh()
  self.shopConfig = ShopExtModel.Instance:GetShopConfig(self.data.tid)
  self:_RefreshBaseInfo()
  self:_RefreshPriceShow()
  self:_RefreshSoldOutUI()
  self:_RefreshLimitBuyUI()
  self:_RefreshTagResUI()
  self:_RefreshRedPoint()
  self:_RefreshTimeUI()
  self:_RefreshPotencyMaxUI()
end

function ShopGoodsListItemBase:_OnClick()
  local itemTid = self.data.itemTid
  if ItemDataUtils.IsHaveMaxLevelWeapon(itemTid) or MainShopDataUtils.IsMaxPotencyByShopId(self.data.tid) then
    local remainNum = MainShopDataUtils.GetGoodRemaining(self.data)
    if remainNum > 0 then
      Alert.ShowWithParams(20229, {
        ItemDataUtils.GetItemName(itemTid),
        remainNum
      }, nil, function()
        self:_OpenBuyConfirmPanel()
      end)
      return
    end
  end
  self:_OpenBuyConfirmPanel()
end

function ShopGoodsListItemBase:_OpenBuyConfirmPanel()
  local maxNum = self.data.maxBuyCount
  local costItemId = self.shopConfig.Price[1]
  if self.shopConfig.ShopType == MainShopDataUtils.GetShopTypeIDByTag(MainShopTypeTag.GiftBag) then
    UIManager.Instance:Reopen(Urls.MainShopGiftBagBuyConfirmPanel, self.data, self.shopConfig.ShopType, {})
  else
    UIManager.Instance:Reopen(Urls.MainShopSingleBuyConfirmPanel, {
      itemId = costItemId,
      shopItemData = self.data,
      shopType = self.shopConfig.ShopType,
      maxNum = maxNum,
      currencyList = {}
    })
  end
end

function ShopGoodsListItemBase:OnExitComponent()
  Super.OnExitComponent(self)
end

return ShopGoodsListItemBase
