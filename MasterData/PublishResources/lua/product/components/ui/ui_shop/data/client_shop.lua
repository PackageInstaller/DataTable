_class("ClientShop", Object)
ClientShop = ClientShop
_enum("ShopOpenWay", ShopOpenWay)
local ShopMainTabType = {
  Recommend = 1,
  Secret = 2,
  Exchange = 3,
  Recharge = 4,
  Gift = 5,
  Skins = 6,
  Homeland = 7,
  FlashSale = 8,
  SailingPlan = 9,
  MonthCard = 10
}
_enum("ShopMainTabType", ShopMainTabType)
local ShopGotoType = {
  OpenShopConfirm = 0,
  SortGoods = 1,
  OpenTab = 2
}
_enum("ShopGotoType", ShopGotoType)

function ClientShop:Constructor()
  self.SecretSubTabType2Class = {
    [MarketType.Shop_BlackMarket] = DShopBlackStore,
    [MarketType.Shop_MysteryMarket] = DShopSecretExplore,
    [MarketType.Shop_WorldBoss] = DShopWorldBossStore,
    [MarketType.Shop_BattlePass] = DShopBattlePassStore,
    [MarketType.Shop_Season] = DShopSeason
  }
  self:InitMainTabConfig()
  self:InitSecretTabInfo()
  self._exchangeShopData = ExchangeShopData:New()
  self._rechargeShopData = RechargeShopData:New()
  self._giftPackShopData = GiftPackShopData:New()
  self._skinsShopData = SkinsShopData:New()
  self._homelandShopData = HomelandShopData:New()
  self._flashSaleShopData = FlashSaleShopData:New()
end

function ClientShop:InitMainTabConfig()
  self.m_ShopMainTabData = {}
  local datas = Cfg.cfg_shop_main_tab({})
  for id, cfg in ipairs(datas) do
    if cfg.MainTab == ShopMainTabType.Secret or cfg.MainTab == ShopMainTabType.Exchange or cfg.MainTab == ShopMainTabType.Homeland then
      local s = DShopMainTab:New(cfg, #self.m_ShopMainTabData + 1)
      table.insert(self.m_ShopMainTabData, s)
    end
  end
end

function ClientShop:RemoveMainType(shopMainTabType)
  local tempMainTabs = {}
  for _, value in pairs(self.m_ShopMainTabData) do
    if value:GetMainTab() ~= shopMainTabType then
      table.insert(tempMainTabs, value)
    end
  end
  self.m_ShopMainTabData = tempMainTabs
end

function ClientShop:InsertMainType(shopMainTabType, componentID)
  local cfg = Cfg.cfg_shop_main_tab({MainTab = shopMainTabType})
  if cfg and cfg[1] then
    local mainTab = DShopMainTab:New(cfg[1], #self.m_ShopMainTabData + 1, componentID)
    table.insert(self.m_ShopMainTabData, mainTab)
  end
end

function ClientShop:ResetUniqueid()
  for i = 1, #self.m_ShopMainTabData do
    self.m_ShopMainTabData[i]:SetUniqueid(i)
  end
end

function ClientShop:SetRecommendConfig(idDic)
  local hasSkinsAdBefore = self:CheckRecommendDataHasMarketType(MarketType.Shop_SkinMarket)
  self.m_ShopRecommendData = {}
  local tmpDic = {}
  for key, value in pairs(idDic) do
    local cfg_recommend = Cfg.cfg_shop_recommend_ad[value]
    if not cfg_recommend then
      Log.error("###[ClientShop] cfg_shop_recommend_ad is nil ! id : ", value)
    end
    local group = cfg_recommend.Group
    if not tmpDic[group] then
      tmpDic[group] = {}
    end
    tmpDic[group][#tmpDic[group] + 1] = value
  end
  for key, value in pairs(tmpDic) do
    local cls = UIShopRecommendGroupCls:New(key, value)
    table.insert(self.m_ShopRecommendData, cls)
  end
  table.sort(self.m_ShopRecommendData, function(a, b)
    return a.group < b.group
  end)
  local hasSkinsAdNow = self:CheckRecommendDataHasMarketType(MarketType.Shop_SkinMarket)
  if not hasSkinsAdBefore and hasSkinsAdNow then
    Log.debug("[Shop] recommend now has skins ad,refresh skin btn")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceShowMainTabBtn, ShopMainTabType.Skins)
  end
  if not next(self.m_ShopRecommendData) then
    Log.error("###[ClientShop] m_ShopRecommendData is nil !")
    for key, value in pairs(idDic) do
      Log.error("###[ClientShop] idDic value:", value)
    end
  end
end

function ClientShop:CheckRecommendDataHasMarketType(marketType)
  if not self.m_ShopRecommendData then
    return false
  end
  for index, value in ipairs(self.m_ShopRecommendData) do
    if value:CheckTabType(MarketType.Shop_SkinMarket) then
      return true
    end
  end
  return false
end

function ClientShop:GetMainTabDatas()
  return self.m_ShopMainTabData
end

function ClientShop:GetRecommendDatas()
  return self.m_ShopRecommendData
end

function ClientShop:InitSecretTabInfo()
  self.shopSecretTabData = {}
  for subTabType, value in pairs(self.SecretSubTabType2Class) do
    self.shopSecretTabData[subTabType] = value:New(subTabType)
  end
end

function ClientShop:SetSecretTabData(marketinfo, goodsconfig, subTabType)
  self.shopSecretTabData[subTabType]:SetData(marketinfo, goodsconfig)
end

function ClientShop:SetRemainTime(time, subType)
  self.shopSecretTabData[subType]:SetRemainSecond(time)
end

function ClientShop:ReSortSecretGoods(subTabType, targetShopIds)
  self.shopSecretTabData[subTabType]:ReSortSecretGoods(targetShopIds)
end

function ClientShop:GetSecretTabData(subTabType)
  return self.shopSecretTabData[subTabType]
end

function ClientShop:GetSecretGoods(subTabType)
  return self.shopSecretTabData[subTabType]:GetSecretGoods()
end

function ClientShop.OpenShop(...)
  GameGlobal.UIStateManager():ShowDialog("UIShopController", ...)
end

function ClientShop.CheckBuy(saleType, price)
  local result = true
  local roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  if saleType == RoleAssetID.RoleAssetGlow then
    local diamond = roleModule:GetGlow()
    if price > diamond then
      GameGlobal.UIStateManager():ShowDialog("UIShopCurrency1To2", price - diamond)
      ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
      result = false
    end
  elseif saleType == RoleAssetID.RoleAssetGold then
    local gold = roleModule:GetGold()
    if price > gold then
      ToastManager.ShowToast(StringTable.Get("str_shop_buy_no_gold"))
      result = false
    end
  elseif saleType == RoleAssetID.RoleAssetMazeCoin then
    local mazeCoin = roleModule:GetMazeCoin()
    if price > mazeCoin then
      ToastManager.ShowToast(StringTable.Get("str_shop_buy_no_maze"))
      result = false
    end
  end
  return result
end

function ClientShop.CheckShopCode(result)
  if result == SHOP_CODE.SHOP_SUCCESS then
    return true
  end
  if not ClientShop.ShopCode2Message then
    local get = StringTable.Get
    ClientShop.ShopCode2Message = {
      [SHOP_CODE.SHOP_CONFIG_ERROR] = get("str_shop_code_config_error"),
      [SHOP_CODE.SHOP_SERVER_RETURN_ERROR] = get("str_shop_code_server_return_error"),
      [SHOP_CODE.SHOP_GOODS_ID_ERROR] = get("str_shop_code_goods_id_error"),
      [SHOP_CODE.SHOP_GOODS_SELLED_OUT] = get("str_shop_code_goods_selled_out"),
      [SHOP_CODE.SHOP_ERROR_PRICE] = get("str_shop_code_error_price"),
      [SHOP_CODE.SHOP_DONNOT_HAVE_DISCOUNT] = get("str_shop_code_do_not_have_discount"),
      [SHOP_CODE.SHOP_ERROR_DISCOUNT] = get("str_shop_code_error_discount"),
      [SHOP_CODE.SHOP_CURRENCY_TYPE_ERROR] = get("str_shop_code_currency_type_error"),
      [SHOP_CODE.SHOP_CURRENCY_NOT_ENOUGH] = get("str_shop_code_currency_not_enough"),
      [SHOP_CODE.SHOP_AlREADY_PASSED_DOWN_LIMIT] = get("str_shop_code_not_being_sold"),
      [SHOP_CODE.SHOP_BUY_COUNT_INVILID] = get("str_pay_bad_12"),
      [SHOP_CODE.SHOP_MIDAS_COST_ERROR] = get("str_pay_error_tips_relogin"),
      [SHOP_CODE.SHOP_BATTLEPASS_ERROE] = get("str_shop_bp_tips3"),
      [SHOP_CODE.SHOP_GIFT_MAX_DAY_LIMIT] = string.format(get("str_pay_month_card_max_day_count_cant_over_limit", GiftPackShopItem.GetMonthCardMaxDayNum()))
    }
  end
  local msg = ClientShop.ShopCode2Message[result] or string.format("Request Error. SHOP_CODE=%d", result)
  ToastManager.ShowToast(msg)
  return false
end

function ClientShop.GetCurrencyImageName(saleType)
  return Cfg.cfg_top_tips[saleType].Icon
end

function ClientShop.GetMoney(saleType)
  local roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  local money = 0
  if saleType == RoleAssetID.RoleAssetPhyPoint then
    money = roleModule:GetHealthPoint()
  elseif saleType == RoleAssetID.RoleAssetGlow then
    money = roleModule:GetGlow()
  elseif saleType == RoleAssetID.RoleAssetGold then
    money = roleModule:GetGold()
  elseif saleType == RoleAssetID.RoleAssetMazeCoin then
    money = roleModule:GetMazeCoin()
  elseif saleType == RoleAssetID.RoleAssetXingZuan then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetXingZuan)
  elseif saleType == RoleAssetID.RoleAssetHuiYao then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetHuiYao)
  elseif saleType == RoleAssetID.RoleAssetHongPiao then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetHongPiao)
  elseif saleType == RoleAssetID.RoleAssetFurnitureCoin then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetFurnitureCoin)
  elseif saleType == RoleAssetID.RoleAssetWorldBossCoin then
    money = roleModule:GetWorldBossCoin()
  elseif saleType == RoleAssetID.RoleAssetWorldBossCoin2 then
    money = roleModule:GetWorldBossCoin2()
  elseif saleType == RoleAssetID.RoleAssetHistory then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetHistory)
  elseif saleType == RoleAssetID.RoleAssetBPPay then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetBPPay)
  elseif saleType == RoleAssetID.RoleAssetBPFree then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetBPFree)
  elseif saleType == RoleAssetID.RoleAssetBPSkin then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetBPSkin)
  elseif saleType == RoleAssetID.RoleAssetBPFurniture then
    local itemMd = GameGlobal.GetModule(ItemModule)
    money = itemMd:GetItemCount(RoleAssetID.RoleAssetBPFurniture)
  else
    Log.error("!!!!!!!Unknown currency type,cant get money , type == " .. saleType)
  end
  return money
end

function ClientShop:SendProtocal(TT, mainTabType, subTabType, uniqueid)
  self.lastRequestMaintab = mainTabType
  local shopModule = GameGlobal.GameLogic():GetModule(ShopModule)
  if mainTabType == ShopMainTabType.Recommend then
    local idDic = shopModule:GetRecommendIds(TT)
    if next(idDic) and idDic ~= nil then
      self:SetRecommendConfig(idDic)
    end
    return idDic and next(idDic)
  elseif mainTabType == ShopMainTabType.Secret then
    if subTabType == MarketType.Shop_BlackMarket then
      local marketinfo, time = shopModule:GetBlackMarketData(TT)
      if next(marketinfo) and marketinfo ~= nil then
        local goodsconfig = shopModule:GetBlackMarketConfig()
        self:SetSecretTabData(marketinfo, goodsconfig, MarketType.Shop_BlackMarket)
        self:SetRemainTime(time, MarketType.Shop_BlackMarket)
      end
      return marketinfo and next(marketinfo)
    elseif subTabType == MarketType.Shop_MysteryMarket then
      local marketinfo, time = shopModule:GetMysteryMarketData(TT)
      if next(marketinfo) and marketinfo ~= nil then
        local goodsconfig = shopModule:GetMysteryMarketConfig()
        self:SetSecretTabData(marketinfo, goodsconfig, MarketType.Shop_MysteryMarket)
        self:SetRemainTime(time, MarketType.Shop_MysteryMarket)
      end
      return marketinfo and next(marketinfo)
    elseif subTabType == MarketType.Shop_WorldBoss then
      local marketinfo, time = shopModule:RequestWorldBossMarket(TT)
      if next(marketinfo) and marketinfo ~= nil then
        local goodsconfig = shopModule:GetWorldBossMarketConfig()
        self:SetSecretTabData(marketinfo, goodsconfig, MarketType.Shop_WorldBoss)
        self:SetRemainTime(time, MarketType.Shop_WorldBoss)
      end
      return marketinfo and next(marketinfo)
    elseif subTabType == MarketType.Shop_BattlePass then
      local marketinfo, time = shopModule:GetBattlePassMarketData(TT)
      if next(marketinfo) and marketinfo ~= nil then
        local goodsconfig = shopModule:GetBattlePassMarketConfig()
        self:SetSecretTabData(marketinfo, goodsconfig, MarketType.Shop_BattlePass)
        self:SetRemainTime(time, MarketType.Shop_BattlePass)
      end
      return marketinfo and next(marketinfo)
    elseif subTabType >= MarketType.Shop_CampaignMarket then
      return true
    elseif subTabType == MarketType.Shop_Season then
      local marketinfo, time = shopModule:GetSeasonMarketData(TT)
      if next(marketinfo) and marketinfo ~= nil then
        local goodsconfig = shopModule:GetSeasonMarketConfig()
        self:SetSecretTabData(marketinfo, goodsconfig, MarketType.Shop_Season)
        self:SetRemainTime(time, MarketType.Shop_Season)
      end
      return marketinfo and next(marketinfo)
    end
  elseif mainTabType == ShopMainTabType.Exchange then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateExchangeSeasonShop)
    return true
  elseif mainTabType == ShopMainTabType.Recharge then
    local res = shopModule:ApplyGiftMarketData(TT)
    if res and res:GetSucc() then
      local marketinfo, cfgGiftMarket = shopModule:GetGiftMarketData()
      self:GetGiftPackShopData():UpdateByServerData(marketinfo, cfgGiftMarket)
    end
    res = shopModule:ApplyPayMarketData(TT)
    if res and res:GetSucc() then
      GameGlobal.UAReportChannelEvent("OpenPurchase", {})
      local marketinfo, cfgRechargeMarket, monthCardInfoList, cfgGiftMarket = shopModule:GetPayMarketData()
      self:GetRechargeShopData():UpdateByServerData(TT, marketinfo, cfgRechargeMarket, monthCardInfoList, cfgGiftMarket)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateRechargeShop)
      return true
    end
  elseif mainTabType == ShopMainTabType.Gift then
    local res = shopModule:ApplyGiftMarketData(TT)
    if res and res:GetSucc() then
      local marketinfo, cfgGiftMarket = shopModule:GetGiftMarketData()
      self:GetGiftPackShopData():UpdateByServerData(marketinfo, cfgGiftMarket)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateGiftPackShop)
      return true
    end
  elseif mainTabType == ShopMainTabType.Skins then
    local res = shopModule:ApplySkinMarketData(TT)
    if res and res:GetSucc() then
      local marketinfo, cfgSkinsMarket, newSkins = shopModule:GetSkinsMarketData()
      self:GetSkinsShopData():UpdateByServerData(marketinfo, cfgSkinsMarket, newSkins)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateSkinsShop)
      return true
    end
  elseif mainTabType == ShopMainTabType.Homeland then
    local res = shopModule:RequestFurnitureMarket(TT)
    if res and res:GetSucc() then
      local marketData, marketConfig, refreshRemainTime = shopModule:GetFurnitureData()
      self:GetHomelandShopData():UpdateByServerData(MarketType.Shop_Furniture, marketData, marketConfig, refreshRemainTime, true)
    else
      return false
    end
    local preciousRes = shopModule:RequestFurniturePreciousMarket(TT)
    if preciousRes and preciousRes:GetSucc() then
      local precoousMarketData, precoousMarketConfig, precoousRefreshRemainTime = shopModule:GetFurniturePreciousData()
      self:GetHomelandShopData():UpdateByServerData(MarketType.Shop_Furniture_Precious, precoousMarketData, precoousMarketConfig, precoousRefreshRemainTime, false)
    else
      return false
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateHomelandShop)
    return true
  elseif mainTabType == ShopMainTabType.FlashSale then
    local res = shopModule:ApplyGiftMarketData(TT)
    if res and res:GetSucc() then
      local marketinfo, cfgGiftMarket = shopModule:GetGiftMarketData()
      self:GetFlashSaleShopData():UpdateByServerData(marketinfo, cfgGiftMarket)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateFlashSaleShop, uniqueid)
      return true
    end
  elseif mainTabType == ShopMainTabType.SailingPlan then
    return true
  elseif mainTabType == ShopMainTabType.MonthCard then
    local res = shopModule:ApplyPayMarketData(TT)
    if res and res:GetSucc() then
      local marketinfo, cfgRechargeMarket, monthCardInfoList, cfgGiftMarket = shopModule:GetPayMarketData()
      self:GetRechargeShopData():UpdateByServerData(TT, marketinfo, cfgRechargeMarket, monthCardInfoList, cfgGiftMarket)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateMonthCardShop)
      return true
    end
  else
    Log.fatal("No ShopMainType. ", mainTabType)
  end
  return false
end

function ClientShop:SendCampaign(TT, mainTabType, subTabType)
  if mainTabType ~= ShopMainTabType.Secret then
    return subTabType
  end
  local preCount = 0
  if self._shopCampaign ~= nil then
    preCount = #self._shopCampaign
  end
  self._shopCampaign = {}
  self._shopCampaignCfg = {}
  self._shopCampaignEnd = false
  local findSubTabType = false
  local res = AsyncRequestRes:New()
  local cfgSecret = Cfg.cfg_shop_main_tab({MainTab = mainTabType})[1]
  for k, v in pairs(cfgSecret.SubTab) do
    if v >= MarketType.Shop_CampaignMarket then
      local cfgTab = Cfg.cfg_shop_campaign_secret_tab[v]
      local aCampaign = UIActivityCampaign:New()
      aCampaign:LoadCampaignInfo(TT, res, cfgTab.CampaignType, cfgTab.ComponentID)
      if aCampaign:CheckCampaignOpen() then
        table.insert(self._shopCampaign, aCampaign)
        table.insert(self._shopCampaignCfg, cfgTab)
        findSubTabType = findSubTabType or subTabType == cfgTab.ID
      end
    end
  end
  local nxtCount = #self._shopCampaign
  self._shopCampaignEnd = preCount > nxtCount
  if subTabType ~= nil and not findSubTabType then
    subTabType = nil
  end
  if subTabType ~= nil then
    return subTabType
  elseif 0 < #self._shopCampaignCfg then
    return self._shopCampaignCfg[1].ID
  end
  return MarketType.Shop_BattlePass
end

function ClientShop:HaveShopCampaignEnd()
  return self._shopCampaignEnd
end

function ClientShop:GetSecretCampaign(subTabType)
  if subTabType ~= nil then
    for k, v in pairs(self._shopCampaignCfg) do
      if v.ID == subTabType then
        return self._shopCampaign[k], v
      end
    end
    return nil, nil
  end
  return self._shopCampaign, self._shopCampaignCfg
end

function ClientShop:GetRechargeShopData()
  return self._rechargeShopData
end

function ClientShop:GetGiftPackShopData()
  return self._giftPackShopData
end

function ClientShop:GetSkinsShopData()
  return self._skinsShopData
end

function ClientShop:GetHomelandShopData()
  return self._homelandShopData
end

function ClientShop:GetFlashSaleShopData()
  return self._flashSaleShopData
end

function ClientShop:OpenRechargeShop()
  ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
end

function ClientShop:CheckEnoughYJ(cost, bShowMsg, closeFunc)
  local mShop = GameGlobal.GetModule(ShopModule)
  local count1, freeCount1 = mShop:GetDiamondCount()
  if cost <= count1 then
    return true
  else
    ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
    return false
  end
  if bShowMsg then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_pay_yj_not_enough_goto_recharge"), function(param)
      self:OpenRechargeShop()
      if closeFunc then
        closeFunc()
      end
    end, nil, function(param)
    end, nil)
    return false
  else
    self:OpenRechargeShop()
    return false
  end
  return false
end

function ClientShop:CheckEnoughGP(cost)
  local mRole = GameGlobal.GetModule(RoleModule)
  local count = mRole:GetGlow()
  if cost <= count then
    return true
  end
  local diff = cost - count
  GameGlobal.UIStateManager():ShowDialog("UIShopCurrency1To2", diff)
  return false
end

function ClientShop:GetDiamondExchangeGlowRate()
  if self._DiamondExchangeGlowRate then
    return self._DiamondExchangeGlowRate
  end
  local cfgv = Cfg.cfg_shop_global[1]
  if cfgv then
    self._DiamondExchangeGlowRate = cfgv.DiamondExchangeGlowRate
    return self._DiamondExchangeGlowRate
  end
  return 1
end

function ClientShop:GetGlowExchangeFurnitureCoinRate()
  if self._GlowExchangeFurnitureCoinRate then
    return self._GlowExchangeFurnitureCoinRate
  end
  local cfgv = Cfg.cfg_shop_global[1]
  if cfgv then
    self._GlowExchangeFurnitureCoinRate = cfgv.GlowExchangeFurnitureCoinRate
    return self._GlowExchangeFurnitureCoinRate
  end
  return 1
end

function ClientShop.GetXBCfg(xbId)
  local mShop = GameGlobal.GetModule(ShopModule)
  local _, config = mShop:GetGlowData()
  for id, cfgv in pairs(config) do
    if cfgv[ConfigKey.ConfigKey_ItemId] == xbId then
      local cfgv = config[id]
      return cfgv, id
    end
  end
  Log.fatal("### get goodsid failed from cfg_shop_guangpo_goods.")
  return nil, 0
end

function ClientShop:GetNotShowLeftTime()
  if self._NotShowLeftTime then
    return self._NotShowLeftTime
  end
  local cfgv = Cfg.cfg_shop_global[1]
  if cfgv then
    self._NotShowLeftTime = tonumber(cfgv.NotShowLeftTime)
    return self._NotShowLeftTime
  end
  return 0
end

function ClientShop:GetExchangeShopStoreData()
  return self._exchangeShopData
end

function ClientShop:GetExchangeShopData(subShop)
  return self._exchangeShopData:GetGoods(subShop)
end

function ClientShop:RefreshExchangeShopData(subShop)
  return self._exchangeShopData:RefreshData(subShop)
end

function ClientShop:GetExchangeShopResetTime()
  return self._exchangeShopData:RefreshTime()
end

function ClientShop.PriceUnit()
  return ""
end
