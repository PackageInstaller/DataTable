_class("UIShopGiftPackItem", UICustomWidget)
UIShopGiftPackItem = UIShopGiftPackItem

function UIShopGiftPackItem:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetGiftPackShopData()
end

function UIShopGiftPackItem:OnShow()
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtNameShadow = self:GetUIComponent("UILocalizationText", "txtNameShadow")
  self._label = self:GetGameObject("label")
  self._txtLabel = self:GetUIComponent("UILocalizationText", "txtLabel")
  self._goTips = self:GetGameObject("tips")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._imgIconImage = self:GetUIComponent("RawImage", "imgIcon")
  self.goRefresh = self:GetGameObject("refresh")
  self.goWeekRefresh = self:GetGameObject("weekRefresh")
  self.txRefreshLT = self:GetUIComponent("UILocalizationText", "txRefresh")
  self.txRefreshLT.alignment = UnityEngine.TextAnchor.MiddleCenter
  self.txRefresh = self:GetUIComponent("UILocalizationText", "txRefresh")
  self.txWeekRefreshLT = self:GetUIComponent("UILocalizationText", "txWeekRefresh")
  self.txWeekRefreshLT.alignment = UnityEngine.TextAnchor.MiddleCenter
  self.txWeekRefresh = self:GetUIComponent("UILocalizationText", "txWeekRefresh")
  self._goLimit = self:GetGameObject("limit")
  self._goLimit:SetActive(false)
  self._txtLimitLT = self:GetUIComponent("UILocalizationText", "txtLimit")
  self._txtLimitLT.alignment = UnityEngine.TextAnchor.MiddleCenter
  self._txtLimit = self:GetUIComponent("RollingText", "txtLimit")
  self._bgLimit = self:GetUIComponent("Image", "bgLimit")
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
  self._uiNormal = self:GetUIComponent("RectTransform", "uiNormal")
  self._redpoint = self:GetGameObject("redpoint")
  self._redpoint:SetActive(false)
  self.imgNew = self:GetGameObject("imgNew")
  self.imgNew:SetActive(false)
  self._goPaid = self:GetGameObject("paid")
  self.paidText = self:GetUIComponent("UILocalizationText", "txtPaid")
  self._txtNameShadowL = self:GetUIComponent("UILocalizationText", "txtNameShadowL")
  self._txtNameL = self:GetUIComponent("UILocalizationText", "txtNameL")
  self.animation = self:GetGameObject():GetComponent("Animation")
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UpdateGiftPackItemPrice, self.FlushPrice)
  self:AttachEvent(GameEventType.CheckMonthCardRedpoint, self._CheckMonthCardRedpoint)
end

function UIShopGiftPackItem:OnHide()
  self:DetachEvent(GameEventType.UpdateGiftPackItemPrice, self.FlushPrice)
  self:DetachEvent(GameEventType.CheckMonthCardRedpoint, self._CheckMonthCardRedpoint)
end

function UIShopGiftPackItem:Flush(id)
  self._itemData = self._data:GetGoodBuyId(id)
  if self._uiNormal ~= nil and self._txtNameL ~= nil then
    self._txtNameL:SetText(self._itemData:GetName())
    self._txtNameShadowL:SetText(self._itemData:GetName())
  end
  self._txtName:SetText(self._itemData:GetName())
  if self._txtNameShadow ~= nil then
    self._txtNameShadow:SetText(self._itemData:GetName())
  end
  local discount = self._itemData:GetDiscountEx(true)
  if discount then
    local discountStr = StringTable.Get("str_pay_discount_percent", string.format("<size=39>%s</size>", discount))
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
    self._txtLimitLT.alignment = UnityEngine.TextAnchor.MiddleCenter
  end
  local strCycleType = self._itemData:GetCycleTypeStr()
  if string.isnullorempty(strCycleType) then
    self._goTips:SetActive(false)
  else
    self._goTips:SetActive(true)
    self._txtTips:SetText(strCycleType)
  end
  local txtRefreshTimeStr = strCycleType
  if string.isnullorempty(txtRefreshTimeStr) then
    txtRefreshTimeStr = self._itemData:GetRefreshTimeStr()
  end
  if string.isnullorempty(txtRefreshTimeStr) then
    self.goRefresh:SetActive(false)
  else
    self.goRefresh:SetActive(true)
    self.txRefresh:SetText(txtRefreshTimeStr)
    self.txRefreshLT.alignment = UnityEngine.TextAnchor.MiddleCenter
  end
  if self._itemData:IsWeekCard() then
    local weekShowStr = self._itemData:GetWeekShowStr()
    if weekShowStr then
      self.goWeekRefresh:SetActive(true)
      self.txWeekRefresh:SetText(weekShowStr)
      self.txWeekRefreshLT.alignment = UnityEngine.TextAnchor.MiddleCenter
    else
      self.goWeekRefresh:SetActive(false)
    end
  else
    self.goWeekRefresh:SetActive(false)
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
  self._goPaid:SetActive(false)
  if self._itemData:GetRechargeGift() then
    local data = self._itemData:GetAwardsImmediately()
    if next(data) then
      self._goPaid:SetActive(true)
      self.paidText:SetText(data[1]:GetCount())
    end
  end
  self._goLock:SetActive(isLock)
  if self._uiNormal ~= nil and self._txtNameL ~= nil then
    self._uiNormal.gameObject:SetActive(not isLock)
    if isLock then
      self._imgIconImage.color = Color(0.2, 0.2, 0.2, 0.7058823529411765)
      self.txtPrice.color = Color(0.4, 0.4, 0.4, 1)
      self.imgPrice.color = Color(0.4, 0.4, 0.4, 1)
      self.otherText.color = Color(0.4, 0.4, 0.4, 1)
      self._bgLimit.color = Color(0.2, 0.2, 0.2, 1)
      self._txtLimitLT.color = Color(0.4, 0.4, 0.4, 1)
    elseif self._itemData:HasSoldOut() then
      self._imgIconImage.color = Color(0.2, 0.2, 0.2, 0.7058823529411765)
      self.txtPrice.color = Color(0.4, 0.4, 0.4, 1)
      self.imgPrice.color = Color(0.4, 0.4, 0.4, 1)
      self.otherText.color = Color(0.4, 0.4, 0.4, 1)
      self._bgLimit.color = Color(0.2, 0.2, 0.2, 1)
      self._txtLimitLT.color = Color(0.4, 0.4, 0.4, 1)
      self._txtName.color = Color(0.4, 0.4, 0.4, 1)
    else
      self._imgIconImage.color = Color(1.0, 1.0, 1.0, 1)
      self.txtPrice.color = Color(1.0, 1.0, 1.0, 1)
      self.imgPrice.color = Color(1.0, 1.0, 1.0, 1)
      self.otherText.color = Color(1.0, 1.0, 1.0, 1)
      self._bgLimit.color = Color(1.0, 1.0, 1.0, 1)
      self._txtLimitLT.color = Color(1.0, 1.0, 1.0, 1)
      self._txtName.color = Color(1.0, 1.0, 1.0, 1)
    end
  end
  self:FlushPrice()
  self._redpoint:SetActive(false)
  self:_CheckMonthCardRedpoint()
  self:_CheckLevelGiftRedpoint()
  self:FlushNew()
end

function UIShopGiftPackItem:FlushPrice()
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
    self.txtPrice:SetText(self._itemData:GetPriceWithCurrencySymbolEx(36))
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

function UIShopGiftPackItem:_CheckLevelGiftRedpoint()
  if self._itemData and self._itemData:IsLevelGift() then
    local show = self._itemData:IsLevelGiftRed()
    self._redpoint:SetActive(show and not self._itemData:GetNew())
  end
end

function UIShopGiftPackItem:_CheckMonthCardRedpoint()
end

function UIShopGiftPackItem:FlushNew()
  local isNew = self._itemData:GetNew()
  if self._itemData:GetRechargeGift() then
    local key = "UIShopGiftPackItem" .. self:GetNewFlagKey(self._itemData:GetId())
    isNew = LocalDB.GetInt(key, 0) == 0
    self.imgNew:SetActive(isNew)
  else
    self.imgNew:SetActive(isNew)
  end
end

function UIShopGiftPackItem:BgOnClick()
  self:OpenUIShopGiftPackDetail()
end

function UIShopGiftPackItem:BtnPriceOnClick()
  self:OpenUIShopGiftPackDetail()
end

function UIShopGiftPackItem:OpenUIShopGiftPackDetail()
  if self._goLock.activeSelf then
    return
  end
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
    if self._itemData:GetRechargeGift() then
      self.shopModule:CancelRechargeGiftNewMark(self._itemData:GetId())
      self._itemData:SetNew(false)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    self:_CheckMonthCardRedpoint()
    self:_CheckLevelGiftRedpoint()
    self:FlushNew()
  end
end

function UIShopGiftPackItem:_RecordClick()
end

function UIShopGiftPackItem:GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIShopGiftPackItem:PlayInAnimation()
  if self.animation.gameObject.activeInHierarchy then
    self.animation:Play("uianim_UIShopGiftPackItem_in")
  end
  return 500
end
