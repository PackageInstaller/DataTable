_class("FlashSaleShopData", Object)
FlashSaleShopData = FlashSaleShopData

function FlashSaleShopData:Constructor()
  self._goods = {}
  self._goodPriceList = {}
  self._mPay = GameGlobal.GetModule(PayModule)
end

function FlashSaleShopData:UpdateByServerData(marketInfo, cfgs)
  if not marketInfo then
    Log.fatal("FlashSaleShopData No Goods.")
    return
  end
  self._goods = {}
  local serGoods = marketInfo.goods
  for _, good in ipairs(serGoods) do
    local id = good.gift_id
    local cfgServer = cfgs[id]
    local cfgClient = Cfg.cfg_shop_giftmarket_goods[id]
    local giftType = tonumber(cfgServer[ConfigKey.ConfigKey_ShopGiftType])
    if cfgServer and cfgClient and (giftType == ShopGiftType.SGT_CampaignGift or giftType == ShopGiftType.SGT_CampaignWeekCard) then
      local item = FlashSaleShopItem:New(id)
      local midasId = cfgServer[ConfigKey.ConfigKey_MidasItemId]
      item:SetMidasId(midasId)
      item:SetBuyCount(good.selled_num)
      local maxBuyCount = tonumber(cfgServer[ConfigKey.ConfigKey_SaleNum])
      item:SetMaxBuyCount(maxBuyCount)
      local strOneTime = cfgServer[ConfigKey.ConfigKey_DirectAssetList]
      local lstOneTime = FlashSaleShopData.ItemString2List(strOneTime)
      local awardsImmediately = self:Lst2FlashSaleShopItemAward(lstOneTime)
      item:SetAwardsImmediately(awardsImmediately)
      local strCycle = cfgServer[ConfigKey.ConfigKey_CycleAcceptAssetList]
      local lstCycle = FlashSaleShopData.ItemString2List(strCycle)
      local awardsDaily = self:Lst2FlashSaleShopItemAward(lstCycle)
      item:SetAwardsDaily(awardsDaily)
      item:SetIsMonthCard(giftType == ShopGiftType.SGT_MonthCard)
      item:SetBattlePassGift(giftType == ShopGiftType.SGT_BattlePassGift)
      item.isWeekCard = giftType == ShopGiftType.SGT_CampaignWeekCard
      self:UpdateByServerData_LevelGift(item, good, cfgServer, cfgClient)
      local refreshMethod = tonumber(cfgServer[ConfigKey.ConfigKey_RefreshMethod])
      item:SetCycleType(refreshMethod)
      local refreshInterval = tonumber(cfgServer[ConfigKey.ConfigKey_RefreshInterval])
      item:SetCycleDayCount(refreshInterval)
      item:SetRefreshTime(good.deadline_time)
      local showEndTime = tonumber(cfgServer[ConfigKey.ConfigKey_ShowEndTime])
      item:SetEndTime(showEndTime)
      local saleType = cfgClient.SaleType
      local priceNotCash = tonumber(cfgServer[ConfigKey.ConfigKey_NowPrice])
      if saleType == SpecialNum.NeedPayMoney then
        item:SetType(GiftPackType.Currency)
        item:SetPriceIcon(nil)
        item:SetPriceItemId(nil)
        item:SetPrice(priceNotCash)
        item:SetPriceWithCurrencySymbol(ClientShop.PriceUnit() .. UIShopToolFunctions.GetPrice(priceNotCash))
      else
        local priceRawNotCash = tonumber(cfgServer[ConfigKey.ConfigKey_RawPrice])
        local priceNotCash = tonumber(cfgServer[ConfigKey.ConfigKey_NowPrice])
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
      item._discount = tonumber(cfgServer[ConfigKey.ConfigKey_Discount])
      item:SetName(StringTable.Get(cfgClient.Name))
      item:SetIcon(cfgClient.Icon)
      item:SetIconDetail(cfgClient.IconDetail)
      table.insert(self._goods, item)
    else
    end
  end
end

function FlashSaleShopData:UpdateByServerData_LevelGift(item, goods, cfgv, cfgClient)
  local strShopGiftType = cfgv[ConfigKey.ConfigKey_ShopGiftType]
  if tonumber(strShopGiftType) == ShopGiftType.SGT_LevelGift then
    item:SetLevelGift(true)
    local saleNum = tonumber(cfgv[ConfigKey.ConfigKey_SaleNum])
    if saleNum ~= 1 then
      Log.exception("FlashSaleShopData:UpdateByServerData_LevelGift()", " [cfg_shop_giftmarket_goods]", " ID = ", goods.gift_id, " Error: GiftType == 5 and SaleNum ~= 1")
    end
    local levelLock = goods.gift_lock_status & GiftLockStatus.GLS_LevelLock ~= 0
    local preLock = goods.gift_lock_status & GiftLockStatus.GLS_PreposeLock ~= 0
    local buy = goods.selled_num ~= 0
    item:SetLevelGiftLock(levelLock)
    local isShow = not preLock and not buy
    item:SetLevelGiftShow(isShow)
    item:SetLevelGiftLockLv(tonumber(cfgv[ConfigKey.ConfigKey_LevelCondition]))
    local free = cfgClient.SaleType == 0
    local red = isShow and not levelLock and free
    item:SetLevelGiftRed(red)
  end
end

function FlashSaleShopData:UpdateGoodsPrice()
  local goodPriceList = self._mPay:GetGoodPriceList()
  if goodPriceList and table.count(goodPriceList) > 0 then
    for _, goods in pairs(self._goods) do
      local midasId = goods:GetMidasId()
      if not string.isnullorempty(midasId) and goodPriceList[midasId] then
        local goodPrice = goodPriceList[midasId]
        goods._price = goodPrice.microprice / 1000000
        goods:SetPriceWithCurrencySymbol(goodPrice.price)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateFlashSaleItemPrice)
  else
    Log.fatal("### [Pay]no data in goodPriceList.")
  end
end

function FlashSaleShopData.ItemString2List(itemStr)
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

function FlashSaleShopData:Lst2FlashSaleShopItemAward(lst)
  local items = {}
  for _, item in ipairs(lst) do
    local item = FlashSaleShopItemAward:New(item.templateId, item.count)
    table.insert(items, item)
  end
  return items
end

function FlashSaleShopData:GetGoods()
  return self._goods
end

function FlashSaleShopData:GetGoodBuyId(id)
  for _, goods in ipairs(self._goods) do
    if goods:GetId() == id then
      return goods
    end
  end
end

function FlashSaleShopData:GetNew()
  for _, goods in ipairs(self._goods) do
    if goods:GetNew() then
      return true
    end
  end
  return false
end

_class("ShopFlashSalePriceItem", Object)
ShopFlashSalePriceItem = ShopFlashSalePriceItem

function ShopFlashSalePriceItem:Constructor(id)
  self._priceIcon = ""
  self._priceItemId = 0
  self._priceRaw = 1
  self._price = 0
  self._discount = 0
  self._priceWithCurrencySymbol = ""
end

function ShopFlashSalePriceItem:GetPriceIcon()
  return self._priceIcon
end

function ShopFlashSalePriceItem:SetPriceIcon(priceIcon)
  self._priceIcon = priceIcon
end

function ShopFlashSalePriceItem:GetPriceItemId()
  return self._priceItemId
end

function ShopFlashSalePriceItem:SetPriceItemId(priceItemId)
  self._priceItemId = priceItemId
end

function ShopFlashSalePriceItem:GetPrice()
  return self._price
end

function ShopFlashSalePriceItem:GetPriceRaw()
  return self._priceRaw
end

function ShopFlashSalePriceItem:GetDiscount()
  if self._discount > 0 then
    local discount = self._discount / 10
    local i, f = math.modf(discount)
    if f <= 0 then
      discount = i
    end
    local str = StringTable.Get("str_pay_discount_percent", discount)
    return self._discount, str
  end
  return nil, nil
end

function ShopFlashSalePriceItem:GetPriceWithCurrencySymbol()
  return self._priceWithCurrencySymbol
end

function ShopFlashSalePriceItem:SetPriceWithCurrencySymbol(priceWithCurrencySymbol)
  priceWithCurrencySymbol = RechargeShopItem.RemoveDot00(priceWithCurrencySymbol)
  self._priceWithCurrencySymbol = priceWithCurrencySymbol
end

_class("FlashSaleShopItem", ShopFlashSalePriceItem)
FlashSaleShopItem = FlashSaleShopItem

function FlashSaleShopItem:Constructor(id)
  FlashSaleShopItem.super.Constructor(self, id)
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
  self._new = false
end

function FlashSaleShopItem:GetCurrencyGoodsType()
  return self._currencyGoodsType
end

function FlashSaleShopItem:GetId()
  return self._id
end

function FlashSaleShopItem:GetType()
  return self._type
end

function FlashSaleShopItem:SetType(ptype)
  self._type = ptype
end

function FlashSaleShopItem:GetMidasId()
  return self._midasId
end

function FlashSaleShopItem:SetMidasId(midasId)
  self._midasId = midasId
  Log.debug("midasId : ", self._midasId)
end

function FlashSaleShopItem:GetName()
  return self._name
end

function FlashSaleShopItem:SetName(name)
  self._name = name
end

function FlashSaleShopItem:GetRefreshTime()
  return self._refreshTime
end

function FlashSaleShopItem:SetRefreshTime(refreshTime)
  self._refreshTime = refreshTime
end

function FlashSaleShopItem:GetEndTime()
  return self._endTime
end

function FlashSaleShopItem:SetEndTime(endTime)
  self._endTime = endTime
end

function FlashSaleShopItem:IsMonthCard()
  return self._isMonthCard
end

function FlashSaleShopItem:SetIsMonthCard(isMonthCard)
  self._isMonthCard = isMonthCard
end

function FlashSaleShopItem:IsBattlePassGift()
  return self._isBattlePassGift
end

function FlashSaleShopItem:SetBattlePassGift(isBattlePassGift)
  self._isBattlePassGift = isBattlePassGift
end

function FlashSaleShopItem:IsWeekCard()
  return self.isWeekCard
end

function FlashSaleShopItem:IsLevelGift()
  return self._isLevelGift
end

function FlashSaleShopItem:SetLevelGift(isLevelGift)
  self._isLevelGift = isLevelGift
end

function FlashSaleShopItem:IsLevelGiftShow()
  return self._isLevelGiftShow
end

function FlashSaleShopItem:SetLevelGiftShow(isLevelGiftShow)
  self._isLevelGiftShow = isLevelGiftShow
end

function FlashSaleShopItem:IsLevelGiftLock()
  return self._isLevelGiftLock
end

function FlashSaleShopItem:SetLevelGiftLock(isLevelGiftLock)
  self._isLevelGiftLock = isLevelGiftLock
end

function FlashSaleShopItem:SetLevelGiftLockLv(lv)
  self._isLevelGiftLockLv = lv
end

function FlashSaleShopItem:GetLevelGiftLockLv()
  return self._isLevelGiftLockLv
end

function FlashSaleShopItem:SetLevelGiftRed(red)
  self._isLevelGiftRed = red
end

function FlashSaleShopItem:IsLevelGiftRed()
  return self._isLevelGiftRed
end

function FlashSaleShopItem:GetCycleType()
  return self._cycleType
end

function FlashSaleShopItem:SetCycleType(refreshMethod)
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

function FlashSaleShopItem:GetCycleDayCount()
  return self._cycleDayCount
end

function FlashSaleShopItem:SetCycleDayCount(cycleDayCount)
  self._cycleDayCount = cycleDayCount
end

function FlashSaleShopItem.GetMonthCardMaxDayNum()
  local cfgv = Cfg.cfg_shop_global[1]
  if cfgv then
    return cfgv.MonthCardMaxDayNum
  end
  return 0
end

function FlashSaleShopItem.GetMonthCycleDay()
  local cfg = Cfg.cfg_shop_global[1]
  if cfg then
    return cfg.MonthCycleDay
  end
  return 0
end

function FlashSaleShopItem:CheckDayCount()
  local isMonthCard = self:IsMonthCard()
  if isMonthCard then
    local d, h, m, s = UICommonHelper.S2DHMS(self:GetRefreshTime())
    local dayCount = math.ceil(d)
    local monthCycleDay = FlashSaleShopItem.GetMonthCycleDay()
    local monthCardMaxDayNum = FlashSaleShopItem.GetMonthCardMaxDayNum()
    if monthCardMaxDayNum < dayCount + monthCycleDay then
      if self._type == GiftPackType.Currency then
        GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "month_card_day_count_limit_reached")
      end
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_month_card_max_day_count_cant_over_limit", FlashSaleShopItem.GetMonthCardMaxDayNum()))
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

function FlashSaleShopItem:GetCycleTypeStr()
  if self:IsMonthCard() then
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
      return StringTable.Get("str_pay_left_day", math.ceil(d))
    elseif 1 <= h then
      return StringTable.Get("str_pay_left_hour", math.ceil(h))
    elseif 1 <= m then
      return StringTable.Get("str_pay_left_minute", math.ceil(m))
    else
      return StringTable.Get("str_pay_left_minute", "<1")
    end
  end
end

function FlashSaleShopItem:GetRefreshTimeStr()
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

function FlashSaleShopItem:GetPriceIcon()
  return self._priceIcon
end

function FlashSaleShopItem:SetPriceIcon(priceIcon)
  self._priceIcon = priceIcon
end

function FlashSaleShopItem:GetPriceItemId()
  return self._priceItemId
end

function FlashSaleShopItem:SetPriceItemId(priceItemId)
  self._priceItemId = priceItemId
end

function FlashSaleShopItem:GetPrice()
  return self._price
end

function FlashSaleShopItem:SetPrice(price)
  self._price = price
end

function FlashSaleShopItem:GetPriceWithCurrencySymbol()
  return self._priceWithCurrencySymbol
end

function FlashSaleShopItem:SetPriceWithCurrencySymbol(priceWithCurrencySymbol)
  priceWithCurrencySymbol = RechargeShopItem.RemoveDot00(priceWithCurrencySymbol)
  self._priceWithCurrencySymbol = priceWithCurrencySymbol
end

function FlashSaleShopItem:GetIcon()
  return self._icon
end

function FlashSaleShopItem:SetIcon(icon)
  self._icon = icon
end

function FlashSaleShopItem:GetIconDetail()
  return self._iconDetail
end

function FlashSaleShopItem:SetIconDetail(iconDetail)
  self._iconDetail = iconDetail
end

function FlashSaleShopItem:GetBuyCount()
  return self._buyCount
end

function FlashSaleShopItem:SetBuyCount(buyCount)
  self._buyCount = buyCount
end

function FlashSaleShopItem:GetMaxBuyCount()
  return self._maxBuyCount
end

function FlashSaleShopItem:SetMaxBuyCount(maxBuyCount)
  self._maxBuyCount = maxBuyCount
end

function FlashSaleShopItem:HasSoldOut()
  local buyCount = self:GetBuyCount()
  local maxBuyCount = self:GetMaxBuyCount()
  local soldOut = buyCount >= maxBuyCount
  return soldOut
end

function FlashSaleShopItem:GetCountStr()
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

function FlashSaleShopItem:GetAwardsImmediately()
  return self._awardsImmediately
end

function FlashSaleShopItem:SetAwardsImmediately(awardsImmediately)
  self._awardsImmediately = awardsImmediately
end

function FlashSaleShopItem:GetAwardsDaily()
  return self._awardsDaily
end

function FlashSaleShopItem:SetAwardsDaily(awardsDaily)
  self._awardsDaily = awardsDaily
end

function FlashSaleShopItem:GetNew()
  local record = UIShopToolFunctions.GetLocalDBInt(self._id, 0)
  return record <= 0
end

function FlashSaleShopItem:SetNew(new)
  local record = 0
  if not new then
    record = 1
  end
  UIShopToolFunctions.SetLocalDBInt(self._id, record)
end

_class("FlashSaleShopItemAward", Object)
FlashSaleShopItemAward = FlashSaleShopItemAward

function FlashSaleShopItemAward:Constructor(templateId, count)
  self._templateId = templateId
  self._count = count
  local cfg = Cfg.cfg_item[self._templateId]
  if cfg then
    self._name = StringTable.Get(cfg.Name)
    self._icon = cfg.Icon
  end
end

function FlashSaleShopItemAward:GetTemplateId()
  return self._templateId
end

function FlashSaleShopItemAward:GetIcon()
  return self._icon
end

function FlashSaleShopItemAward:GetName()
  return self._name
end

function FlashSaleShopItemAward:GetCount()
  return self._count
end
