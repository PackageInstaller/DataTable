_class("UIShopMonthCardTab", UICustomWidget)
UIShopMonthCardTab = UIShopMonthCardTab

function UIShopMonthCardTab:OnShow(uiParams)
  self:AttachEvent(GameEventType.UpdateMonthCardShop, self.Flush)
  self:AttachEvent(GameEventType.ForceFlushMonthCard, self.ForceFlush)
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._shopMainTabType = ShopMainTabType.MonthCard
  self:InitWidget()
  self:Flush()
  local BuyBtn = self:GetUIComponent("RectTransform", "BuyBtn")
  if Localization.GetCurLanguage() == LanguageType.us then
    BuyBtn.anchoredPosition = Vector2(404, -286)
  else
    BuyBtn.anchoredPosition = Vector2(404, -346)
  end
end

function UIShopMonthCardTab:OnHide()
  self._itemData = nil
  self:DetachEvent(GameEventType.UpdateMonthCardShop, self.Flush)
  self:DetachEvent(GameEventType.ForceFlushMonthCard, self.ForceFlush)
end

function UIShopMonthCardTab:Update(deltaTimeMS)
end

function UIShopMonthCardTab:InitWidget()
  self.priceTex = self:GetUIComponent("UILocalizationText", "priceTex")
  self.leftTime = self:GetUIComponent("UILocalizationText", "leftTime")
  self._anim = self:GetUIComponent("Animation", "UIShopMonthCardTab")
end

function UIShopMonthCardTab:ForceFlush()
  self:Lock("UIShopMonthCardTab:ForceFlush")
  self:StartTask(function(TT)
    self.clientShop:SendProtocal(TT, self._shopMainTabType)
    self:UnLock("UIShopMonthCardTab:ForceFlush")
  end, self)
end

function UIShopMonthCardTab:Flush()
  local monthCardInfo = self.shopModule:GetMonthCardInfo()
  if not monthCardInfo then
    return
  end
  self._itemData = GiftPackShopItem:New(monthCardInfo.ID)
  self._itemData:SetPrice(monthCardInfo.MicroPrice)
  self._itemData:SetPriceWithCurrencySymbol(ClientShop.PriceUnit() .. monthCardInfo.NowPrice)
  self._itemData:SetIsMonthCard(true)
  self._itemData:SetRefreshTime(monthCardInfo.DeadlineTime)
  self._itemData:SetBuyCount(monthCardInfo.selled_num)
  self._itemData:SetMaxBuyCount(monthCardInfo.maxBuyCount)
  self._itemData:SetMidasId(monthCardInfo.midasId)
  local saleType = monthCardInfo.saleType
  if saleType == SpecialNum.NeedPayMoney then
    self._itemData:SetType(GiftPackType.Currency)
    self._itemData:SetPriceIcon(nil)
    self._itemData:SetPriceItemId(nil)
  else
    if saleType == SpecialNum.FreeGiftSaleType then
      self._itemData:SetType(GiftPackType.Free)
      self._itemData:SetPriceItemId(nil)
    else
      if saleType == RoleAssetID.RoleAssetDiamond then
        self._itemData:SetType(GiftPackType.Yaojing)
      elseif saleType == RoleAssetID.RoleAssetGlow then
        self._itemData:SetType(GiftPackType.Guangpo)
      else
        self._itemData:SetType(GiftPackType.Item)
      end
      self._itemData:SetPriceIcon("toptoon_" .. saleType)
      self._itemData:SetPriceItemId(saleType)
    end
    
    local function l2g(lst)
      local items = {}
      for i, item in ipairs(lst) do
        local item = GiftPackShopItemAward:New(item.templateId, item.count)
        table.insert(items, item)
      end
      return items
    end
    
    local awardsImmediately = l2g(monthCardInfo.DirectAssetList)
    self._itemData:SetAwardsImmediately(awardsImmediately)
    local awardsDaily = l2g(monthCardInfo.CycleAcceptAssetList)
    self._itemData:SetAwardsDaily(awardsDaily)
  end
  if not self._itemData then
    return
  end
  self.priceTex:SetText(self._itemData:GetPriceWithCurrencySymbolEx(56))
  local strCycleType = self._itemData:GetMonthCardCycleTypeStr(60)
  if string.isnullorempty(strCycleType) then
  else
    self.leftTime:SetText(strCycleType)
  end
  local controller = self:RootUIOwner()
  controller:CheckMonthCardTips(true)
end

function UIShopMonthCardTab:ExcuteHideLogic(callBack)
  if callBack then
    callBack(self)
  end
end

function UIShopMonthCardTab:SetData()
  self:_RefreshRedPoint()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.MonthCard)
end

function UIShopMonthCardTab:BuyBtnOnClick(go)
  if self._itemData:IsWeekCard() and self._itemData:GetBuyCount() > 0 then
    return
  end
  local packType = self._itemData:GetType()
  if not self._itemData:CheckDayCount() then
    return
  end
  if self._itemData:HasSoldOut() then
    if packType == GiftPackType.Currency then
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "buy_limit_reached")
    end
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_buy_limit_reached"))
    return
  end
  if packType == GiftPackType.Currency then
    local midasId = self._itemData:GetMidasId()
    Log.debug("###[lxs] BuyBtnOnClick 4mdsid:", midasId)
    if string.isnullorempty(midasId) then
      GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "midasId_is_empty")
      Log.fatal("### [Pay]midasId can't be empty")
      return
    end
    self:StartTask(function(TT)
      self:Lock("UIShopMonthCardTabRequestBuyGift")
      local ret = self.shopModule:BuyGift(TT, self._itemData:GetId())
      if ClientShop.CheckShopCode(ret) then
        self:CanCharge(midasId)
      elseif ret == SHOP_CODE.SHOP_GOODS_SELLED_OUT then
        self.clientShop:SendProtocal(TT, self._shopMainTabType)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
      self:UnLock("UIShopMonthCardTabRequestBuyGift")
    end, self)
  elseif packType == GiftPackType.Yaojing then
    local price = self._itemData:GetPrice()
    if self.clientShop:CheckEnoughYJ(price) then
      self:RequestBuyGift()
    else
    end
  elseif packType == GiftPackType.Guangpo then
    local price = self._itemData:GetPrice()
    if self.clientShop:CheckEnoughGP(price) then
      self:RequestBuyGift()
    else
    end
  elseif packType == GiftPackType.Item then
    local mRole = self:GetModule(RoleModule)
    local price = self._itemData:GetPrice()
    local assetId = self._itemData:GetPriceItemId()
    local count = mRole:GetAssetCount(assetId)
    if price <= count then
      self:RequestBuyGift()
    else
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_item_not_enough"))
    end
  elseif packType == GiftPackType.Free then
    self:RequestBuyGift()
  else
    Log.fatal("### invalid GiftPackType. packType=", packType)
  end
end

function UIShopMonthCardTab:RequestBuyGift()
  self:StartTask(function(TT)
    self:Lock("UIShopMonthCardTabRequestBuyGift")
    local id = self._itemData:GetId()
    local ret = self.shopModule:BuyGift(TT, id)
    if ClientShop.CheckShopCode(ret) then
      local mPay = GameGlobal.GetModule(PayModule)
      mPay:ShowUIShopRechargeGainWithoutYJ(self._itemData)
    end
    self.clientShop:SendProtocal(TT, self._shopMainTabType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    self:UnLock("UIShopMonthCardTabRequestBuyGift")
  end, self)
end

function UIShopMonthCardTab:CanCharge(midasId)
  self:Lock("UIShopMonthCardTab_CanCharge")
  GameGlobal.TaskManager():StartTask(self.CanChargeCoro, self, midasId)
end

function UIShopMonthCardTab:CanChargeCoro(TT, midasId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:IsJapanZone() then
    self:StartTask(self.BuyGoodsTask, self, midasId, 1)
    self:UnLock("UIShopMonthCardTab_CanCharge")
    return
  end
  local payModule = GameGlobal.GetModule(PayModule)
  if payModule:NeedSelectAge(TT) then
    self:ShowDialog("UISetAgeConfirmController")
    self:UnLock("UIShopMonthCardTab_CanCharge")
    return
  end
  self:StartTask(self.BuyGoodsTask, self, midasId, 1)
  self:UnLock("UIShopMonthCardTab_CanCharge")
end

function UIShopMonthCardTab:BuyGoodsTask(TT, itemId, itemCount)
  local mPay = self:GetModule(PayModule)
  if IsAndroid() or IsUnityEditor() or IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local res, replyEvent = mPay:SendBuyGoodsRequest(TT, itemId, itemCount)
      Log.debug("UIDemoPayController:BuyGoodsTask IsAndroid start res ", res.m_result)
      if not res:GetSucc() then
        if res.m_result == PayErrorCode.PAY_ERROR_NOT_USE_MIDAS then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_need_open_switch"))
        else
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_fail_try_later"))
        end
      elseif not replyEvent then
        Log.debug("UIDemoPayController:BuyGoodsTask failed no replyEvent")
      elseif res.m_result == PayErrorCode.PAY_SUCC then
        local token = replyEvent.token
        local url = replyEvent.url_params
        Log.debug("UIDemoPayController:BuyGoodsTask success token ", token, " url ", url)
        mPay:BuyGoodsByUrl(url, self._itemData)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      mPay:BuyGoodsByGiftPackShopItem(self._itemData, itemCount)
    end
  elseif IsIos() then
    mPay:BuyGoodsByGiftPackShopItem(self._itemData, itemCount)
  end
end

function UIShopMonthCardTab:_RefreshRedPoint()
  local isRed, tips, state = self.shopModule:ShowMonthCardRedPoint()
  if isRed then
    local monthCardInfo = self.shopModule:GetMonthCardInfo()
    local key
    if state == 2 then
      key = self.shopModule:GetMonthCardWillOutDataRedKey(monthCardInfo)
    elseif state == 3 then
      key = self.shopModule:GetMonthCardOutDataRedKey(monthCardInfo)
    end
    if key then
      LocalDB.SetInt(key, 1)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckMonthCardRedpoint)
    end
  end
end

function UIShopMonthCardTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopMonthCardTab:HideSelf()
end
