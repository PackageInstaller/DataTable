_class("ExchangeShopData", Object)
ExchangeShopData = ExchangeShopData

function ExchangeShopData:Constructor()
  self._shopGoods = {
    [MarketType.Shop_XingZuan] = {},
    [MarketType.Shop_HuiYao] = {},
    [MarketType.Shop_GuangPo] = {},
    [MarketType.Shop_HongPiao] = {},
    [MarketType.Shop_Season] = {},
    [MarketType.Shop_BlackMarket] = {}
  }
  self.maxCount = 999
  self.costType = RoleAssetID.RoleAssetGlow
  self.refreshTime = {}
  self.today_refreshed_count = 0
end

function ExchangeShopData:SetData()
end

function ExchangeShopData:GetGoods(shopType)
  return self._shopGoods[shopType]
end

function ExchangeShopData:AddGoods(shop, goodsInfo, cfg)
  local data
  if shop == MarketType.Shop_BlackMarket then
    data = ExchangeShopBlackMarketGoods:New()
  else
    data = ExchangeShopGoods:New()
  end
  data:Refresh(goodsInfo, cfg)
  table.insert(self._shopGoods[shop], data)
end

function ExchangeShopData:RefreshData(shop)
  local module = GameGlobal.GetModule(ShopModule)
  local info, cfgs
  if shop == MarketType.Shop_XingZuan then
    info, cfgs, _ = module:GetXingzuanData()
    table.clear(self._shopGoods[MarketType.Shop_XingZuan])
  elseif shop == MarketType.Shop_HuiYao then
    info, cfgs, _ = module:GetHuiyaoData()
    table.clear(self._shopGoods[MarketType.Shop_HuiYao])
  elseif shop == MarketType.Shop_GuangPo then
    info, cfgs, _ = module:GetGlowData()
    table.clear(self._shopGoods[MarketType.Shop_GuangPo])
  elseif shop == MarketType.Shop_HongPiao then
    info, cfgs, _ = module:GetHongPiaoData()
    table.clear(self._shopGoods[MarketType.Shop_HongPiao])
  elseif shop == MarketType.Shop_Season then
    info, cfgs, _ = module:GetSeasonData()
    table.clear(self._shopGoods[MarketType.Shop_Season])
  elseif shop == MarketType.Shop_BlackMarket then
    info, cfgs, _ = module:ExchangeGetBlackMarketData()
    table.clear(self._shopGoods[MarketType.Shop_BlackMarket])
  end
  if info then
    for _, goods in pairs(info.goods) do
      local cfg = cfgs[goods.goods_id]
      self:AddGoods(shop, goods, cfg)
    end
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local now = math.floor(timeModule:GetServerTime() / 1000)
  self._refreshTime = now + module:GetExchangeRefreshTime()
  if info then
    self.today_refreshed_count = info.today_refreshed_count or 0
    self:SetRefreshInfo(info.cur_level_id)
  end
end

function ExchangeShopData:RefreshTime()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  return self._refreshTime - math.floor(timeModule:GetServerTime() / 1000)
end

function ExchangeShopData:SetRefreshInfo(shopLevelId)
  local cfg = Cfg.cfg_shop_level[shopLevelId]
  if cfg then
    local a = string.split(cfg.RefreshPrice, "|")
    self.maxCount = cfg.RefreshMax
    self.costType = cfg.RefreshCostType
    for index = 1, self.maxCount do
      local count = index
      local consume = tonumber(a[index] or a[#a])
      self.refreshTime[count] = consume
    end
  end
end

function ExchangeShopData:GetCurCount()
  return self.today_refreshed_count
end

function ExchangeShopData:GetMaxCount()
  return self.maxCount
end

function ExchangeShopData:GetCostType()
  return self.costType
end

function ExchangeShopData:GetConsume()
  local count = self.today_refreshed_count + 1
  if count > self.maxCount then
    count = self.maxCount
  end
  return self.refreshTime[count]
end

_class("ExchangeShopGoods", DShopSecretGoodBase)
ExchangeShopGoods = ExchangeShopGoods

function ExchangeShopGoods:ShowRemain()
  return true
end

function ExchangeShopGoods:IsUnLimit()
  return self.cfg[ConfigKey.ConfigKey_SaleNum] == SpecialNum.MysteryGoodsUnlimitedNum
end

function ExchangeShopGoods:GetSeasonSaleTag()
  local saleTag = self.cfg and self.cfg[ConfigKey.ConfigKey_SaleTag]
  if saleTag and saleTag == 1 then
    return 1
  end
  return 0
end

function ExchangeShopGoods:GrandPrize()
  local cfg = Cfg.cfg_shop_season_goods[self.goodId]
  if cfg then
    local grandPrize = cfg.GrandPrize
    return grandPrize and grandPrize == 1
  end
  return false
end

_class("ExchangeShopBlackMarketGoods", ExchangeShopGoods)
ExchangeShopBlackMarketGoods = ExchangeShopBlackMarketGoods

function ExchangeShopBlackMarketGoods:Refresh(goodinfo, goodconfig)
  ExchangeShopGoods.Refresh(self, goodinfo, goodconfig)
  if not self.cfg then
    Log.error("服务器传来的商品配置缺失 商品id：" .. tostring(self.goodId) .. " 防御..使用本地配置")
    self.localCfg = Cfg.cfg_shop_blackmarket_goods[self.goodId]
  end
end

function ExchangeShopBlackMarketGoods:GetSaleTag()
  local saleTag = self.cfg and self.cfg[ConfigKey.ConfigKey_SaleTag] or self.localCfg and self.localCfg.SaleTag or 0
  if saleTag == 1 then
    return 1
  elseif 0 < self.discount and self.discount < 100 then
    return self.discount
  elseif saleTag == 0 then
    return 0
  end
end

function ExchangeShopBlackMarketGoods:ShowRemain()
  return false
end

function ExchangeShopBlackMarketGoods:ShowSaleTag()
  return true
end

_class("ExchangeSeasonShopViewData", Object)
ExchangeSeasonShopViewData = ExchangeSeasonShopViewData

function ExchangeSeasonShopViewData:Constructor()
  self.sin = false
  self.list = {}
end

function ExchangeSeasonShopViewData:AddData(exchangeShopGoods)
  table.insert(self.list, exchangeShopGoods)
end
