_class("DShopSecretStoreBase", Object)
DShopSecretStoreBase = DShopSecretStoreBase

function DShopSecretStoreBase:Constructor(subTabType)
  self.SubTabType2Class = {
    [MarketType.Shop_BlackMarket] = DShopBlackGood,
    [MarketType.Shop_MysteryMarket] = DShopSecretExploreGood,
    [MarketType.Shop_WorldBoss] = DShopWorldBossGood,
    [MarketType.Shop_BattlePass] = DShopBattlePassGood,
    [MarketType.Shop_Season] = DShopSeasonGood
  }
  self.subTabType = subTabType
  self.goods = {}
  self.newGoods = {}
  self.remainSecond = 0
  self.maxCount = 999
  self.costType = RoleAssetID.RoleAssetGlow
  self.refreshTime = {}
  self.today_refreshed_count = 0
end

function DShopSecretStoreBase:SetRefreshInfo(shopLevelId)
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

function DShopSecretStoreBase:SetData(marketinfo, goodsconfig)
  self.goods = {}
  if marketinfo.goods ~= nil then
    for _, goodinfo in ipairs(marketinfo.goods) do
      self:AddGood(goodinfo, goodsconfig[goodinfo.goods_id])
    end
  end
  self.today_refreshed_count = marketinfo.today_refreshed_count or 0
  if marketinfo.new_mark_goods ~= nil then
    for _, newgood in ipairs(marketinfo.new_mark_goods) do
      self.newGoods[newgood] = 0
    end
  end
  self:SetRefreshInfo(marketinfo.cur_level_id)
end

function DShopSecretStoreBase:ReSortSecretGoods(targetShopIds)
  if targetShopIds == nil then
    return
  end
  local appendArr = {}
  for i = #self.goods, 1, -1 do
    if table.iskey(targetShopIds, self.goods[i]:GetGoodId()) then
      table.insert(appendArr, self.goods[i])
      table.remove(self.goods, i)
    end
  end
  table.appendArray(appendArr, self.goods)
  self.goods = appendArr
end

function DShopSecretStoreBase:GetSecretGoods()
  return self.goods
end

function DShopSecretStoreBase:AddGood(goodinfo, goodconfig)
  local good = self.SubTabType2Class[self.subTabType]:New()
  table.insert(self.goods, good)
  good:Refresh(goodinfo, goodconfig)
end

function DShopSecretStoreBase:GetGood(goodId)
  for index, value in ipairs(self.goods) do
    if value:GetGoodId() == goodId then
      return value
    end
  end
  return nil
end

function DShopSecretStoreBase:SortSecretGoods(targetShopIds, nestType, buyState)
  if targetShopIds == MarketType.Shop_BattlePass then
    local remainGood = {}
    local notRemainGood = {}
    for _, good in ipairs(self.goods) do
      local itemId = good.cfg[ConfigKey.ConfigKey_ItemId]
      local goodCfg = Cfg.cfg_shop_battlepass_goods[good.goodId]
      local payState = {
        [BattlePassMarketType.Shop_BattlePass_Pay] = 1,
        [BattlePassMarketType.Shop_BattlePass_Free] = 0
      }
      if payState[nestType] == goodCfg.PayType then
        local itemModule = GameGlobal.GetModule(ItemModule)
        local itemCount = itemModule:GetItemCount(itemId)
        local canBuyBackGroud = Cfg.cfg_item[itemId].ItemSubType == ItemSubType.ItemSubType_BackGroudPicture and itemCount == 0
        if Cfg.cfg_item[itemId].ItemSubType ~= ItemSubType.ItemSubType_BackGroudPicture or canBuyBackGroud then
          if 0 < good.remainNum and good.cfg[ConfigKey.ConfigKey_BattleType] <= buyState + 1 then
            table.insert(remainGood, good)
          else
            table.insert(notRemainGood, good)
          end
        end
      end
    end
    table.sort(remainGood, function(a, b)
      if a.cfg[ConfigKey.ConfigKey_BattleType] ~= b.cfg[ConfigKey.ConfigKey_BattleType] then
        return a.cfg[ConfigKey.ConfigKey_BattleType] > b.cfg[ConfigKey.ConfigKey_BattleType]
      end
      return a.goodId < b.goodId
    end)
    table.sort(notRemainGood, function(a, b)
      if a.cfg[ConfigKey.ConfigKey_BattleType] ~= b.cfg[ConfigKey.ConfigKey_BattleType] then
        return a.cfg[ConfigKey.ConfigKey_BattleType] > b.cfg[ConfigKey.ConfigKey_BattleType]
      end
      return a.goodId < b.goodId
    end)
    table.move(notRemainGood, 1, #notRemainGood, #remainGood + 1, remainGood)
    self.goods = remainGood
  end
  return self.goods
end

function DShopSecretStoreBase:SetRemainSecond(remainSecond)
  self.remainSecond = remainSecond
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local now = timeModule:GetServerTime() / 1000
  self._refreshTime = now + remainSecond
end

function DShopSecretStoreBase:GetRemainSecond()
  if not self._refreshTime then
    return nil
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local now = timeModule:GetServerTime() / 1000
  return self._refreshTime - now
end

function DShopSecretStoreBase:GetCurCount()
  return self.today_refreshed_count
end

function DShopSecretStoreBase:GetMaxCount()
  return self.maxCount
end

function DShopSecretStoreBase:GetCostType()
  return self.costType
end

function DShopSecretStoreBase:GetConsume()
  local count = self.today_refreshed_count + 1
  if count > self.maxCount then
    count = self.maxCount
  end
  return self.refreshTime[count]
end
