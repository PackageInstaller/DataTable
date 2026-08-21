_class("UIShopGiftPackItemWeek", UICustomWidget)
UIShopGiftPackItemWeek = UIShopGiftPackItemWeek

function UIShopGiftPackItemWeek:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetGiftPackShopData()
end

function UIShopGiftPackItemWeek:OnShow()
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._label = self:GetGameObject("label")
  self._txtLabel = self:GetUIComponent("UILocalizationText", "txtLabel")
  self.price = self:GetGameObject("price")
  self.priceDiscount = self:GetGameObject("priceDiscount")
  self.txtPrice = self:GetUIComponent("UILocalizationText", "txtPrice")
  self.imgPrice = self:GetUIComponent("Image", "imgPrice")
  self.txtPriceRaw = self:GetUIComponent("UILocalizationText", "txtPriceRaw")
  self.txtPriceDiscount = self:GetUIComponent("UILocalizationText", "txtPriceDiscount")
  self.imgPriceRaw = self:GetUIComponent("Image", "imgPriceRaw")
  self.otherText = self:GetUIComponent("UILocalizationText", "otherText")
  self.txtLeft = self:GetUIComponent("UILocalizationText", "txtLeft")
  self.notBuy = self:GetGameObject("notBuy")
  self._goLimit = self:GetGameObject("limit")
  self._goLimit:SetActive(false)
  self._txtLimit = self:GetUIComponent("RollingText", "txtLimit")
  self._redpoint = self:GetGameObject("redpoint")
  self._redpoint:SetActive(false)
  self.imgNew = self:GetGameObject("imgNew")
  self.imgNew:SetActive(false)
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UpdateGiftPackItemPrice, self.FlushPrice)
end

function UIShopGiftPackItemWeek:OnHide()
  self._imgIcon:DestoryLastImage()
  self:DetachEvent(GameEventType.UpdateGiftPackItemPrice, self.FlushPrice)
end

function UIShopGiftPackItemWeek:Flush(id)
  self._itemData = self._data:GetGoodBuyId(id)
  self._txtName:SetText(self._itemData:GetName())
  local discount, discountStr = self._itemData:GetDiscount()
  if discountStr then
    self._label:SetActive(true)
    self._txtLabel:SetText(discountStr)
  else
    self._label:SetActive(false)
  end
  self._imgIcon:LoadImage(self._itemData:GetIcon())
  self:FlushTxtLeft()
  self:FlushHint()
  self:FlushPrice()
  self:FlushNew()
end

function UIShopGiftPackItemWeek:FlushTxtLeft()
  local function LeftDays(t, obtained)
    local d, h, m, s = UICommonHelper.S2DHMS(t)
    
    if 1 <= d then
      if obtained then
        return StringTable.Get("str_pay_left_times", math.ceil(d))
      else
        return StringTable.Get("str_pay_left_day", math.floor(d))
      end
    else
      if obtained then
        local times = 1
        if math.abs(d) <= 1.0E-5 then
          times = 0
        end
        return StringTable.Get("str_pay_left_times", times)
      end
      if 1 <= h then
        return StringTable.Get("str_pay_left_hour", math.floor(h))
      elseif 1 <= m then
        return StringTable.Get("str_pay_left_minute", math.floor(m))
      else
        return StringTable.Get("str_pay_left_minute", "<1")
      end
    end
  end
  
  local str = ""
  if self._itemData:GetBuyCount() > 0 then
    self.notBuy:SetActive(false)
    local stampRefresh = self._itemData:GetRefreshTime()
    str = LeftDays(stampRefresh, true)
  else
    self.notBuy:SetActive(true)
    local stampEnd = self._itemData:GetEndTime()
    local stampNow = UICommonHelper.GetNowTimestamp()
    str = LeftDays(stampEnd - stampNow, false)
  end
  self.txtLeft:SetText(str)
end

function UIShopGiftPackItemWeek:FlushHint()
  local str = ""
  if self._itemData:HasSoldOut() then
    str = StringTable.Get("str_pay_soldout")
  else
    str = self._itemData:GetCountStr()
  end
  if string.isnullorempty(str) then
    self._goLimit:SetActive(false)
  else
    self._txtLimit:RefreshText(str)
    self._goLimit:SetActive(true)
  end
end

function UIShopGiftPackItemWeek:FlushPrice()
  if not self._itemData then
    Log.warn("### _itemData is nil.")
    return
  end
  self.price:SetActive(false)
  self.priceDiscount:SetActive(false)
  self.imgPriceRaw.gameObject:SetActive(false)
  self.imgPrice.gameObject:SetActive(false)
  self.otherText.gameObject:SetActive(false)
  if self._itemData:HasSoldOut() then
    self.price:SetActive(true)
    self.txtPrice:SetText(StringTable.Get("str_pay_soldout"))
    return
  end
  local itemtType = self._itemData:GetType()
  if itemtType == GiftPackType.Currency then
    self.price:SetActive(true)
    self.txtPrice.gameObject:SetActive(true)
    self.txtPrice:SetText(self._itemData:GetPriceWithCurrencySymbol())
  elseif itemtType == GiftPackType.Free then
    self.otherText:SetText(StringTable.Get("str_pay_free"))
    self.otherText.gameObject:SetActive(true)
    self.price:SetActive(true)
    self.txtPrice.gameObject:SetActive(false)
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
      self.txtPrice:SetText(self._itemData:GetPrice())
    end
  end
end

function UIShopGiftPackItemWeek:FlushNew()
  local isNew = self._itemData:GetNew()
  self.imgNew:SetActive(isNew)
end

function UIShopGiftPackItemWeek:bgOnClick()
  self:OpenUIShopGiftPackDetail()
end

function UIShopGiftPackItemWeek:btnPriceOnClick()
  self:OpenUIShopGiftPackDetail()
end

function UIShopGiftPackItemWeek:OpenUIShopGiftPackDetail()
  local isBattlePassGift = self._itemData:IsBattlePassGift()
  if isBattlePassGift then
    UIActivityBattlePassHelper.OpenBuyGiftController(function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateGiftPackShop)
    end)
  else
    self:_RecordClick()
    if self._itemData:GetType() == GiftPackType.Currency then
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchPurchaseUI, true, 0, tostring(self._itemData:GetId()))
    end
    self:ShowDialog("UIShopGiftPackDetail", self._itemData:GetId(), ShopMainTabType.Gift)
    if self._itemData:GetNew() then
      self.shopModule:CancelNewMark(MarketType.Shop_GiftMarket, self._itemData:GetId())
      self._itemData:SetNew(false)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    self:FlushNew()
  end
end

function UIShopGiftPackItemWeek:_RecordClick()
  if self._itemData:IsMonthCard() then
    local key = self.shopModule:GetMonthCardClickKey()
    LocalDB.SetInt(key, self._day)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckMonthCardRedpoint)
  end
end
