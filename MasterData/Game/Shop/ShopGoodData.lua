local ShopGoodData = class("ShopGoodData")
local ShopUtil = require("Game.Shop.ShopUtil")
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ShopGoodData.IsUseful(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg ~= nil and itemCfg.type == eItemType.Skin then
    local isUnlock, isRecitify = PlayerDataCenter.skinData:IsSkinUnlocked(itemId)
    if isRecitify and isGameDev then
      warn("商店中有被和谐的皮肤出现, itemId为:" .. tostring(itemId))
    end
    return isUnlock
  end
  return true
end

function ShopGoodData.CreateShopGoodData(data, shopType, shopId)
  if not ShopGoodData.IsUseful(data.itemId) then
    return nil
  end
  local ShopGoodData = ShopGoodData.New()
  ShopGoodData:InitShopGoodData(data, shopType, shopId)
  return ShopGoodData
end

function ShopGoodData.CreateNewShopGoodData(goodCfg, shopType, shopId, purchases, hasDouble, historyPurchases, freshType)
  if not ShopGoodData.IsUseful(goodCfg.itemId) then
    return nil
  end
  local ShopGoodData = ShopGoodData.New()
  ShopGoodData:InitNewShopGoodData(goodCfg, shopType, shopId, purchases, hasDouble, historyPurchases, freshType)
  return ShopGoodData
end

function ShopGoodData:ctor()
  self.shopId = nil
  self.shelfId = nil
  self.itemId = nil
  self.itemCfg = nil
  self.itemNum = nil
  self.currencyId = nil
  self.oldCurrencyNum = 0
  self.newCurrencyNum = 0
  self.discount = nil
  self.isLimit = false
  self.limitType = ShopEnum.eLimitType.None
  self.isSoldOut = false
  self.purchases = nil
  self.limitTime = nil
  self.historyPurchases = nil
  self.totallimitTime = nil
  self.freshTm = nil
  self.isRecommendGood = nil
  self.order = math.mininteger
  self.pageId = nil
end

function ShopGoodData:InitShopGoodData(data, shopType, shopId)
  self.shopId = shopId
  self.shopType = shopType
  self.shelfId = data.shelfId
  self.itemId = data.itemId
  self.itemNum = data.itemNum
  local payType = data.payType
  self.discount = data.discount
  local FreshType = data.FreshType
  self.purchases = data.purchases
  self.freshTm = data.freshTm
  self.historyPurchases = data.historyPurchases
  local itemCfg = ConfigData.item[self.itemId]
  if itemCfg == nil then
    error("item cfg is null,id:" .. tostring(self.itemId))
  else
    self.itemCfg = itemCfg
    self:m_HandleCurrency(payType)
  end
  self:m_HandleDifferData(shopType, shopId, FreshType)
  if data.order ~= nil then
    self.order = data.order
  end
end

function ShopGoodData:InitNewShopGoodData(goodCfg, shopType, shopId, purchases, hasDouble, historyPurchases, freshType)
  self.shopId = shopId
  self.shopType = shopType
  self.shelfId = goodCfg.goods_shelves
  self.itemId = goodCfg.itemId
  self.discount = 100
  self.purchases = purchases or 0
  self.historyPurchases = historyPurchases or 0
  self.hasDouble = hasDouble
  self.freshTm = 0
  self.goodCfg = goodCfg
  if shopType ~= ShopEnum.eShopType.Recharge then
    local itemCfg = ConfigData.item[self.itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(self.itemId))
    else
      self.itemCfg = itemCfg
    end
  end
  self.currencyId = goodCfg.currencyId
  self:m_HandleDifferData(shopType, shopId, freshType)
  if goodCfg.order ~= nil then
    self.order = goodCfg.order
  end
end

function ShopGoodData:m_HandleCurrency(payType)
  local payItemCfg = ConfigData.item[payType]
  if payItemCfg == nil then
    error("item cfg is null,id:" .. tostring(payType))
  end
  local currencyCfg = ConfigData.item_currency[payType]
  if currencyCfg == nil then
    error("Item Currency Cfg is null,ID:" .. tostring(payType))
  else
    local originPrice = math.ceil(self.itemCfg.currency_price[currencyCfg.num] * self.itemNum / currencyCfg.divisor)
    self.oldCurrencyNum = originPrice
    if self.discount == 100 then
      self.newCurrencyNum = originPrice
    else
      self.newCurrencyNum = math.ceil(originPrice * self.discount / 100)
    end
    self.currencyId = payItemCfg.id
  end
end

function ShopGoodData:m_HandleDifferData(shopType, shopId, FreshType)
  if shopType == ShopEnum.eShopType.Normal or shopType == ShopEnum.eShopType.Skin then
    if ConfigData.shop_normal[shopId] == nil or ConfigData.shop_normal[shopId][self.shelfId] == nil then
      error("shop normal cfg is null,storeId:" .. tostring(shopId) .. " shelfId:" .. tostring(self.shelfId))
      self.isLimit = true
      self.isSoldOut = true
    else
      local shelfCfg = ConfigData.shop_normal[shopId][self.shelfId]
      local limitTime = shelfCfg.times
      self.pageId = shelfCfg.page
      if FreshType ~= nil and 0 < FreshType then
        self.limitType = FreshType
        self.isSoldOut = limitTime <= self.purchases
        self.limitTime = limitTime
        self.isLimit = true
      else
        self.isSoldOut = false
        self.isLimit = false
      end
      self.shelfCfg = shelfCfg
    end
  elseif shopType == ShopEnum.eShopType.Random then
    self.isLimit = true
    self.limitType = ShopEnum.eLimitType.Eternal
    self.limitTime = 1
    self.isSoldOut = 0 < self.purchases
  elseif shopType == ShopEnum.eShopType.Resource then
    self.isLimit = true
    self.isSoldOut = true
    self.limitType = ShopEnum.eLimitType.Day
    if #self.goodCfg.times ~= 0 then
      self.limitTime = self.goodCfg.times[#self.goodCfg.times]
      local numAdd = PlayerDataCenter.playerBonus:GetResourceGoodBuyNumAdd(shopId, self.shelfId)
      for i, refreshTime in ipairs(self.goodCfg.times) do
        if refreshTime > self.purchases or refreshTime == -1 or i == #self.goodCfg.times and self.purchases < refreshTime + numAdd then
          self.itemNum = self.goodCfg.itemNums[i]
          self.isSoldOut = false
          self.oldCurrencyNum = self.goodCfg.currencyNums[i]
          self.newCurrencyNum = self.goodCfg.currencyNums[i]
          if refreshTime == -1 then
            self.isLimit = false
            break
          end
          self.limitTime = refreshTime
          break
        end
      end
      if self.isLimit then
        self.totallimitTime = self.goodCfg.times[#self.goodCfg.times] + numAdd
      end
    end
  elseif shopType == ShopEnum.eShopType.ResourceRefresh then
    self.isLimit = true
    self.isSoldOut = true
    self.isRecommendGood = self.goodCfg.recommend_tag
    self.shelfCfg = ConfigData.shop_resource[shopId][self.shelfId]
    local cycleBuyLimit = math.maxinteger
    if self.shelfCfg.limit_type ~= 0 then
      if self.shelfCfg.limit_type == 202 then
        self.limitType = 3
      end
      if 0 < self.shelfCfg.limit_times then
        cycleBuyLimit = self.shelfCfg.limit_times or math.maxinteger
      end
    end
    if #self.goodCfg.times ~= 0 then
      self.limitTime = self.goodCfg.times[#self.goodCfg.times]
      for i, refreshTime in ipairs(self.goodCfg.times) do
        if refreshTime > self.purchases or refreshTime == -1 then
          self.itemNum = self.goodCfg.itemNums[i]
          self.isSoldOut = false
          if self.goodCfg.show_discount ~= nil and self.goodCfg.show_discount[i] ~= nil then
            self.oldCurrencyNum = self.goodCfg.show_original_price[i]
            self.discount = self.goodCfg.show_discount[i]
          else
            self.oldCurrencyNum = self.goodCfg.currencyNums[i]
          end
          self.newCurrencyNum = self.goodCfg.currencyNums[i]
          if refreshTime == -1 then
            if cycleBuyLimit < math.maxinteger then
              self.limitTime = cycleBuyLimit
              self.totallimitTime = cycleBuyLimit
              self.isSoldOut = self.purchases >= self.totallimitTime
              break
            end
            self.isLimit = false
            break
          end
          self.limitTime = math.min(refreshTime, cycleBuyLimit)
          self.totallimitTime = math.min(self.goodCfg.times[#self.goodCfg.times], cycleBuyLimit)
          self.isSoldOut = self.purchases >= self.totallimitTime
          break
        elseif i == #self.goodCfg.times then
          if self.goodCfg.show_discount ~= nil and self.goodCfg.show_discount[i] ~= nil then
            self.oldCurrencyNum = self.goodCfg.show_original_price[i]
            self.discount = self.goodCfg.show_discount[i]
          else
            self.oldCurrencyNum = self.goodCfg.currencyNums[i]
          end
          self.newCurrencyNum = self.goodCfg.currencyNums[i]
        end
      end
    end
  elseif shopType == ShopEnum.eShopType.Charcter then
    self.isLimit = true
    self.isSoldOut = true
    self.fragMaxBuyNum = 0
    if #self.goodCfg.times ~= 0 then
      self.limitTime = self.goodCfg.times[#self.goodCfg.times]
      for i, refreshTime in ipairs(self.goodCfg.times) do
        if refreshTime > self.purchases or refreshTime == -1 then
          self.itemNum = self.goodCfg.itemNums[i]
          local itemCfg = ConfigData.item[self.goodCfg.itemId]
          if itemCfg == nil or itemCfg.arg == nil then
            error("cant't read itemCfg(.arg) with id = " .. tostring(self.goodCfg.itemId))
          end
          local heroData = PlayerDataCenter.heroDic[itemCfg.arg[1]]
          if heroData == nil then
            error("cant't read heroData with id = " .. tostring(itemCfg.arg[1]))
          end
          self.fragMaxBuyNum = heroData:GetMaxNeedFragNum(true)
          self.isSoldOut = 0 >= self.fragMaxBuyNum
          self.isFullHeroFrag = 0 >= self.fragMaxBuyNum
          self.oldCurrencyNum = self.goodCfg.currencyNums[i]
          self.newCurrencyNum = self.goodCfg.currencyNums[i]
          if refreshTime == -1 then
            self.isLimit = false
            break
          end
          self.limitTime = refreshTime
          break
        end
      end
    end
    self.pageId = self.goodCfg.page
  elseif shopType == ShopEnum.eShopType.Recharge then
    self.shelfCfg = self.goodCfg
    if FreshType > ShopEnum.eLimitType.None then
      self.limitType = FreshType
      self.limitTime = self.goodCfg.times
      self.isSoldOut = self.purchases >= self.limitTime
      self.isLimit = true
    else
      self.isSoldOut = false
      self.isLimit = false
    end
  end
  if ConfigData:GetCanByLimitGoodByShopId(self.shopId) then
    return
  end
  if not self.isSoldOut then
    self.isSoldOut = PlayerDataCenter:IsItemLimitHold(self.itemId) or false
  end
end

function ShopGoodData:GetCouldBuy()
  if PlayerDataCenter:GetItemCount(self.currencyId) >= self.newCurrencyNum then
    return true
  else
    return false
  end
end

function ShopGoodData:GetItemHoldLimit()
  if self.itemCfg.holdlimit == nil or self.itemCfg.holdlimit == 0 then
    return -1
  end
  local specialNum = 0
  if self.itemCfg.type == eItemType.DormFurniture then
    specialNum = specialNum + PlayerDataCenter.dormBriefData:GetFurnitureItemCountInDorm(self.itemId)
  end
  return math.max(self.itemCfg.holdlimit - PlayerDataCenter:GetItemCount(self.itemId) - specialNum, 0)
end

function ShopGoodData:GetWareHouseLeftCapacity()
  local num = PlayerDataCenter.playerBonus:GetWarehouseCapcity(self.itemId)
  if num == 0 then
    num = ConfigData.item[self.itemId].holdlimit
  end
  local specialNum = 0
  if self.itemCfg.type == eItemType.DormFurniture then
    specialNum = specialNum + PlayerDataCenter.dormBriefData:GetFurnitureItemCountInDorm(self.itemId)
  end
  return math.max(num - PlayerDataCenter:GetItemCount(self.itemId) - specialNum, 0)
end

function ShopGoodData:GetCouldBuyMaxBuyNum()
  local leftCapacity = self:GetWareHouseLeftCapacity()
  local itemHoldLimit = self:GetItemHoldLimit()
  if leftCapacity == -1 then
    if itemHoldLimit == -1 then
      return -1
    else
      return math.floor(itemHoldLimit / (self.itemNum or 1))
    end
  else
    local leftCapacityBuyNum = math.ceil(leftCapacity / (self.itemNum or 1))
    if itemHoldLimit == -1 then
      return leftCapacityBuyNum
    else
      local itemHoldBuyNum = math.floor(itemHoldLimit / (self.itemNum or 1))
      if leftCapacityBuyNum >= itemHoldBuyNum then
        return itemHoldBuyNum
      else
        return leftCapacityBuyNum
      end
    end
  end
end

function ShopGoodData:GetPriceInterval()
  if self.goodCfg.times == nil or #self.goodCfg.times == 0 then
    return
  end
  local intervalList = {}
  local priceList = {}
  local curIndex
  local lastTime = 1
  for i, refreshTime in ipairs(self.goodCfg.times) do
    priceList[i] = self.goodCfg.currencyNums[i]
    if curIndex == nil and (refreshTime > self.purchases or refreshTime == -1) then
      curIndex = i
    end
    if refreshTime == -1 then
      intervalList[i] = Vector2.New(lastTime, -1)
      break
    else
      intervalList[i] = Vector2.New(lastTime, refreshTime)
      lastTime = refreshTime + 1
    end
  end
  return intervalList, priceList, curIndex
end

function ShopGoodData:UpdateShopGoodData(data)
  if self.shopType == ShopEnum.eShopType.Charcter or self.shopType == ShopEnum.eShopType.Recharge or self.shopType == ShopEnum.eShopType.Resource or self.shopType == ShopEnum.eShopType.ResourceRefresh then
    self.shelfId = data.shelfId
    self.purchases = data.purchases
    self.hasDouble = data.hasDouble
    self.historyPurchases = data.historyPurchases
    local freshType = data.FreshType
    self:m_HandleDifferData(self.shopType, self.shopId, freshType)
  else
    self.shelfId = data.shelfId
    self.itemId = data.itemId
    self.itemNum = data.itemNum
    local payType = data.payType
    self.discount = data.discount
    local FreshType = data.FreshType
    self.purchases = data.purchases
    self.freshTm = data.freshTm
    self:m_HandleCurrency(payType)
    self:m_HandleDifferData(self.shopType, self.shopId, FreshType)
  end
end

function ShopGoodData:GetTotallimitTime()
  return self.totallimitTime or self.limitTime
end

function ShopGoodData:GetShopGoodCouldBuyNum()
  local limitTime = self:GetTotallimitTime()
  local couldBuyNum = limitTime - self.purchases
  return couldBuyNum
end

function ShopGoodData:GetStillTime()
  return ShopUtil.GetShopGoodStillTime(self.shelfCfg)
end

function ShopGoodData:RefreshDataWithSeverMsg()
  self:m_HandleDifferData(self.shopType, self.shopId, nil)
end

function ShopGoodData:IsReplenishGoodsAndCount()
  if self.goodCfg ~= nil then
    local count = self.goodCfg.replenish_num or 0
    return 0 < count, count
  end
  if self.shelfCfg ~= nil then
    local count = self.shelfCfg.replenish_num or 0
    return 0 < count, count
  end
  return false, 0
end

return ShopGoodData
