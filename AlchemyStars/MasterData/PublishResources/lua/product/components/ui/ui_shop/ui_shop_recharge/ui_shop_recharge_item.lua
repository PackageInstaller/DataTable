_class("UIShopRechargeItem", UICustomWidget)
UIShopRechargeItem = UIShopRechargeItem

function UIShopRechargeItem:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetRechargeShopData()
  self._giftData = self.clientShop:GetGiftPackShopData()
end

function UIShopRechargeItem:OnShow()
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtNameShadow = self:GetUIComponent("UILocalizationText", "txtNameShadow")
  self._label = self:GetGameObject("label")
  self.label = self:GetUIComponent("UILocalizationText", "label")
  self._txtLabel = self:GetUIComponent("UILocalizationText", "txtLabel")
  self._paidObj = self:GetGameObject("paid")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtPaid = self:GetUIComponent("UILocalizationText", "txtPaid")
  self._txtPaidRect = self:GetUIComponent("RectTransform", "txtPaid")
  self._txtFree = self:GetUIComponent("UILocalizationText", "txtFree")
  self._txtFreeTMP = self:GetUIComponent("UILocalizedTMP", "txtFreeTMP")
  self._txtPrice = self:GetUIComponent("UILocalizationText", "txtPrice")
  self._txtTotal = self:GetUIComponent("UILocalizationText", "txtTotal")
  self._txtGift = self:GetUIComponent("UILocalizationText", "txtGift")
  self._txtPrice:SetText("")
  self._freeObj = self:GetGameObject("free")
  self._totalGO = self:GetGameObject("total")
  self._offset = self:GetGameObject("offset")
  self._giftGO = self:GetGameObject("gift")
  self._new = self:GetGameObject("new")
  self._redGo = self:GetGameObject("red")
  self._tips = self:GetGameObject("tips")
  self._discountLabel = self:GetGameObject("discountLabel")
  self._refresh = self:GetGameObject("refresh")
  self._limit = self:GetGameObject("limit")
  self._txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self.txRefresh = self:GetUIComponent("UILocalizationText", "txRefresh")
  self._txtLimit = self:GetUIComponent("UILocalizationText", "txtLimit")
  self._discountTxtLabel = self:GetUIComponent("UILocalizationText", "discountTxtLabel")
  self._monthCardAwardGO = self:GetGameObject("MonthCardAward")
  self._monthCardValue1 = self:GetUIComponent("UILocalizationText", "MonthCardValue1")
  self._monthCardValue2 = self:GetUIComponent("UILocalizationText", "MonthCardValue2")
  self._monthCardValue2Text = self:GetUIComponent("UILocalizationText", "MonthCardValue2Text")
  self._monthCardValue3 = self:GetUIComponent("UILocalizationText", "MonthCardValue3")
  self._monthCardValue4 = self:GetUIComponent("UILocalizationText", "MonthCardValue4")
  self.animation = self:GetGameObject():GetComponent("Animation")
  self:AttachEvent(GameEventType.UpdateRechargeItemPrice, self.FlushPrice)
  self:AttachEvent(GameEventType.UpdateRechargeItemPresent, self.FlushPresent)
end

function UIShopRechargeItem:OnHide()
  self:DetachEvent(GameEventType.UpdateRechargeItemPrice, self.FlushPrice)
  self:DetachEvent(GameEventType.UpdateRechargeItemPresent, self.FlushPresent)
end

function UIShopRechargeItem:Flush(id, isMonthCard, isGift)
  self._itemData = self._data:GetGoodBuyId(id)
  self._offset:SetActive(true)
  self._isMonthCard = isMonthCard
  self._isGift = isGift
  if self._isMonthCard then
    self._itemData = self._data:GetMonthCardGoods()
  elseif self._isGift then
    self._itemData = self._giftData:GetGoodBuyId(id)
  else
    self._itemData = self._data:GetGoodBuyId(id)
  end
  self._txtName:SetText(self._itemData:GetName())
  self._txtNameShadow:SetText(self._itemData:GetName())
  if self._isGift then
    self._txtName.color = Color(1.0, 0.8549019607843137, 0.5372549019607843)
  else
    self._txtName.color = self._txtName.color
  end
  self._imgIcon:LoadImage(self._itemData:GetIcon())
  if self._isMonthCard then
    self._monthCardValue2Text:SetText(StringTable.Get("str_shop_monthcard_notice2", 30))
    local immediatelyData = self._itemData:GetAwardsImmediately()
    if next(immediatelyData) then
      self._monthCardValue1:SetText(immediatelyData[1]:GetCount())
    end
    local dailyData = self._itemData:GetAwardsDaily()
    if next(dailyData) then
      self._monthCardValue2:SetText("*" .. dailyData[1]:GetCount())
      self._monthCardValue3:SetText("*" .. dailyData[2]:GetCount())
      self._monthCardValue4:SetText("*" .. dailyData[3]:GetCount())
    end
    self._monthCardAwardGO:SetActive(true)
  elseif self._isGift then
    self._monthCardAwardGO:SetActive(false)
  else
    self._txtPaid:SetText(self._itemData:GetCount())
    self._monthCardAwardGO:SetActive(false)
  end
  self._paidObj:SetActive(not self._isMonthCard and not self._isGift)
  self:FlushPrice()
  self:FlushPresent()
  self:FlushMonthCardOrGift()
end

function UIShopRechargeItem:FlushPrice()
  local price = ""
  if self._isMonthCard then
    price = ClientShop.PriceUnit() .. self._itemData:GetPrice()
  elseif self._isGift then
    price = self._itemData:GetPriceWithCurrencySymbol()
  else
    if not self._itemData then
      return
    end
    price = self._itemData:GetPrice()
  end
  local priceStr = GiftPackShopItem:GetPriceWithSymbolSize(price, 36)
  self._txtPrice:SetText(priceStr)
end

function UIShopRechargeItem:FlushPresent()
  if not self._itemData then
    return
  end
  if self._isMonthCard then
    self._label:SetActive(false)
    self._freeObj:SetActive(false)
    self._totalGO:SetActive(false)
    self._giftGO:SetActive(false)
  elseif self._isGift then
    self._label:SetActive(false)
    self._freeObj:SetActive(false)
    self._totalGO:SetActive(false)
    self._giftGO:SetActive(true)
    local awards = self._itemData:GetAwardsImmediately()
    local count = 0
    for _, value in pairs(awards) do
      count = count + value:GetCount()
    end
    self._txtGift:SetText(count)
  else
    local freeCount = self._itemData:GetCountFree()
    if self._itemData:GetCount() ~= freeCount then
      self._label:SetActive(false)
    else
      self._label:SetActive(true)
      local label = self._itemData:GetLabel()
      self._txtLabel:SetText(label)
    end
    if 0 < freeCount then
      self._txtFree:SetText(self._itemData:GetCountFree())
      self._txtFreeTMP:SetText(tostring(self._itemData:GetCountFree()))
    else
    end
    self._freeObj:SetActive(0 < freeCount)
    self._txtTotal:SetText(self._itemData:GetCountFree() + self._itemData:GetCount())
    self._totalGO:SetActive(0 < self._itemData:GetCountFree())
    self._giftGO:SetActive(false)
  end
end

function UIShopRechargeItem:FlushMonthCardOrGift()
  self._new:SetActive(false)
  self._discountLabel:SetActive(false)
  self._tips:SetActive(false)
  self._refresh:SetActive(false)
  self._limit:SetActive(false)
  if not self._isMonthCard and not self._isGift then
    return
  end
  local discount = self._itemData:GetDiscountEx(true)
  if discount then
    local discountStr = StringTable.Get("str_pay_discount_percent", string.format("<size=39>%s</size>", discount))
    self._discountLabel:SetActive(true)
    self._discountTxtLabel:SetText(discountStr)
  else
    self._discountLabel:SetActive(false)
  end
  local strCycleType = self._itemData:GetCycleTypeStr()
  if string.isnullorempty(strCycleType) then
    self._tips:SetActive(false)
  else
    self._tips:SetActive(true)
    self._txtTips:SetText(strCycleType)
  end
  local txtRefreshTimeStr = strCycleType
  if string.isnullorempty(txtRefreshTimeStr) then
    txtRefreshTimeStr = self._itemData:GetRefreshTimeStr()
  end
  if string.isnullorempty(txtRefreshTimeStr) then
    self._refresh:SetActive(false)
  else
    self._refresh:SetActive(true)
    self.txRefresh:SetText(txtRefreshTimeStr)
  end
  local str = self._itemData:GetCountStr()
  if string.isnullorempty(str) then
    self._limit:SetActive(false)
  else
    self._limit:SetActive(false)
    self._txtLimit:SetText(str)
  end
  local isNew = false
  if self._isGift then
    local new, list = self.shopModule:GetRechargeTabNew()
    for key, value in pairs(list) do
      if value == self._itemData:GetId() then
        isNew = true
        break
      end
    end
  else
    isNew = self._itemData:GetNew()
  end
  self._new:SetActive(isNew)
  local isRed = false
  self._redGo:SetActive(isRed)
end

function UIShopRechargeItem:BgOnClick()
  self:CanCharge()
end

function UIShopRechargeItem:BtnPriceOnClick()
  self:CanCharge()
end

function UIShopRechargeItem:CanCharge()
  if string.isnullorempty(self._txtPrice.text) then
    return
  end
  if self._isMonthCard then
    self:OpenUIShopGiftPackDetail(ShopMainTabType.Recharge)
  elseif self._isGift then
    self:OpenUIShopGiftPackDetail(ShopMainTabType.Gift)
  else
    self:Lock("UIShopRechargeItem_CanCharge")
    GameGlobal.TaskManager():StartTask(self.CanChargeCoro, self)
  end
end

function UIShopRechargeItem:CanChargeCoro(TT)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:IsJapanZone() then
    self:Charge()
    self:UnLock("UIShopRechargeItem_CanCharge")
    return
  end
  local payModule = GameGlobal.GetModule(PayModule)
  if payModule:NeedSelectAge(TT) then
    self:ShowDialog("UISetAgeConfirmController")
    self:UnLock("UIShopRechargeItem_CanCharge")
    return
  end
  self:Charge()
  self:UnLock("UIShopRechargeItem_CanCharge")
end

function UIShopRechargeItem:Charge()
  if not self._itemData then
    Log.fatal("### self._itemData is nil.")
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchPurchaseUI, false, -1, "nil")
    return
  end
  GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchPurchaseUI, true, 0, "Charge" .. tostring(self._itemData:GetCount()))
  local mPay = self:GetModule(PayModule)
  mPay:Recharge(self._itemData)
end

function UIShopRechargeItem:OpenUIShopGiftPackDetail(mainTabType)
  self:_RecordClick()
  if self._itemData:GetType() == GiftPackType.Currency then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.LaunchPurchaseUI, true, 0, tostring(self._itemData:GetId()))
  end
  self:ShowDialog("UIShopGiftPackDetail", self._itemData:GetId(), mainTabType)
  if self._itemData:GetNew() then
    self.shopModule:CancelNewMark(MarketType.Shop_PayMarket, self._itemData:GetId())
    self._itemData:SetNew(false)
    self._new:SetActive(false)
  end
  if self._itemData:GetRechargeGift() then
    self.shopModule:CancelRechargeGiftNewMark(self._itemData:GetId())
    self._itemData:SetNew(false)
    self._new:SetActive(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
end

function UIShopRechargeItem:GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function UIShopRechargeItem:_RecordClick()
end

function UIShopRechargeItem:PlayInAnimation()
  self.animation:Play("uianim_UIShopRechargeItem_in")
  return 867
end
