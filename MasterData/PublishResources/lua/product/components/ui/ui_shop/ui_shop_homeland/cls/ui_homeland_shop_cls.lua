_class("HomelandShopData", Object)
HomelandShopData = HomelandShopData

function HomelandShopData:Constructor()
  self.allGoods = {}
  self.goodsSet = {}
end

function HomelandShopData:UpdateByServerData(marketType, marketInfo, cfgs, remainRefreshTime, needInit)
  if not marketInfo then
    Log.fatal("HomelandShopData marketInfo is nil.")
    return
  end
  if needInit then
    self.allGoods = {}
    self.goodsSet = {}
  end
  for _, goodsInfo in pairs(marketInfo.goods) do
    local cfgServer = cfgs[goodsInfo.goods_id]
    local cfgClient
    if marketType == MarketType.Shop_Furniture then
      cfgClient = Cfg.cfg_shop_furniture_goods[goodsInfo.goods_id]
    elseif marketType == MarketType.Shop_Furniture_Precious then
      cfgClient = Cfg.cfg_shop_furniture_precious_goods[goodsInfo.goods_id]
    end
    if cfgServer and cfgClient then
      local shopItem = HomelandShopItem:New(marketType, cfgClient, goodsInfo)
      if not self.goodsSet[marketType] then
        self.goodsSet[marketType] = {}
      end
      if not self.goodsSet[marketType][cfgClient.FurnitureType] then
        self.goodsSet[marketType][cfgClient.FurnitureType] = {}
      end
      if not self.goodsSet[marketType][cfgClient.FurnitureType][cfgClient.BelongShopId] then
        self.goodsSet[marketType][cfgClient.FurnitureType][cfgClient.BelongShopId] = {}
      end
      table.insert(self.goodsSet[marketType][cfgClient.FurnitureType][cfgClient.BelongShopId], shopItem)
      table.insert(self.allGoods, shopItem)
    else
      Log.fatal("HomelandShopData Not Exist. marketType, id, ", marketType, goodsInfo.goods_id)
    end
  end
  self.remainRefreshTime = remainRefreshTime
end

function HomelandShopData:GetGoodsByGoodsId(id)
  for _, goods in ipairs(self.allGoods) do
    if goods.goodsID == id then
      return goods
    end
  end
end

function HomelandShopData:IsEmpty()
  for _, goods in ipairs(self.allGoods) do
    if not goods:OutOfDate() then
      return false
    end
  end
  return true
end

_class("HomelandShopItem", Object)
HomelandShopItem = HomelandShopItem

function HomelandShopItem:Constructor(marketType, cfgClient, goodsInfo)
  self.marketType = marketType
  self.cfg = cfgClient
  self.itemCfg = Cfg.cfg_item[self.cfg.ItemId]
  if not self.itemCfg then
    Log.fatal("HomelandShopData cfg_item not exist. id = ", self.cfg.ItemId)
  end
  self.itemID = self.itemCfg.ID
  self.goodsID = self.cfg.ID
  self.goodsCount = self.cfg.ItemCount
  self.saleNum = self.cfg.SaleNum
  self.selledCount = goodsInfo.selled_num
  self.isSpecial = self.cfg.IsSpecial
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self.beginTime = self._loginModule:GetTimeStampByTimeStr(self.cfg.ShowBeginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self.endTime = self._loginModule:GetTimeStampByTimeStr(self.cfg.ShowEndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  self.discountStartTime = 0
  if self.cfg.DiscountStartDate then
    self.discountStartTime = self._loginModule:GetTimeStampByTimeStr(self.cfg.DiscountStartDate, Enum_DateTimeZoneType.E_ZoneType_GMT)
  end
  self.discountDeadTime = 0
  if self.cfg.DiscountDeadDate then
    self.discountDeadTime = self._loginModule:GetTimeStampByTimeStr(self.cfg.DiscountDeadDate, Enum_DateTimeZoneType.E_ZoneType_GMT)
  end
  self.sequenceID = cfgClient.SequenceId
end

function HomelandShopItem:IsPet()
  return Cfg.cfg_pet[self.itemID] ~= nil
end

function HomelandShopItem:GetItemId()
  return self.itemID
end

function HomelandShopItem:GetSaleType()
  return self.cfg.SaleType
end

function HomelandShopItem:GetSalePrice()
  if self:IsDiscount() then
    return self.cfg.NewPrice
  else
    return self.cfg.RawPrice
  end
end

function HomelandShopItem:GetItemCount()
  return self.goodsCount
end

function HomelandShopItem:IsUnLimit()
  return self.saleNum == 888888888
end

function HomelandShopItem:GetGoodId()
  return self.goodsID
end

function HomelandShopItem:GetRemainCount()
  if self:IsSelling() then
    return self.saleNum - self.selledCount
  end
  return 0
end

function HomelandShopItem:IsSelling()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  return curTime >= self.beginTime and curTime < self.endTime
end

function HomelandShopItem:IsDiscount()
  if not self:IsSelling() then
    return false
  end
  if self.cfg.RawPrice == self.cfg.NewPrice then
    return false
  end
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  return curTime >= self.discountStartTime and curTime < self.discountDeadTime
end

function HomelandShopItem:IsSellOut()
  return self:IsSelling() and self.selledCount >= self.saleNum
end

function HomelandShopItem:OutOfDate()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  return curTime < self.beginTime or curTime > self.endTime
end

_class("HomelandShopItemSet", Object)
HomelandShopItemSet = HomelandShopItemSet

function HomelandShopItemSet:Constructor(shopType, shopID, goods)
  self.shopType = shopType
  self.shopID = shopID
  self.goods = goods
  self.cfg = nil
  self.sequenceID = 0
  local cfg = Cfg.cfg_shop_furniture_goods_ext({ShopId = shopID})
  if cfg then
    self.cfg = cfg[1]
    self.sequenceID = cfg[1].SequenceId
  else
    Log.fatal("HomelandShopData cfg_shop_furniture_goods_ext not exist. ShopID = ", shopID)
  end
  self:Sort(self.goods)
end

function HomelandShopItemSet:IsDiscount()
  return self.cfg and self.cfg.IsPromotion
end

function HomelandShopItemSet:GetAllGoodsCount()
  local totalCount = 0
  for _, goods in pairs(self.goods) do
    if goods:IsSelling() then
      totalCount = totalCount + goods.goodsCount
    end
  end
  return totalCount
end

function HomelandShopItemSet:GetSelledCount()
  local selledCount = 0
  if self.goods then
    for _, goods in pairs(self.goods) do
      if goods:IsSelling() then
        selledCount = selledCount + goods.selledCount
      end
    end
  end
  return selledCount
end

function HomelandShopItemSet:UpdateGoods(goods)
  for key, value in pairs(self.goods) do
    if value.goodsID == goods.goodsID then
      self.goods[key] = goods
      break
    end
  end
  if goods:IsSellOut() then
    self:Sort(self.goods)
  end
end

function HomelandShopItemSet:Sort(goods)
  table.sort(goods, function(a, b)
    local a1 = 0
    local b1 = 0
    if a:IsSellOut() then
      a1 = 1
    end
    if b:IsSellOut() then
      b1 = 1
    end
    if a1 ~= b1 then
      return a1 < b1
    end
    return a.sequenceID < b.sequenceID
  end)
end
