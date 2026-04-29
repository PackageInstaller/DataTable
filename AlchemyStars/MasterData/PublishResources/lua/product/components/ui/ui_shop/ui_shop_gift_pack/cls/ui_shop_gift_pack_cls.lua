_class("GiftPackShopData", Object)
GiftPackShopData = GiftPackShopData

function GiftPackShopData:Constructor()
  self._goods = {}
  self._goodPriceList = {}
  self._mPay = GameGlobal.GetModule(PayModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function GiftPackShopData:UpdateByServerData(marketInfo, cfgs)
  if not marketInfo then
    Log.fatal("### marketInfo nil.")
    return
  end
  local srvTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(srvTimeModule:GetServerTime() / 1000)
  local goodPriceList = self._mPay:GetGoodPriceList()
  self._goods = {}
  local serGoods = marketInfo.goods
  local productList = {}
  for i, good in ipairs(serGoods) do
    local id = good.gift_id
    local cfgv = cfgs[id]
    local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
    local giftType = tonumber(cfgv[ConfigKey.ConfigKey_ShopGiftType])
    if cfgv and cfgClient and giftType ~= ShopGiftType.SGT_CampaignGift and giftType ~= ShopGiftType.SGT_CampaignWeekCard then
      local item = GiftPackShopItem:New(id)
      local midasId = cfgv[ConfigKey.ConfigKey_MidasItemId]
      item:SetMidasId(midasId)
      item:SetBuyCount(good.selled_num)
      local maxBuyCount = tonumber(cfgv[ConfigKey.ConfigKey_SaleNum])
      item:SetMaxBuyCount(maxBuyCount)
      local strOneTime = cfgv[ConfigKey.ConfigKey_DirectAssetList]
      local lstOneTime = GiftPackShopData.ItemString2List(strOneTime)
      local awardsImmediately = self:Lst2GiftPackShopItemAward(lstOneTime)
      item:SetAwardsImmediately(awardsImmediately)
      local strCycle = cfgv[ConfigKey.ConfigKey_CycleAcceptAssetList]
      local lstCycle = GiftPackShopData.ItemString2List(strCycle)
      local awardsDaily = self:Lst2GiftPackShopItemAward(lstCycle)
      item:SetAwardsDaily(awardsDaily)
      local strShopGiftType = cfgv[ConfigKey.ConfigKey_ShopGiftType]
      item:SetIsMonthCard(tonumber(strShopGiftType) == ShopGiftType.SGT_MonthCard)
      item:SetBattlePassGift(tonumber(strShopGiftType) == ShopGiftType.SGT_BattlePassGift)
      item:SetRechargeGift(tonumber(strShopGiftType) == ShopGiftType.SGT_RechargeGift)
      item.isWeekCard = tonumber(strShopGiftType) == ShopGiftType.SGT_WeekCard
      if cfgv[ConfigKey.ConfigKey_AcceptUseFullLife] then
        item.duration = tonumber(cfgv[ConfigKey.ConfigKey_AcceptUseFullLife])
      else
        item.duration = Cfg.cfg_shop_giftmarket_goods[id].AcceptUsefulLife or 0
      end
      self:UpdateByServerData_LevelGift(item, good, cfgv, cfgClient)
      local refreshMethod = tonumber(cfgv[ConfigKey.ConfigKey_RefreshMethod])
      item:SetCycleType(refreshMethod)
      local refreshInterval = tonumber(cfgv[ConfigKey.ConfigKey_RefreshInterval])
      item:SetCycleDayCount(refreshInterval)
      item:SetRefreshTime(good.deadline_time)
      local insert = true
      local showEndTime
      if cfgClient.LiveTime and 0 < cfgClient.LiveTime then
        if good.deadline_time and 0 < good.deadline_time then
          local nowTime = self._svrTimeModule:GetServerTime() * 0.001
          if nowTime < good.deadline_time then
            showEndTime = good.deadline_time
            Log.debug("###[GiftPackShopData] 限时礼包未过期,showEndTime:", showEndTime, "|nowTime:", nowTime)
          else
            Log.debug("###[GiftPackShopData] 过期")
            insert = false
          end
        else
          Log.debug("###[GiftPackShopData] deadline_time 无")
          insert = false
        end
      else
        showEndTime = tonumber(cfgv[ConfigKey.ConfigKey_ShowEndTime])
      end
      item:SetEndTime(showEndTime)
      local saleType = cfgClient.SaleType
      if saleType == SpecialNum.NeedPayMoney then
        item:SetType(GiftPackType.Currency)
        item:SetPriceIcon(nil)
        item:SetPriceItemId(nil)
        local goodPrice = goodPriceList[midasId]
        if goodPrice then
          item._price = goodPrice.microprice / 1000000
          item:SetPriceWithCurrencySymbol(goodPrice.price)
        elseif showEndTime == nil then
          table.insert(productList, midasId)
        elseif curTime < showEndTime then
          table.insert(productList, midasId)
        end
      else
        local priceRawNotCash = tonumber(cfgv[ConfigKey.ConfigKey_RawPrice])
        local priceNotCash = tonumber(cfgv[ConfigKey.ConfigKey_NowPrice])
        if saleType == SpecialNum.FreeGiftSaleType then
          item:SetType(GiftPackType.Free)
          item:SetPriceIcon(nil)
          item:SetPriceItemId(nil)
        else
          if saleType == RoleAssetID.RoleAssetDiamond then
            item:SetType(GiftPackType.Yaojing)
          elseif saleType == RoleAssetID.RoleAssetGlow then
            item:SetType(GiftPackType.Guangpo)
          else
            item:SetType(GiftPackType.Item)
          end
          item:SetPriceIcon("toptoon_" .. saleType)
          item:SetPriceItemId(saleType)
        end
        item._priceRaw = priceRawNotCash
        item._price = priceNotCash
      end
      item._discount = tonumber(cfgv[ConfigKey.ConfigKey_Discount])
      item:SetName(StringTable.Get(cfgClient.Name))
      item:SetIcon(cfgClient.Icon)
      item:SetIconDetail(cfgClient.IconDetail)
      item.isSkin = cfgClient.IsSkin or false
      if insert then
        table.insert(self._goods, item)
      end
    else
      Log.fatal("### no goods in cfgs. id = ", id)
    end
  end
  if productList and 0 < table.count(productList) then
    GameGlobal.GetModule(ShopModule):GetLocalPrice()
  end
  local newList = marketInfo.new_mark_goods
  if newList and 0 < table.count(newList) then
    for _, newItem in ipairs(newList) do
      for _, good in ipairs(self._goods) do
        if newItem ~= good:GetId() or good:IsBattlePassGift() then
        elseif good:IsLevelGift() then
          good:SetNew(not good:IsLevelGiftLock())
        else
          good:SetNew(true)
        end
      end
    end
  end
end

function GiftPackShopData:UpdateByServerData_LevelGift(item, good, cfgv, cfgClient)
  local strShopGiftType = cfgv[ConfigKey.ConfigKey_ShopGiftType]
  if tonumber(strShopGiftType) == ShopGiftType.SGT_LevelGift then
    item:SetLevelGift(true)
    local saleNum = tonumber(cfgv[ConfigKey.ConfigKey_SaleNum])
    if saleNum ~= 1 then
      Log.exception("GiftPackShopData:UpdateByServerData_LevelGift()", " [cfg_shop_giftmarket_goods]", " ID = ", good.gift_id, " Error: GiftType == 5 and SaleNum ~= 1")
    end
    local levelLock = good.gift_lock_status & GiftLockStatus.GLS_LevelLock ~= 0
    local preLock = good.gift_lock_status & GiftLockStatus.GLS_PreposeLock ~= 0
    local buy = good.selled_num ~= 0
    item:SetLevelGiftLock(levelLock)
    local isShow = not preLock and not buy
    item:SetLevelGiftShow(isShow)
    item:SetLevelGiftLockLv(tonumber(cfgv[ConfigKey.ConfigKey_LevelCondition]))
    local free = cfgClient.SaleType == 0
    local red = isShow and not levelLock and free
    item:SetLevelGiftRed(red)
  end
end

function GiftPackShopData:SortGoods_Client_LevelGift()
  local tb = {}
  local items = {}
  for i, v in ipairs(self._goods) do
    if v:IsLevelGift() and v:IsLevelGiftShow() and v:IsLevelGiftLock() then
      table.insert(items, v)
    end
  end
  for i, v in ipairs(self._goods) do
    if not v:IsLevelGift() or v:IsLevelGiftShow() and not v:IsLevelGiftLock() then
      table.insert(tb, v)
    end
  end
  if 0 < #items then
    table.appendArray(tb, items)
  end
  self._goods = tb
end

function GiftPackShopData:SortGoods_Client_BattlePass()
  local campaignType = ECampaignType.CAMPAIGN_TYPE_BATTLEPASS
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(campaignType, cmptId)
  local componentInfo = self._campaign:GetComponentInfo(cmptId)
  local buyState = componentInfo and componentInfo.m_buy_state or -1
  local toFirst = buyState == 0
  local toLast = buyState == 1 or buyState == 2
  Log.debug("GiftPackShopData:SortGoods_Client_BattlePass()", " toFirst = ", toFirst, " toLast = ", toLast)
  local tb = {}
  local items = {}
  for i, v in ipairs(self._goods) do
    if v:IsBattlePassGift() then
      table.insert(items, v)
    end
  end
  if 0 < #items and toFirst then
    table.appendArray(tb, items)
  end
  for i, v in ipairs(self._goods) do
    if not v:IsBattlePassGift() then
      table.insert(tb, v)
    end
  end
  if 0 < #items and toLast then
    table.appendArray(tb, items)
  end
  self._goods = tb
end

function GiftPackShopData:UpdateGoodsPrice()
  local goodPriceList = self._mPay:GetGoodPriceList()
  if goodPriceList and table.count(goodPriceList) > 0 then
    for i, item in ipairs(self._goods) do
      local midasId = item:GetMidasId()
      if not string.isnullorempty(midasId) and goodPriceList[midasId] then
        local goodPrice = goodPriceList[midasId]
        item._price = goodPrice.microprice / 1000000
        item:SetPriceWithCurrencySymbol(goodPrice.price)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateGiftPackItemPrice)
  else
    Log.fatal("### [Pay]no data in goodPriceList.")
  end
end

function GiftPackShopData.ItemString2List(itemStr)
  local lst = {}
  local a = string.split(itemStr, "|")
  for _, idcount in ipairs(a) do
    local strs = string.split(idcount, ",")
    local templateId = tonumber(strs[1])
    local count = tonumber(strs[2])
    table.insert(lst, {templateId = templateId, count = count})
  end
  return lst
end

function GiftPackShopData:Lst2GiftPackShopItemAward(lst)
  local items = {}
  for i, item in ipairs(lst) do
    local item = GiftPackShopItemAward:New(item.templateId, item.count)
    table.insert(items, item)
  end
  return items
end

function GiftPackShopData:GetGoods()
  self:SortGoods_Client_LevelGift()
  self:SortGoods_Client_BattlePass()
  return self._goods
end

function GiftPackShopData:GetRechargeGiftGoods()
  self.rechargeGiftGoods = {}
  for index, value in ipairs(self._goods) do
    if value:GetRechargeGift() then
      table.insert(self.rechargeGiftGoods, value)
    end
  end
  return self.rechargeGiftGoods
end

function GiftPackShopData:GetGoodBuyId(id)
  for index, good in ipairs(self._goods) do
    if good:GetId() == id then
      return good
    end
  end
end

function GiftPackShopData:GetNew()
  for index, good in ipairs(self._goods) do
    if good:GetNew() then
      return true
    end
  end
  return false
end

_class("ShopPriceItem", Object)
ShopPriceItem = ShopPriceItem

function ShopPriceItem:Constructor(id)
  self._priceIcon = ""
  self._priceItemId = 0
  self._priceRaw = 1
  self._price = 0
  self._discount = 0
  self._priceWithCurrencySymbol = ""
end

function ShopPriceItem:GetPriceIcon()
  return self._priceIcon
end

function ShopPriceItem:SetPriceIcon(priceIcon)
  self._priceIcon = priceIcon
end

function ShopPriceItem:GetPriceItemId()
  return self._priceItemId
end

function ShopPriceItem:SetPriceItemId(priceItemId)
  self._priceItemId = priceItemId
end

function ShopPriceItem:GetPrice()
  return self._price
end

function ShopPriceItem:GetPriceRaw()
  return self._priceRaw
end

function ShopPriceItem:GetDiscount()
  if self._discount > 0 then
    local str = StringTable.Get("str_pay_discount_percent", self._discount)
    return self._discount, str
  end
  return nil, nil
end

function ShopPriceItem:GetDiscountEx(onlyNumber)
  if self._discount > 0 then
    local discount = self._discount
    local i, f = math.modf(discount)
    if f <= 0 then
      discount = i
    end
    if onlyNumber then
      return discount
    end
    local str = StringTable.Get("str_pay_discount_percent", discount)
    return self._discount, str
  end
  return nil, nil
end

function ShopPriceItem:GetPriceWithCurrencySymbol()
  return self._priceWithCurrencySymbol
end

function ShopPriceItem:SetPriceWithCurrencySymbol(priceWithCurrencySymbol)
  priceWithCurrencySymbol = RechargeShopItem.RemoveDot00(priceWithCurrencySymbol)
  self._priceWithCurrencySymbol = priceWithCurrencySymbol
end

_class("GiftPackShopItem", ShopPriceItem)
GiftPackShopItem = GiftPackShopItem

function GiftPackShopItem:Constructor(id)
  GiftPackShopItem.super.Constructor(self, id)
  self._currencyGoodsType = MidasCurrencyGoodsType.MIDAS_CURRENCY_GOODS_TYPE_GIFT_PACK
  self._id = id
  self._type = GiftPackType.Item
  self._midasId = ""
  self._name = ""
  self._refreshTime = 0
  self._endTime = 0
  self._icon = ""
  self._iconDetail = ""
  self._buyCount = 0
  self._maxBuyCount = 0
  self._isMonthCard = false
  self._isBattlePassGift = false
  self.isWeekCard = false
  self._cycleType = GiftPackCycleType.Once
  self._cycleDayCount = 0
  self._awardsImmediately = {}
  self._awardsDaily = {}
  self.duration = 0
  self._new = false
end

function GiftPackShopItem:GetCurrencyGoodsType()
  return self._currencyGoodsType
end

function GiftPackShopItem:GetId()
  return self._id
end

function GiftPackShopItem:GetType()
  return self._type
end

function GiftPackShopItem:SetType(ptype)
  self._type = ptype
end

function GiftPackShopItem:GetMidasId()
  return self._midasId
end

function GiftPackShopItem:SetMidasId(midasId)
  self._midasId = midasId
  Log.debug("midasId : ", self._midasId)
end

function GiftPackShopItem:GetName()
  return self._name
end

function GiftPackShopItem:SetName(name)
  self._name = name
end

function GiftPackShopItem:GetRefreshTime()
  return self._refreshTime
end

function GiftPackShopItem:SetRefreshTime(refreshTime)
  self._refreshTime = refreshTime
end

function GiftPackShopItem:GetEndTime()
  return self._endTime
end

function GiftPackShopItem:SetEndTime(endTime)
  self._endTime = endTime
end

function GiftPackShopItem:IsMonthCard()
  return self._isMonthCard
end

function GiftPackShopItem:GetPriceWithCurrencySymbolEx(symbolSize)
  return self:GetPriceWithSymbolSize(self._priceWithCurrencySymbol, symbolSize)
end

function GiftPackShopItem:GetPriceWithSymbolSize(currencySymbol, symbolSize)
  if string.isnullorempty(currencySymbol) then
    return ""
  end
  local priceSymbol
  local len = string.len(currencySymbol)
  local n0 = string.byte("0")
  local n9 = string.byte("9")
  local npt = string.byte(".")
  local firstByte = string.byte(currencySymbol, 1)
  if n0 <= firstByte and n9 >= firstByte then
    local firstSymbolID = string.len(currencySymbol) + 1
    for i = 1, len do
      local byte = string.byte(currencySymbol, i)
      if byte == npt then
      elseif n0 > byte or n9 < byte then
        firstSymbolID = i
        break
      end
    end
    local subNumber = string.sub(currencySymbol, 1, firstSymbolID - 1)
    local subSymbol = string.sub(currencySymbol, firstSymbolID)
    local format = "%s<size=%d>%s</size>"
    priceSymbol = string.format(format, subNumber, symbolSize, subSymbol)
  else
    local firstNumID = string.len(currencySymbol) + 1
    for i = 1, len do
      local byte = string.byte(currencySymbol, i)
      if n0 <= byte and n9 >= byte then
        firstNumID = i
        break
      end
    end
    local subSymbol = string.sub(currencySymbol, 1, firstNumID - 1)
    local subNumber = string.sub(currencySymbol, firstNumID)
    local format = "<size=%d>%s</size>%s"
    priceSymbol = string.format(format, symbolSize, subSymbol, subNumber)
  end
  return priceSymbol
end

function GiftPackShopItem:GetMonthCardCycleTypeStr(daySize)
  if self:IsMonthCard() then
    local rt = self:GetRefreshTime()
    if rt <= 0 then
      return StringTable.Get("str_pay_not_buy_yet")
    else
      local d, h, m, s = UICommonHelper.S2DHMS(rt)
      local leftDays = math.ceil(d)
      leftDays = string.format("<size=%d>%d</size>", daySize, leftDays)
      return StringTable.Get("str_shop_buy_left_day", leftDays)
    end
  else
    Log.error("err: GiftPackShopItem:GetMonthCardCycleTypeStr is not mathCard")
  end
end

function GiftPackShopItem:SetIsMonthCard(isMonthCard)
  self._isMonthCard = isMonthCard
end

function GiftPackShopItem:IsBattlePassGift()
  return self._isBattlePassGift
end

function GiftPackShopItem:SetBattlePassGift(isBattlePassGift)
  self._isBattlePassGift = isBattlePassGift
end

function GiftPackShopItem:IsWeekCard()
  return self.isWeekCard
end

function GiftPackShopItem:IsLevelGift()
  return self._isLevelGift
end

function GiftPackShopItem:SetLevelGift(isLevelGift)
  self._isLevelGift = isLevelGift
end

function GiftPackShopItem:IsLevelGiftShow()
  return self._isLevelGiftShow
end

function GiftPackShopItem:SetLevelGiftShow(isLevelGiftShow)
  self._isLevelGiftShow = isLevelGiftShow
end

function GiftPackShopItem:IsLevelGiftLock()
  return self._isLevelGiftLock
end

function GiftPackShopItem:SetLevelGiftLock(isLevelGiftLock)
  self._isLevelGiftLock = isLevelGiftLock
end

function GiftPackShopItem:SetLevelGiftLockLv(lv)
  self._isLevelGiftLockLv = lv
end

function GiftPackShopItem:GetLevelGiftLockLv()
  return self._isLevelGiftLockLv
end

function GiftPackShopItem:SetLevelGiftRed(red)
  self._isLevelGiftRed = red
end

function GiftPackShopItem:IsLevelGiftRed()
  return self._isLevelGiftRed
end

function GiftPackShopItem:GetCycleType()
  return self._cycleType
end

function GiftPackShopItem:SetCycleType(refreshMethod)
  if refreshMethod == 1 then
    self._cycleType = GiftPackCycleType.Weekly
  elseif refreshMethod == 2 then
    self._cycleType = GiftPackCycleType.Monthly
  elseif refreshMethod == 3 then
    self._cycleType = GiftPackCycleType.Cycle
  else
    self._cycleType = GiftPackCycleType.Once
  end
end

function GiftPackShopItem:GetCycleDayCount()
  return self._cycleDayCount
end

function GiftPackShopItem:SetCycleDayCount(cycleDayCount)
  self._cycleDayCount = cycleDayCount
end

function GiftPackShopItem.GetMonthCardMaxDayNum()
  local cfgv = Cfg.cfg_shop_global[1]
  if cfgv then
    local day = cfgv.MonthCardMaxDayNum
    return day
  end
  return 0
end

function GiftPackShopItem.GetMonthCycleDay()
  local cfgv = Cfg.cfg_shop_global[1]
  if cfgv then
    local day = cfgv.MonthCycleDay
    return day
  end
  return 0
end

function GiftPackShopItem:CheckDayCount()
  local isMonthCard = self:IsMonthCard()
  if isMonthCard then
    local d, h, m, s = UICommonHelper.S2DHMS(self:GetRefreshTime())
    local dayCount = math.ceil(d)
    local monthCycleDay = GiftPackShopItem.GetMonthCycleDay()
    local monthCardMaxDayNum = GiftPackShopItem.GetMonthCardMaxDayNum()
    if monthCardMaxDayNum < dayCount + monthCycleDay then
      if self._type == GiftPackType.Currency then
        GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "month_card_day_count_limit_reached")
      end
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_month_card_max_day_count_cant_over_limit", GiftPackShopItem.GetMonthCardMaxDayNum()))
      return false
    end
  else
    local nowTime = UICommonHelper.GetNowTimestamp()
    local endTime = self:GetEndTime()
    if nowTime > endTime then
      if self._type == GiftPackType.Currency then
        GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "gift_invalid")
      end
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_gift_invalid"))
      return false
    end
  end
  return true
end

function GiftPackShopItem:GetCycleTypeStr()
  if self:IsMonthCard() or self:IsWeekCard() then
    local rt = self:GetRefreshTime()
    if rt <= 0 then
      return StringTable.Get("str_pay_not_buy_yet")
    else
      local d, h, m, s = UICommonHelper.S2DHMS(rt)
      local leftDays = math.ceil(d)
      return StringTable.Get("str_pay_left_collect_day", leftDays)
    end
  else
    local soldOut = self:HasSoldOut()
    if soldOut then
      return
    end
    local endTime = self:GetEndTime()
    local mShop = GameGlobal.GetModule(ShopModule)
    local notShowLeftTime = mShop:GetClientShop():GetNotShowLeftTime()
    if endTime > notShowLeftTime then
      return
    end
    local leftSeconds = UICommonHelper.CalcLeftSeconds(endTime)
    if leftSeconds <= 0 then
      return StringTable.Get("str_pay_expired")
    end
    local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
    if 1 <= d then
      return StringTable.Get("str_pay_left_day", math.floor(d))
    elseif 1 <= h then
      return StringTable.Get("str_pay_left_hour", math.floor(h))
    elseif 1 <= m then
      return StringTable.Get("str_pay_left_minute", math.floor(m))
    else
      return StringTable.Get("str_pay_left_minute", "<1")
    end
  end
end

function GiftPackShopItem:GetWeekShowStr()
  if self:IsWeekCard() then
    local rt = self:GetRefreshTime()
    if 0 < rt then
      return
    end
    local endTime = self:GetEndTime()
    local mShop = GameGlobal.GetModule(ShopModule)
    local notShowLeftTime = mShop:GetClientShop():GetNotShowLeftTime()
    if endTime > notShowLeftTime then
      return
    end
    local leftSeconds = UICommonHelper.CalcLeftSeconds(endTime)
    if leftSeconds <= 0 then
      return StringTable.Get("str_pay_expired")
    end
    local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
    if 1 <= d then
      return StringTable.Get("str_pay_left_day", math.floor(d))
    elseif 1 <= h then
      return StringTable.Get("str_pay_left_hour", math.floor(h))
    elseif 1 <= m then
      return StringTable.Get("str_pay_left_minute", math.floor(m))
    else
      return StringTable.Get("str_pay_left_minute", "<1")
    end
  end
end

function GiftPackShopItem:GetRefreshTimeStr()
  if self:IsMonthCard() then
    return
  end
  local cycleType = self:GetCycleType()
  if cycleType == GiftPackCycleType.Once then
    return
  end
  local refreshTime = self:GetRefreshTime()
  local leftSeconds = UICommonHelper.CalcLeftSeconds(refreshTime)
  if leftSeconds <= 0 then
    return
  end
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  if 1 <= d then
    return StringTable.Get("str_pay_purchase_refresh_n_day", math.floor(d))
  elseif 1 <= h then
    return StringTable.Get("str_pay_purchase_refresh_n_hour", math.floor(h))
  elseif 1 <= m then
    return StringTable.Get("str_pay_purchase_refresh_n_minute", math.floor(m))
  else
    return StringTable.Get("str_pay_purchase_refresh_n_minute", "<1")
  end
end

function GiftPackShopItem:GetPrice()
  return self._price
end

function GiftPackShopItem:SetPrice(price)
  self._price = price
end

function GiftPackShopItem:GetIcon()
  return self._icon
end

function GiftPackShopItem:SetIcon(icon)
  self._icon = icon
end

function GiftPackShopItem:GetIconDetail()
  return self._iconDetail
end

function GiftPackShopItem:SetIconDetail(iconDetail)
  self._iconDetail = iconDetail
end

function GiftPackShopItem:GetBuyCount()
  return self._buyCount
end

function GiftPackShopItem:SetBuyCount(buyCount)
  self._buyCount = buyCount
end

function GiftPackShopItem:GetMaxBuyCount()
  return self._maxBuyCount
end

function GiftPackShopItem:SetMaxBuyCount(maxBuyCount)
  self._maxBuyCount = maxBuyCount
end

function GiftPackShopItem:HasSoldOut()
  local buyCount = self:GetBuyCount()
  local maxBuyCount = self:GetMaxBuyCount()
  local soldOut = buyCount >= maxBuyCount
  return soldOut
end

function GiftPackShopItem:GetCountStr()
  if self:IsBattlePassGift() then
    return ""
  end
  local maxBuyCount = self:GetMaxBuyCount()
  if maxBuyCount == 888888888 then
    return ""
  end
  local buyCount = self:GetBuyCount()
  local n2m = maxBuyCount - buyCount .. "/" .. maxBuyCount
  local cycleType = self:GetCycleType()
  local strLimit = ""
  if cycleType == GiftPackCycleType.Weekly then
    strLimit = StringTable.Get("str_pay_purchase_limitation_weekly", n2m)
  elseif cycleType == GiftPackCycleType.Monthly then
    strLimit = StringTable.Get("str_pay_purchase_limitation_monthly", n2m)
  elseif cycleType == GiftPackCycleType.Cycle then
    local dayCount = self:GetCycleDayCount()
    strLimit = StringTable.Get("str_pay_purchase_limitation_n_day", dayCount, n2m)
  else
    strLimit = StringTable.Get("str_pay_purchase_limitation_forever", n2m)
  end
  return strLimit
end

function GiftPackShopItem:GetAwardsImmediately()
  return self._awardsImmediately
end

function GiftPackShopItem:SetAwardsImmediately(awardsImmediately)
  self._awardsImmediately = awardsImmediately
end

function GiftPackShopItem:GetAwardsDaily()
  return self._awardsDaily
end

function GiftPackShopItem:SetAwardsDaily(awardsDaily)
  self._awardsDaily = awardsDaily
end

function GiftPackShopItem:GetNew()
  return self._new
end

function GiftPackShopItem:SetNew(new)
  self._new = new
end

function GiftPackShopItem:IsSkin()
  local cfgv = Cfg.cfg_shop_giftmarket_goods[self._id]
  if cfgv then
    return cfgv.IsSkin
  end
end

function GiftPackShopItem:IsShowInSkinsTab()
  local cfgv = Cfg.cfg_shop_giftmarket_goods[self._id]
  if cfgv then
    return cfgv.ShowInSkinsTab
  end
  return false
end

function GiftPackShopItem:GetShopGiftTabID()
  local goodsId = self:GetId()
  local cfgClient = Cfg.cfg_shop_giftmarket_goods[goodsId]
  local tabID = -1
  if cfgClient ~= nil then
    tabID = cfgClient.GiftPackTabID
  end
  if tabID == nil then
    tabID = -1
  end
  return tabID
end

function GiftPackShopItem:SetRechargeGift(isRechargeGift)
  self._isRechargeGift = isRechargeGift
end

function GiftPackShopItem:GetRechargeGift()
  return self._isRechargeGift
end

GiftPackType = {
  Currency = 0,
  Yaojing = 1,
  Guangpo = 2,
  Item = 3,
  Free = 4
}
GiftPackCycleType = {
  Once = 0,
  Monthly = 1,
  Weekly = 2,
  Cycle = 3
}
_class("GiftPackShopItemAward", Object)
GiftPackShopItemAward = GiftPackShopItemAward

function GiftPackShopItemAward:Constructor(templateId, count)
  self._templateId = templateId
  self._count = count
  local cfg = Cfg.cfg_item[self._templateId]
  if cfg then
    self._name = StringTable.Get(cfg.Name)
    self._icon = cfg.Icon
  end
end

function GiftPackShopItemAward:GetTemplateId()
  return self._templateId
end

function GiftPackShopItemAward:GetIcon()
  return self._icon
end

function GiftPackShopItemAward:GetName()
  return self._name
end

function GiftPackShopItemAward:GetCount()
  return self._count
end
