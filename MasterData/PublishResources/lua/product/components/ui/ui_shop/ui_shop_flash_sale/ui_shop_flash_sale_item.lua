_class("UIShopflashSaleItem", UICustomWidget)
UIShopflashSaleItem = UIShopflashSaleItem

function UIShopflashSaleItem:Constructor()
  self.shopModule = self:GetModule(ShopModule)
end

function UIShopflashSaleItem:OnShow()
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._label = self:GetGameObject("label")
  self._txtLabel = self:GetUIComponent("UILocalizationText", "txtLabel")
  self._goTips = self:GetGameObject("tips")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.goRefresh = self:GetGameObject("refresh")
  self.txRefresh = self:GetUIComponent("RollingText", "txRefresh")
  self._goLimit = self:GetGameObject("limit")
  self._goLimit:SetActive(false)
  self._txtLimit = self:GetUIComponent("RollingText", "txtLimit")
  self.price = self:GetGameObject("price")
  self.priceDiscount = self:GetGameObject("priceDiscount")
  self.txtPrice = self:GetUIComponent("UILocalizationText", "txtPrice")
  self.imgPrice = self:GetUIComponent("Image", "imgPrice")
  self.txtPriceRaw = self:GetUIComponent("UILocalizationText", "txtPriceRaw")
  self.txtPriceDiscount = self:GetUIComponent("UILocalizationText", "txtPriceDiscount")
  self.imgPriceRaw = self:GetUIComponent("Image", "imgPriceRaw")
  self.otherText = self:GetUIComponent("UILocalizationText", "otherText")
  self._goSoldout = self:GetGameObject("soldout")
  self._goSoldout:SetActive(false)
  self._goLock = self:GetGameObject("lock")
  self._goLock:SetActive(false)
  self._redpoint = self:GetGameObject("redpoint")
  self._redpoint:SetActive(false)
  self.imgNew = self:GetGameObject("imgNew")
  self.imgNew:SetActive(false)
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UpdateFlashSaleItemPrice, self.FlushPrice)
end

function UIShopflashSaleItem:OnHide()
end

function UIShopflashSaleItem:Flush(itemData)
  self._itemData = itemData
  self._txtName:SetText(self._itemData:GetName())
  local discount, discountStr = self._itemData:GetDiscount()
  if discountStr then
    self._label:SetActive(true)
    self._txtLabel:SetText(discountStr)
  else
    self._label:SetActive(false)
  end
  local str = self._itemData:GetCountStr()
  if string.isnullorempty(str) then
    self._goLimit:SetActive(false)
  else
    self._txtLimit:RefreshText(str)
    self._goLimit:SetActive(true)
  end
  local strCycleType = self._itemData:GetCycleTypeStr()
  if string.isnullorempty(strCycleType) then
    self._goTips:SetActive(false)
  else
    self._goTips:SetActive(true)
    self._txtTips:SetText(strCycleType)
  end
  local s = self._itemData:GetRefreshTimeStr()
  if string.isnullorempty(s) then
    self.goRefresh:SetActive(false)
  else
    self.goRefresh:SetActive(true)
    self.txRefresh:RefreshText(s)
  end
  self._imgIcon:LoadImage(self._itemData:GetIcon())
  if self._itemData:HasSoldOut() then
    self._goSoldout:SetActive(true)
  else
    self._goSoldout:SetActive(false)
  end
  local isLock = false
  if self._itemData:IsLevelGift() and self._itemData:IsLevelGiftLock() then
    local txt = StringTable.Get("str_pay_level_gift_lock", self._itemData:GetLevelGiftLockLv())
    UIWidgetHelper.SetLocalizationText(self, "txtLock", txt)
    isLock = true
  end
  self._goLock:SetActive(isLock)
  self:FlushPrice()
  self._redpoint:SetActive(false)
  self:_CheckLevelGiftRedpoint()
  self:_FlushNew()
end

function UIShopflashSaleItem:FlushPrice()
  if not self._itemData then
    return
  end
  local isBattlePassGift = self._itemData:IsBattlePassGift()
  local itemtType = self._itemData:GetType()
  self.price:SetActive(false)
  self.priceDiscount:SetActive(false)
  self.imgPriceRaw.gameObject:SetActive(false)
  self.imgPrice.gameObject:SetActive(false)
  self.otherText.gameObject:SetActive(false)
  if isBattlePassGift then
    self.price:SetActive(true)
    self.txtPrice.gameObject:SetActive(false)
    self.otherText:SetText(StringTable.Get("str_pay_goto"))
    self.otherText.gameObject:SetActive(true)
  elseif itemtType == GiftPackType.Currency then
    self.price:SetActive(true)
    self.txtPrice.gameObject:SetActive(true)
    self.txtPrice:SetText(self._itemData:GetPriceWithCurrencySymbol())
  elseif itemtType == GiftPackType.Free then
    self.price:SetActive(true)
    self.txtPrice.gameObject:SetActive(false)
    self.otherText:SetText(StringTable.Get("str_pay_free"))
    self.otherText.gameObject:SetActive(true)
  else
    local discount, discountStr = self._itemData:GetDiscount()
    if discount then
      self.priceDiscount:SetActive(true)
      self.imgPriceRaw.gameObject:SetActive(true)
      self.imgPriceRaw.sprite = self._atlas:GetSprite(self._itemData:GetPriceIcon())
      self.txtPriceRaw:SetText(self._itemData:GetPriceRaw())
      self.txtPriceDiscount:SetText(self._itemData:GetPrice())
    else
      self.price:SetActive(true)
      self.imgPrice.gameObject:SetActive(true)
      self.imgPrice.sprite = self._atlas:GetSprite(self._itemData:GetPriceIcon())
      self.txtPrice.gameObject:SetActive(true)
      self.txtPrice:SetText(self._itemData:GetPrice())
    end
  end
end

function UIShopflashSaleItem:_CheckLevelGiftRedpoint()
  if self._itemData and self._itemData:IsLevelGift() then
    local show = self._itemData:IsLevelGiftRed()
    self._redpoint:SetActive(show)
  end
end

function UIShopflashSaleItem:_FlushNew()
  local isNew = self._itemData:GetNew()
  self.imgNew:SetActive(isNew)
end

function UIShopflashSaleItem:bgOnClick()
  self:OpenUIShopGiftPackDetail()
end

function UIShopflashSaleItem:btnPriceOnClick()
  self:OpenUIShopGiftPackDetail()
end

function UIShopflashSaleItem:OpenUIShopGiftPackDetail()
  local isBattlePassGift = self._itemData:IsBattlePassGift()
  if isBattlePassGift then
    UIActivityBattlePassHelper.OpenBuyGiftController(function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateFlashSaleShop)
    end)
  else
    if self._itemData:GetType() == GiftPackType.Currency then
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchPurchaseUI, true, 0, tostring(self._itemData:GetId()))
    end
    self:ShowDialog("UIShopGiftPackDetail", self._itemData:GetId(), ShopMainTabType.FlashSale)
    if self._itemData:GetNew() then
      self.shopModule:CancelNewMark(MarketType.Shop_GiftMarket, self._itemData:GetId())
      self._itemData:SetNew(false)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    self:_FlushNew()
  end
end
