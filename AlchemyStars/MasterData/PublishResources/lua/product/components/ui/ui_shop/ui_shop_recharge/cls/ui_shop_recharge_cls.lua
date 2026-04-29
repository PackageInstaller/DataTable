_class("RechargeShopData", Object)
RechargeShopData = RechargeShopData

function RechargeShopData:Constructor()
  self._monthCardGoods = nil
  self._goods = {}
  self._mPay = GameGlobal.GetModule(PayModule)
end

function RechargeShopData:UpdateByServerData(TT, marketInfo, cfgs, monthCardInfoList, cfgGiftMarket)
  if not marketInfo then
    Log.fatal("### marketInfo nil.")
    return
  end
  local goodPriceList = self._mPay:GetGoodPriceList()
  local productList = {}
  self._goods = {}
  local serGoods = marketInfo.goods
  for i, good in ipairs(serGoods) do
    local goodsId = good.goods_id
    local cfgv = cfgs[goodsId]
    if cfgv then
      local item = RechargeShopItem:New(goodsId)
      local cfg_shop_paymarket_goods_v = Cfg.cfg_shop_paymarket_goods[goodsId]
      local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
      item:SetMidasId(midasId)
      local keyName = cfg_shop_paymarket_goods_v.Name
      item:SetName(StringTable.Get(keyName))
      local keyLabel = cfg_shop_paymarket_goods_v.Tag
      item:SetLabel(StringTable.Get(keyLabel))
      local icon = cfg_shop_paymarket_goods_v.Icon or ""
      item:SetIcon(icon)
      item:SetCount(tonumber(cfgv[ConfigKey.ConfigKey_ItemCount]))
      if goodPriceList[midasId] then
        local price = goodPriceList[midasId].price
        item:SetPrice(price)
      else
        table.insert(productList, midasId)
      end
      table.insert(self._goods, item)
    else
      Log.fatal("### no goods in cfgs. goodsId = ", goodsId)
    end
  end
  if productList and table.count(productList) > 0 then
    GameGlobal.GetModule(ShopModule):GetLocalPrice()
  end
  self:UpdateMonthCardByServerData(monthCardInfoList, cfgGiftMarket)
  self:UpdateGoodsPresent()
end

function RechargeShopData:UpdateMonthCardByServerData(monthCardInfoList, cfgGiftMarket)
  local goods = monthCardInfoList[1]
  if goods then
    local id = goods.gift_id
    local cfgServer = cfgGiftMarket[id]
    local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
    if cfgServer and cfgClient then
      local item = GiftPackShopItem:New(id)
      local midasId = cfgServer[ConfigKey.ConfigKey_MidasItemId]
      item:SetMidasId(midasId)
      item:SetBuyCount(goods.selled_num)
      item:SetMaxBuyCount(tonumber(cfgServer[ConfigKey.ConfigKey_SaleNum]))
      local strOneTime = cfgServer[ConfigKey.ConfigKey_DirectAssetList]
      local lstOneTime = GiftPackShopData.ItemString2List(strOneTime)
      local awardsImmediately = self:Lst2GiftPackShopItemAward(lstOneTime)
      item:SetAwardsImmediately(awardsImmediately)
      local strCycle = cfgServer[ConfigKey.ConfigKey_CycleAcceptAssetList]
      local lstCycle = GiftPackShopData.ItemString2List(strCycle)
      local awardsDaily = self:Lst2GiftPackShopItemAward(lstCycle)
      item:SetAwardsDaily(awardsDaily)
      local strShopGiftType = cfgServer[ConfigKey.ConfigKey_ShopGiftType]
      item:SetIsMonthCard(tonumber(strShopGiftType) == ShopGiftType.SGT_MonthCard)
      item:SetBattlePassGift(tonumber(strShopGiftType) == ShopGiftType.SGT_BattlePassGift)
      local refreshMethod = tonumber(cfgServer[ConfigKey.ConfigKey_RefreshMethod])
      item:SetCycleType(refreshMethod)
      local refreshInterval = tonumber(cfgServer[ConfigKey.ConfigKey_RefreshInterval])
      item:SetCycleDayCount(refreshInterval)
      item:SetRefreshTime(goods.deadline_time)
      local showEndTime = tonumber(cfgServer[ConfigKey.ConfigKey_ShowEndTime])
      item:SetEndTime(showEndTime)
      local saleType = cfgClient.SaleType
      local priceNotCash = tonumber(cfgServer[ConfigKey.ConfigKey_NowPrice])
      if saleType == SpecialNum.NeedPayMoney then
        item:SetType(GiftPackType.Currency)
        item:SetPriceIcon(nil)
        item:SetPriceItemId(nil)
        local mPay = GameGlobal.GetModule(PayModule)
        local goodPriceList = mPay:GetGoodPriceList()
        local goodPrice = goodPriceList[cfgServer[ConfigKey.ConfigKey_MidasItemId]]
        if goodPrice then
          priceNotCash = goodPrice.price
        else
          priceNotCash = cfgServer[ConfigKey.ConfigKey_NowPrice]
        end
        item:SetPrice(priceNotCash)
      end
      item._discount = tonumber(cfgServer[ConfigKey.ConfigKey_Discount])
      item:SetName(StringTable.Get(cfgClient.Name))
      item:SetIcon(cfgClient.Icon)
      item:SetIconDetail(cfgClient.IconDetail)
      self._monthCardGoods = item
    end
  end
end

function RechargeShopData:Lst2GiftPackShopItemAward(lst)
  local items = {}
  for i, item in ipairs(lst) do
    local item = GiftPackShopItemAward:New(item.templateId, item.count)
    table.insert(items, item)
  end
  return items
end

function RechargeShopData:UpdateGoodsPrice()
  local goodPriceList = self._mPay:GetGoodPriceList()
  if goodPriceList and table.count(goodPriceList) > 0 then
    for i, item in ipairs(self._goods) do
      local midasId = item:GetMidasId()
      if goodPriceList[midasId] then
        local price = goodPriceList[midasId].price
        item:SetPrice(price)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateRechargeItemPrice)
  end
end

function RechargeShopData:UpdateGoodsPresent()
  local presents = self._mPay:GetGoodPresents()
  if presents and table.count(presents) > 0 then
    for i, item in ipairs(self._goods) do
      local count = item:GetCount()
      local present = presents[count]
      if present then
        item:SetHasBuy(present.hasBuy)
        item:SetCountFree(present.send_num)
      else
        Log.fatal("### [Pay][GetInfo] no good present in Midas json. midasId=[" .. item:GetMidasId() .. "] num=" .. count)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateRechargeItemPresent)
  else
    self._mPay:GetInfo("mp")
  end
end

function RechargeShopData:GetGoods()
  return self._goods
end

function RechargeShopData:GetMonthCardGoods()
  return self._monthCardGoods
end

function RechargeShopData:GetGoodBuyId(id)
  for index, good in ipairs(self._goods) do
    if good:GetId() == id then
      return good
    end
  end
end

_class("RechargeShopItem", Object)
RechargeShopItem = RechargeShopItem

function RechargeShopItem:Constructor(goodsId)
  self._id = goodsId
  self._midasId = ""
  self._name = ""
  self._label = ""
  self._price = ""
  self._icon = ""
  self._hasBuy = true
  self._count = 0
  self._countFree = 0
end

function RechargeShopItem:GetId()
  return self._id
end

function RechargeShopItem:GetMidasId()
  return self._midasId
end

function RechargeShopItem:SetMidasId(midasId)
  self._midasId = midasId
end

function RechargeShopItem:GetName()
  return self._name
end

function RechargeShopItem:SetName(name)
  self._name = name
end

function RechargeShopItem:GetLabel()
  return self._label
end

function RechargeShopItem:SetLabel(label)
  self._label = label
end

function RechargeShopItem:GetPrice()
  return self._price
end

function RechargeShopItem:SetPrice(price)
  price = RechargeShopItem.RemoveDot00(price)
  self._price = price
end

function RechargeShopItem.RemoveDot00(str)
  local newStr, num = string.gsub(str, "%.00", "")
  return newStr
end

function RechargeShopItem:GetIcon()
  return self._icon
end

function RechargeShopItem:SetIcon(icon)
  self._icon = icon
end

function RechargeShopItem:GetHasBuy()
  return self._hasBuy
end

function RechargeShopItem:SetHasBuy(hasBuy)
  self._hasBuy = hasBuy
end

function RechargeShopItem:GetCount()
  return self._count
end

function RechargeShopItem:SetCount(count)
  self._count = count
end

function RechargeShopItem:GetCountFree()
  return self._countFree
end

function RechargeShopItem:SetCountFree(countFree)
  self._countFree = countFree
end
