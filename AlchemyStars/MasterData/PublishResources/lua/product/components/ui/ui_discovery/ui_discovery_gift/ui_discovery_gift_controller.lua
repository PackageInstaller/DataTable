_class("UIDiscoveryGiftController", UIController)
UIDiscoveryGiftController = UIDiscoveryGiftController

function UIDiscoveryGiftController:Constructor()
end

function UIDiscoveryGiftController:OnShow(uiParams)
  self._good = uiParams[1]
  self._cfgv = uiParams[2]
  self._itemData = self:GetItemData()
  self._titleTex = self:GetUIComponent("UILocalizationText", "titleTex")
  self._awardsPool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._priceTex = self:GetUIComponent("UILocalizationText", "priceTex")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  self._buyBtn = self:GetGameObject("BuyBtn")
  self._timerTex = self:GetUIComponent("UILocalizationText", "timerTex")
  self._timerGo = self:GetGameObject("timerTex")
  local yieldTimeStart = 100
  local cfg = Cfg.cfg_shop_giftmarket_goods[self._good.gift_id]
  local awardsStr = cfg.DirectAssetList
  local awards = GiftPackShopData.ItemString2List(awardsStr)
  self._awardsPool:SpawnObjects("UIDiscoveryGiftControllerAward", #awards)
  local pools = self._awardsPool:GetAllSpawnList()
  for i = 1, #awards do
    local item = pools[i]
    local award = awards[i]
    local yieldTime = yieldTimeStart + i * 33
    item:SetData(award, function(id, pos)
      self:OnItemClick(id, pos)
    end, yieldTime)
  end
  local title = cfg.Name
  self._titleTex:SetText(StringTable.Get(title))
  local price = self._itemData:GetPriceWithCurrencySymbol()
  self._priceTex:SetText(price)
  self._buying = false
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnCurrencyBuySuccess)
  self:AttachEvent(GameEventType.MidasPayError, self.OnCurrencyBuyError)
  self:CheckBuyState()
  self:CancelGiftRed()
end

function UIDiscoveryGiftController:CancelGiftRed()
  if self._good then
    local gidtid = self._good.gift_id
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local key = "UIDiscoveryGiftItem" .. pstid .. gidtid
    LocalDB.SetInt(key, 1)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDisGiftCheckRed)
  end
end

function UIDiscoveryGiftController:CheckBuyState()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = svrTimeModule:GetServerTime() * 0.001
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._GiftData, self._GiftCfg = self._shopModule:GetGiftMarketData()
  local giftList = self._GiftData.goods
  local data
  local cfgs = Cfg.cfg_shop_giftmarket_goods({})
  for k, v in pairs(giftList) do
    local giftid = v.gift_id
    if self._good.gift_id == giftid then
      data = v
      break
    end
  end
  local show = false
  if data and data.deadline_time > 0 and svrTime < data.deadline_time then
    show = true
  end
  self._buyBtn:SetActive(show)
  self:ShowTimer(show, data)
end

function UIDiscoveryGiftController:ShowTimer(show, data)
  self._timerGo:SetActive(show)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  if show then
    self._endTime = data.deadline_time
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:ShowTimeTex()
    end)
    self:ShowTimeTex()
  end
end

function UIDiscoveryGiftController:ShowTimeTex()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = svrTimeModule:GetServerTime() * 0.001
  local gap = math.floor(self._endTime - svrTime)
  if 0 < gap then
    local timeStr = HelperProxy:GetInstance():Time2Tex(gap)
    self._timerTex:SetText(StringTable.Get("str_shop_discovery_gift_c_time_str", timeStr))
  end
end

function UIDiscoveryGiftController:OnCurrencyBuySuccess(giftid)
  Log.debug("###[UIDiscoveryGiftController] 购买成功,id:", giftid)
  if giftid == self._good.gift_id then
    Log.debug("###[UIDiscoveryGiftController] 购买成功,刷新状态")
    self._buying = false
    self:CloseDialog()
  end
end

function UIDiscoveryGiftController:OnCurrencyBuyError()
  Log.debug("###[UIDiscoveryGiftController] 购买失败")
  self._buying = false
end

function UIDiscoveryGiftController:OnItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

function UIDiscoveryGiftController:Lst2GiftPackShopItemAward(lst)
  local items = {}
  for i, item in ipairs(lst) do
    local item = GiftPackShopItemAward:New(item.templateId, item.count)
    table.insert(items, item)
  end
  return items
end

function UIDiscoveryGiftController:GetItemData()
  local item = GiftPackShopItem:New(self._good.gift_id)
  local cfg = Cfg.cfg_shop_giftmarket_goods[self._good.gift_id]
  local midasId = self._cfgv[ConfigKey.ConfigKey_MidasItemId]
  item:SetMidasId(midasId)
  item:SetBuyCount(1)
  item:SetMaxBuyCount(cfg.SaleNum)
  local strOneTime = cfg.DirectAssetList
  local lstOneTime = GiftPackShopData.ItemString2List(strOneTime)
  local awardsImmediately = self:Lst2GiftPackShopItemAward(lstOneTime)
  item:SetAwardsImmediately(awardsImmediately)
  local strCycle = self._cfgv[ConfigKey.ConfigKey_CycleAcceptAssetList]
  local lstCycle = GiftPackShopData.ItemString2List(strCycle)
  local awardsDaily = self:Lst2GiftPackShopItemAward(lstCycle)
  item:SetAwardsDaily(awardsDaily)
  local strShopGiftType = self._cfgv[ConfigKey.ConfigKey_ShopGiftType]
  item:SetIsMonthCard(false)
  item:SetBattlePassGift(false)
  item:SetRechargeGift(false)
  item.isWeekCard = false
  local refreshMethod = tonumber(self._cfgv[ConfigKey.ConfigKey_RefreshMethod])
  item:SetCycleType(refreshMethod)
  local refreshInterval = tonumber(self._cfgv[ConfigKey.ConfigKey_RefreshInterval])
  item:SetCycleDayCount(refreshInterval)
  item:SetRefreshTime(self._good.deadline_time)
  local showEndTime = tonumber(self._cfgv[ConfigKey.ConfigKey_ShowEndTime])
  item:SetEndTime(showEndTime)
  local saleType = cfg.SaleType
  local priceNotCash = tonumber(self._cfgv[ConfigKey.ConfigKey_NowPrice])
  if saleType == SpecialNum.NeedPayMoney then
    item:SetType(GiftPackType.Currency)
    item:SetPriceIcon(nil)
    item:SetPriceItemId(nil)
    item:SetPrice(priceNotCash)
    local mPay = GameGlobal.GetModule(PayModule)
    local goodPriceList = mPay:GetGoodPriceList()
    Log.debug("###[lxs] price 8 midasId:", midasId)
    local goodPrice = goodPriceList[midasId]
    local priceTex = ""
    if goodPrice and goodPrice.price then
      priceTex = goodPrice.price
    else
      Log.error("###[UIDiscoveryGiftController] goodPrice.price is nil !")
    end
    item:SetPriceWithCurrencySymbol(priceTex)
  end
  item._discount = tonumber(self._cfgv[ConfigKey.ConfigKey_Discount])
  item:SetName(StringTable.Get(cfg.Name))
  item:SetIcon(cfg.Icon)
  item:SetIconDetail(cfg.IconDetail)
  return item
end

function UIDiscoveryGiftController:CheckOutTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = svrTimeModule:GetServerTime() * 0.001
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._GiftData, self._GiftCfg = self._shopModule:GetGiftMarketData()
  local giftList = self._GiftData.goods
  local data
  local cfgs = Cfg.cfg_shop_giftmarket_goods({})
  for k, v in pairs(giftList) do
    local giftid = v.gift_id
    if self._good.gift_id == giftid then
      data = v
      break
    end
  end
  local show = false
  if data and data.deadline_time > 0 and svrTime < data.deadline_time then
    show = true
  end
  return not show
end

function UIDiscoveryGiftController:BuyBtnOnClick(go)
  if self:CheckOutTime() then
    Log.debug("###[UIDiscoveryGiftController] 礼包过期")
    local tips = "str_shop_discovery_gift_c_out_time"
    ToastManager.ShowToast(StringTable.Get(tips))
    return
  end
  local cfg = Cfg.cfg_shop_giftmarket_goods[self._good.gift_id]
  local midasId = cfg.DirectAMidasID
  if string.isnullorempty(midasId) then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "midasId_is_empty")
    Log.fatal("### [Pay]midasId can't be empty")
    return
  end
  if self._buying then
    Log.debug("###[UIDiscoveryGiftController] is buying !")
    return
  end
  self:StartTask(function(TT)
    self:Lock("UIDiscoveryGiftController:BuyBtnOnClick")
    self._buying = true
    local shopModule = GameGlobal.GetModule(ShopModule)
    local ret = shopModule:BuyGift(TT, self._good.gift_id)
    if ClientShop.CheckShopCode(ret) then
      self:CanCharge(midasId)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
    self:UnLock("UIDiscoveryGiftController:BuyBtnOnClick")
  end, self)
end

function UIDiscoveryGiftController:CanCharge(midasId)
  self:Lock("UIDiscoveryGiftController:CanChargeCoro")
  GameGlobal.TaskManager():StartTask(self.CanChargeCoro, self, midasId)
end

function UIDiscoveryGiftController:CanChargeCoro(TT, midasId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:IsJapanZone() then
    self:StartTask(self.BuyGoodsTask, self, midasId, 1)
    self:UnLock("UIDiscoveryGiftController:CanChargeCoro")
    return
  end
  local payModule = GameGlobal.GetModule(PayModule)
  if payModule:NeedSelectAge(TT) then
    self:ShowDialog("UISetAgeConfirmController")
    self:UnLock("UIDiscoveryGiftController:CanChargeCoro")
    return
  end
  self:StartTask(self.BuyGoodsTask, self, midasId, 1)
  self:UnLock("UIDiscoveryGiftController:CanChargeCoro")
end

function UIDiscoveryGiftController:BuyGoodsTask(TT, itemId, itemCount)
  local mPay = self:GetModule(PayModule)
  if IsAndroid() or IsUnityEditor() or IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local res, replyEvent = mPay:SendBuyGoodsRequest(TT, itemId, itemCount)
      Log.debug("UIDiscoveryGiftController:BuyGoodsTask IsAndroid start res ", res.m_result)
      if not res:GetSucc() then
        if res.m_result == PayErrorCode.PAY_ERROR_NOT_USE_MIDAS then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_need_open_switch"))
        else
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_fail_try_later"))
        end
      elseif not replyEvent then
        Log.debug("UIDiscoveryGiftController:BuyGoodsTask failed no replyEvent")
      elseif res.m_result == PayErrorCode.PAY_SUCC then
        local token = replyEvent.token
        local url = replyEvent.url_params
        Log.debug("UIDiscoveryGiftController:BuyGoodsTask success token ", token, " url ", url)
        mPay:BuyGoodsByUrl(url, self._itemData)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      mPay:BuyGoodsByGiftPackShopItem(self._itemData, itemCount)
    end
  elseif IsIos() then
    mPay:BuyGoodsByGiftPackShopItem(self._itemData, itemCount)
  end
end

function UIDiscoveryGiftController:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIDiscoveryGiftController:BgOnClick(go)
  self:CloseDialog()
end

function UIDiscoveryGiftController:CloseBtnOnClick(go)
  self:CloseDialog()
end
