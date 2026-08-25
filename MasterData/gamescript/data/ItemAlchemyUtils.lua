local Item = ItemDataUtils.GetItemNum
local ItemAlchemyUtils = {}

function ItemAlchemyUtils.CheckItemEnough(requireItem)
  local _, _, money = ItemAlchemyUtils.ItemAlchemyCompose(requireItem)
  return nil ~= money
end

function ItemAlchemyUtils.ItemAlchemyCompose(requireItem)
  if not requireItem then
    return nil, nil, nil
  end
  local needItems = {}
  local targetItems = {}
  local moneyId = DT.GetConstant("GoldItemTid")
  local moneyNeed = 0
  for _, itemData in pairs(requireItem) do
    local needCount = math.max(itemData.count - Item(itemData.id), 0)
    if itemData.id == moneyId then
      moneyNeed = itemData.count
    end
    local singleComp, realCount
    if needCount > 0 then
      singleComp, realCount = ItemAlchemyUtils.SingleCompose(itemData.id, needCount)
      if not singleComp then
        return nil, nil, nil
      else
        needItems = ItemAlchemyUtils.MergeTable(needItems, singleComp)
      end
      table.insert(targetItems, {
        id = itemData.id,
        count = realCount
      })
    end
  end
  local moneyInd
  for i = 1, #needItems do
    if needItems[i].count > Item(needItems[i].id) then
      return nil, nil, nil
    end
    if needItems[i].id == DT.GetConstant("GoldItemTid") then
      moneyInd = i
    end
  end
  moneyNeed = moneyNeed + (moneyInd and table.remove(needItems, moneyInd).count or 0)
  return needItems, targetItems, moneyNeed
end

function ItemAlchemyUtils.EnsureAlchemyFormat()
  if not ItemAlchemyUtils.format then
    ItemAlchemyUtils.ParseAlchemyFormat()
  end
end

function ItemAlchemyUtils.SingleCompose(itemId, itemCount, isAdd)
  if (itemCount or 0) <= 0 then
    return {}, 0
  end
  local needItems = {}
  ItemAlchemyUtils.EnsureAlchemyFormat()
  local formats = ItemAlchemyUtils.format[itemId]
  if not formats then
    if isAdd then
      return {
        {id = itemId, count = itemCount}
      }, itemCount
    else
      return nil, nil
    end
  end
  itemCount = math.ceil(itemCount / DT.ItemConversion[formats[1]].ItemsGet[2])
  local format = DT.ItemConversion[formats[1]].ConsumeItem
  for i = 1, #format, 2 do
    local fragId = format[i]
    local fragCount = format[i + 1]
    if "Material" == fragId then
      fragId = 74143
      fragCount = 1
    end
    if (fragCount or 0) > 0 then
      local haveCount = Item(fragId)
      if not fragCount then
        break
      end
      local nowId
      if haveCount > 0 then
        nowId = ItemAlchemyUtils.FindKey(needItems, fragId)
        if not nowId then
          nowId = #needItems + 1
          table.insert(needItems, {id = fragId, count = 0})
        end
      end
      if nowId and haveCount >= itemCount * fragCount then
        needItems[nowId].count = needItems[nowId].count + itemCount * fragCount
      else
        local needCount = itemCount * fragCount - haveCount
        if haveCount > 0 then
          needItems[nowId].count = needItems[nowId].count + haveCount
        end
        local deeperCompose, _ = ItemAlchemyUtils.SingleCompose(fragId, needCount, isAdd)
        if not deeperCompose then
          if isAdd then
            return {
              {id = itemId, count = itemCount}
            }, itemCount
          else
            return nil, nil
          end
        else
          needItems = ItemAlchemyUtils.MergeTable(needItems, deeperCompose)
        end
      end
    end
  end
  return needItems, itemCount * DT.ItemConversion[formats[1]].ItemsGet[2]
end

ItemAlchemyUtils.SeasonS1SmallMtrl = DT.GetConstant("Alchemy_SeasonS1SmallMtrl")
ItemAlchemyUtils.SeasonS1BigMtrl = DT.GetConstant("Alchemy_SeasonS1BigMtrl")
ItemAlchemyUtils.TrinketRefineLock = DT.GetConstant("Alchemy_TrinketRefineLock")
ItemAlchemyUtils.TrinketMaterial = DT.GetConstant("Alchemy_TrinketMaterial")

function ItemAlchemyUtils.ParseAlchemyFormat()
  local ret = {}
  for formatId, cfg in pairs(DT.ItemConversion) do
    if cfg.ConversionType == AlchemyDefine.AlchemyType.Compose then
      local itemId = cfg.ItemsGet[1]
      if not ret[itemId] then
        ret[itemId] = {}
      end
      table.insert(ret[itemId], formatId)
    elseif ItemAlchemyUtils.IsExchangeItem(cfg.ItemsGet[1]) then
      if not ret[ItemAlchemyUtils.SeasonS1SmallMtrl] then
        ret[ItemAlchemyUtils.SeasonS1SmallMtrl] = {}
      end
      table.insert(ret[ItemAlchemyUtils.SeasonS1SmallMtrl], formatId)
    elseif cfg.ConversionType == AlchemyDefine.AlchemyType.Exchange then
      if not ItemAlchemyUtils.trinketChipFormat and cfg.ConsumeItem[2] == CommonDefine.ItemSubType.TrinketChip then
        ItemAlchemyUtils.trinketChipFormat = formatId
      elseif not ItemAlchemyUtils.trinketRefineFormat and cfg.ConsumeItem[2] == CommonDefine.ItemSubType.TrinketRefineLock and (DT.Item[cfg.ItemsGet[1]].StartDropDate or 0) < TimeUtils.GetServerTime() then
        ItemAlchemyUtils.trinketRefineFormat = formatId
        ItemAlchemyUtils.tmpTrinket = cfg.ItemsGet[1]
      end
      if cfg.ConsumeItem[2] == CommonDefine.ItemSubType.TrinketRefineLock or cfg.ConsumeItem[2] == CommonDefine.ItemSubType.TrinketChip then
        local itemId = cfg.ItemsGet[1]
        if not ret[itemId] then
          ret[itemId] = {}
        end
        table.insert(ret[itemId], formatId)
      end
    end
  end
  ItemAlchemyUtils.format = ret
end

function ItemAlchemyUtils.OpenUpgradeView(requireItem, notOpen, otherMoney)
  local isExchanging = false
  local isComposing = false
  for _, itemData in pairs(requireItem) do
    if itemData.id == DT.GetConstant("GoldItemTid") then
      otherMoney = itemData.count
      itemData.count = 0
    end
  end
  local consumeItemsNoMoney, compositeItems, costMoney = ItemAlchemyUtils.ItemAlchemyCompose(requireItem)
  for _, item in pairs(compositeItems or {}) do
    if ItemAlchemyUtils.IsExchangeItem(item.id) then
      isExchanging = true
    else
      isComposing = true
    end
  end
  local _, composeUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.AutoSynthesis, 0)
  if isComposing and not composeUnlock then
    return false
  end
  local _, exchangeUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.AutoReplacement, 0)
  if isExchanging and not exchangeUnlock then
    return false
  end
  if consumeItemsNoMoney and Item(DT.GetConstant("GoldItemTid")) >= (otherMoney or 0) + (costMoney or 0) then
    if not notOpen then
      AwakerPopupExchangeTipView.OpenThisView(consumeItemsNoMoney, compositeItems, costMoney)
    end
    return true
  else
    return false
  end
end

function ItemAlchemyUtils.OpenUpgradeViewWithAwakerTid(awakerTid, notOpen, otherMoney)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local requireItem = awaker.nextBreakthroughStarMtrlCost
  do return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen end
  return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen, otherMoney
end

function ItemAlchemyUtils.OpenUpgradeViewWithItemList(data, notOpen, otherMoney)
  local requireItem = {}
  for _, item in pairs(data) do
    table.insert(requireItem, {
      id = item.tid,
      count = item.num
    })
  end
  do return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen end
  return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen, otherMoney, nil, nil, table.insert, requireItem, {
    id = item.tid,
    count = item.num
  }, item.num
end

function ItemAlchemyUtils.OpenUpgradeViewWithItemKeyList(data, notOpen, otherMoney)
  local requireItem = {}
  for itemTid, itemCount in pairs(data) do
    table.insert(requireItem, {id = itemTid, count = itemCount})
  end
  do return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen end
  return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen, otherMoney, nil, nil, table.insert, requireItem, {id = itemTid, count = itemCount}
end

function ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(costItems, notOpen, otherMoney)
  costItems = costItems or {}
  local requireItem = {}
  for i = 1, #costItems, 2 do
    local tid = costItems[i]
    local count = costItems[i + 1]
    table.insert(requireItem, {id = tid, count = count})
  end
  do return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen end
  return ItemAlchemyUtils.OpenUpgradeView, requireItem, notOpen, otherMoney, costItems[i], costItems[i + 1], table.insert, requireItem, {id = tid, count = count}
end

function ItemAlchemyUtils.MaxComposeCount(itemTid, conversionId)
  local ret, _ = ItemAlchemyUtils._MaxComposeCount(itemTid, 0)
  local remainCompositeTime = AlchemyCompositeExtModel.Instance:GetRemainCompositeTime(conversionId)
  if not remainCompositeTime then
    return ret
  end
  do return math.min, ret end
  return math.min, ret, remainCompositeTime
end

function ItemAlchemyUtils.GetComposeMoneyCost(formatId)
  local consumeItem = DT.ItemConversion[formatId] and DT.ItemConversion[formatId].ConsumeItem or {}
  local goldTid = DT.GetConstant("GoldItemTid")
  for i = 1, #consumeItem, 2 do
    if consumeItem[i] == goldTid then
      return consumeItem[i + 1] or 0
    end
  end
  return 0
end

function ItemAlchemyUtils.CanComposeByCount(itemTid, composeCount, moneyOff)
  if composeCount <= 0 then
    return true
  end
  ItemAlchemyUtils.EnsureAlchemyFormat()
  local formats = ItemAlchemyUtils.format[itemTid]
  if not formats or not formats[1] then
    return false
  end
  local cfg = DT.ItemConversion[formats[1]]
  if not cfg then
    return false
  end
  local getCountPerCompose = cfg.ItemsGet and cfg.ItemsGet[2] or 1
  if getCountPerCompose <= 0 then
    return false
  end
  local targetCount = composeCount * getCountPerCompose
  local needItems = ItemAlchemyUtils.SingleCompose(itemTid, targetCount, false)
  if not needItems then
    return false
  end
  local goldTid = DT.GetConstant("GoldItemTid")
  for _, needData in ipairs(needItems) do
    local haveCount = Item(needData.id)
    if needData.id == goldTid then
      haveCount = haveCount - (moneyOff or 0)
    end
    if haveCount < needData.count then
      return false
    end
  end
  return true
end

function ItemAlchemyUtils._MaxComposeCount(itemTid, moneyOff)
  ItemAlchemyUtils.EnsureAlchemyFormat()
  local formats = ItemAlchemyUtils.format[itemTid]
  if ItemAlchemyUtils.IsExchangeItem(itemTid) or not formats then
    return 0, 0
  end
  local formatId = formats[1]
  local moneyCost = ItemAlchemyUtils.GetComposeMoneyCost(formatId)
  if not ItemAlchemyUtils.CanComposeByCount(itemTid, 1, moneyOff) then
    return 0, moneyCost
  end
  local low = 0
  local high = 1
  local maxBound = 1000000
  while high < maxBound and ItemAlchemyUtils.CanComposeByCount(itemTid, high, moneyOff) do
    low = high
    high = math.min(high * 2, maxBound)
  end
  while high > low + 1 do
    local mid = math.floor((low + high) / 2)
    if ItemAlchemyUtils.CanComposeByCount(itemTid, mid, moneyOff) then
      low = mid
    else
      high = mid
    end
  end
  return low, moneyCost
end

function ItemAlchemyUtils.OpenTrinketView(costList, targetList, chipReqList, refineReqList)
  AwakerPopupExchangeTipView.OpenThisView(costList, targetList, 0, function()
    ItemAlchemyUtils.ReqTrinketExchange(chipReqList, refineReqList)
  end)
end

function ItemAlchemyUtils.GetTrinketExchangeList(exchangePlan, count)
  local chipExchangeCount = DT.ItemConversion[ItemAlchemyUtils.trinketChipFormat].ItemsGet[2]
  local refineExchangeCount = DT.ItemConversion[ItemAlchemyUtils.trinketRefineFormat].ItemsGet[2]
  local chipReqList, refineReqList
  local costList = {}
  local realCount = 0
  local exchangePlanWithCount = {}
  local haveRefine = false
  for tid, _ in pairs(exchangePlan) do
    if tid == ItemAlchemyUtils.TrinketRefineLock then
      haveRefine = true
    end
    table.insert(exchangePlanWithCount, {
      tid = tid,
      num = Item(tid)
    })
  end
  table.sort(exchangePlanWithCount, function(a, b)
    return a.num > b.num
  end)
  local mtrlEnough = false
  if not mtrlEnough then
    for _, data in ipairs(exchangePlanWithCount) do
      if (DT.Item[data.tid].StartDropDate or 0) > TimeUtils.GetServerTime() or data.tid == ItemAlchemyUtils.TrinketRefineLock or DT.Item[data.tid].SubType ~= CommonDefine.ItemSubType.TrinketChip then
      else
        if data.num > 0 then
          local costCount
          if data.num >= math.ceil(count / chipExchangeCount) then
            mtrlEnough = true
            costCount = math.ceil(count / chipExchangeCount)
          else
            costCount = data.num
          end
          if costCount > 0 then
            count = count - costCount * chipExchangeCount
            realCount = realCount + costCount * chipExchangeCount
            local itemData = ItemDataUtils.GetItemByTid(data.tid)
            local uid = itemData and itemData.uid or 0
            chipReqList = chipReqList or {}
            table.insert(chipReqList, {uid = uid, num = costCount})
            table.insert(costList, {
              id = data.tid,
              count = costCount
            })
          end
        end
        if mtrlEnough then
          break
        end
      end
    end
  end
  if not mtrlEnough then
    local refineCount = Item(ItemAlchemyUtils.TrinketRefineLock)
    if haveRefine and refineCount > 0 then
      local refineCostCount
      if refineCount >= math.ceil(count / refineExchangeCount) then
        mtrlEnough = true
        refineCostCount = math.ceil(count / refineExchangeCount)
      else
        refineCostCount = refineCount
      end
      if refineCostCount > 0 then
        count = count - refineCostCount * refineExchangeCount
        realCount = realCount + refineCostCount * refineExchangeCount
        local itemData = ItemDataUtils.GetItemByTid(ItemAlchemyUtils.TrinketRefineLock)
        local uid = itemData and itemData.uid or 0
        refineReqList = {
          {uid = uid, num = refineCostCount}
        }
        table.insert(costList, {
          id = ItemAlchemyUtils.TrinketRefineLock,
          count = refineCostCount
        })
      end
    end
  end
  if not mtrlEnough then
    return false, nil, nil, nil, nil
  end
  local targetList = {
    {
      id = ItemAlchemyUtils.TrinketMaterial,
      count = realCount
    }
  }
  return true, costList, targetList, chipReqList, refineReqList
end

function ItemAlchemyUtils.ReqTrinketExchange(chipReqList, refineReqList, cb)
  if refineReqList then
    local formatCount = refineReqList[1].num * DT.ItemConversion[ItemAlchemyUtils.trinketRefineFormat].ItemsGet[2]
    
    local function callback()
      local itemData = ItemDataUtils.GetItemByTid(ItemAlchemyUtils.tmpTrinket)
      local uid = itemData and itemData.uid or 0
      if 0 == uid then
        TimerManager.Instance:CreateTimer(0.25, 0, nil, function()
          itemData = ItemDataUtils.GetItemByTid(ItemAlchemyUtils.tmpTrinket)
          uid = itemData and itemData.uid or 0
          AlchemyDataUtils.ExchangeItem(ItemAlchemyUtils.trinketChipFormat, {
            {uid = uid, num = formatCount}
          }, cb)
        end)
        return
      end
      AlchemyDataUtils.ExchangeItem(ItemAlchemyUtils.trinketChipFormat, {
        {uid = uid, num = formatCount}
      }, cb)
    end
    
    AlchemyDataUtils.ExchangeItem(ItemAlchemyUtils.trinketRefineFormat, refineReqList, callback, true)
  end
  if chipReqList then
    AlchemyDataUtils.ExchangeItem(ItemAlchemyUtils.trinketChipFormat, chipReqList, cb)
  end
end

function ItemAlchemyUtils.MergeArray(ta, tb)
  for key, value in pairs(tb) do
    if ta[key] then
      ta[key] = ta[key] + value
    else
      ta[key] = value
    end
  end
end

function ItemAlchemyUtils.MergeTable(ta, tb)
  local contain
  for i = 1, #tb do
    contain = false
    for j = 1, #ta do
      if ta[j].id == tb[i].id then
        ta[j].count = ta[j].count + tb[i].count
        contain = true
      end
    end
    if not contain then
      table.insert(ta, tb[i])
    end
  end
  return ta
end

function ItemAlchemyUtils.FindKey(t, id)
  for i = 1, #t do
    if t[i].id == id then
      return i
    end
  end
  return nil
end

function ItemAlchemyUtils.UnpackTable(t, sortFunc)
  local ret = {}
  for key, value in pairs(t) do
    if value > 0 then
      table.insert(ret, {key, value})
    end
  end
  table.sort(ret, function(a, b)
    if sortFunc then
      do return sortFunc, a end
      return sortFunc, a, b
    else
      return DT.Item[a[1]].BaseSortID < DT.Item[b[1]].BaseSortID
    end
  end)
  do return table.unpack end
  return table.unpack, ret, function(a, b)
    if sortFunc then
      do return sortFunc, a end
      return sortFunc, a, b
    else
      return DT.Item[a[1]].BaseSortID < DT.Item[b[1]].BaseSortID
    end
  end, pairs(t)
end

function ItemAlchemyUtils.IsExchangeItem(targetTid)
  return ItemAlchemyUtils.SeasonS1SmallMtrl == targetTid
end

return ItemAlchemyUtils
