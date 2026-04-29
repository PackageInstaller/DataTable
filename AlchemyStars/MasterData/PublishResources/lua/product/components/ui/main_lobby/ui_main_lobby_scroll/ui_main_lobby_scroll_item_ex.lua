require("ui_main_lobby_scroll_item")

function UIMainLobbyScrollItem:BookPrice(request)
  self._uiBuy.gameObject:SetActive(false)
  self._uiDay.gameObject:SetActive(false)
  self._uiActiveNon.gameObject:SetActive(false)
  self._uiActiveNor.gameObject:SetActive(false)
  self._uiActiveLux.gameObject:SetActive(false)
  if self._cfg == nil then
    return
  end
  local jump = self._cfg.data
  if jump.JumpType ~= UIJumpType.UI_JumpMall then
    return
  end
  local countParam = 0
  local JumpParam = jump.JumpParam
  if jump.JumpParam ~= nil then
    countParam = #JumpParam
  end
  if 4 <= countParam and JumpParam[2] == ShopMainTabType.Recharge then
    setmetatable(self, UIMainLobbyScrollItemRecharge)
    request:BookPrice(self, ShopMainTabType.Recharge, MarketType.Shop_Error)
  elseif 4 <= countParam and JumpParam[2] == ShopMainTabType.Gift then
    setmetatable(self, UIMainLobbyScrollItemGift)
    request:BookPrice(self, ShopMainTabType.Gift, MarketType.Shop_Error)
  elseif 2 <= countParam and JumpParam[2] == ShopMainTabType.SailingPlan then
    setmetatable(self, UIMainLobbyScrollItemSailingPlan)
    request:BookPrice(self, ShopMainTabType.SailingPlan, MarketType.Shop_Error)
  end
end

function UIMainLobbyScrollItem:UpdatePrice(request)
end

_class("UIMainLobbyScrollItemRecharge", UIMainLobbyScrollItem)
UIMainLobbyScrollItemRecharge = UIMainLobbyScrollItemRecharge

function UIMainLobbyScrollItemRecharge:UpdatePrice(request)
  local jump = self._cfg.data
  local id = jump.JumpParam[4]
  local clientShop = request:GetClientShop()
  local shopData = clientShop:GetRechargeShopData()
  local monthCard
  if shopData.GetMonthCardGoods ~= nil then
    monthCard = shopData:GetMonthCardGoods()
  end
  if monthCard ~= nil and monthCard:GetId() == id then
    local cardCfg = Cfg.cfg_shop_giftmarket_goods[id]
    if cardCfg.SaleType == SpecialNum.NeedPayMoney and cardCfg.NewPrice ~= 0 then
      if 0 < monthCard:GetRefreshTime() then
        self._uiDay.gameObject:SetActive(true)
        local remainTime = monthCard:GetRefreshTime()
        self._txtDayValue:SetText(math.ceil(remainTime / 86400))
      else
        local price = monthCard:GetPrice()
        self._uiBuy.gameObject:SetActive(true)
        self._txtBuyValue:SetText(UIShopToolFunctions.GetPrice(price))
      end
    end
  end
end

_class("UIMainLobbyScrollItemGift", UIMainLobbyScrollItem)
UIMainLobbyScrollItemGift = UIMainLobbyScrollItemGift

function UIMainLobbyScrollItemGift:UpdatePrice(request)
  local jump = self._cfg.data
  local id = jump.JumpParam[4]
  local giftInfo, giftCfg = request:GetGiftData(id)
  if giftInfo == nil or giftCfg == nil then
    return
  end
  local showPrice = giftCfg.SaleType == SpecialNum.NeedPayMoney and giftCfg.NewPrice ~= 0
  if showPrice and giftCfg.GiftType == ShopGiftType.SGT_NormalGift then
    if giftInfo.selled_num ~= 0 then
      local price = request:GetGiftPrice(id)
      self._uiBuy.gameObject:SetActive(true)
      self._txtBuyValue:SetText(price)
    else
      local price = request:GetGiftPrice(id)
      self._uiBuy.gameObject:SetActive(true)
      self._txtBuyValue:SetText(price)
    end
  elseif showPrice and giftCfg.GiftType == ShopGiftType.SGT_MonthCard then
    if 0 < giftInfo.deadline_time then
      self._uiDay.gameObject:SetActive(true)
      local remainTime = giftInfo.deadline_time
      self._txtDayValue:SetText(math.ceil(remainTime / 86400))
    else
      local price = request:GetGiftPrice(id)
      self._uiBuy.gameObject:SetActive(true)
      self._txtBuyValue:SetText(UIShopToolFunctions.GetPrice(price))
    end
  elseif giftCfg.GiftType == ShopGiftType.SGT_BattlePassGift then
    local battlePassCampaign = request:BattlePassCampaign()
    local buyInfo, buyComponent
    if battlePassCampaign ~= nil then
      local localProcess = battlePassCampaign:GetLocalProcess()
      buyInfo = localProcess:GetComponentInfo(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
      buyComponent = localProcess:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
    end
    if buyInfo ~= nil then
      local buyState = buyInfo.m_buy_state
      if buyState == BuyGiftStateType.EBGST_ADVANCED then
        self._uiActiveNor.gameObject:SetActive(true)
      elseif buyState == BuyGiftStateType.EBGST_LUXURY then
        self._uiActiveLux.gameObject:SetActive(true)
      elseif buyState == BuyGiftStateType.EBGST_INIT then
        local type = CampaignGiftType.ECGT_ADVANCED
        local giftId = buyComponent:GetFirstGiftIDByType(type)
        local price = buyComponent:GetGiftPriceForShowById(giftId)
        self._uiBuy.gameObject:SetActive(true)
        self._txtBuyValue:SetText(price)
      end
    end
  elseif showPrice and giftCfg.GiftType == ShopGiftType.SGT_WeekCard then
    if 0 < giftInfo.deadline_time then
      self._uiDay.gameObject:SetActive(true)
      local remainTime = giftInfo.deadline_time
      self._txtDayValue:SetText(math.ceil(remainTime / 86400))
    else
      local price = request:GetGiftPrice(id)
      self._uiBuy.gameObject:SetActive(true)
      self._txtBuyValue:SetText(price)
    end
  end
end

_class("UIMainLobbyScrollItemSailingPlan", UIMainLobbyScrollItem)
UIMainLobbyScrollItemSailingPlan = UIMainLobbyScrollItemSailingPlan

function UIMainLobbyScrollItemSailingPlan:UpdatePrice(request)
  local sailingPlanCampaign = request:SailingPlanCampaign()
  local buyInfo
  if sailingPlanCampaign ~= nil then
    local localProcess = sailingPlanCampaign:GetLocalProcess()
    buyInfo = localProcess:GetComponentInfo(ECCampaignInlandSailingComponentID.BUY_GIFT)
  end
  local gift
  if buyInfo ~= nil then
    gift = buyInfo.m_campaign_gift_list[1]
  end
  local cfgGood
  if gift ~= nil then
    cfgGood = Cfg.cfg_shop_common_goods[gift.m_gift_id]
  end
  if cfgGood ~= nil and cfgGood.SaleType == SpecialNum.NeedPayMoney and gift.m_now_price ~= 0 then
    local buyState = buyInfo.m_buy_state
    if buyState ~= BuyGiftStateType.EBGST_INIT then
      self._uiActiveNon.gameObject:SetActive(true)
    else
      local gift = buyInfo.m_campaign_gift_list[1]
      local price = gift.m_now_price
      self._uiBuy.gameObject:SetActive(true)
      self._txtBuyValue:SetText(UIShopToolFunctions.GetPrice(price))
    end
  end
end

_class("MainLobbyShopPriceRequest", Object)
MainLobbyShopPriceRequest = MainLobbyShopPriceRequest

function MainLobbyShopPriceRequest:Constructor()
  self._isNational = true
  self._payModule = GameGlobal.GetModule(PayModule)
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._clientShop = self._shopModule:GetClientShop()
  self._bookList = nil
  self._priceEvent = nil
  self._giftData = nil
  self._giftConfig = nil
end

function MainLobbyShopPriceRequest:Dispose()
  if self._requestTask then
    local task = GameGlobal.TaskManager():FindTask(self._requestTask)
    if task and task.state ~= TaskState.Stop then
      GameGlobal.TaskManager():KillTask(self._requestTask)
    end
    self._requestTask = nil
  end
  if self._priceEvent ~= nil then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.PayGetLocalPriceFinished, self._priceEvent)
    self._priceEvent = nil
  end
end

function MainLobbyShopPriceRequest:BookPrice(target, mainType, subType)
  if self._bookList == nil then
    self._bookList = {}
  end
  local exist = false
  for k, v in pairs(self._bookList) do
    if v.mainType == mainType and v.subType == subType then
      table.insert(v.targets, target)
      exist = true
      break
    end
  end
  if not exist then
    table.insert(self._bookList, {
      targets = {target},
      mainType = mainType,
      subType = subType
    })
  end
end

function MainLobbyShopPriceRequest:GetShopModule()
  return self._shopModule
end

function MainLobbyShopPriceRequest:GetClientShop()
  return self._clientShop
end

function MainLobbyShopPriceRequest:GetGiftData(id)
  if self._giftData == nil then
    local giftInfo, giftCfg = self._shopModule:GetGiftMarketData()
    local giftList = giftInfo.goods
    self._giftData = {}
    self._giftConfig = giftCfg
    for k, v in pairs(giftList) do
      self._giftData[v.gift_id] = v
    end
  end
  return self._giftData[id], Cfg.cfg_shop_giftmarket_goods[id]
end

function MainLobbyShopPriceRequest:BattlePassCampaign()
  return self._battlePassCampaign
end

function MainLobbyShopPriceRequest:SailingPlanCampaign()
  return self._sailingPlanCampaign
end

function MainLobbyShopPriceRequest:Request()
  local bookList = self._bookList
  if bookList == nil then
    bookList = {}
  end
  self._requestTask = GameGlobal.TaskManager():StartTask(function(TT)
    for k, v in pairs(bookList) do
      if v.mainType == ShopMainTabType.Recharge then
        self._clientShop:SendProtocal(TT, v.mainType, v.subType, nil)
      elseif v.mainType == ShopMainTabType.Gift then
        local loadBattlePass = false
        for tk, tv in pairs(v.targets) do
          local jump = tv._cfg.data
          local id = jump.JumpParam[4]
          local giftInfo, giftCfg = self:GetGiftData(id)
          if giftCfg.GiftType == ShopGiftType.SGT_BattlePassGift then
            loadBattlePass = true
          end
        end
        if loadBattlePass then
          local res = AsyncRequestRes:New()
          self._battlePassCampaign = UIActivityCampaign:New()
          self._battlePassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
          self._battlePassCampaign:ReLoadCampaignInfo_Force(TT, res)
          if not res:GetSucc() then
            Log.error("MainLobbyShopPriceRequest No battle pass.")
          end
          local localProcess = self._battlePassCampaign:GetLocalProcess()
          local buyComponent = localProcess:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
          buyComponent:GetAllGiftLocalPrice()
          self._buyInfo = localProcess:GetComponentInfo(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
          self:ListenPriceEvent()
        end
        if self._shopModule.GetLocalPrice ~= nil then
          self._shopModule:GetLocalPrice()
          self:ListenPriceEvent()
        end
      elseif v.mainType == ShopMainTabType.SailingPlan then
        local res = AsyncRequestRes:New()
        self._sailingPlanCampaign = UIActivityCampaign:New()
        self._sailingPlanCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_SAILING, ECCampaignInlandSailingComponentID.BUY_GIFT)
        self._sailingPlanCampaign:ReLoadCampaignInfo_Force(TT, res)
        if not res:GetSucc() then
          Log.error("MainLobbyShopPriceRequest No sailing plan.")
        end
        local localProcess = self._sailingPlanCampaign:GetLocalProcess()
        self._buyInfo = localProcess:GetComponentInfo(ECCampaignInlandSailingComponentID.BUY_GIFT)
      end
    end
    for k, v in pairs(bookList) do
      for tk, tv in pairs(v.targets) do
        tv:UpdatePrice(self)
      end
    end
  end)
end

function MainLobbyShopPriceRequest:ListenPriceEvent()
  if self._isNational then
    return
  end
  if self._priceEvent == nil then
    self._priceEvent = GameHelper:GetInstance():CreateCallback(self.OnPayGetLocalPriceFinished, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.PayGetLocalPriceFinished, self._priceEvent)
  end
end

function MainLobbyShopPriceRequest:OnPayGetLocalPriceFinished()
  if self._bookList == nil then
    return
  end
  for k, v in pairs(self._bookList) do
    for tk, tv in pairs(v.targets) do
      tv:UpdatePrice(self)
    end
  end
end

function MainLobbyShopPriceRequest:GetGiftPrice(id)
  local goodPriceList = self._payModule:GetGoodPriceList()
  local marketinfo, cfgGiftMarket = self._shopModule:GetGiftMarketData()
  local goodPrice
  local cfgv = cfgGiftMarket[id]
  if cfgv then
    local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
    goodPrice = goodPriceList[midasId]
  end
  if goodPrice then
    return goodPrice.price
  else
    local giftCfg = Cfg.cfg_shop_giftmarket_goods[id]
    local price = giftCfg.NewPrice
    return price
  end
end
