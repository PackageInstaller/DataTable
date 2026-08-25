local MainShopData = DataCenter.mainShopData
local MainShopDataUtils = {}

function MainShopDataUtils.ResetAll()
  MainShopData.shopData = {}
  MainShopData.exchangeNum = 0
  MainShopData.isInit = false
end

function MainShopDataUtils.GetCfg(shopTid)
  if not shopTid then
    return nil
  end
  return DT.Shop[shopTid]
end

function MainShopDataUtils.GetCfgByField(field, shopTid)
  if not field or not shopTid then
    return nil
  end
  local cfg = MainShopDataUtils.GetCfg(shopTid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function MainShopDataUtils.IsInitData()
  return MainShopData.isInit == true
end

function MainShopDataUtils.GetShopTypeIDByTag(mainShopTypeTag)
  for _, cfg in pairs(DT.ShopType) do
    if cfg.TypeTag == mainShopTypeTag then
      return cfg.ID
    end
  end
  return nil
end

function MainShopDataUtils.GetShopItemList(curShopType, ignoreSort)
  local shopRealType = MainShopDataUtils.GetShopRealType(curShopType)
  local data = shopRealType and MainShopDataUtils.GetShopGoodsList(shopRealType) or nil
  if not data then
    return {}
  end
  local tmpList = {}
  local chipFixedDatas = MainShopDataUtils.GetAwakerChipItems(data)
  local tmp = chipFixedDatas
  for _, shopData in pairs(tmp) do
    local shopTid = shopData.tid
    local itemTid = shopData.itemTid
    local shopCfg = DT.Shop[shopTid] or {}
    if itemTid == CommonDefine.CurrencyType.FreePayMoney and MainShopDataUtils.IsShopSellOut(shopData) then
    elseif CommonDefine.MainShopTypeTag.GiftBag == curShopType and MainShopDataUtils.GetShopItemLockedReason(shopData.tid) then
    elseif not MainShopDataUtils.CheckShopItemIsOnSale(shopData) then
    elseif shopCfg.UnlockCondType == CommonDefine.ShopUnlockType.StageFirstClear then
      if curShopType == CommonDefine.MainShopTypeTag.GiftBag and not MainShopDataUtils.CheckStageFirstClearGoodCanShow(shopData) then
      elseif curShopType ~= CommonDefine.MainShopTypeTag.GoldShop and MainShopDataUtils.IsShopSellOut(shopData) then
      else
        table.insert(tmpList, shopData)
      end
    end
  end
  if curShopType == CommonDefine.MainShopTypeTag.GiftBag then
    local shopDatas = MainShopDataUtils.GetShopDataByTag(CommonDefine.MainShopTypeTag.DailyFreeGiftBagShop)
    local goodsList = shopDatas and shopDatas.goodsList
    for _, shopData in ipairs(goodsList or {}) do
      if MainShopDataUtils.CanBuy(shopData) then
        table.insert(tmpList, shopData)
      end
    end
  end
  table.sort(tmpList, function(a, b)
    local aIsMaxPotency = MainShopDataUtils.IsMaxPotencyByShopId(a.tid) and 1 or 0
    local bIsMaxPotency = MainShopDataUtils.IsMaxPotencyByShopId(b.tid) and 1 or 0
    local aSortId = DT.Shop[a.tid] and DT.Shop[a.tid].SortID or 999999
    local bSortId = DT.Shop[b.tid] and DT.Shop[b.tid].SortID or 999999
    local aTier = MainShopDataUtils.GetShopItemDisplayTier(a)
    local bTier = MainShopDataUtils.GetShopItemDisplayTier(b)
    if aIsMaxPotency ~= bIsMaxPotency then
      return aIsMaxPotency < bIsMaxPotency
    end
    if curShopType == CommonDefine.MainShopTypeTag.ClothersShop then
      local aSkinHaved = AwakerSkinUtils.IsOwnSkin(a.tid) == false and 0 or 1
      local bSkinHaved = AwakerSkinUtils.IsOwnSkin(b.tid) == false and 0 or 1
      if aSkinHaved ~= bSkinHaved then
        return aSkinHaved < bSkinHaved
      end
    end
    if aTier ~= bTier then
      return aTier < bTier
    end
    if a.price ~= b.price and (0 == a.price or 0 == b.price) then
      if 0 == a.price then
        return true
      end
      return false
    end
    return aSortId < bSortId
  end)
  if curShopType == CommonDefine.MainShopTypeTag.GiftBag then
    local soldOutPos = #tmpList + 1
    for idx, item in ipairs(tmpList) do
      if item.isSell == true then
        soldOutPos = idx
        break
      end
    end
    local freeGoodsPos = 1
    for idx, item in ipairs(tmpList) do
      if 0 == item.price then
        freeGoodsPos = idx + 1
        break
      end
    end
    local conditionLevel = DT.GetConstant("EnergyMonthlyCardDisplayConditions") or 0
    if conditionLevel <= DataCenter.playerData.DRole.level then
      local monthCardState = MainShopDataUtils.GetEnergyMonthCardState()
      if monthCardState == CommonDefine.MonthCardState.InEffect then
        table.insert(tmpList, soldOutPos, CommonDefine.MonthCardType.Energy)
      else
        table.insert(tmpList, freeGoodsPos, CommonDefine.MonthCardType.Energy)
      end
    end
  end
  return tmpList
end

function MainShopDataUtils.IsHaveFreeGoods()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Shop, 0)
  if not unlocked then
    return false
  end
  for _, shopType in pairs(CommonDefine.MainShopTypeTag) do
    local isFree, redType = MainShopDataUtils.IsHaveFreeGoodsInShopType(shopType)
    if isFree then
      return true, redType
    end
  end
  return false
end

function MainShopDataUtils.IsHaveFreeGoodsInShopType(shopType)
  local realTypeTid = MainShopDataUtils.GetShopRealType(shopType)
  local featureId = PlayerDataUtils.GetFeatureConfigByTypeAndKey(CommonDefine.FeatureId.Shop, realTypeTid)
  if featureId then
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Shop, realTypeTid)
    if not unlocked then
      return false
    end
  end
  local shopItemList = MainShopDataUtils.GetShopItemList(shopType, true)
  for _, shopItem in ipairs(shopItemList) do
    local goodsConfig = DT.Shop[shopItem.tid] or {}
    if MainShopDataUtils.IsFreeShopItem(shopItem) then
      if LimitTimeGiftUtils.IsExpiredLimitGiftShopItem(shopItem.tid) then
      else
        do return true end
        if shopType == cd.MainShopTypeTag.ClothersShop and goodsConfig.OnSaleDate and RedPointDataUtils.IsLimitGoodFirstOpen(shopItem.tid) then
          return true, RedPointDataUtils.RedAttrType.IsNew
        end
      end
    end
  end
  return false
end

function MainShopDataUtils.IsFreeShopItem(shopItem)
  if 0 == shopItem.price and not shopItem.lock and MainShopDataUtils.CanBuy(shopItem) then
    return true
  end
end

function MainShopDataUtils.OnRefreshChargeData(data)
  for key, value in pairs(data.isDoubleSign or {}) do
    MainShopData.chargeData[key] = value
  end
  MainShopDataUtils.SetExchangeNum(data.exchangeNum)
end

function MainShopDataUtils.FindShopItemIndex(list, tid)
  for i, shopItem in ipairs(list) do
    if shopItem.tid == tid then
      return i
    end
  end
end

function MainShopDataUtils.GetMonthCardItemInfo()
  if not MainShopDataUtils.monthCardItemInfo then
    local itemInfo = {}
    local buyAwardCfg = DT.Constant.MonthlyCardBuyAward.Data
    itemInfo.buyItem = {
      tid = buyAwardCfg[1],
      count = buyAwardCfg[2]
    }
    local dailyAwardCfg = DT.Constant.MonthlyCardDailyAward.Data
    itemInfo.dailyItem = {
      tid = dailyAwardCfg[1],
      count = dailyAwardCfg[2]
    }
    MainShopDataUtils.monthCardItemInfo = itemInfo
  end
  return MainShopDataUtils.monthCardItemInfo
end

function MainShopDataUtils.RequestMonthCardInfo(callback, monthCardType)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "SyncMonthCard", function(svrData)
    Logger.Info("SyncMonthCard Successful data ", table.tostring(svrData))
    if "table" ~= type(svrData) then
      return
    end
    if callback then
      callback(svrData)
    end
  end, function(svrData)
    Logger.Info("SyncMonthCard Failed data ", table.tostring(svrData))
  end, monthCardType)
end

function MainShopDataUtils.ReqOnShopOneKeyBuy(shopTypeId, goodTid2Nume, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnShopOneKeyBuy", function(svrData)
    Logger.Info("OnShopOneKeyBuy Successful data ", table.tostring(svrData))
    MainShopDataUtils.OnUpdateShopGoods(svrData)
    if callback then
      callback()
    end
  end, function(svrData)
    Logger.Info("OnShopOneKeyBuy Failed data ", table.tostring(svrData))
  end, shopTypeId, goodTid2Nume)
end

function MainShopDataUtils.PurchaseMonthCard(callback, monthCardType)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "PurchaseMonthCard", function(svrData)
    Logger.Info("SyncMonthCard PurchaseMonthCard data ", table.tostring(svrData))
    if callback then
      callback()
    end
    ShopController.Instance:OnMonthCardDataChanged(monthCardType)
  end, function(svrData)
    Logger.Info("PurchaseMonthCard Failed data ", table.tostring(svrData))
  end, monthCardType)
end

function MainShopDataUtils.ReceiveRewards(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "GainTodayReward", function()
    if callback then
      callback()
    end
  end)
end

function MainShopDataUtils.CheckShopItemIsOnSale(shopData)
  local shopId = shopData.tid
  local shopCfg = DT.Shop[shopId]
  if not shopCfg then
    return false
  end
  local onSaleTs = shopCfg.OnSaleDate and tonumber(shopCfg.OnSaleDate)
  local offSaleTs = shopCfg.OffSaleDate and tonumber(shopCfg.OffSaleDate)
  offSaleTs = shopData.expireTs and shopData.expireTs or offSaleTs
  local curTs = TimeUtils.GetServerTime()
  if offSaleTs and offSaleTs < curTs then
    return false
  end
  if not onSaleTs or onSaleTs < curTs then
    return true
  end
  return true
end

function MainShopDataUtils.CheckSHopItemHasDeadline(shopData)
  local shopId = shopData.tid
  local shopCfg = DT.Shop[shopId]
  if not shopCfg then
    return false
  end
  local result = shopCfg.OffSaleDate and true or false
  result = shopData.expireTs and true or result
  return result
end

function MainShopDataUtils.OnFreshShop(data)
  for tid, shopItem in pairs(data) do
    local shopType = shopItem.shopType
    local typeData = MainShopData.shopData[shopType]
    local list = typeData and typeData.goodsList or nil
    if list then
      local index = MainShopDataUtils.FindShopItemIndex(list, tid)
      if index then
        list[index] = shopItem.data
      else
        table.insert(list, shopItem.data)
      end
    end
  end
  RedPointDataUtils.UpdateShopRed()
end

function MainShopDataUtils.SortAllGoods(data)
  for shopType, v in pairs(data) do
    if data[shopType] and data[shopType].goodsList then
      data[shopType].goodsList = MainShopDataUtils.SortGoods(shopType, v.goodsList)
    end
  end
  return data
end

function MainShopDataUtils.SetSortId(list)
  for _, item in pairs(list) do
    local config = DT.Shop[item.tid]
    item.SortID = config.SortID
  end
end

function MainShopDataUtils.SortGoods(curShopType, data)
  for i = #data, 1, -1 do
    local item = data[i]
    if not DT.Shop[item.tid] then
      Logger.Warn("Cannot find shop config and remove item :" .. item.tid)
      table.remove(data, i)
    end
  end
  table.sort(data, function(a, b)
    local aIsMaxPotency = MainShopDataUtils.IsMaxPotencyByShopId(a.tid) and 1 or 0
    local bIsMaxPotency = MainShopDataUtils.IsMaxPotencyByShopId(b.tid) and 1 or 0
    local aSortId = DT.Shop[a.tid].SortID
    local bSortId = DT.Shop[b.tid].SortID
    local aTier = MainShopDataUtils.GetShopItemDisplayTier(a)
    local bTier = MainShopDataUtils.GetShopItemDisplayTier(b)
    if aIsMaxPotency ~= bIsMaxPotency then
      return aIsMaxPotency < bIsMaxPotency
    end
    if curShopType == CommonDefine.MainShopTypeTag.ClothersShop then
      local aSkinHaved = AwakerSkinUtils.IsOwnSkin(a.tid) == false and 0 or 1
      local bSkinHaved = AwakerSkinUtils.IsOwnSkin(b.tid) == false and 0 or 1
      if aSkinHaved ~= bSkinHaved then
        return aSkinHaved < bSkinHaved
      end
    end
    if aTier ~= bTier then
      return aTier < bTier
    end
    if a.price ~= b.price and (0 == a.price or 0 == b.price) then
      if 0 == a.price then
        return true
      end
      return false
    end
    return aSortId < bSortId
  end)
  return data
end

function MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(typeTag)
  if typeTag == CommonDefine.MainShopTypeTag.BattlePassReview then
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.BattlePass, 0)
    return unlocked
  end
  local shopKey = MainShopDataUtils.GetShopRealType(typeTag)
  if not shopKey then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Shop, shopKey)
  return unlocked
end

function MainShopDataUtils.IsShopInOpenTime(shopTypeTid)
  if not shopTypeTid then
    return true
  end
  local shopCfg = DT.ShopType[shopTypeTid]
  if not shopCfg then
    return false
  end
  local openTs = shopCfg.ShopOpenDate
  local closeTs = shopCfg.ShopCloseDate
  local curTs = TimeUtils.GetServerTime()
  local alertTips
  if openTs and openTs > curTs then
    local leftTime = openTs - curTs
    local day, hour, min = TimeUtils.GetDayHourMin(leftTime)
    if day > 0 then
      local tipType = DT.TipsType[20211]
      alertTips = LT.Textf(tipType.Desc, day, hour)
    else
      local tipType = DT.TipsType[20212]
      alertTips = LT.Textf(tipType.Desc, hour, min)
    end
  end
  local openData = {
    ShopOpenDate = shopCfg.ShopOpenDate,
    ShopCloseDate = shopCfg.ShopCloseDate,
    AlertTips = alertTips
  }
  return curTs >= (openTs or 0) and curTs <= (closeTs or math.maxinteger), openData
end

function MainShopDataUtils.IsShopTid(tid)
  return DT.ShopType[tid] ~= nil
end

function MainShopDataUtils.GetShopTypeByShopTid(shopTid)
  local shopTypeCfg = DT.ShopType[shopTid]
  return shopTypeCfg and shopTypeCfg.TypeTag
end

function MainShopDataUtils.IsShopOpen(shopTid)
  if not MainShopDataUtils.IsShopTid(shopTid) then
    return false
  end
  local shopData = MainShopDataUtils.GetShopData(shopTid)
  if shopData then
    return true
  end
end

function MainShopDataUtils.OnUpdateShopGoods(data)
  local goodsList = MainShopDataUtils.GetShopGoodsList(data.shopType)
  if goodsList then
    local uids = data.uids or {}
    local needResort = false
    local priceChange = {}
    for _, v in ipairs(goodsList) do
      for _, val in ipairs(uids) do
        if v.uid == val.uid then
          if v.isSell ~= val.isSell then
            needResort = true
          end
          if v.price < val.price then
            table.insert(priceChange, v.itemTid)
          end
          v.isSell = val.isSell
          v.price = val.price
          v.buyCount = val.buyCount or v.buyCount + 1
          v.maxBuyCount = val.maxBuyCount
          v.refreshTime = val.refreshTime or val.refreshTime
        end
      end
    end
    if needResort then
      goodsList = MainShopDataUtils.SortGoods(data.shopType, goodsList)
      local shopData = MainShopDataUtils.GetShopData(data.shopType)
      shopData.goodsList = goodsList
    end
    RedPointDataUtils.UpdateShopRed()
    local tipConfig = DT.TipsType[10461]
    local str = tipConfig.Desc
    for _, itemId in ipairs(priceChange) do
      Alert.ShowStr(LT.Textf(str, ItemDataUtils.GetItemName(itemId)))
    end
  end
end

function MainShopDataUtils.HasFreeGoods(shopType)
  local shopInfo = MainShopDataUtils.GetShopData(shopType)
  if shopInfo then
    for _, v in ipairs(shopInfo) do
      if v.isSell == false and 0 == v.price and false == v.lock then
        return true
      end
    end
  end
  return false
end

function MainShopDataUtils.IsShopSellOut(shopData)
  local BuyLimit = MainShopDataUtils.GetLimitNum(shopData)
  local buyCount = shopData.buyCount
  return BuyLimit and BuyLimit <= buyCount or false
end

function MainShopDataUtils.IsPlayerAvatarOwned(shopData)
  if not shopData then
    return false
  end
  local itemList = shopData.itemList
  local tid = itemList and itemList[1]
  if not tid then
    return false
  end
  local itemCfg = DT.Item[tid]
  if not itemCfg or itemCfg.SubType ~= CommonDefine.ItemSubType.PlayerAvatar then
    return false
  end
  return (ItemDataUtils.GetItemNum(tid) or 0) > 0
end

function MainShopDataUtils.GetShopItemDisplayTier(shopData)
  if not shopData then
    return 0
  end
  if MainShopDataUtils.IsShopSellOut(shopData) then
    return 3
  end
  if MainShopDataUtils.IsPlayerAvatarOwned(shopData) then
    return 2
  end
  if MainShopDataUtils.GetShopItemLockedReason(shopData.tid) then
    return 1
  end
  return 0
end

function MainShopDataUtils.GetShopItemLockedReason(shopCfgId)
  local goodsConfig = DT.Shop[shopCfgId] or {}
  if goodsConfig.PlayerLevelCondition then
    local levelCondType = CommonDefine.ShopUnlockType.PlayerLevelCondition
    if MainShopDataUtils.ShopUnlockType2FuncMap[levelCondType] and MainShopDataUtils.ShopUnlockType2FuncMap[levelCondType].CheckLockFunc and MainShopDataUtils.ShopUnlockType2FuncMap[levelCondType].CheckLockFunc(goodsConfig) then
      return levelCondType
    end
  end
  local conditionType = goodsConfig.UnlockCondType
  if not conditionType then
    return nil
  end
  if MainShopDataUtils.ShopUnlockType2FuncMap[conditionType] and MainShopDataUtils.ShopUnlockType2FuncMap[conditionType].CheckLockFunc then
    return MainShopDataUtils.ShopUnlockType2FuncMap[conditionType].CheckLockFunc(goodsConfig) and conditionType or nil
  end
  return nil
end

function MainShopDataUtils.CanBuy(shopData)
  local unlock = not MainShopDataUtils.GetShopItemLockedReason(shopData.tid)
  local noSellOut = not MainShopDataUtils.IsShopSellOut(shopData)
  return unlock and noSellOut
end

function MainShopDataUtils.GetLockShopStr(shopCfgId)
  local goodsConfig = DT.Shop[shopCfgId]
  local unlockType = MainShopDataUtils.GetShopItemLockedReason(shopCfgId)
  if MainShopDataUtils.ShopUnlockType2FuncMap[unlockType] and MainShopDataUtils.ShopUnlockType2FuncMap[unlockType].GetLockShopStrFunc then
    do return MainShopDataUtils.ShopUnlockType2FuncMap[unlockType].GetLockShopStrFunc end
    return MainShopDataUtils.ShopUnlockType2FuncMap[unlockType].GetLockShopStrFunc, goodsConfig
  end
  return ""
end

function MainShopDataUtils.IsAwakerOrChip(itemId)
  local itemCfg = DT.Item[itemId]
  local itemType = itemCfg.Type
  local itemSubType = itemCfg.SubType
  if itemType == CommonDefine.ItemType.AwakerItem then
    return true
  elseif itemSubType == CommonDefine.ItemSubType.AwakerChip then
    return true
  else
    return false
  end
end

function MainShopDataUtils.IsAwaker(itemId)
  local itemCfg = DT.Item[itemId]
  local itemType = itemCfg.Type
  if itemType == CommonDefine.ItemType.AwakerItem then
    return true
  else
    return false
  end
end

function MainShopDataUtils.IsAwakerByShopId(shopCfgId)
  local goodsConfig = DT.Shop[shopCfgId]
  local itemId = goodsConfig.Item[1]
  do return MainShopDataUtils.IsAwaker end
  return MainShopDataUtils.IsAwaker, itemId
end

function MainShopDataUtils.IsMaxPotencyByShopId(shopCfgId)
  local goodsConfig = DT.Shop[shopCfgId]
  if not goodsConfig or not goodsConfig.Item then
    return false
  end
  local itemId = goodsConfig.Item[1]
  if not itemId then
    return false
  end
  do return MainShopDataUtils.IsMaxPotencyByItemId end
  return MainShopDataUtils.IsMaxPotencyByItemId, itemId
end

function MainShopDataUtils.IsMoonCardEndTsGreaterCurTs()
  local endTs = MainShopDataUtils.GetMoonCardEndTs()
  local curTs = TimeUtils.GetServerTime()
  return endTs > curTs
end

function MainShopDataUtils.IsMaxPotencyByItemId(itemId)
  local awakerId = MainShopDataUtils.GetAwakerId(itemId)
  if awakerId then
    if AwakerDataUtils.IsAwakerPotencyMax(awakerId) then
      return true
    end
    if ItemDataUtils.IsAwakerChipOverFlow(itemId) then
      return true
    end
  end
  local itemType = ItemCfgUtils.GetCfgField("Type", itemId)
  if itemType == CommonDefine.ItemType.Weapon then
    local itemData = ItemDataUtils.GetItemByTid(itemId)
    return itemData and itemData.level >= DT.GetConstant("UnLockExtraSSRWeaponLv")
  end
  return false
end

function MainShopDataUtils.GetCanBuyChipNum(itemTid)
  local itemCfg = DT.Item[itemTid]
  if not ItemDataUtils.IsAwakerChip(itemTid) then
    return 0
  end
  local awakerChipNum = ItemDataUtils.GetItemNum(itemTid)
  local awakerTid = itemCfg.SpParam[1]
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local awakerPotencyLevel = awakerData and AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency) or 0
  local chipMaxOwnedNum = DT.GetConstant("AwakerChipMaxOwnedNum")
  do return math.max, chipMaxOwnedNum - (awakerChipNum + awakerPotencyLevel) end
  return math.max, chipMaxOwnedNum - (awakerChipNum + awakerPotencyLevel), 0
end

function MainShopDataUtils.OnOpenShop(shopType, onClose)
  MainShopDataUtils.RequestMonthCardInfo(function(svrData)
    MainShopDataUtils.UpdateEnergyMonthBySvrData(svrData)
  end, CommonDefine.MonthCardType.Energy)
  if MainShopData.isInit then
    UIManager.Instance:Reopen(Urls.MainShopPanel, shopType, onClose)
  else
    MainShopDataUtils.ReqShopData(function(_)
      UIManager.Instance:Reopen(Urls.MainShopPanel, shopType, onClose)
    end)
  end
end

function MainShopDataUtils.OpenAwakerClipOptionalPanel(itemTid, goodsTid)
  UIManager.Instance:Reopen(Urls.AwakerClipOptionalPanel, itemTid, goodsTid)
end

function MainShopDataUtils.OpenEnergyMonthCardExchangePanel()
  UIManager.Instance:Reopen(Urls.MainShopEnergyMonthCardTips)
end

function MainShopDataUtils.ReqShopData(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenShop", function(data)
    Logger.Debug("OnOpenShop Successful data", table.tostring(data))
    MainShopData.shopData = MainShopDataUtils.SortAllGoods(data)
    MainShopData.isInit = true
    RedPointDataUtils.UpdateShopRed()
    if callback then
      callback(data)
    end
  end, function(_)
    Logger.Debug("reqShopData Error")
  end)
end

function MainShopDataUtils.ReqOnShopBuyGoods(uid, shopType, num, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnShopBuyGoods", function(data)
    Logger.Debug("OnShopBuyGoods Successful data", table.tostring(data))
    MainShopDataUtils.OnUpdateShopGoods(data)
    if callback then
      callback(data)
    end
    ShopExtModel.Instance:LocalNotify(NotifyId.OnUpdateShopGoodsList, data.shopType)
  end, nil, uid, shopType, num)
end

function MainShopDataUtils.ReqBuyItem(shopItemTid, num, callback)
  local shopCfg = MainShopDataUtils.GetCfg(shopItemTid or 0)
  if not shopCfg then
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnShopBuyGoods", function(data)
    Logger.Debug("OnShopBuyGoods Successful data", table.tostring(data))
    if callback then
      callback(data)
    end
    ShopExtModel.Instance:LocalNotify(NotifyId.OnUpdateShopGoodsList, data.shopType)
  end, nil, shopItemTid, shopCfg.ShopType, num or 1)
end

function MainShopDataUtils.AlertBuyItem(uid, num, callback, costItemTid, costAmount)
  if not costItemTid or not costAmount then
    costItemTid, costAmount = MainShopDataUtils.GetCfgCostItemAndAmount(uid)
    costAmount = costAmount * num
  end
  if ItemDataUtils.IsPayMoneyType(costItemTid) then
    Alert.ShowPayMoneyBuyConfirm(costAmount, function()
      MainShopDataUtils.ReqBuyItem(uid, num, callback)
    end)
  else
    Alert.ShowWithParams(20216, {
      ItemDataUtils.GetItemName(costItemTid),
      costAmount
    }, nil, function()
      MainShopDataUtils.ReqBuyItem(uid, num, callback)
    end)
  end
end

function MainShopDataUtils.ReqOnChooseBuy(goodTid, chooseTids, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnChooseBuy", function(data)
    Logger.Debug("OnChooseBuy Successful data", table.tostring(data))
    MainShopDataUtils.OnUpdateShopGoods(data)
    if callback then
      callback(data)
    end
  end, function(_, data)
    Logger.Debug("OnChooseBuy failed data", table.tostring(data))
  end, goodTid, chooseTids)
end

function MainShopDataUtils.ReqOnBuyMultipleChooseItem(shopItemId, params, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnBuyMultipleChooseItem", function(data)
    Logger.Debug("OnBuyMultipleChooseItem Successful data", table.tostring(data))
    MainShopDataUtils.OnUpdateShopGoods(data)
    if callback then
      callback(data)
    end
    ShopExtModel.Instance:LocalNotify(NotifyId.OnUpdateShopGoodsList, params.shopType)
  end, function(_, data)
    Logger.Debug("OnBuyMultipleChooseItem failed data", table.tostring(data))
  end, shopItemId, params)
end

function MainShopDataUtils.ReqShopRefresh(shopType, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnShopRefresh", function(data)
    Logger.Info("GameRequest OnShopRefresh Successful data", table.tostring(data))
    local newShopData = MainShopDataUtils.SortAllGoods(data)
    for key, val in pairs(newShopData) do
      MainShopDataUtils.SetShopDataByShopType(key, val)
    end
    if callback then
      callback()
    end
  end, nil, shopType)
end

function MainShopDataUtils.GetShopTypeCfgByTypeTag(typeTag)
  local rst = {}
  for _, cfg in pairs(DT.ShopType) do
    if cfg.TypeTag == typeTag then
      rst = cfg
      break
    end
  end
  return rst
end

function MainShopDataUtils.GetShopTypeCfg(shopTid)
  return DT.ShopType[shopTid]
end

function MainShopDataUtils.GetMonthCardRemainDays(endTs)
  if 0 == endTs then
    return 0
  end
  local countdown = endTs - TimeUtils.GetServerTime()
  do return TimeUtils.SecsToDays end
  return TimeUtils.SecsToDays, countdown
end

function MainShopDataUtils.GetEnergyMonthCardTs()
  return MainShopData.energyMonthCardTs
end

function MainShopDataUtils.GetEnergyMonthCardState()
  return MainShopData.energyMonthCardState
end

function MainShopDataUtils.GetShopRealType(tabShopType)
  local shopRealType = MainShopDataUtils.GetShopTypeIDByTag(tabShopType)
  return shopRealType
end

function MainShopDataUtils.GetShopTabType(realType)
  if not realType then
    return nil
  end
  for _, cfg in pairs(DT.ShopType) do
    if cfg.ID == realType then
      return cfg.TypeTag
    end
  end
  return nil
end

function MainShopDataUtils.GetShopData(shopType)
  if MainShopData.shopData[shopType] then
    return MainShopData.shopData[shopType]
  else
    return nil
  end
end

function MainShopDataUtils.GetShopDataByTid(shopTid)
  local shopCfg = DT.Shop[shopTid]
  if shopCfg and shopCfg.ShopType and MainShopData.shopData[shopCfg.ShopType] then
    local shopTypeData = MainShopDataUtils.GetShopData(shopCfg.ShopType)
    for _, shopItem in ipairs(shopTypeData.goodsList) do
      if shopItem.tid == shopTid then
        return shopItem
      end
    end
    return MainShopData.shopData[shopCfg.ShopType][shopCfg.ID]
  end
  return nil
end

function MainShopDataUtils.GetShopGoodsList(shopType)
  if MainShopData.shopData[shopType] then
    return MainShopData.shopData[shopType].goodsList
  else
    return nil
  end
end

function MainShopDataUtils.GetShopDataByTag(typeTag)
  local shopTypeId = MainShopDataUtils.GetShopTypeIDByTag(typeTag)
  if shopTypeId then
    do return MainShopDataUtils.GetShopData end
    return MainShopDataUtils.GetShopData, shopTypeId
  end
end

function MainShopDataUtils.GetShopGoodDataByItemTid(shopType, itemTid)
  if not shopType or not itemTid then
    return nil
  end
  if MainShopData.shopData[shopType] then
    for _, goodData in pairs(MainShopData.shopData[shopType].goodsList) do
      if goodData.itemTid == itemTid then
        return goodData
      end
    end
  end
  return nil
end

function MainShopDataUtils.CheckStageFirstClearGoodCanShow(shopData)
  return shopData.lock == false
end

function MainShopDataUtils.GetChargeData()
  return MainShopData.chargeData
end

function MainShopDataUtils.GetFreshCount(shopType)
  return MainShopData.shopData[shopType] and MainShopData.shopData[shopType].refreshCount or 0
end

function MainShopDataUtils.GetNextRefreshTs(shopType)
  return MainShopData.shopData[shopType] and MainShopData.shopData[shopType].nextRefreshTs or 0
end

function MainShopDataUtils.GetGoldShopRefreshRemainTimes()
  local refreshTimes = MainShopDataUtils.GetFreshCount(MainShopDataUtils.GetShopRealType(CommonDefine.MainShopTypeTag.GoldShop))
  local refreshPriceGroup = PlayerDataUtils.GetGoldShopRefeshGroup(PlayerDataUtils.GetLevel())
  local maxRefreshTimes = #refreshPriceGroup
  return maxRefreshTimes - refreshTimes
end

function MainShopDataUtils.GetFreshCost(shopType)
  local item = DT.ShopType[shopType].ShopRefreshItem
  if nil == item then
    return 0
  end
  local freshTime = MainShopDataUtils.GetFreshCount(shopType) + 1
  local count = math.min(freshTime, #item)
  return item[count]
end

function MainShopDataUtils.GetNextFreshTime(refreshTime)
  local leftTime = refreshTime - TimeUtils.GetServerTime()
  local days, hours, minutes = TimeUtils.ShopItemFormat(leftTime)
  if days >= 1 then
    do return LT.Textf, "UI_Recharge_Panel_DayShopItemRefresh", days end
    return LT.Textf, "UI_Recharge_Panel_DayShopItemRefresh", days, hours
  else
    do return LT.Textf, "UI_Recharge_Panel_DayShopItemRefresh_Hour", hours end
    return LT.Textf, "UI_Recharge_Panel_DayShopItemRefresh_Hour", hours, minutes
  end
end

function MainShopDataUtils.GetDeadline(OffSaleDate)
  local leftTime = tonumber(OffSaleDate) - TimeUtils.GetServerTime()
  local days, hours, minutes = TimeUtils.ShopItemFormat(leftTime)
  if days >= 1 then
    do return LT.Textf, "UI_Recharge_Panel_Deadline", days end
    return LT.Textf, "UI_Recharge_Panel_Deadline", days, hours
  else
    do return LT.Textf, "UI_Recharge_Panel_Deadline_Hour", hours end
    return LT.Textf, "UI_Recharge_Panel_Deadline_Hour", hours, minutes
  end
end

function MainShopDataUtils.GetSpecialSaleTimeText(specialSaleEndTime)
  local leftTime = tonumber(specialSaleEndTime) - TimeUtils.GetServerTime()
  local days, hours, minutes = TimeUtils.ShopItemFormat(leftTime)
  if days >= 1 then
    do return LT.Textf, "UI_Recharge_Panel_SpecialSaleDeadline", days end
    return LT.Textf, "UI_Recharge_Panel_SpecialSaleDeadline", days, hours
  else
    do return LT.Textf, "UI_Recharge_Panel_SpecialSaleDeadline_Hour", hours end
    return LT.Textf, "UI_Recharge_Panel_SpecialSaleDeadline_Hour", hours, minutes
  end
end

function MainShopDataUtils.GetRichStr(shopType)
  return DT.ShopType[shopType].ShopMoneyIcon or ""
end

function MainShopDataUtils.GetShopGoodTid(shopItemData)
  return shopItemData.itemList[1]
end

function MainShopDataUtils.GetGoodRemaining(shopItemData)
  if not shopItemData then
    return 0
  end
  local buyLimitNum = MainShopDataUtils.GetLimitNum(shopItemData)
  if not buyLimitNum then
    return 0
  end
  local rst = math.min(shopItemData.maxBuyCount, buyLimitNum) - shopItemData.buyCount
  local itemTid = shopItemData.itemTid
  local itemCfg = ItemCfgUtils.GetCfg(itemTid)
  if not itemCfg then
    return 0
  end
  local itemType = itemCfg.Type
  if itemType == cd.ItemType.Weapon and itemCfg.Quality == CommonDefine.CommonQuality.Orange then
    local allRefineLevel = ItemDataUtils.GetWeaponAllRefineLevelByTid(itemTid)
    rst = math.min(rst, DT.GetConstant("UnLockExtraSSRWeaponLv") + 1 - allRefineLevel)
  elseif ItemDataUtils.IsAwakerChip(itemTid) then
    rst = math.min(rst, ItemDataUtils.GetAwakerChipRemainOwnedNum(itemTid))
  end
  local pricingModel = MainShopDataUtils.GetCfgByField("PricingModel", shopItemData.tid)
  if pricingModel and 0 ~= pricingModel then
    rst = 1
  end
  return rst
end

function MainShopDataUtils.GetLimitNum(shopData)
  if -1 == shopData.maxBuyCount then
    return
  end
  local cfgBuyLimit = DT.Shop[shopData.tid] and DT.Shop[shopData.tid].BuyLimit
  if shopData.isMergeShop then
    return shopData.maxMergeBuyCount or shopData.maxBuyCount or cfgBuyLimit
  end
  return shopData.maxBuyCount or cfgBuyLimit
end

function MainShopDataUtils.GetFirstShopType()
  local shopTypeConfigs = DT.ShopType
  local returnType
  for _, config in pairs(shopTypeConfigs) do
    if 1 == config.SortID then
      returnType = config.ID
    end
  end
  return returnType
end

function MainShopDataUtils.GetMaxFreshCount(shopType)
  local configItem = DT.ShopType[shopType]
  if configItem then
    return configItem.ShopRefreshMaxTimes
  end
end

function MainShopDataUtils.GetShopRefresh(shopType)
  local shopData = MainShopData.shopData[shopType]
  local refreshCount = shopData.refreshCount
  local shopConfig = DT.ShopType[shopType]
  local refreshConsume = shopConfig.RefreshConsume
  if not refreshConsume then
    return
  end
  local refreshCostItem = refreshConsume[1]
  local refreshCost
  for index = 2, #refreshConsume do
    local data = refreshConsume[index]
    if refreshCount < data[1] then
      refreshCost = data[2]
      break
    end
  end
  return refreshCostItem, refreshCost
end

function MainShopDataUtils.GetShopCurrency(tid)
  return DT.Shop[tid].Price[1]
end

function MainShopDataUtils.CheckPlayerLevelConditionShopIsLock(goodsConfig)
  if not goodsConfig.PlayerLevelCondition then
    return nil
  end
  return PlayerDataUtils.GetLevel() < goodsConfig.PlayerLevelCondition
end

function MainShopDataUtils.CheckStageFirstClearShopIsLock(goodsConfig)
  if not goodsConfig.UnlockCondPara or not goodsConfig.UnlockCondPara[1] then
    return false
  end
  local stageId = goodsConfig.UnlockCondPara[1]
  return not MainCopyDataUtils.IsStageDataFirstFinish(stageId)
end

function MainShopDataUtils.CheckHaveSpecificItemShopIsLock(goodsConfig)
  if not goodsConfig.UnlockCondPara or 2 ~= #goodsConfig.UnlockCondPara then
    return false
  end
  local itemNeedNum, itemTid = goodsConfig.UnlockCondPara[1], goodsConfig.UnlockCondPara[2]
  local itemHaveNum = ItemDataUtils.GetItemNum(itemTid) or 0
  return itemNeedNum > itemHaveNum
end

function MainShopDataUtils.MergeShopData2Show(data)
  local tmp = {}
  local map = {}
  for i = #data, 1, -1 do
    local v = data[i]
    local shopCfg = DT.Shop[v.tid]
    local costItemTid = shopCfg and shopCfg.Price and shopCfg.Price[1] or 0
    local itemTid = v.itemTid
    local maxBuyCount = math.max(v.maxBuyCount or 0, 0)
    local price = v.price
    local key = 10000000 * costItemTid + 1000000 * itemTid + 100 * price + (1 * maxBuyCount or 0)
    if not map[key] then
      map[key] = {}
    end
    table.insert(map[key], v)
  end
  for _, v in pairs(map) do
    local mergeResult = v[1]
    if #v > 1 then
      MainShopDataUtils.SetSortId(v)
      table.sort(v, function(a, b)
        if a.SortID ~= b.SortID then
          return a.SortID < b.SortID
        end
        return a.tid < b.tid
      end)
      mergeResult = v[1]
      mergeResult = table.deepclone(mergeResult)
      mergeResult.isMergeShop = true
      mergeResult.maxMergeBuyCount = mergeResult.maxBuyCount
      for i = 2, #v do
        local change = false
        local compareItem = v[i]
        local compareUnlock = not MainShopDataUtils.GetShopItemLockedReason(compareItem.tid)
        local resultUnlock = not MainShopDataUtils.GetShopItemLockedReason(mergeResult.tid)
        if compareUnlock then
          if compareItem.buyCount <= 0 then
            if mergeResult.buyCount >= mergeResult.maxBuyCount then
              change = true
              mergeResult.isSell = false
            end
          else
            change = true
            mergeResult.isSell = true
          end
        elseif false == resultUnlock then
          if compareItem.SortID < mergeResult.SortID then
            change = true
            mergeResult.isSell = false
          end
        elseif mergeResult.buyCount >= mergeResult.maxBuyCount then
          change = true
          mergeResult.isSell = true
        end
        if change then
          mergeResult.tid = compareItem.tid
          mergeResult.uid = compareItem.uid
          mergeResult.SortID = compareItem.SortID
        end
        if compareUnlock then
          mergeResult.maxBuyCount = mergeResult.maxBuyCount + compareItem.maxBuyCount
          mergeResult.buyCount = mergeResult.buyCount + compareItem.buyCount
        end
        mergeResult.maxMergeBuyCount = mergeResult.maxMergeBuyCount + compareItem.maxBuyCount
      end
    end
    table.insert(tmp, mergeResult)
  end
  return tmp
end

function MainShopDataUtils.GetAwakerChipItems(data)
  local tmp = {}
  for _, v in ipairs(data) do
    local itemTid = v.itemTid
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    if not ItemDataUtils.IsAwakerChip(itemTid) or AwakerDataUtils.HasOwnedAwaker(awakerTid) then
      table.insert(tmp, v)
    end
  end
  return tmp
end

function MainShopDataUtils.GetAwakerId(itemId)
  local itemCfg = DT.Item[itemId]
  local isAwakerChip = MainShopDataUtils.IsAwakerOrChip(itemId)
  local awakerId = isAwakerChip and itemCfg.SpParam and itemCfg.SpParam[1] or 0
  return awakerId
end

function MainShopDataUtils.GetMoonCardPurchased()
  return MainShopData.moonCardPurchased
end

function MainShopDataUtils.GetMoonCardEndTs()
  return MainShopData.moonCardEndTs
end

function MainShopDataUtils.GetMoonCardCountDownDay()
  if not MainShopDataUtils.IsMoonCardEndTsGreaterCurTs() then
    return 0
  end
  local endTs = MainShopDataUtils.GetMoonCardEndTs()
  local curTs = TimeUtils.GetServerTime()
  do return TimeUtils.ConvertTime end
  return TimeUtils.ConvertTime, endTs - curTs
end

function MainShopDataUtils.GetExchangeNum()
  return MainShopData.exchangeNum
end

function MainShopDataUtils.GetCfgCostItemAndAmount(shopItemTid)
  local shopItemCfg = DT.Shop[shopItemTid]
  if not shopItemCfg then
    return
  end
  if shopItemCfg.SpecialSalesPrice then
    local specialSaleEndTime = shopItemCfg.SpecialSalesEndTime or math.huge
    if specialSaleEndTime > TimeUtils.GetServerTime() then
      return shopItemCfg.SpecialSalesPrice[1], shopItemCfg.SpecialSalesPrice[2]
    end
  end
  return shopItemCfg.Price[1], shopItemCfg.Price[2]
end

function MainShopDataUtils.CheckPayMoneyEnough(costItemTid, costAmount, isShowBuyTip)
  if ItemDataUtils.IsPayMoneyType(costItemTid) then
    if costAmount <= ItemDataUtils.GetPayMoneyTotalNum() then
      print("pay money is enough")
      return true
    end
    if isShowBuyTip then
      DiamondShopDataUtils.ChargeNotEnoughTips()
    end
    return false
  end
  print("check pay money enough : param costItemTid is not pay money tid", costItemTid, cd.CurrencyType.PayMoney)
  return true
end

function MainShopDataUtils.IsOwnSkinInSale(shopTid)
  local shopItemCfg = MainShopDataUtils.GetCfg(shopTid)
  local saleItemList = shopItemCfg and shopItemCfg.Item
  local saleItemTid = saleItemList and saleItemList[1]
  if not saleItemTid then
    return
  end
  local itemCfg = ItemCfgUtils.GetCfg(saleItemTid)
  if itemCfg.Type == cd.ItemType.SkinItem and AwakerSkinUtils.IsOwnSkin(saleItemTid) then
    return true
  end
end

function MainShopDataUtils.SetExchangeNum(numVal)
  MainShopData.exchangeNum = numVal or 0
end

function MainShopDataUtils.SetShopDataByShopType(shopType, data)
  MainShopData.shopData[shopType] = data
end

function MainShopDataUtils.SetEnergyMonthCardTs(numVal)
  if not numVal then
    Logger.Error("Error Val: ", numVal)
  end
  MainShopData.energyMonthCardTs = numVal
end

function MainShopDataUtils.SetEnergyMonthCardState(numVal)
  if not numVal then
    Logger.Error("Error Val: ", numVal)
  end
  MainShopData.energyMonthCardState = numVal
end

function MainShopDataUtils.SetMoonCardPurchased(boolVal)
  if nil == boolVal then
    Logger.Error("Error Val: ", boolVal)
  end
  MainShopData.moonCardPurchased = boolVal
end

function MainShopDataUtils.SetMoonCardEndTs(numVal)
  if not numVal then
    Logger.Error("Error Val: ", numVal)
  end
  MainShopData.moonCardEndTs = numVal
end

function MainShopDataUtils.UpdateEnergyMonthBySvrData(svrData)
  MainShopDataUtils.SetEnergyMonthCardTs(svrData.expireTime)
  local monthCardState
  if 0 == svrData.expireTime then
    monthCardState = CommonDefine.MonthCardState.NeverPurchased
  elseif TimeUtils.GetServerTime() < svrData.expireTime then
    monthCardState = CommonDefine.MonthCardState.InEffect
  else
    monthCardState = CommonDefine.MonthCardState.Expired
  end
  MainShopDataUtils.SetEnergyMonthCardState(monthCardState)
end

function MainShopDataUtils.GetStageFirstClearLockStr(goodsConfig)
  do return LT.Text end
  return LT.Text, goodsConfig.UnlockText
end

function MainShopDataUtils.GetHaveSpecificItemLockStr(goodsConfig)
  if not goodsConfig.UnlockCondPara or 2 ~= #goodsConfig.UnlockCondPara then
    return ""
  end
  local _, itemTid = goodsConfig.UnlockCondPara[1], goodsConfig.UnlockCondPara[2]
  local itemName = ItemDataUtils.GetItemName(tonumber(itemTid))
  do return LT.Textf, "UI_Recharge_Panel_HaveItemCondition" end
  return LT.Textf, "UI_Recharge_Panel_HaveItemCondition", itemName
end

function MainShopDataUtils.GetPlayerLevelConditionLockStr(goodsConfig)
  do return LT.Textf, "UI_Recharge_Panel_PlayerLevelCondition" end
  return LT.Textf, "UI_Recharge_Panel_PlayerLevelCondition", goodsConfig.PlayerLevelCondition
end

MainShopDataUtils.ShopUnlockType2FuncMap = {
  [CommonDefine.ShopUnlockType.StageFirstClear] = {
    CheckLockFunc = MainShopDataUtils.CheckStageFirstClearShopIsLock,
    GetLockShopStrFunc = MainShopDataUtils.GetStageFirstClearLockStr
  },
  [CommonDefine.ShopUnlockType.HaveSpecificItem] = {
    CheckLockFunc = MainShopDataUtils.CheckHaveSpecificItemShopIsLock,
    GetLockShopStrFunc = MainShopDataUtils.GetHaveSpecificItemLockStr
  },
  [CommonDefine.ShopUnlockType.PlayerLevelCondition] = {
    CheckLockFunc = MainShopDataUtils.CheckPlayerLevelConditionShopIsLock,
    GetLockShopStrFunc = MainShopDataUtils.GetPlayerLevelConditionLockStr
  }
}

function MainShopDataUtils.GetMultiShopFirstUnlockTypeTag(targetTypeTag)
  local multiUIGroups = MainShopDataUtils.GetMultiUIGroups()
  local typeTagList = multiUIGroups and multiUIGroups[targetTypeTag] or {}
  for _, typeTag in ipairs(typeTagList) do
    if MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(typeTag) then
      return typeTag
    end
  end
  return nil
end

function MainShopDataUtils.GetMultiUIGroups()
  if MainShopDataUtils.multiUIGroups then
    return MainShopDataUtils.multiUIGroups
  end
  local ret = {}
  for _, shopTypeCfg in pairs(DT.ShopType) do
    if shopTypeCfg.MainShopType and 0 ~= shopTypeCfg.MainShopType[1] then
      local parentTypeTag = DT.ShopType[shopTypeCfg.MainShopType[2]].TypeTag
      if not ret[parentTypeTag] then
        ret[parentTypeTag] = {}
      end
      table.insert(ret[parentTypeTag], shopTypeCfg.TypeTag)
    end
  end
  for _, uiGroup in pairs(ret) do
    table.sort(uiGroup, function(aTypeTag, bTypeTag)
      local aBaseSortId = MainShopDataUtils.GetShopTypeCfgByTypeTag(aTypeTag).BaseSortID
      local bBaseSortId = MainShopDataUtils.GetShopTypeCfgByTypeTag(bTypeTag).BaseSortID
      return aBaseSortId < bBaseSortId
    end)
  end
  MainShopDataUtils.multiUIGroups = ret
  return MainShopDataUtils.multiUIGroups
end

return MainShopDataUtils
