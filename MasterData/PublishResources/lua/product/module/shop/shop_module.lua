_class("ShopModule", GameModule)
ShopModule = ShopModule

function ShopModule:Constructor()
  self._blackMarketData = {}
  self._blackMarketConfig = {}
  self._mysteryMarketData = {}
  self._mysteryMarketConfig = {}
  self._SkinMarketData = {}
  self._skinMarketConfig = {}
  self._new_mark_skins = {}
  self._recommendData = {}
  self._clientShop = ClientShop:New()
  self._diamondCount = 0
  self._freeDiamondCount = 0
  self._lastGetPriceTime = 0
end

function ShopModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventPushDiamondData)
  self.caller:UnRegisterPushHandler(CEventPushCommonTimeIds)
end

function ShopModule:GetClientShop()
  return self._clientShop
end

function ShopModule:Init()
  self:AttachEvent(GameEventType.UIQuestDailyReset, self._RefreshGiftMarketData)
  self.caller:RegisterPushHandler(CEventPushDiamondData, self._HandlePushDiamondData, self)
  self.caller:RegisterPushHandler(CEventPushCommonTimeIds, self._HandlePushCommonTimeIds, self)
end

function ShopModule:GetLocalPriceOnlyForLoginLoad()
  self:_GetLocalPrice_Private()
end

function ShopModule:_GetLocalPrice_Private()
  local midasIds = {}
  if self._payMarketConfig then
    for k, cfgv in pairs(self._payMarketConfig) do
      if cfgv then
        local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
        if midasId and not string.isnullorempty(midasId) then
          table.insert(midasIds, midasId)
        end
      end
    end
  else
    Log.fatal("### _payMarketConfig nil.")
  end
  if self._giftMarketConfig then
    for k, cfgv in pairs(self._giftMarketConfig) do
      if cfgv and self:_ConfirmOnShow(cfgv) then
        local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
        if midasId and not string.isnullorempty(midasId) then
          table.insert(midasIds, midasId)
        end
      end
    end
  else
    Log.fatal("### _giftMarketConfig nil.")
  end
  if self._skinMarketConfig then
    for k, cfgv in pairs(self._skinMarketConfig) do
      if cfgv and self:_ConfirmOnShow(cfgv) then
        local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
        if midasId and not string.isnullorempty(midasId) then
          table.insert(midasIds, midasId)
        end
      end
    end
  else
    Log.fatal("### _skinMarketConfig nil.")
  end
  if midasIds and table.count(midasIds) > 0 then
    local mPay = GameGlobal.GetModule(PayModule)
    mPay:GetLocalPrice(midasIds)
  else
    Log.fatal("### [shop] midasIds empty. did not call GetLocalPrice.")
  end
end

function ShopModule:FillInitData(all_market_info, total_diamond_count, skin_market_data)
  self._mysteryMarketData = all_market_info.market_datas[MarketType.Shop_MysteryMarket]
  self._blackMarketData = all_market_info.market_datas[MarketType.Shop_BlackMarket]
  self._payMarketData = all_market_info.market_datas[MarketType.Shop_PayMarket]
  if self._payMarketData then
    local tmp_log_str = ""
    for k, v in pairs(self._payMarketData.goods) do
      tmp_log_str = tmp_log_str .. tostring(v.goods_id) .. "   "
    end
    Log.debug("self._payMarketData.goods :", tmp_log_str)
  end
  self._giftMarketData = all_market_info.month_card_data
  self._ClientGiftSaleNums = {}
  self._diamondCount = total_diamond_count
  self._SkinMarketData = skin_market_data
end

function ShopModule:FillInitConfig(all_market_config)
  self._blackMarketConfig = all_market_config.black_market_config
  self._mysteryMarketConfig = all_market_config.mystery_market_config
  self._payMarketConfig = all_market_config.pay_market_config
  self._giftMarketConfig = all_market_config.gift_market_config
  self._GuangPoMarketConfig = all_market_config.guangpo_market_config
  self._skinMarketConfig = all_market_config.skin_market_config
end

function ShopModule:_HandlePushDiamondData(diamondData)
  if self._not1stIn then
    local delta = diamondData.diamond_count - self._diamondCount
    if 0 < delta then
      local a = RoleAsset:New()
      a.assetid = RoleAssetID.RoleAssetDiamond
      a.count = delta
      GameGlobal.UIStateManager():ShowDialog("UIShopRechargeGain", {a})
    end
  else
    self._not1stIn = true
  end
  self._diamondCount = diamondData.diamond_count
  self._freeDiamondCount = diamondData.free_diamond_count
  Log.debug("current _diamondCount:", self._diamondCount, "_freeDiamondCount : ", self._freeDiamondCount)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiamondCountChanged)
end

function ShopModule:GetLocalPrice()
  local srvTime = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(srvTime:GetServerTime() / 1000)
  if curTime - self._lastGetPriceTime < 10 then
    return
  end
  self:_GetLocalPrice_Private()
end

function ShopModule:GetDiamondCount()
  return self._diamondCount, self._freeDiamondCount
end

function ShopModule:_ConfirmOnShow(cfgv)
  local srvTime = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(srvTime:GetServerTime() / 1000)
  local showEndTIme = tonumber(cfgv[ConfigKey.ConfigKey_ShowEndTime])
  if curTime ~= nil and showEndTIme ~= nil then
    return curTime <= showEndTIme
  else
    Log.error("curTime : ", curTime, "showEndTIme : ", showEndTIme)
    return true
  end
end

function ShopModule:_HandlePushCommonTimeIds(msgData)
  if self._giftMarketData ~= nil and self._giftMarketData.goods ~= nil then
    for key, value in pairs(self._giftMarketData.goods) do
      if msgData.data[value.gift_id] ~= nil then
        self._giftMarketData.goods[key] = msgData.data[value.gift_id]
      end
    end
  end
end

function ShopModule:BuyItem(TT, market_type, goods_id, buy_num, currency_type, selling_price, ids)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventBuyItem)
  request.market_type = market_type
  request.goods_id = goods_id == nil and 1 or goods_id
  request.buy_num = buy_num == nil and 1 or buy_num
  request.currency_type = currency_type == nil and 1 or currency_type
  request.selling_price = selling_price == nil and 1 or selling_price
  if ids ~= nil then
    request.ids = ids
  end
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return SHOP_CODE.SHOP_SERVER_RETURN_ERROR
  end
  return reply.msg.ret
end

function ShopModule:BuyGift(TT, giftID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventBuyGift)
  request.gift_id = giftID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return SHOP_CODE.SHOP_SERVER_RETURN_ERROR
  end
  return reply.msg.ret
end

function ShopModule:ApplyRefreshBlackMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyRefreshMarketData)
  request.market_type = MarketType.Shop_BlackMarket
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return SHOP_CODE.SHOP_SERVER_RETURN_ERROR, {}
  end
  self._blackMarketData = reply.msg.market_data
  self._blackMarketConfig = reply.msg.market_config
  return reply.msg.ret, self._blackMarketData
end

function ShopModule:GetBlackMarketData(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_BlackMarket
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}, 0
  end
  if reply.msg.update_data then
    self._blackMarketData = reply.msg.market_data
    self._blackMarketConfig = reply.msg.market_config
  end
  return self._blackMarketData, reply.msg.refresh_leave_second
end

function ShopModule:RequestGetBlackMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_BlackMarket
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.update_data then
    self._blackMarketData = reply.msg.market_data
    self._blackMarketConfig = reply.msg.market_config
  end
  self._refresh_leave_second = reply.msg.refresh_leave_second
  return res
end

function ShopModule:GetBlackMarketConfig()
  return self._blackMarketConfig
end

function ShopModule:ApplyRefreshMysteryMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyRefreshMarketData)
  request.market_type = MarketType.Shop_MysteryMarket
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return SHOP_CODE.SHOP_SERVER_RETURN_ERROR, {}
  end
  self._mysteryMarketData = reply.msg.market_data
  self._mysteryMarketConfig = reply.msg.market_config
  return reply.msg.ret, self._mysteryMarketData
end

function ShopModule:GetMysteryMarketData(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_MysteryMarket
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}
  end
  if reply.msg.update_data then
    self._mysteryMarketData = reply.msg.market_data
    self._mysteryMarketConfig = reply.msg.market_config
  end
  return self._mysteryMarketData, reply.msg.refresh_leave_second
end

function ShopModule:GetMysteryMarketConfig()
  return self._mysteryMarketConfig
end

function ShopModule:GetRecommendIds(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyAdvertisingData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}
  end
  self._recommendData = reply.msg.advertising_data
  self._monthCardInfoList = reply.msg.month_card_list
  self._market_config = reply.msg.market_config
  return self._recommendData
end

function ShopModule:GetMonthGiftData()
  return self._monthCardInfoList, self._market_config
end

function ShopModule:GetMonthCardInfo()
  if self._monthCardInfoList then
    local goodsInfo = self._monthCardInfoList[1]
    if goodsInfo then
      local id = goodsInfo.gift_id
      local cfgServer
      if self._market_config then
        cfgServer = self._market_config[id]
      end
      if not cfgServer and self._giftMarketConfig then
        cfgServer = self._giftMarketConfig[id]
      end
      local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
      if cfgServer and cfgClient and cfgClient.GiftType == ShopGiftType.SGT_MonthCard then
        local giftInfo = {}
        giftInfo.ID = id
        local mPay = GameGlobal.GetModule(PayModule)
        local goodPriceList = mPay:GetGoodPriceList()
        local goodPrice = goodPriceList[cfgServer[ConfigKey.ConfigKey_MidasItemId]]
        if goodPrice then
          giftInfo.MicroPrice = goodPrice.microprice / 1000000
          giftInfo.NowPrice = goodPrice.price
        else
          giftInfo.NowPrice = cfgServer[ConfigKey.ConfigKey_NowPrice]
        end
        giftInfo.DirectAssetList = GiftPackShopData.ItemString2List(cfgServer[ConfigKey.ConfigKey_DirectAssetList])
        giftInfo.CycleAcceptAssetList = GiftPackShopData.ItemString2List(cfgServer[ConfigKey.ConfigKey_CycleAcceptAssetList])
        giftInfo.DeadlineTime = goodsInfo.deadline_time
        giftInfo.deadline_timestamp = goodsInfo.deadline_timestamp
        giftInfo.selled_num = goodsInfo.selled_num
        giftInfo.maxBuyCount = tonumber(cfgServer[ConfigKey.ConfigKey_SaleNum])
        giftInfo.midasId = cfgServer[ConfigKey.ConfigKey_MidasItemId]
        giftInfo.saleType = cfgClient.SaleType
        return giftInfo
      end
    end
  end
  return nil
end

function ShopModule:confirmIfExist(TT, recommendId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyAdvertisingData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return SHOP_CODE.SHOP_SERVER_RETURN_ERROR, {}
  end
  self._recommendData = reply.msg.advertising_data
  local exist = false
  for key, value in pairs(self._recommendData) do
    if value == recommendId then
      exist = true
    end
  end
  return exist, self._recommendData
end

function ShopModule:RequestXingzuanMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_XingZuan
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._XingzuanMarketData = reply.msg.market_data
    self._XingzuanMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  end
  return res
end

function ShopModule:GetXingzuanData()
  return self._XingzuanMarketData, self._XingzuanMarketConfig, self._refresh_leave_second
end

function ShopModule:ExchangeRedDotChecker()
  return false
end

function ShopModule:RequestHuiyaoMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_HuiYao
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._HuiYaoMarketData = reply.msg.market_data
    self._HuiYaoMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  end
  return res
end

function ShopModule:GetHuiyaoData()
  return self._HuiYaoMarketData, self._HuiYaoMarketConfig, self._refresh_leave_second
end

function ShopModule:RequestGlowMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_GuangPo
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._GuangPoMarketData = reply.msg.market_data
    self._GuangPoMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  end
  return res
end

function ShopModule:GetGlowData()
  return self._GuangPoMarketData, self._GuangPoMarketConfig, self._refresh_leave_second
end

function ShopModule:RequestHongPiaoMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_HongPiao
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._HongPiaoMarketData = reply.msg.market_data
    self._HongPiaoMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  end
  return res
end

function ShopModule:GetHongPiaoData()
  return self._HongPiaoMarketData, self._HongPiaoMarketConfig, self._refresh_leave_second
end

function ShopModule:RequestSeasonMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_Season
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._SeasonMarketData = reply.msg.market_data
    self._SeasonMarketConfig = reply.msg.market_config
    self._refresh_leave_second = self:SeasonRefreshTime()
  end
  return res
end

function ShopModule:GetSeasonMarketData(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_Season
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}, 0
  end
  if reply.msg.update_data then
    self._SeasonMarketData = reply.msg.market_data
    self._SeasonMarketConfig = reply.msg.market_config
    self._refresh_leave_second = self:SeasonRefreshTime()
  end
  return self._SeasonMarketData, self._refresh_leave_second
end

function ShopModule:SeasonRefreshTime()
  local info = self._SeasonMarketData
  local cfgs = self._SeasonMarketConfig
  local timeGap
  local serverTimeModule = GameGlobal.GetModule(SvrTimeModule)
  if info and next(info) and cfgs and next(cfgs) then
    local nextTime
    for _, goods in pairs(info.goods) do
      local cfg = cfgs[goods.goods_id]
      if not nextTime then
        nextTime = cfg[ConfigKey.ConfigKey_ShowEndTime]
      else
        nextTime = math.min(nextTime, cfg[ConfigKey.ConfigKey_ShowEndTime])
      end
    end
    if nextTime then
      timeGap = nextTime - math.ceil(serverTimeModule:GetServerTime() * 0.001)
    else
      Log.error("###[season shop] nextTime is nil !")
      timeGap = 99999999999
    end
  else
    Log.error("###[season shop] info or cfgs is nil !")
    timeGap = 99999999999
  end
  return timeGap
end

function ShopModule:GetSeasonData()
  return self._SeasonMarketData, self._SeasonMarketConfig, self._refresh_leave_second
end

function ShopModule:GetSeasonMarketConfig()
  return self._SeasonMarketConfig
end

function ShopModule:ExchangeGetBlackMarketData()
  return self._blackMarketData, self._blackMarketConfig, self._refresh_leave_second
end

function ShopModule:RequestFurnitureMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_Furniture
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._FurnitureMarketData = reply.msg.market_data
    self._FurnitureMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  end
  return res
end

function ShopModule:GetFurnitureData()
  return self._FurnitureMarketData, self._FurnitureMarketConfig, self._refresh_leave_second
end

function ShopModule:RequestFurniturePreciousMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_Furniture_Precious
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._FurniturePreciousMarketData = reply.msg.market_data
    self._FurniturePreciousMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  end
  return res
end

function ShopModule:GetFurniturePreciousData()
  return self._FurniturePreciousMarketData, self._FurniturePreciousMarketConfig, self._refresh_leave_second
end

function ShopModule:RequestWorldBossMarket(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_WorldBoss
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._WorldBossMarketData = reply.msg.market_data
    self._WorldBossMarketConfig = reply.msg.market_config
    self._refresh_leave_second = reply.msg.refresh_leave_second
  else
    Log.error("err RequestWorldBossMarket err code: " .. reply.msg.ret)
  end
  return self._WorldBossMarketData, self._refresh_leave_second
end

function ShopModule:GetBattlePassMarketData(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMarketData)
  request.market_type = MarketType.Shop_BattlePass
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}
  end
  if reply.msg.update_data then
    self._battlePassMarketData = reply.msg.market_data
    self._battlePassMarketConfig = reply.msg.market_config
  end
  return self._battlePassMarketData, reply.msg.refresh_leave_second
end

function ShopModule:GetBattlePassMarketConfig()
  return self._battlePassMarketConfig
end

function ShopModule:GetWorldBossMarketConfig()
  return self._WorldBossMarketConfig
end

function ShopModule:GetExchangeRefreshTime()
  return self._refresh_leave_second
end

function ShopModule:ApplyPayMarketData(TT)
  local payModule = GameGlobal.GameLogic():GetModule(PayModule)
  payModule:RequestGetBalanceNormal()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyPayMarketData)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._payMarketData = reply.msg.market_data
    self._payMarketConfig = reply.msg.market_config
    self._monthCardInfoList = reply.msg.month_card_list
    self._giftMarketConfig = reply.msg.gift_market_config
  end
  return res
end

function ShopModule:GetPayMarketData()
  return self._payMarketData, self._payMarketConfig, self._monthCardInfoList, self._giftMarketConfig
end

function ShopModule:ApplyGiftMarketData(TT)
  GameGlobal.GameLogic():GetModule(PayModule):RequestGetBalanceNormal()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyGiftMarketData)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._giftMarketData = reply.msg.market_data
    self._giftMarketConfig = reply.msg.market_config
    Log.debug("self._giftMarketData : ", cjson.encode(self._giftMarketData))
    self:_ConfirmModifySaledNum()
    self:_FiltUnshowGifts()
  end
  return res
end

function ShopModule:GetGiftMarketData()
  return self._giftMarketData, self._giftMarketConfig
end

function ShopModule:ClientSaledGift(ID)
  for k, v in pairs(self._giftMarketData.goods) do
    if v.gift_id == ID then
      v.selled_num = v.selled_num + 1
      self._ClientGiftSaleNums[ID] = v.selled_num
      break
    end
  end
end

function ShopModule:_ConfirmModifySaledNum()
  for k, v in pairs(self._giftMarketData.goods) do
    local clientNum = self._ClientGiftSaleNums[v.gift_id]
    if v.selled_num ~= 0 and clientNum and clientNum > v.selled_num then
      v.selled_num = clientNum
    end
  end
end

function ShopModule:_FiltUnshowGifts()
  local retTable = {}
  for _k, goods in pairs(self._giftMarketData.goods) do
    local cfg = self._giftMarketConfig[goods.gift_id]
    local strShowEndTime = cfg[ConfigKey.ConfigKey_ShowEndTime]
    local strShowBeginTime = cfg[ConfigKey.ConfigKey_ShowBeginTime]
    local giftType = tonumber(cfg[ConfigKey.ConfigKey_ShopGiftType])
    if strShowEndTime ~= nil and strShowBeginTime ~= nil and giftType ~= ShopGiftType.SGT_MonthCard and giftType ~= ShopGiftType.SGT_BattlePassGift then
      local svrTime = GameGlobal.GetModule(SvrTimeModule)
      local nowTime = svrTime:GetServerTime() / 1000
      local showEndTime = tonumber(strShowEndTime)
      local showBeginTime = tonumber(strShowBeginTime)
      local deadlineTime = goods.deadline_time
      if giftType == ShopGiftType.SGT_WeekCard then
        if 0 < deadlineTime then
          table.insert(retTable, goods)
        elseif nowTime < showEndTime and nowTime > showBeginTime and tonumber(cfg[ConfigKey.ConfigKey_SaleNum]) > goods.selled_num then
          table.insert(retTable, goods)
        end
      elseif nowTime < showEndTime and nowTime > showBeginTime then
        if tonumber(cfg[ConfigKey.ConfigKey_RefreshMethod]) == RefreshMethod.RM_OneOff then
          if tonumber(cfg[ConfigKey.ConfigKey_SaleNum]) > goods.selled_num then
            table.insert(retTable, goods)
          elseif giftType == ShopGiftType.SGT_WeekCard and goods.deadline_time > 0 then
            table.insert(retTable, goods)
          end
        else
          table.insert(retTable, goods)
        end
      elseif giftType == ShopGiftType.SGT_WeekCard then
        if goods.deadline_time > 0 then
          table.insert(retTable, goods)
        end
      else
        Log.debug("showEndTime : ", showEndTime, "nowTime : ", nowTime, "showBeginTime", showBeginTime)
      end
    end
  end
  self._giftMarketData.goods = retTable
end

function ShopModule:ApplyDiamondExchangeGlow(TT, diamondCount, glowCount)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDiamondExchangeGlow)
  request.diamond_count = diamondCount
  request.exchange_glow_count = glowCount
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  return res
end

function ShopModule:ApplyGlowExchangeFurnitureCoin(TT, glowCount, furnitureCoinCount)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGlowExchangeFurnitureCoin)
  request.glow_count = glowCount
  request.exchange_coin_count = furnitureCoinCount
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  return res
end

function ShopModule:RequestPhysicalData(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqExchangePhyInfo)
  local reply = self:Call(TT, request)
  local res = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  self._leftExchangePhyState = reply.msg.left_info
  self._rightExchangePhyState = reply.msg.right_info
  self._validLeftPhyState = reply.msg.valid_left_infos
  return res
end

function ShopModule:GetCurExchangePhyState()
  return self._leftExchangePhyState, self._rightExchangePhyState
end

function ShopModule:GetCurExchangePhyValidLeftState()
  local uniqueList = {}
  local res = {}
  for _, value in pairs(self._validLeftPhyState) do
    if not table.icontains(uniqueList, value.cost_id) then
      table.insert(res, value)
      table.insert(uniqueList, value.cost_id)
    end
  end
  return res
end

function ShopModule:BuyPhysicalPower(TT, exchangeType, item_count)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqExchangePhyPoint)
  request.exchange_type = exchangeType
  request.count = item_count
  local reply = self:Call(TT, request)
  local res = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if exchangeType == ExchangePhyPointType.EPPT_LEFT then
    self._leftExchangePhyState.cur_times = self._leftExchangePhyState.cur_times + reply.msg.item_cost
  else
    self._rightExchangePhyState.cur_times = self._rightExchangePhyState.cur_times + 1
  end
  return res
end

function ShopModule:ApplySkinMarketData(TT)
  GameGlobal.GameLogic():GetModule(PayModule):RequestGetBalanceNormal()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplySkinMarketData)
  local reply = self:Call(TT, request)
  local res = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SHOP_CODE.SHOP_SUCCESS then
    self._SkinMarketData = reply.msg.data
    self._skinMarketConfig = reply.msg.market_config
    self._new_mark_skins = reply.msg.new_mark_goods
  end
  return res
end

function ShopModule:GetSkinsMarketData()
  return self._SkinMarketData, self._skinMarketConfig, self._new_mark_skins
end

function ShopModule:CEventBuyPetSkin(TT, goods_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventBuyPetSkin)
  request.goods_id = goods_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  return res
end

function ShopModule:ShowMonthCardRedPoint()
  if self._monthCardInfoList and self._market_config then
    local goodsInfo = self._monthCardInfoList[1]
    if goodsInfo then
      local id = goodsInfo.gift_id
      local cfgServer = self._market_config[id]
      local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
      if cfgServer and cfgClient and cfgClient.GiftType == ShopGiftType.SGT_MonthCard then
        return self:_CheckMonthCardRedAndTips(goodsInfo)
      end
    end
    return false, false, 0
  end
  if not self._initMonthCardData or not self._initMaketConfig then
    return false, 0
  end
  for key, value in pairs(self._initMonthCardData.goods) do
    local id = value.gift_id
    local cfgv = self._initMaketConfig[id]
    local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
    if cfgv and cfgClient then
      local strShopGiftType = cfgv[ConfigKey.ConfigKey_ShopGiftType]
      local isMonthCard = tonumber(strShopGiftType) == ShopGiftType.SGT_MonthCard
      if isMonthCard then
        return self:_CheckMonthCardRedAndTips(value)
      end
    end
  end
  return false, false, 0
end

function ShopModule:GetGoodsPrice(marketType, goodsID)
  local mPay = GameGlobal.GetModule(PayModule)
  local goodPriceList = mPay:GetGoodPriceList()
  if marketType == MarketType.Shop_GiftMarket then
    if self._giftMarketData and self._giftMarketConfig then
      for _, value in pairs(self._giftMarketData.goods) do
        local goodsInfo = value
        local id = goodsInfo.gift_id
        if id == goodsID then
          local cfgServer = self._giftMarketConfig[id]
          local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
          if cfgServer and cfgClient then
            if goodPriceList[cfgServer[ConfigKey.ConfigKey_MidasItemId]] then
              return goodPriceList[cfgServer[ConfigKey.ConfigKey_MidasItemId]].price
            else
              Log.error("###[ShopModule] lxs 价格列表里没有这个mdsid：", ConfigKey.ConfigKey_MidasItemId)
              return cfgServer[ConfigKey.ConfigKey_NowPrice]
            end
          end
        end
      end
    end
  elseif marketType == MarketType.Shop_SkinMarket and self._SkinMarketData and self._skinMarketConfig then
    for _, value in pairs(self._SkinMarketData) do
      local goodsInfo = value
      local id = goodsInfo.goodid
      if id == goodsID then
        local cfgServer = self._giftMarketConfig[id]
        local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
        if cfgServer and cfgClient then
          if goodPriceList[cfgServer[ConfigKey.ConfigKey_MidasItemId]] then
            return goodPriceList[cfgServer[ConfigKey.ConfigKey_MidasItemId]].price
          else
            Log.error("###[ShopModule] lxs 价格列表里没有这个mdsid：", ConfigKey.ConfigKey_MidasItemId)
            return cfgServer[ConfigKey.ConfigKey_NowPrice]
          end
        end
      end
    end
  end
  return 0
end

function ShopModule:_CheckMonthCardRedAndTips(monthCard)
  local state = self:GetMonthCardState(monthCard)
  local redKey, tipsKey
  if state == 2 then
    redKey = self:GetMonthCardWillOutDataRedKey(monthCard)
    tipsKey = self:GetMonthCardWillOutDataTipsKey(monthCard)
  elseif state == 3 then
    redKey = self:GetMonthCardOutDataRedKey(monthCard)
    tipsKey = self:GetMonthCardOutDataTipsKey(monthCard)
  else
    return false, false, state
  end
  local isRed = LocalDB.GetInt(redKey) == 0
  local isTips = LocalDB.GetInt(tipsKey) == 0
  return isRed, isTips, state
end

function ShopModule:_RefreshGiftMarketData()
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = self:ApplyGiftMarketData(TT)
    if res and res:GetSucc() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckMonthCardRedpoint)
    end
  end)
end

function ShopModule:CEventTakeFurnitureReward(TT, shop_id, goods_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTakeFurnitureReward)
  request.shop_id = shop_id
  request.goods_id = goods_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.SHOP_SUCCESS then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  return res
end

function ShopModule:CancelNewMark(marketType, goods_id)
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventCancelGoodNewMark)
  msg.market_type = marketType
  msg.goods_id = goods_id
  self:Push(msg)
end

function ShopModule:GetHomelandShopLocalRecord(key, defaultValue)
  key = "HomelandShopLocalRecord" .. key
  local loginModule = GameGlobal.GetModule(LoginModule)
  return LocalDB.GetInt(key .. loginModule:GetRoleShowID(), defaultValue)
end

function ShopModule:SetHomelandShopLocalRecord(key, value)
  key = "HomelandShopLocalRecord" .. key
  local loginModule = GameGlobal.GetModule(LoginModule)
  LocalDB.SetInt(key .. loginModule:GetRoleShowID(), value)
end

function ShopModule:GetHomelandShopTabNew()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_SHOP_ARC_UI)
  if not unlock then
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local srvTime = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(srvTime:GetServerTime() * 0.001)
  local t = {}
  local cfg = Cfg.cfg_shop_furniture_goods()
  for _, value in pairs(cfg) do
    if value.FurnitureType == FurnitureShopType.FRN_Set and not table.icontains(t, value.BelongShopId) then
      table.insert(t, value.BelongShopId)
      local beginTime = loginModule:GetTimeStampByTimeStr(value.ShowBeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      local endTime = loginModule:GetTimeStampByTimeStr(value.ShowEndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if curTime >= beginTime and curTime < endTime then
        local record = self:GetHomelandShopLocalRecord(value.BelongShopId, 0)
        if record <= 0 then
          return true
        end
      end
    end
  end
  return false
end

function ShopModule:FakeMidasProvide(TT, gift_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventFakeMidasProvide)
  request.goods_midas_id = gift_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return false
  end
  return true, reply.msg.ret
end

function ShopModule:GetHomelandRechargeTabNew()
  if not self._giftMarketData or not self._giftMarketConfig then
    return false
  end
  local newList = {}
  local serGoods = self._giftMarketData.goods
  local rechargeList = {}
  local loginModule = GameGlobal.GetModule(LoginModule)
  local srvTime = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(srvTime:GetServerTime() * 0.001)
  for i, good in ipairs(serGoods) do
    local id = good.gift_id
    local cfgv = self._giftMarketConfig[id]
    local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
    if cfgv and cfgClient then
      local strShopGiftType = cfgv[ConfigKey.ConfigKey_ShopGiftType]
      if tonumber(strShopGiftType) == ShopGiftType.SGT_RechargeGift and good.selled_num == 0 then
        local beginTime = loginModule:GetTimeStampByTimeStr(cfgClient.ShowBeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
        local endTime = loginModule:GetTimeStampByTimeStr(cfgClient.ShowEndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
        if curTime >= beginTime and curTime < endTime then
          table.insert(rechargeList, id)
        end
      end
    end
  end
  for i = 1, #rechargeList do
    local key = "UIShopGiftPackItem" .. self:GetNewFlagKey(rechargeList[i])
    if LocalDB.GetInt(key, 0) == 0 then
      table.insert(newList, rechargeList[i])
    end
  end
  return 0 < #newList, newList
end

function ShopModule:GetExchangeTabNew()
  return false
end

function ShopModule:GetExchangeTab_SeasonNew()
  local cfgs = Cfg.cfg_shop_season_goods({})
  local activeCfgs = {}
  local loginModule = GameGlobal.GetModule(LoginModule)
  local serverTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local serverTime = serverTimeModule:GetServerTime() * 0.001
  if cfgs and next(cfgs) then
    for key, value in pairs(cfgs) do
      local beginTimeStr = value.BeginTime
      local endTimeStr = value.EndTime
      local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      local beginTime = loginModule:GetTimeStampByTimeStr(beginTimeStr, timeType)
      local endTime = loginModule:GetTimeStampByTimeStr(endTimeStr, timeType)
      if serverTime >= beginTime and beginTime < endTime then
        table.insert(activeCfgs, value.ID)
      end
    end
  end
  if activeCfgs and next(activeCfgs) then
    local idList = self:Exchange_Season_Local_IDList()
    for idx, id in pairs(activeCfgs) do
      if table.icontains(idList, id) then
      else
        Log.debug("###[ShopModule] 赛季商店有新上架的商品，id:", id)
        return true
      end
    end
  end
  return false
end

function ShopModule:Exchange_Season_Local_Key()
  local pstid = GameGlobal.GetModule(RoleModule):GetPstId()
  local key = "ExchangeSeasonShop" .. pstid
  return key
end

function ShopModule:Exchange_Season_Local_IDList()
  local key = self:Exchange_Season_Local_Key()
  local lastID_str = LocalDB.GetString(key, "")
  local idList = {}
  if not string.isnullorempty(lastID_str) then
    local idStrList = string.split(lastID_str, ",")
    if idStrList and next(idStrList) then
      for index, isStr in ipairs(idStrList) do
        table.insert(idList, tonumber(isStr))
      end
    end
  end
  return idList
end

function ShopModule:ClearExchangeTab_SeasonNew()
  local cfgs = Cfg.cfg_shop_season_goods({})
  local activeCfgs = {}
  local loginModule = GameGlobal.GetModule(LoginModule)
  local serverTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local serverTime = serverTimeModule:GetServerTime() * 0.001
  if cfgs and next(cfgs) then
    for key, value in pairs(cfgs) do
      local beginTimeStr = value.BeginTime
      local endTimeStr = value.EndTime
      local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      local beginTime = loginModule:GetTimeStampByTimeStr(beginTimeStr, timeType)
      local endTime = loginModule:GetTimeStampByTimeStr(endTimeStr, timeType)
      if serverTime >= beginTime and beginTime < endTime then
        table.insert(activeCfgs, value.ID)
      end
    end
  end
  local idList = self:Exchange_Season_Local_IDList()
  local saveMap = {}
  for _, id in pairs(idList) do
    saveMap[id] = true
  end
  if activeCfgs and next(activeCfgs) then
    for _, id in pairs(activeCfgs) do
      saveMap[id] = true
    end
  end
  if saveMap and table.count(saveMap) > 0 then
    local saveVal = ""
    for id, value in pairs(saveMap) do
      saveVal = saveVal .. tostring(id) .. ","
    end
    if not string.isnullorempty(saveVal) then
      local key = self:Exchange_Season_Local_Key()
      LocalDB.SetString(key, saveVal)
    end
  end
end

function ShopModule:CancelRechargeGiftNewMark(goods_id)
  local key = "UIShopGiftPackItem" .. self:GetNewFlagKey(goods_id)
  LocalDB.SetInt(key, 1)
end

function ShopModule:GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function ShopModule:GetMonthCardOutDataRedKey(monthCardData)
  local stamp = monthCardData.deadline_timestamp
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "mcd_out_data_red" .. stamp
  return key
end

function ShopModule:GetMonthCardOutDataTipsKey(monthCardData)
  local stamp = monthCardData.deadline_timestamp
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "mcd_out_data_tips" .. stamp
  return key
end

function ShopModule:GetMonthCardWillOutDataRedKey(monthCardData)
  local stamp = monthCardData.deadline_timestamp
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "mcd_will_out_data_red" .. stamp
  return key
end

function ShopModule:GetMonthCardWillOutDataTipsKey(monthCardData)
  local stamp = monthCardData.deadline_timestamp
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "mcd_will_out_data_tips1" .. stamp
  return key
end

function ShopModule:GetMonthCardState(monthCardData)
  local stamp = monthCardData.deadline_timestamp
  if stamp == 0 then
    return 0
  end
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local d, h, m, s = UICommonHelper.S2DHMS(monthCardData.deadline_time)
  local leftDays = math.ceil(d)
  if leftDays == 1 then
    return 2
  end
  if leftDays <= 0 then
    local limit = Cfg.cfg_global.MonthCardOutDateLimit.IntValue
    if limit < nowTimestamp - stamp then
      return 0
    else
      return 3
    end
  end
  return 1
end

function ShopModule:GetRechargeTabNew()
  if not self._giftMarketData or not self._giftMarketConfig then
    return false
  end
  local newList = {}
  local serGoods = self._giftMarketData.goods
  local rechargeList = {}
  for i, good in ipairs(serGoods) do
    local id = good.gift_id
    local cfgv = self._giftMarketConfig[id]
    local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
    if cfgv and cfgClient then
      local strShopGiftType = cfgv[ConfigKey.ConfigKey_ShopGiftType]
      if tonumber(strShopGiftType) == ShopGiftType.SGT_RechargeGift then
        table.insert(rechargeList, id)
      end
    end
  end
  for i = 1, #rechargeList do
    local key = "UIShopGiftPackItem" .. self:GetNewFlagKey(rechargeList[i])
    if LocalDB.GetInt(key, 0) == 0 then
      table.insert(newList, rechargeList[i])
    end
  end
  return 0 < #newList, newList
end

function ShopModule:GetSecretTabNew()
  local isNew = false
  isNew = self:GetAllBattlePassTabNew()
  isNew = isNew or self:GetExchangeTab_SeasonNew()
  return isNew
end

function ShopModule:GetAllBattlePassTabNew()
  local isNew = false
  for i, v in pairs(BattlePassMarketType) do
    isNew = self:GetBattlePassTabNew(v)
    if isNew then
      break
    end
  end
  return isNew
end

function ShopModule:GetBattlePassTabNew(nestSuIndex)
  for id, cfg in pairs(Cfg.cfg_shop_battlepass_goods()) do
    local payState = {
      [BattlePassMarketType.Shop_BattlePass_Pay] = 1,
      [BattlePassMarketType.Shop_BattlePass_Free] = 0
    }
    if payState[nestSuIndex] == cfg.PayType then
      local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
      local loginModule = GameGlobal.GetModule(LoginModule)
      local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
      local beginTime = loginModule:GetTimeStampByTimeStr(cfg.BeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      local endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if beginTime and curTime > beginTime and endTime and curTime < endTime then
        local itemId = cfg.ItemId
        local itemModule = GameGlobal.GetModule(ItemModule)
        local itemCount = itemModule:GetItemCount(itemId)
        local canBuyBackGroud = Cfg.cfg_item[itemId].ItemSubType == ItemSubType.ItemSubType_BackGroudPicture and itemCount == 0
        local haveSkin = false
        if itemId >= RoleAssetID.RoleAssetPetSkinBegin and itemId <= RoleAssetID.RoleAssetPetSkinEnd then
          local skinid = itemId - RoleAssetID.RoleAssetPetSkinBegin
          local petModule = GameGlobal.GetModule(PetModule)
          haveSkin = petModule:HaveSkin(skinid)
        end
        if (Cfg.cfg_item[itemId].ItemSubType ~= ItemSubType.ItemSubType_BackGroudPicture or canBuyBackGroud) and not haveSkin then
          local key = "UIShoBattlePassGood" .. self:GetNewFlagKey(cfg.ID)
          if LocalDB.GetInt(key, 0) == 0 then
            return true
          end
        end
      end
    end
  end
  return false
end

function ShopModule:SetBattlePassTabNew(goodId)
  local key = "UIShoBattlePassGood" .. self:GetNewFlagKey(goodId)
  LocalDB.SetInt(key, 1)
end
