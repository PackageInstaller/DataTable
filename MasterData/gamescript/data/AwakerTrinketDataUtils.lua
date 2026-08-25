local SortOrder = CommonDefine.SortOrder
local TrinketSortType = CommonDefine.AwakerTrinketSortType
local WeaponSortType = CommonDefine.AwakerWeaponSortType
local tableSort = table.sort
local tableInsert = table.insert
local MAX_EQUIP_TRINKET_COUNT = 6
local MaxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
local MaxSubAttrsCount = 3
local AwakerTrinketDataUtils = {}
AwakerTrinketDataUtils.SuitNotActiveImagePath = "UIResources/AtlasSource/HD/UI_Common_Image/UI_Common_D_Image_Ban_Icon.png"
AwakerTrinketDataUtils.SuitActiveImagePath = "UIResources/AtlasSource/UI_Common_Image/UI_Common_D_Image_Tick_Icon.png"
AwakerTrinketDataUtils.SuitEffectActiveImagePath = "UIResources/AtlasSource/UI_Common/UI_Common_Image_Finish_4.png"

function AwakerTrinketDataUtils.TrinketAttrToClientAttr(trinketAttr)
  if not trinketAttr then
    return {}
  end
  local config = DT.ActorAttrType[trinketAttr.attrId]
  if not config then
    Logger.Error("找不到attrId对应的属性:" .. trinketAttr.attrId)
    return {}
  end
  local attr = {
    uid = trinketAttr.index,
    tid = trinketAttr.attrId,
    count = trinketAttr.val or 0,
    type = config.Name,
    isPercent = config.Percentage,
    name = LT.Text(config.Text)
  }
  return attr
end

function AwakerTrinketDataUtils.GetMainAttrByItemData(itemData)
  if not itemData or not itemData.attrs then
    return nil
  end
  for _, attr in pairs(itemData.attrs) do
    if attr and 1 == attr.index then
      return attr
    end
  end
  return nil
end

function AwakerTrinketDataUtils.GetMainAttr(uid, extraItemDataMap)
  local trinket
  if extraItemDataMap and extraItemDataMap[uid] then
    trinket = extraItemDataMap[uid]
  else
    trinket = ItemDataUtils.GetItemByUid(uid)
  end
  do return AwakerTrinketDataUtils.GetMainAttrByItemData end
  return AwakerTrinketDataUtils.GetMainAttrByItemData, trinket
end

function AwakerTrinketDataUtils.GetClientMainAttr(uid)
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(uid)
  do return AwakerTrinketDataUtils.TrinketAttrToClientAttr end
  return AwakerTrinketDataUtils.TrinketAttrToClientAttr, mainAttr
end

function AwakerTrinketDataUtils.GetSubAttrs(uid)
  local trinket = ItemDataUtils.GetItemByUid(uid)
  if not trinket then
    return
  end
  do return AwakerTrinketDataUtils.GetSubAttrsByItemData end
  return AwakerTrinketDataUtils.GetSubAttrsByItemData, trinket
end

function AwakerTrinketDataUtils.GetSubAttrsByItemData(itemData)
  local subAttrs = {}
  for _, attr in pairs(itemData.attrs) do
    if attr and 1 ~= attr.index then
      table.insert(subAttrs, attr)
    end
  end
  table.sort(subAttrs, function(a, b)
    return a.index < b.index
  end)
  return subAttrs
end

function AwakerTrinketDataUtils.GetClientSubAttrs(uid)
  local subAttrs = AwakerTrinketDataUtils.GetSubAttrs(uid)
  if not subAttrs then
    return
  end
  local subClientAttrs = {}
  for _, attr in pairs(subAttrs) do
    table.insert(subClientAttrs, AwakerTrinketDataUtils.TrinketAttrToClientAttr(attr))
  end
  return subClientAttrs
end

function AwakerTrinketDataUtils.GetSuitId2NumMapByTrinketUids(trinketUids)
  local suitId2NumMap = {}
  for slot, uid in pairs(trinketUids) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if not itemData then
    else
      if not suitId2NumMap[itemData.suitId] then
        suitId2NumMap[itemData.suitId] = 0
      end
      suitId2NumMap[itemData.suitId] = suitId2NumMap[itemData.suitId] + 1
    end
  end
  return suitId2NumMap
end

function AwakerTrinketDataUtils.GetSuitIdByTrinketUids(trinketUids)
  local suitId2NumMap = AwakerTrinketDataUtils.GetSuitId2NumMapByTrinketUids(trinketUids)
  for suitId, suitNum in pairs(suitId2NumMap) do
    if suitNum == MAX_EQUIP_TRINKET_COUNT then
      return suitId
    end
  end
  return nil
end

function AwakerTrinketDataUtils.GetActiveSuiteEffects(awakerData, extraItemDataMap)
  local trinketIds = awakerData.trinkets
  if nil == trinketIds then
    return {}
  end
  local trinkets = {}
  for pos, id in pairs(trinketIds) do
    local data = ItemDataUtils.GetItemByUid(id)
    if awakerData.isAssist then
      data = extraItemDataMap and extraItemDataMap[id]
    end
    trinkets[pos] = data
  end
  local suitActiveMap = {}
  for _, trinket in pairs(trinkets) do
    local suitId = trinket.suitId
    local activeNum = suitActiveMap[suitId]
    if not activeNum then
      suitActiveMap[suitId] = 1
    else
      suitActiveMap[suitId] = activeNum + 1
    end
  end
  return suitActiveMap
end

function AwakerTrinketDataUtils.GetSuitEffectCount(awakerData, extraItemDataMap)
  local suitAcitveMap = AwakerTrinketDataUtils.GetActiveSuiteEffects(awakerData, extraItemDataMap)
  local effectCount = 0
  for tid, count in pairs(suitAcitveMap) do
    local suitCfg = DT.TrinketSuitEffect[tid]
    local tmpCnt = 0
    for key, value in pairs(suitCfg) do
      if string.contains(key, "SuitEffectNum_") then
        local stripStr = string.gsub(key, "SuitEffectNum_", "")
        local idx = tonumber(stripStr)
        if value <= count and tmpCnt < idx then
          tmpCnt = idx
        end
      end
    end
    effectCount = effectCount + tmpCnt
  end
  return effectCount
end

function AwakerTrinketDataUtils.GetSuitIdByItemTid(tid)
  local itemCfg = DT.Item[tid]
  if itemCfg.Type ~= CommonDefine.ItemType.Trinket then
    return nil
  end
  return itemCfg and itemCfg.SpParam and itemCfg.SpParam[2] or nil
end

function AwakerTrinketDataUtils.GetTrinketTidsBySuitId(suitId)
  if not suitId or 0 == suitId or not DT.TrinketSuitEffect[suitId] then
    return {
      0,
      0,
      0,
      0,
      0,
      0
    }
  end
  local partOrder = {
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI"
  }
  local part2Tid = {}
  for itemTid, cfg in pairs(DT.Item) do
    if cfg.Type == CommonDefine.ItemType.Trinket and cfg.SpParam and cfg.SpParam[2] == suitId then
      local part = cfg.SpParam[1]
      if not part2Tid[part] or itemTid < part2Tid[part] then
        part2Tid[part] = itemTid
      end
    end
  end
  local tids = {}
  for i = 1, 6 do
    tids[i] = part2Tid[partOrder[i]] or 0
  end
  return tids
end

function AwakerTrinketDataUtils.GetSuitDescData(tid, activeNum, showActiveEffect, showActiveNum)
  if not tid or 0 == tid then
    return {}
  end
  activeNum = activeNum or 0
  local suitConfig = DT.TrinketSuitEffect[tid]
  assert(nil ~= suitConfig, "找不到套装配置:" .. tostring(tid))
  local suitName = LT.Text(suitConfig.Name)
  local activeNumStr = ""
  if showActiveNum or nil == showActiveNum then
    activeNumStr = string.format("(%s)", activeNum)
  end
  local titleDesc = string.format("%s %s", suitName, activeNumStr)
  local tmp = {}
  local hasActiveEffect = false
  for targetNum = 1, 6 do
    local descKey = string.format("SuitEffectDesc_%s", targetNum)
    local desc = suitConfig[descKey] and LT.Text(suitConfig[descKey])
    if desc then
      local suitActiveNum = targetNum
      local suitNumKey = string.format("SuitEffectNum_%s", targetNum)
      if suitConfig[suitNumKey] then
        suitActiveNum = suitConfig[suitNumKey]
      end
      desc = LT.Textf("TrinketSuitEffect", suitActiveNum, desc)
      if showActiveEffect and activeNum >= suitActiveNum then
        hasActiveEffect = true
        desc = string.format("<TrinketSuitOn:%s>", desc)
      end
      local tmpData = {
        activeNum = suitActiveNum,
        desc = LT.Text(desc)
      }
      table.insert(tmp, tmpData)
    end
  end
  if showActiveEffect and hasActiveEffect then
    titleDesc = string.format("<TrinketSuitOn:%s>", titleDesc)
  end
  tableSort(tmp, function(a, b)
    return a.activeNum < b.activeNum
  end)
  local list = {}
  local numNeedList = {}
  for _, v in ipairs(tmp) do
    table.insert(list, v.desc)
    table.insert(numNeedList, v.activeNum)
  end
  local descData = {
    suitEffectTitle = LT.Text(titleDesc),
    effectDescList = list,
    numNeedList = numNeedList
  }
  return descData
end

function AwakerTrinketDataUtils.IsSuitEffectActive(suitId, activeNum)
  if not (suitId and 0 ~= suitId and activeNum) or activeNum <= 0 then
    return false
  end
  local suitConfig = DT.TrinketSuitEffect[suitId]
  if not suitConfig then
    return false
  end
  for targetNum = 1, 6 do
    local descKey = string.format("SuitEffectDesc_%s", targetNum)
    if suitConfig[descKey] then
      local suitActiveNum = targetNum
      local suitNumKey = string.format("SuitEffectNum_%s", targetNum)
      if suitConfig[suitNumKey] then
        suitActiveNum = suitConfig[suitNumKey]
      end
      if activeNum >= suitActiveNum then
        return true
      end
    end
  end
  return false
end

function AwakerTrinketDataUtils.GetTrinketSuitId(awakerData)
  return awakerData.trinketSuitId
end

function AwakerTrinketDataUtils.GetTrinketSuitConfig(suitId)
  return DT.TrinketSuitEffect[suitId]
end

function AwakerTrinketDataUtils.GetTrinketSuitConfigByField(field, suitId)
  if not field or not suitId then
    return nil
  end
  local cfg = AwakerTrinketDataUtils.GetTrinketSuitConfig(suitId)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function AwakerTrinketDataUtils.GetTrinketAttrValue(trinket, attrId)
  if not trinket or not attrId then
    return 0
  end
  if not trinket.attrs then
    return 0
  end
  local attrVal = 0
  for _, trinketAttr in pairs(trinket.attrs) do
    if trinketAttr and trinketAttr.attrId == attrId then
      attrVal = attrVal + trinketAttr.val
    end
  end
  return attrVal
end

function AwakerTrinketDataUtils.GetTrinketOfMainAttrId(tid, mainAttrId, getMaxLevelItemIfNot, excludeTrinketUidMap)
  local itemMap = ItemDataUtils.GetItemUidMap(tid) or {}
  local bestTrink
  local bestCompletion = -1
  local bestLevel = -1
  for uid in pairs(itemMap) do
    if (not excludeTrinketUidMap or not excludeTrinketUidMap[uid]) and not AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
      local item = ItemDataUtils.GetItemByUid(uid)
      if item then
        local completion = AwakerTrinketDataUtils.GetTrinketCompletionNumber(item)
        local level = item.level or 0
        if bestCompletion < completion or completion == bestCompletion and bestLevel < level then
          bestCompletion = completion
          bestLevel = level
          bestTrink = item
        end
      end
    end
  end
  return bestTrink
end

function AwakerTrinketDataUtils.GetTrinketMaxLevel()
  local mainAttr = DT.Constant.TrinketMainAttrValue.Data
  return #mainAttr - 1
end

function AwakerTrinketDataUtils.GetTrinketLevelUpExp(currLevel, quality)
  if not currLevel or not quality then
    return 0
  end
  local expKey = string.format("%sTrinketLevelUpExp", quality)
  if AwakerTrinketDataUtils.LevelUpExpMap then
    local expMap = AwakerTrinketDataUtils.LevelUpExpMap[currLevel]
    return expMap[expKey]
  end
  AwakerTrinketDataUtils.LevelUpExpMap = {}
  for _, config in pairs(DT.TrinketLevelUpExp) do
    if not AwakerTrinketDataUtils.LevelUpExpMap[config.Level] then
      AwakerTrinketDataUtils.LevelUpExpMap[config.Level] = {}
    end
    for k, v in pairs(config) do
      AwakerTrinketDataUtils.LevelUpExpMap[config.Level][k] = v
    end
  end
  return AwakerTrinketDataUtils.LevelUpExpMap[currLevel][expKey]
end

function AwakerTrinketDataUtils.GetTrinketMainAttrValue(currLevel, attrId)
  local mainAttr = DT.Constant.TrinketMainAttrValue.Data
  local value = mainAttr[currLevel + 1]
  local attrType = DT.ActorAttrType[attrId]
  if attrType then
    return (attrType.Equivalency or 0) * value
  end
  return value
end

function AwakerTrinketDataUtils.GetTrinketSubAttrMaxLevel()
  local attrsWeight = DT.Constant.TrinketSubAttrValueWeight.Data
  return #attrsWeight / 2
end

function AwakerTrinketDataUtils.GetTrinketSubAttrMaxValue(attrTid)
  local attrsWeight = DT.Constant.TrinketSubAttrValueWeight.Data
  local maxValue = attrsWeight[#attrsWeight - 1]
  local attrType = DT.ActorAttrType[attrTid]
  if attrType then
    return (attrType.Equivalency or 0) * maxValue
  end
  return maxValue
end

function AwakerTrinketDataUtils.GetTrinketSubAttrRefineLevel(attrData)
  local tid = attrData.attrId
  local val = attrData.val
  local weight = val / DT.ActorAttrType[tid].Equivalency
  local attrsWeight = DT.Constant.TrinketSubAttrValueWeight.Data
  local weightDelta = attrsWeight[#attrsWeight - 1] - attrsWeight[#attrsWeight - 3]
  return weight / weightDelta
end

local StrengthTrinketIconPosTable = {
  I = {46, 0},
  II = {-46, 0},
  III = {46, 0},
  IV = {-46, 0},
  V = {46, 0},
  VI = {-46, 0}
}
local ConversionTrinketIconPosTable = {
  I = {29, 0},
  II = {-42, 0},
  III = {29, 0},
  IV = {-42, 0},
  V = {29, 0},
  VI = {-42, 0}
}

function AwakerTrinketDataUtils.GetTrinketPos(tid)
  if not tid or 0 == tid then
    return
  end
  local trinketInfoList = ItemDataUtils.GetTrinketInfoByItemTid(tid)
  if not trinketInfoList then
    return nil
  end
  local pos = trinketInfoList[1]
  return pos
end

function AwakerTrinketDataUtils.GetStrengthTrinketIconPosTable(tid)
  local pos = AwakerTrinketDataUtils.GetTrinketPos(tid)
  return StrengthTrinketIconPosTable[pos]
end

function AwakerTrinketDataUtils.GetConversionTrinketIconPosTable(tid)
  local pos = AwakerTrinketDataUtils.GetTrinketPos(tid)
  return ConversionTrinketIconPosTable[pos]
end

function AwakerTrinketDataUtils.GetAttrFmtStringWithMax(attr)
  local value = AwakerTrinketDataUtils.GetAttrValueString(attr.count or 0)
  if attr.isPercent then
    do return string.format, "%s%%" end
    return string.format, "%s%%", value
  else
    do return string.format, "%s" end
    return string.format, "%s", value
  end
end

function AwakerTrinketDataUtils.GetAttrValueString(value)
  value = value or 0
  local integerValue, demical = math.modf(value)
  if demical >= 0.9999 then
    do return string.format, "%d", math.floor(integerValue + 1) end
    return string.format, "%d", math.floor(integerValue + 1)
  end
  if math.abs(demical) < 1.0E-4 then
    do return string.format, "%d", math.floor(value) end
    return string.format, "%d", math.floor(value)
  else
    do return tostring end
    return tostring, value, math.floor(value)
  end
end

function AwakerTrinketDataUtils.GetAttrFmtString(attr)
  do return AwakerTrinketDataUtils.GetAttrFmtStringByValue, attr.count end
  return AwakerTrinketDataUtils.GetAttrFmtStringByValue, attr.count, attr.isPercent
end

function AwakerTrinketDataUtils.GetAttrFmtStringByValue(value, isPercent)
  value = AwakerTrinketDataUtils.GetAttrValueString(value)
  if isPercent then
    do return string.format, "%s%%" end
    return string.format, "%s%%", value
  else
    return value
  end
end

local function GetQualitySort(tid)
  do return ItemCfgUtils.GetItemQualitySort end
  return ItemCfgUtils.GetItemQualitySort, tid
end

local function Compare(a, b, order)
  if order == SortOrder.Ascend then
    return a < b
  end
  return b < a
end

local function GetItemLevel(item)
  return item.level
end

function AwakerTrinketDataUtils.SortByLevel(a, b, order)
  local aParams = TrinketSortingModel.Instance:TryCalSortingParam(a)
  local bParams = TrinketSortingModel.Instance:TryCalSortingParam(b)
  local rawA = GetItemLevel(a)
  local rawB = GetItemLevel(b)
  local sortA = nil == rawA and 999 or rawA
  local sortB = nil == rawB and 999 or rawB
  if sortA ~= sortB then
    do return Compare, sortA, sortB end
    return Compare, sortA, sortB, order, nil, nil, nil, nil, nil, nil
  end
  local suitOrderA = aParams.suitOrder
  local suitOrderB = bParams.suitOrder
  if suitOrderA ~= suitOrderB then
    do return Compare, suitOrderA, suitOrderB end
    return Compare, suitOrderA, suitOrderB, SortOrder.Ascend, nil, nil, nil, nil
  end
  local partA = aParams.part
  local partB = bParams.part
  if partA ~= partB then
    do return Compare, partA, partB end
    return Compare, partA, partB, SortOrder.Ascend, nil, nil
  end
  local mainAttrIdA = aParams.mainAttrId
  local mainAttrIdB = bParams.mainAttrId
  if mainAttrIdA ~= mainAttrIdB then
    do return Compare, mainAttrIdA, mainAttrIdB end
    return Compare, mainAttrIdA, mainAttrIdB, SortOrder.Ascend
  end
  do return Compare, a.tid, b.tid end
  return Compare, a.tid, b.tid, SortOrder.Ascend
end

function AwakerTrinketDataUtils.SortByLevelOnly(a, b, order)
  local rawA = a and GetItemLevel(a)
  local rawB = b and GetItemLevel(b)
  local sortA = nil == rawA and 999 or rawA
  local sortB = nil == rawB and 999 or rawB
  do return Compare, sortA, sortB end
  return Compare, sortA, sortB, order
end

function AwakerTrinketDataUtils.SortByTimestamp(a, b, order)
  local timestampA = a.timestamp
  local timestampB = b.timestamp
  if timestampA == timestampB then
    local aLevel = GetItemLevel(a)
    local bLevel = GetItemLevel(b)
    if aLevel == bLevel then
      local qualitySortA = GetQualitySort(a.tid)
      local qualitySortB = GetQualitySort(b.tid)
      if qualitySortA == qualitySortB then
        do return AwakerTrinketDataUtils.CommonSort, a end
        return AwakerTrinketDataUtils.CommonSort, a, b, nil
      end
      do return AwakerTrinketDataUtils.SortByQuality, a, b end
      return AwakerTrinketDataUtils.SortByQuality, a, b, SortOrder.Descend
    end
    do return AwakerTrinketDataUtils.SortByLevelOnly, a, b end
    return AwakerTrinketDataUtils.SortByLevelOnly, a, b, SortOrder.Descend, b, SortOrder.Descend
  end
  do return Compare, timestampA, timestampB end
  return Compare, timestampA, timestampB, order, b, SortOrder.Descend, b, SortOrder.Descend
end

function AwakerTrinketDataUtils.SortByQuality(a, b, order)
  local default = order == SortOrder.Descend and 1 or 999
  local qualitySortA = GetQualitySort(a.tid) or default
  local qualitySortB = GetQualitySort(b.tid) or default
  if qualitySortA == qualitySortB then
    local aLevel = GetItemLevel(a)
    local bLevel = GetItemLevel(b)
    if aLevel == bLevel then
      do return AwakerTrinketDataUtils.CommonSort, a end
      return AwakerTrinketDataUtils.CommonSort, a, b, nil
    end
    do return AwakerTrinketDataUtils.SortByLevelOnly, a, b end
    return AwakerTrinketDataUtils.SortByLevelOnly, a, b, SortOrder.Descend
  end
  do return Compare, qualitySortA, qualitySortB end
  return Compare, qualitySortA, qualitySortB, order, b, SortOrder.Descend
end

function AwakerTrinketDataUtils.CommonSort(a, b)
  if a.tid == b.tid then
    local attrNumA = a.attrs and #a.attrs or 0
    local attrNumB = b.attrs and #b.attrs or 0
    if attrNumA == attrNumB then
      do return Compare, a.timestamp, b.timestamp end
      return Compare, a.timestamp, b.timestamp, SortOrder.Descend
    end
    do return Compare, attrNumA, attrNumB end
    return Compare, attrNumA, attrNumB, SortOrder.Descend
  end
  local aBaseSortID = ItemCfgUtils.GetCfgField("BaseSortID", a.tid)
  local bBaseSortID = ItemCfgUtils.GetCfgField("BaseSortID", b.tid)
  do return Compare, aBaseSortID, bBaseSortID end
  return Compare, aBaseSortID, bBaseSortID, SortOrder.Ascend
end

function AwakerTrinketDataUtils.SortByAttrType(a, b, attrType, order)
  local attrTypeMap = AttrUtils.GetAttrTypeMap()
  local attrId = attrTypeMap[attrType]
  if not attrId then
    Logger.Info("找不到属性id: ", attrType)
    return false
  end
  local aParams = TrinketSortingModel.Instance:TryCalSortingParam(a)
  local bParams = TrinketSortingModel.Instance:TryCalSortingParam(b)
  aParams.attrs[attrId] = aParams.attrs[attrId] or AwakerTrinketDataUtils.GetTrinketAttrValue(a, attrId)
  bParams.attrs[attrId] = bParams.attrs[attrId] or AwakerTrinketDataUtils.GetTrinketAttrValue(b, attrId)
  local attrValA = aParams.attrs[attrId]
  local attrValB = bParams.attrs[attrId]
  if attrValA == attrValB then
    do return AwakerTrinketDataUtils.SortByLevel, a, b end
    return AwakerTrinketDataUtils.SortByLevel, a, b, SortOrder.Descend
  end
  do return Compare, attrValA, attrValB end
  return Compare, attrValA, attrValB, order
end

function AwakerTrinketDataUtils.SortByCompletionRate(a, b, order)
  local aCompletRate = a.completRate
  local bCompletRate = b.completRate
  if not aCompletRate then
    a.completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(a.uid)
    aCompletRate = a.completRate
  end
  if not bCompletRate then
    b.completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(b.uid)
    bCompletRate = b.completRate
  end
  if aCompletRate ~= bCompletRate then
    do return Compare, aCompletRate, bCompletRate end
    return Compare, aCompletRate, bCompletRate, order, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local aParams = TrinketSortingModel.Instance:TryCalSortingParam(a)
  local bParams = TrinketSortingModel.Instance:TryCalSortingParam(b)
  local suitOrderA = aParams.suitOrder
  local suitOrderB = bParams.suitOrder
  if suitOrderA ~= suitOrderB then
    do return Compare, suitOrderA, suitOrderB end
    return Compare, suitOrderA, suitOrderB, SortOrder.Ascend, nil, nil, nil, nil
  end
  local partA = aParams.part
  local partB = bParams.part
  if partA ~= partB then
    do return Compare, partA, partB end
    return Compare, partA, partB, SortOrder.Ascend, nil, nil
  end
  local mainAttrIdA = aParams.mainAttrId
  local mainAttrIdB = bParams.mainAttrId
  if mainAttrIdA ~= mainAttrIdB then
    do return Compare, mainAttrIdA, mainAttrIdB end
    return Compare, mainAttrIdA, mainAttrIdB, SortOrder.Ascend
  end
  do return Compare, a.tid, b.tid end
  return Compare, a.tid, b.tid, SortOrder.Ascend
end

local Schoolweight = CommonDefine.Schoolweight

function AwakerTrinketDataUtils.SortWeaponBySchool(a, b, order)
  local default = order == SortOrder.Descend and 1 or 999
  local qualitySortA = GetQualitySort(a.tid) or default
  local qualitySortB = GetQualitySort(b.tid) or default
  if qualitySortA == qualitySortB then
    local configA = ItemDataUtils.GetItemConfig(a.tid)
    local configB = ItemDataUtils.GetItemConfig(b.tid)
    if qualitySortA == ItemCfgUtils.QualitySortValueTable.Orange then
      local isRecommendA = configA.RecommendedAwaker and 1 or 0
      local isRecommendB = configB.RecommendedAwaker and 1 or 0
      if isRecommendA == isRecommendB then
        if 1 == isRecommendB then
          do
            local aSchool = Schoolweight[AwakerDataUtils.GetAwakerConfig(configA.RecommendedAwaker).School]
            local bSchool = Schoolweight[AwakerDataUtils.GetAwakerConfig(configB.RecommendedAwaker).School]
            if aSchool == bSchool then
            else
              do return Compare, aSchool, bSchool end
              do return Compare, aSchool, bSchool, order end
              goto lbl_78
            end
          end
        end
      else
        ::lbl_78::
        do return Compare, isRecommendA, isRecommendB end
        return Compare, isRecommendA, isRecommendB, order, bSchool, order
      end
    end
    local aLevel = GetItemLevel(a)
    local bLevel = GetItemLevel(b)
    if aLevel == bLevel then
      do return AwakerTrinketDataUtils.CommonSort, a end
      return AwakerTrinketDataUtils.CommonSort, a, b, order, bSchool, order
    end
    do return AwakerTrinketDataUtils.SortByLevelOnly, a, b end
    return AwakerTrinketDataUtils.SortByLevelOnly, a, b, SortOrder.Descend, bSchool, order
  end
  do return Compare, qualitySortA, qualitySortB end
  return Compare, qualitySortA, qualitySortB, order, AwakerTrinketDataUtils.SortByLevelOnly, a, b, SortOrder.Descend, bSchool, order
end

function AwakerTrinketDataUtils.SortWeaponByPotency(a, b, order)
  local aLevel = GetItemLevel(a)
  local bLevel = GetItemLevel(b)
  if aLevel == bLevel then
    local qualitySortA = GetQualitySort(a.tid)
    local qualitySortB = GetQualitySort(b.tid)
    if qualitySortA == qualitySortB then
      do return AwakerTrinketDataUtils.CommonSort, a end
      return AwakerTrinketDataUtils.CommonSort, a, b, nil
    end
    do return AwakerTrinketDataUtils.SortByQuality, a, b end
    return AwakerTrinketDataUtils.SortByQuality, a, b, order
  end
  do return AwakerTrinketDataUtils.SortByLevel, a, b end
  return AwakerTrinketDataUtils.SortByLevel, a, b, order, b, order
end

function AwakerTrinketDataUtils.SortWeaponByAttrType(a, b, attrType, order)
  local attrTypeMap = AttrUtils.GetAttrTypeMap()
  local attrId = attrTypeMap[attrType]
  if not attrId then
    Logger.Info("找不到属性id: ", attrType)
    return false
  end
  local attrValA, bounusAtrrIdA = ItemDataUtils.GetWeaponAttrNum(a.tid)
  local attrValB, bounusAtrrIdB = ItemDataUtils.GetWeaponAttrNum(b.tid)
  if bounusAtrrIdA ~= attrId then
    attrValA = 0
  end
  if bounusAtrrIdB ~= attrId then
    attrValB = 0
  end
  if attrValA == attrValB then
    local aLevel = GetItemLevel(a)
    local bLevel = GetItemLevel(b)
    if aLevel == bLevel then
      local qualitySortA = GetQualitySort(a.tid)
      local qualitySortB = GetQualitySort(b.tid)
      if qualitySortA == qualitySortB then
        do return AwakerTrinketDataUtils.CommonSort, a end
        return AwakerTrinketDataUtils.CommonSort, a, b, nil
      end
      do return AwakerTrinketDataUtils.SortByQuality, a, b end
      return AwakerTrinketDataUtils.SortByQuality, a, b, SortOrder.Descend
    end
    do return AwakerTrinketDataUtils.SortByLevel, a, b end
    return AwakerTrinketDataUtils.SortByLevel, a, b, SortOrder.Descend, b, SortOrder.Descend
  end
  do return Compare, attrValA, attrValB end
  return Compare, attrValA, attrValB, order, b, SortOrder.Descend, b, SortOrder.Descend
end

local SortTable = {
  [TrinketSortType.Level] = {
    name = LT.Text("RoleInterface_SortTypeBtn_Level"),
    funcName = "SortByLevel"
  }
}
local WeaponSortTable = {
  [WeaponSortType.Quality] = {
    name = LT.Text("WeaponSortTypeName_2"),
    sortFunc = AwakerTrinketDataUtils.SortByQuality,
    funcName = "SortByQuality"
  },
  [WeaponSortType.Potency] = {
    name = LT.Text("WeaponSortTypeName_5"),
    sortFunc = AwakerTrinketDataUtils.SortWeaponByPotency,
    funcName = "SortWeaponByPotency"
  }
}

function AwakerTrinketDataUtils.Sort(list, sortType, sortOrder, sortWithLock, sortWithoutTrinketUsing)
  if not list then
    return
  end
  if #list <= 1 then
    return list
  end
  local sortData = AwakerTrinketDataUtils.GetSortDataTable()[sortType]
  if not sortData then
    Logger.Info("找不到饰品排序数据结构: %s", sortType)
    return list
  end
  local func = AwakerTrinketDataUtils[sortData.funcName]
  if not func then
    Logger.Info("找不到饰品排序函数: %s", sortType)
    return list
  end
  local lockSortDefault = sortOrder == SortOrder.Ascend and 999 or 0
  local notLockSortDefault = sortOrder == SortOrder.Ascend and 0 or 999
  local attrName = sortData.attrName
  
  local function sortFunc(a, b)
    local itemA = ItemDataUtils.GetItemByUid(a)
    itemA = itemA or ItemDataUtils.GetItemByUid(a.uid)
    local itemB = ItemDataUtils.GetItemByUid(b)
    itemB = itemB or ItemDataUtils.GetItemByUid(b.uid)
    local aParams = TrinketSortingModel.Instance:TryCalSortingParam(itemA)
    local bParams = TrinketSortingModel.Instance:TryCalSortingParam(itemB)
    if not sortWithoutTrinketUsing then
      local isTrinketUsingA = aParams.isTrinketUsing
      local isTrinketUsingB = bParams.isTrinketUsing
      if isTrinketUsingA ~= isTrinketUsingB then
        return not isTrinketUsingA
      end
    end
    local lockSortValueA = itemA.locked and lockSortDefault or notLockSortDefault
    local lockSortValueB = itemB.locked and lockSortDefault or notLockSortDefault
    if not sortWithLock or lockSortValueA == lockSortValueB then
      if not attrName then
        do return func, itemA, itemB end
        return func, itemA, itemB, sortOrder, nil
      end
      do return func, itemA, itemB, attrName end
      return func, itemA, itemB, attrName, sortOrder
    end
    do return Compare, lockSortValueA, lockSortValueB end
    return Compare, lockSortValueA, lockSortValueB, sortOrder, sortOrder
  end
  
  tableSort(list, sortFunc)
  return list
end

function AwakerTrinketDataUtils.WeaponSort(list, sortType, sortOrder)
  if not list then
    return
  end
  if #list <= 1 then
    return list
  end
  local sortData = AwakerTrinketDataUtils.GetWeaponSortDataTable()[sortType]
  if not sortData then
    Logger.Info("找不到饰品排序数据结构: %s", sortType)
    return list
  end
  local func = AwakerTrinketDataUtils[sortData.funcName]
  if not func then
    Logger.Info("找不到饰品排序函数: %s", sortType)
    return list
  end
  
  local function sortFunc(a, b)
    local attrName = sortData.attrName
    if not attrName then
      do return func, a, b end
      return func, a, b, sortOrder, nil
    end
    do return func, a, b, attrName end
    return func, a, b, attrName, sortOrder
  end
  
  tableSort(list, sortFunc)
  return list
end

function AwakerTrinketDataUtils.WeaponSortForWeaponChange(list, sortType, sortOrder, unselectedSlotWeaponUid)
  if not list then
    return
  end
  if #list <= 1 then
    return list
  end
  local sortData = AwakerTrinketDataUtils.GetWeaponSortDataTable()[sortType]
  if not sortData then
    Logger.Info("找不到饰品排序数据结构: %s", sortType)
    return list
  end
  local func = AwakerTrinketDataUtils[sortData.funcName]
  if not func then
    Logger.Info("找不到饰品排序函数: %s", sortType)
    return list
  end
  
  local function sortFunc(a, b)
    local aForbidden = AwakerDataUtils.CheckSSRWeaponForbidden(a.uid, unselectedSlotWeaponUid) or AwakerDataUtils.CheckSameWeaponForbidden(a.tid, unselectedSlotWeaponUid)
    local bForbidden = AwakerDataUtils.CheckSSRWeaponForbidden(b.uid, unselectedSlotWeaponUid) or AwakerDataUtils.CheckSameWeaponForbidden(b.tid, unselectedSlotWeaponUid)
    if not aForbidden and bForbidden then
      return true
    end
    if not bForbidden and aForbidden then
      return false
    end
    local attrName = sortData.attrName
    if not attrName then
      do return func, a, b end
      return func, a, b, sortOrder, nil
    end
    do return func, a, b, attrName end
    return func, a, b, attrName, sortOrder
  end
  
  tableSort(list, sortFunc)
  return list
end

function AwakerTrinketDataUtils.GetSortTypeName(sortType)
  local sortTb = AwakerTrinketDataUtils.GetSortDataTable()
  return sortTb[sortType].name
end

function AwakerTrinketDataUtils.GetWeaponSortTypeName(sortType)
  local sortTb = AwakerTrinketDataUtils.GetWeaponSortDataTable()
  return sortTb[sortType].name
end

function AwakerTrinketDataUtils.GetSortDataTable()
  local sortTb = table.clone(SortTable)
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  table.insert(sortTb, {
    name = LT.Text("TrinketCompletionRate"),
    sortFunc = AwakerTrinketDataUtils.SortByCompletionRate,
    funcName = "SortByCompletionRate"
  })
  for _, attrId in ipairs(showAttrIds) do
    local attrCfg = DT.ActorAttrType[attrId]
    table.insert(sortTb, {
      name = attrCfg.Text,
      attrName = attrCfg.Name,
      sortFunc = AwakerTrinketDataUtils.SortByAttrType,
      funcName = "SortByAttrType"
    })
  end
  table.insert(sortTb, {
    name = LT.Text("WeaponSortTypeName_3"),
    sortFunc = AwakerTrinketDataUtils.SortByTimestamp,
    funcName = "SortByTimestamp"
  })
  return sortTb
end

function AwakerTrinketDataUtils.GetWeaponSortDataTable()
  local sortTb = table.clone(WeaponSortTable)
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.WeaponShow)
  for _, attrId in ipairs(showAttrIds) do
    local attrCfg = DT.ActorAttrType[attrId]
    table.insert(sortTb, {
      name = attrCfg.Text,
      attrName = attrCfg.Name,
      sortFunc = AwakerTrinketDataUtils.SortWeaponByAttrType,
      funcName = "SortWeaponByAttrType"
    })
  end
  table.insert(sortTb, {
    name = LT.Text("WeaponSortTypeName_4"),
    sortFunc = AwakerTrinketDataUtils.SortWeaponBySchool,
    funcName = "SortWeaponBySchool"
  })
  return sortTb
end

function AwakerTrinketDataUtils.ReqOnRecommendTrinket(awakerTid)
  ProtoManager.Instance:ReqServer("TrinketRequest", "OnRecommendTrinket", function()
  end, function()
  end, awakerTid)
end

local ALL_SUIT_ID = -1

function AwakerTrinketDataUtils.GetSuitIcon(suitId)
  if not suitId then
    return ""
  end
  if suitId == ALL_SUIT_ID then
    return "UIResources/AtlasSource/HD/2_Icon/Relic/IconL_Relic_510007.png"
  end
  local config = DT.TrinketSuitEffect[suitId]
  return config.Icon
end

function AwakerTrinketDataUtils.GetSuitName(suitId)
  if not suitId then
    return ""
  end
  if suitId == ALL_SUIT_ID then
    do return LT.Text end
    return LT.Text, "全部", nil
  end
  local config = DT.TrinketSuitEffect[suitId]
  do return LT.Text end
  return LT.Text, config.Name
end

function AwakerTrinketDataUtils.GetSuitItemNum(suitId)
  if suitId == ALL_SUIT_ID then
    local suitNumMap = ItemDataUtils.GetTrinketSuitNumMap()
    local suitItemNum = 0
    for _, itemNum in pairs(suitNumMap) do
      suitItemNum = suitItemNum + itemNum
    end
    return suitItemNum
  end
  do return ItemDataUtils.GetSuitItemNum end
  return ItemDataUtils.GetSuitItemNum, suitId, pairs(suitNumMap)
end

function AwakerTrinketDataUtils.ToggleTrinkFilterPanel(isOpen, trinketModel, position, callabck)
  if isOpen then
    if not UIManager.Instance:GetWindow(Urls.TrinketFilterPanel) then
      UIManager.Instance:Reopen(Urls.TrinketFilterPanel, trinketModel, position, callabck)
    end
  else
    local windowFilter = UIManager.Instance:GetWindow(Urls.TrinketFilterPanel)
    if windowFilter then
      if callabck then
        callabck(windowFilter:IsFilterChanged())
      end
      UIManager.Instance:CloseByUrl(Urls.TrinketFilterPanel)
    end
  end
end

function AwakerTrinketDataUtils.GetTrinketUpgradeItemCost(curLevel, targetLevel)
  local itemId = DT.GetConstant("TrinketUpgradeItemIndex")
  local trinketUpgradeItemNum = DT.Constant.TrinketUpgradeItemNum
  local itemNum = 0
  for i = curLevel + 1, targetLevel do
    itemNum = itemNum + trinketUpgradeItemNum.Data[i] or 0
  end
  return {tid = itemId, num = itemNum}
end

function AwakerTrinketDataUtils.GetTrinketSuitEffectConfig(suitTid)
  if not suitTid then
    return
  end
  return DT.TrinketSuitEffect[suitTid]
end

function AwakerTrinketDataUtils.CheckTrinketEffectTeamUnique(suitTid)
  local suitEffectConfig = AwakerTrinketDataUtils.GetTrinketSuitConfig(suitTid)
  if not suitEffectConfig then
    return false
  end
  return suitEffectConfig.SuitUniqueEffectNum_2 == "TRUE"
end

function AwakerTrinketDataUtils.GetAwakerTrinketDatas(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local trinketIds = awakerData.trinkets
  if not trinketIds then
    return {}
  end
  local tmp = {}
  for pos, id in pairs(trinketIds) do
    local data = ItemDataUtils.GetItemByUid(id)
    tmp[pos] = data
  end
  local trinkets = tmp
  return trinkets
end

function AwakerTrinketDataUtils.GetInvalidTrinketSuitInfos(awakerList, trinketDatas)
  local invalidMap = {}
  if not awakerList then
    return invalidMap
  end
  local validMap = {}
  for idx, awakerData in ipairs(awakerList) do
    if not awakerData or not awakerData.trinkets then
    else
      local suitActiveMap = AwakerTrinketDataUtils.GetSuitActiveMapByTrinketDatas(trinketDatas[idx])
      for suitTid, activeNum in pairs(suitActiveMap) do
        local suitEffectConfig = AwakerTrinketDataUtils.GetTrinketSuitConfig(suitTid)
        local isTeamUniqueEffectSuit = AwakerTrinketDataUtils.CheckTrinketEffectTeamUnique(suitTid)
        if isTeamUniqueEffectSuit and activeNum >= suitEffectConfig.SuitEffectNum_2 then
          if not validMap[suitTid] then
            validMap[suitTid] = awakerData.tid
          else
            if not invalidMap[awakerData.tid] then
              invalidMap[awakerData.tid] = {}
            end
            table.insert(invalidMap[awakerData.tid], suitTid)
          end
        end
      end
    end
  end
  return invalidMap
end

function AwakerTrinketDataUtils.GetInvalidTrinketAwakerNames(awakerList, trinketDatas)
  local invalidMap = AwakerTrinketDataUtils.GetInvalidTrinketSuitInfos(awakerList, trinketDatas)
  if not invalidMap or table.next(invalidMap) == nil then
    return
  end
  local awakerNames = {}
  for _, awakerData in ipairs(awakerList) do
    local awakerTid = awakerData and awakerData.tid
    if awakerTid and invalidMap[awakerTid] then
      local awakerName = AwakerDataUtils.GetAwakerName(awakerTid)
      if awakerName then
        table.insert(awakerNames, awakerName)
      end
    end
  end
  if #awakerNames > 0 then
    return awakerNames
  end
end

function AwakerTrinketDataUtils.IsSuitGatherAll(trinketDatas)
  local count = 0
  local suitId = 0
  if trinketDatas[1] and trinketDatas[1].suitId then
    suitId = trinketDatas[1] and trinketDatas[1].suitId
  elseif trinketDatas[1] and trinketDatas[1].tid then
    local tid = trinketDatas[1].tid
    local trinketCfgInfo = ItemDataUtils.GetTrinketInfoByItemTid(tid)
    suitId = trinketCfgInfo and trinketCfgInfo[2] or 0
  end
  if 0 == suitId then
    return false
  end
  for _, trinket in pairs(trinketDatas) do
    if not trinket then
      return false
    end
    local trinketSuitId = trinket.suitId
    if not trinketSuitId then
      local tid = trinket.tid
      local trinketCfgInfo = ItemDataUtils.GetTrinketInfoByItemTid(tid)
      trinketSuitId = trinketCfgInfo and trinketCfgInfo[2] or 0
    end
    if trinketSuitId ~= suitId then
      return false
    end
    count = count + 1
  end
  return count == MAX_EQUIP_TRINKET_COUNT
end

function AwakerTrinketDataUtils.GetAttrsByTrinketDataMap(trinketDatas, attrShowType)
  local rst = {}
  if not trinketDatas then
    return rst
  end
  local attrsActiveMap = {}
  for pos, itemData in pairs(trinketDatas) do
    if not itemData.attrs then
    else
      for _, attr in pairs(itemData.attrs) do
        local curVal = attrsActiveMap[attr.attrId] or 0
        attrsActiveMap[attr.attrId] = curVal + attr.val
      end
    end
  end
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(attrShowType)
  for _, attrId in ipairs(showAttrIds) do
    table.insert(rst, AwakerTrinketDataUtils.TrinketAttrToClientAttr({
      attrId = attrId,
      val = attrsActiveMap[attrId] or 0
    }))
  end
  return rst
end

function AwakerTrinketDataUtils.GetTrinketsLevelCompletePercent(trinketDatas)
  local equipLevels = 0
  for _, trinketData in pairs(trinketDatas) do
    equipLevels = equipLevels + trinketData.level
  end
  local maxLevels = AwakerTrinketDataUtils.GetTrinketMaxLevel() * MAX_EQUIP_TRINKET_COUNT
  return equipLevels / maxLevels
end

function AwakerTrinketDataUtils.GetSuitActiveMapByTrinketDatas(trinketDatas)
  local rst = {}
  for slot, trinketData in pairs(trinketDatas) do
    local itemTid = trinketData.tid
    local suitTid = AwakerTrinketDataUtils.GetSuitIdByItemTid(itemTid)
    if suitTid then
      if not rst[suitTid] then
        rst[suitTid] = 0
      end
      rst[suitTid] = rst[suitTid] + 1
    end
  end
  return rst
end

function AwakerTrinketDataUtils.GetTrinketsRefineCompletePercent(trinketDatas)
  local conversionCount = 0
  for k, trinketData in pairs(trinketDatas or {}) do
    local subAttrs = AwakerTrinketDataUtils.GetSubAttrsByItemData(trinketData)
    if subAttrs then
      for j = 1, #subAttrs do
        conversionCount = conversionCount + math.ceil((subAttrs[j].valIndex or 0) / 2)
      end
    end
  end
  local maxConversionLevel = AwakerTrinketDataUtils.GetTrinketSubAttrMaxLevel() * MaxEquipTrinketsNum * MaxSubAttrsCount
  local conversionPercent = math.floor(conversionCount / maxConversionLevel * 100)
  return conversionPercent
end

function AwakerTrinketDataUtils.GetSuitTypeInfo(trinketUids, extraItemDataMap)
  local suitType = CommonDefine.SuitType.None
  extraItemDataMap = extraItemDataMap or {}
  local fullSuitItemCount = 6
  local halfSuitItemCount = fullSuitItemCount / 2
  local suitIdList = {}
  local suitIdCountMap = {}
  local trinketDatas = {}
  for _, uid in pairs(trinketUids or {}) do
    local trinket = extraItemDataMap[uid] or ItemDataUtils.GetItemByUid(uid)
    if not trinket then
    else
      table.insert(trinketDatas, trinket)
      local suitId = trinket.suitId
      local activeNum = suitIdCountMap[suitId]
      if not activeNum then
        suitIdCountMap[suitId] = 1
        if not table.contains(suitIdList, suitId) then
          table.insert(suitIdList, suitId)
        end
      else
        suitIdCountMap[suitId] = activeNum + 1
      end
    end
  end
  if #suitIdList > 2 then
    suitType = CommonDefine.SuitType.None
  elseif 2 == #suitIdList then
    local suitCount = 0
    for _, count in pairs(suitIdCountMap) do
      if halfSuitItemCount <= count then
        suitCount = suitCount + 1
      end
    end
    if 2 == suitCount then
      suitType = CommonDefine.SuitType.TwoHalf
    elseif 1 == suitCount then
      suitType = CommonDefine.SuitType.OneHalf
    end
  elseif 1 == #suitIdList then
    if fullSuitItemCount <= suitIdCountMap[suitIdList[1]] then
      suitType = CommonDefine.SuitType.Full
    elseif halfSuitItemCount <= suitIdCountMap[suitIdList[1]] then
      suitType = CommonDefine.SuitType.OneHalf
    end
  end
  local suitTypeInfo = {
    suitType = suitType,
    suitIdList = suitIdList,
    suitIdCountMap = suitIdCountMap,
    fullSuitId = suitType == CommonDefine.SuitType.Full and suitIdList[1],
    refineCompletePercent = AwakerTrinketDataUtils.GetTrinketsRefineCompletePercent(trinketDatas),
    levelCompletePercent = AwakerTrinketDataUtils.GetTrinketsLevelCompletePercent(trinketDatas)
  }
  if suitTypeInfo.fullSuitId then
    suitTypeInfo.BaseSortId = DT.TrinketSuitEffect[suitTypeInfo.fullSuitId] and DT.TrinketSuitEffect[suitTypeInfo.fullSuitId].BaseSortID
  end
  return suitTypeInfo
end

function AwakerTrinketDataUtils.GetcurrActiveSuitEffects(trinketDatas)
  local trinkets = trinketDatas
  if not trinkets then
    return {}
  end
  local suitActiveMap = {}
  for _, trinket in pairs(trinkets) do
    local suitId = trinket.suitId
    local activeNum = suitActiveMap[suitId]
    if not activeNum then
      suitActiveMap[suitId] = 1
    else
      suitActiveMap[suitId] = activeNum + 1
    end
  end
  return suitActiveMap
end

function AwakerTrinketDataUtils.GetActiveSuitEffectDescList(trinketDatas)
  local suitActiveMap = AwakerTrinketDataUtils.GetcurrActiveSuitEffects(trinketDatas)
  local descList = {}
  for suitId, activeNum in pairs(suitActiveMap) do
    local suitConfig = DT.TrinketSuitEffect[suitId]
    local suitName = LT.Text(suitConfig.Name)
    local titleDesc = string.format("%s (%s)", suitName, activeNum)
    local tmp = {}
    for targetNum = 1, 6 do
      local descKey = string.format("SuitEffectDesc_%s", targetNum)
      local desc = suitConfig[descKey] and LT.Text(suitConfig[descKey])
      if desc then
        local suitActiveNum = targetNum
        local suitNumKey = string.format("SuitEffectNum_%s", targetNum)
        if suitConfig[suitNumKey] then
          suitActiveNum = suitConfig[suitNumKey]
        end
        if activeNum >= suitActiveNum then
          desc = LT.Textf("TrinketSuitEffect", suitActiveNum, desc)
          desc = string.format("<TrinketSuitOn:%s>", desc)
          local tmpData = {activeNum = suitActiveNum, desc = desc}
          tableInsert(tmp, tmpData)
        end
      end
    end
    tableSort(tmp, function(a, b)
      return a.activeNum < b.activeNum
    end)
    if #tmp > 0 then
      local descData = {
        suitEffectTitle = LT.Text(string.format("<TrinketSuitOn:%s>", titleDesc)),
        rawSuitEffectTitle = LT.Text(titleDesc),
        suitName = suitName,
        effectDescList = tmp,
        suitId = suitId,
        activeNum = activeNum
      }
      tableInsert(descList, descData)
    end
  end
  tableSort(descList, function(a, b)
    return #a.effectDescList > #b.effectDescList
  end)
  return descList
end

function AwakerTrinketDataUtils.GetTrinketChipTid(itemTid)
  local suitTid = AwakerTrinketDataUtils.GetSuitIdByItemTid(itemTid)
  if not suitTid then
    return nil
  end
  do return AwakerTrinketDataUtils.GetTrinketSuitConfigByField, "TrinketChip" end
  return AwakerTrinketDataUtils.GetTrinketSuitConfigByField, "TrinketChip", suitTid
end

function AwakerTrinketDataUtils.GetTrinketMaxNumber()
  local mainAttr = DT.Constant.TrinketMainAttrValue.Data
  return mainAttr[#mainAttr]
end

function AwakerTrinketDataUtils.GetTrinketSubAttrMaxNumber()
  local subAttrLevel = DT.Constant.TrinketSubAttrValueLevel.Data
  return subAttrLevel[#subAttrLevel - 1]
end

function AwakerTrinketDataUtils.GetTrinketSubAttrNum()
  local trinketSubAttrNum = DT.Constant.TrinketSubAttrNumWeight.Data
  return trinketSubAttrNum[1]
end

function AwakerTrinketDataUtils.GetTrinketMainAttrNumber(itemData)
  if itemData then
    local mainAttrValueCfg = DT.Constant.TrinketMainAttrValue.Data
    local level = itemData.level + 1
    return mainAttrValueCfg[level] or 0
  end
  return 0
end

function AwakerTrinketDataUtils.GetTrinketSubAttrNumber(trinketAttr)
  local attrId = trinketAttr.attrId or trinketAttr.tid
  local value = trinketAttr.val or trinketAttr.count or 0
  local attrType = DT.ActorAttrType[attrId]
  if not attrType then
    return 0
  end
  local equivalency = attrType.Equivalency or 0
  if 0 == equivalency then
    return 0
  end
  return value / equivalency
end

function AwakerTrinketDataUtils.GetTrinketSubAttrLevel(trinketAttr)
  if not trinketAttr then
    return 0
  end
  local attrId = trinketAttr.attrId or trinketAttr.tid
  local value = trinketAttr.val or trinketAttr.count or 0
  local attrType = DT.ActorAttrType[attrId]
  if not attrType then
    return 0
  end
  local equivalency = attrType.Equivalency or 0
  if 0 == equivalency then
    return 0
  end
  local TrinketSubAttrValueLevel = DT.Constant.TrinketSubAttrValueLevel.Data
  local attrNumber = value / equivalency
  for i = 1, #TrinketSubAttrValueLevel, 2 do
    local number = TrinketSubAttrValueLevel[i] + 0.0
    if math.abs(attrNumber - number) < 1.0E-10 then
      return TrinketSubAttrValueLevel[i + 1]
    end
  end
  return 0
end

function AwakerTrinketDataUtils.GetTrinketCompletionMaxNumber()
  local maxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
  local mainAttrMaxNumber = AwakerTrinketDataUtils.GetTrinketMaxNumber()
  local subAttrMaxNumber = AwakerTrinketDataUtils.GetTrinketSubAttrMaxNumber()
  local trinketSubAttrNum = AwakerTrinketDataUtils.GetTrinketSubAttrNum()
  return (mainAttrMaxNumber + subAttrMaxNumber * trinketSubAttrNum) * maxEquipTrinketsNum
end

function AwakerTrinketDataUtils.GetTrinketCompletionNumber(itemData)
  local attrNumber = 0
  if itemData then
    local attrs = itemData.attrs
    attrNumber = AwakerTrinketDataUtils.GetTrinketMainAttrNumber(itemData)
    local trinkNumber = 0
    for idx, attr in ipairs(attrs) do
      if idx > 1 then
        trinkNumber = AwakerTrinketDataUtils.GetTrinketSubAttrNumber(attr)
        attrNumber = attrNumber + trinkNumber
      end
    end
  end
  return attrNumber
end

function AwakerTrinketDataUtils.GetTrinketCompletionRate(itemData)
  if not itemData then
    return 0
  end
  local completionMaxNumber = AwakerTrinketDataUtils.GetTrinketCompletionMaxNumber()
  local completNumber = AwakerTrinketDataUtils.GetTrinketCompletionNumber(itemData)
  local completNumberRate = math.floor(completNumber / completionMaxNumber * 1000) / 10
  local integer, demical = math.modf(completNumberRate)
  if 0 ~= demical then
    return completNumberRate
  else
    return integer
  end
end

function AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(itemUid)
  local itemData = ItemDataUtils.GetItemByUid(itemUid)
  do return AwakerTrinketDataUtils.GetTrinketCompletionRate end
  return AwakerTrinketDataUtils.GetTrinketCompletionRate, itemData
end

function AwakerTrinketDataUtils.GetTrinketPreviewCompletionRate(itemUid, previewLevel, subAttrs)
  local itemData = ItemDataUtils.GetItemByUid(itemUid)
  local previewItemData = {}
  if not itemData then
    return
  end
  previewItemData.level = previewLevel and previewLevel or itemData.level
  if subAttrs and table.next(subAttrs) then
    local attrs = {}
    table.insert(attrs, itemData.attrs[1])
    for _, attr in ipairs(subAttrs) do
      table.insert(attrs, attr)
    end
    previewItemData.attrs = attrs
  else
    previewItemData.attrs = itemData.attrs
  end
  do return AwakerTrinketDataUtils.GetTrinketCompletionRate end
  return AwakerTrinketDataUtils.GetTrinketCompletionRate, previewItemData, ipairs(subAttrs)
end

function AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(trinketSuitData)
  if not trinketSuitData then
    return 0
  end
  local suitCompletNumber = 0
  local completionMaxNumber = AwakerTrinketDataUtils.GetTrinketCompletionMaxNumber()
  for _, trinketData in pairs(trinketSuitData) do
    local uid
    if type(trinketData) == "table" then
      uid = trinketData.uid
    else
      uid = trinketData
    end
    local itemData = ItemDataUtils.GetItemByUid(uid) or trinketData
    if itemData and type(itemData) == "table" then
      suitCompletNumber = suitCompletNumber + AwakerTrinketDataUtils.GetTrinketCompletionNumber(itemData)
    end
  end
  local suitCompletNumberRate = math.floor(suitCompletNumber / completionMaxNumber * 1000) / 10
  local integer, demical = math.modf(suitCompletNumberRate)
  if 0 ~= demical then
    return suitCompletNumberRate
  else
    return integer
  end
end

function AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(awakerData)
  return awakerData and awakerData.boundTrinkets or {}
end

function AwakerTrinketDataUtils.HasAnyValidBoundTrinket(awakerTid)
  if not awakerTid or 0 == awakerTid then
    return false
  end
  for pos = 1, MaxEquipTrinketsNum do
    local boundUid = AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, pos)
    if 0 ~= boundUid and ItemDataUtils.GetItemByUid(boundUid) then
      return true
    end
  end
  return false
end

function AwakerTrinketDataUtils.IsBoundTrinketEffective(awakerTid, trinketUids)
  if not awakerTid or 0 == awakerTid or not trinketUids then
    return false
  end
  for pos = 1, MaxEquipTrinketsNum do
    local teamUid = trinketUids[pos] or 0
    local boundUid = AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, pos)
    local hasBoundItem = 0 ~= boundUid and ItemDataUtils.GetItemByUid(boundUid) ~= nil
    local slotEffective = hasBoundItem and (0 == teamUid or teamUid == boundUid)
    if slotEffective then
      return true
    end
  end
  return false
end

function AwakerTrinketDataUtils.IsBoundTrinketEffectiveByBoundTable(boundTrinkets, trinketUids, itemMap)
  if not boundTrinkets or table.next(boundTrinkets) == nil then
    return false
  end
  trinketUids = trinketUids or {}
  for pos = 1, MaxEquipTrinketsNum do
    local boundUid = boundTrinkets[pos] or 0
    if 0 ~= boundUid then
      local boundItem = itemMap and itemMap[boundUid] or ItemDataUtils.GetItemByUid(boundUid)
      local teamUid = trinketUids[pos] or 0
      if boundItem and (0 == teamUid or teamUid == boundUid) then
        return true
      end
    end
  end
  return false
end

function AwakerTrinketDataUtils.HasBoundTrinketOverriddenByBoundTable(boundTrinkets, trinketUids, itemMap)
  if not boundTrinkets or table.next(boundTrinkets) == nil then
    return false
  end
  trinketUids = trinketUids or {}
  for pos = 1, MaxEquipTrinketsNum do
    local boundUid = boundTrinkets[pos] or 0
    if 0 ~= boundUid then
      local boundItem = itemMap and itemMap[boundUid] or ItemDataUtils.GetItemByUid(boundUid)
      local teamUid = trinketUids[pos] or 0
      if boundItem and 0 ~= teamUid and teamUid ~= boundUid then
        return true
      end
    end
  end
  return false
end

function AwakerTrinketDataUtils.GetDisplayTrinketUidsWithBound(awakerTid, trinketUids, boundTrinkets, itemMap)
  if not (trinketUids and awakerTid) or 0 == awakerTid then
    return trinketUids
  end
  local displayMap = {}
  local hasSubstitute = false
  for pos = 1, MaxEquipTrinketsNum do
    local uid = trinketUids[pos] or 0
    if 0 == uid then
      local boundUid = 0
      if boundTrinkets then
        boundUid = boundTrinkets[pos] or 0
      elseif table.next(AwakerDataUtils.GetMockAwakerMap()) == nil then
        boundUid = AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, pos)
      end
      if 0 ~= boundUid then
        local boundItem = itemMap and itemMap[boundUid] or ItemDataUtils.GetItemByUid(boundUid)
        if boundItem then
          uid = boundUid
          hasSubstitute = true
        end
      end
    end
    displayMap[pos] = uid
  end
  if not hasSubstitute then
    return trinketUids
  end
  return displayMap
end

function AwakerTrinketDataUtils.CalcBoundTrinketTagStates(awakerTid, trinketUids, boundTrinkets, itemMap)
  if boundTrinkets then
    return AwakerTrinketDataUtils.IsBoundTrinketEffectiveByBoundTable(boundTrinkets, trinketUids, itemMap), AwakerTrinketDataUtils.HasBoundTrinketOverriddenByBoundTable(boundTrinkets, trinketUids, itemMap)
  end
  return AwakerTrinketDataUtils.IsBoundTrinketEffective(awakerTid, trinketUids), AwakerTrinketDataUtils.HasBoundTrinketOverridden(awakerTid, trinketUids)
end

function AwakerTrinketDataUtils.RefreshBoundTrinketTags(ui, awakerTid, trinketUids, boundTrinkets, itemMap)
  if not ui or not ui.Image_Trinket_Bind and not ui.Image_HasBindTrinket then
    return
  end
  local showBind, showOverridden = AwakerTrinketDataUtils.CalcBoundTrinketTagStates(awakerTid, trinketUids, boundTrinkets, itemMap)
  if ui.Image_Trinket_Bind then
    ui.Image_Trinket_Bind:SetActive(showBind)
  end
  if ui.Image_HasBindTrinket then
    ui.Image_HasBindTrinket:SetActive(showOverridden)
  end
end

function AwakerTrinketDataUtils.HasBoundTrinketOverridden(awakerTid, trinketUids)
  if not awakerTid or 0 == awakerTid then
    return false
  end
  trinketUids = trinketUids or {}
  for pos = 1, MaxEquipTrinketsNum do
    local boundUid = AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, pos)
    local teamUid = trinketUids[pos] or 0
    local hasItem = 0 ~= boundUid and ItemDataUtils.GetItemByUid(boundUid) ~= nil
    local overridden = hasItem and 0 ~= teamUid and teamUid ~= boundUid
    if overridden then
      return true
    end
  end
  return false
end

local BIND_BONUS_YELLOW_FALLBACK = "#f5df94"
local bindBonusRateCache

local function GetBindBonusRate()
  if nil == bindBonusRateCache then
    local rateCfg = DT.Constant.TrinketMainAttrBindBonusRate
    bindBonusRateCache = rateCfg and rateCfg.Data and rateCfg.Data[1] or 0
  end
  return bindBonusRateCache
end

local BIND_BONUS_FLOOR_EPSILON = 1.0E-9

local function FloorToTenths(value)
  return math.floor(value * 10 + BIND_BONUS_FLOOR_EPSILON) / 10
end

function AwakerTrinketDataUtils.GetBindBonusDisplayCount(count, isPercent)
  local _ = isPercent
  count = count or 0
  local bonusValue = count * (1 + GetBindBonusRate())
  do return FloorToTenths end
  return FloorToTenths, bonusValue
end

function AwakerTrinketDataUtils.GetBindBonusAggDisplayCount(totalCount, mainContributions, isPercent)
  totalCount = totalCount or 0
  if not mainContributions or 0 == #mainContributions then
    return totalCount
  end
  local rawMainSum = 0
  local boostedMainSum = 0
  for _, rawVal in ipairs(mainContributions) do
    rawMainSum = rawMainSum + rawVal
    boostedMainSum = boostedMainSum + AwakerTrinketDataUtils.GetBindBonusDisplayCount(rawVal, isPercent)
  end
  do return FloorToTenths end
  return FloorToTenths, totalCount - rawMainSum + boostedMainSum, ipairs(mainContributions)
end

function AwakerTrinketDataUtils.CollectBindBonusMainContributions(trinketItems, boundTrinkets)
  local boundUidSet
  if boundTrinkets then
    boundUidSet = {}
    for _, uid in pairs(boundTrinkets) do
      if 0 ~= uid then
        boundUidSet[uid] = true
      end
    end
  end
  local tidMap = {}
  for _, itemData in pairs(trinketItems or {}) do
    local isActive = false
    if itemData then
      if boundUidSet then
        isActive = true == boundUidSet[itemData.uid or 0]
      else
        isActive = AwakerTrinketDataUtils.IsTrinketBindBonusActive(itemData)
      end
    end
    if isActive then
      local mainAttr = AwakerTrinketDataUtils.GetMainAttrByItemData(itemData)
      if mainAttr and mainAttr.attrId then
        tidMap[mainAttr.attrId] = tidMap[mainAttr.attrId] or {}
        tableInsert(tidMap[mainAttr.attrId], mainAttr.val or 0)
      end
    end
  end
  return tidMap
end

function AwakerTrinketDataUtils.GetBindBonusAttrDisplayMap(trinkets, attrList, opts)
  local forceBonusUid = opts and opts.forceBonusUid or 0
  local itemDataList = {}
  local forceItemData
  for _, trinket in pairs(trinkets or {}) do
    local itemData = trinket
    if type(trinket) == "number" then
      itemData = 0 ~= trinket and ItemDataUtils.GetItemByUid(trinket) or nil
    end
    if itemData then
      if 0 ~= forceBonusUid and itemData.uid == forceBonusUid then
        forceItemData = itemData
      else
        tableInsert(itemDataList, itemData)
      end
    end
  end
  local contributionsMap = AwakerTrinketDataUtils.CollectBindBonusMainContributions(itemDataList, opts and opts.boundTrinkets or nil)
  if forceItemData then
    local mainAttr = AwakerTrinketDataUtils.GetMainAttrByItemData(forceItemData)
    if mainAttr and mainAttr.attrId then
      contributionsMap[mainAttr.attrId] = contributionsMap[mainAttr.attrId] or {}
      tableInsert(contributionsMap[mainAttr.attrId], mainAttr.val or 0)
    end
  end
  local displayMap = {}
  for _, attr in pairs(attrList or {}) do
    local contributions = attr and attr.tid and contributionsMap[attr.tid] or nil
    if contributions then
      displayMap[attr.tid] = {
        displayCount = AwakerTrinketDataUtils.GetBindBonusAggDisplayCount(attr.count, contributions, attr.isPercent),
        isBonusHit = true
      }
    end
  end
  return displayMap
end

function AwakerTrinketDataUtils.IsTrinketBindBonusActive(itemData)
  local uid = itemData and itemData.uid or 0
  return AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) ~= nil
end

function AwakerTrinketDataUtils.IsTrinketBindBonusActiveByUid(uid)
  return AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) ~= nil
end

function AwakerTrinketDataUtils.IsTrinketBoundForCellTag(itemData)
  do return AwakerTrinketDataUtils.IsTrinketBindBonusActive end
  return AwakerTrinketDataUtils.IsTrinketBindBonusActive, itemData
end

function AwakerTrinketDataUtils.IsTrinketBoundForLight(uid)
  if not uid or 0 == uid then
    return false
  end
  return AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) ~= nil
end

function AwakerTrinketDataUtils.IsTrinketBoundForLightByBoundTable(uid, boundTrinkets)
  if not uid or 0 == uid or not boundTrinkets then
    return false
  end
  for _, boundUid in pairs(boundTrinkets) do
    if boundUid == uid then
      return true
    end
  end
  return false
end

function AwakerTrinketDataUtils.GetTrinketLightPartIndex(tid)
  if not tid or 0 == tid then
    return nil
  end
  local spParam = ItemDataUtils.GetTrinketInfoByItemTid(tid)
  return spParam and spParam[1] or nil
end

function AwakerTrinketDataUtils.IsTrinketVisibleInList(uid, exemptUid)
  if not AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
    return true
  end
  if exemptUid and 0 ~= exemptUid and uid == exemptUid then
    return true
  end
  return false
end

function AwakerTrinketDataUtils.GetBindBonusAttrText(attrText)
  if not attrText or "" == attrText then
    return attrText or ""
  end
  local color = CommonDefine.TextColorDefine.TrinketBindBonus
  if not color or "" == color then
    color = ColorUtils.GetColorHexCode("Yellow", CommonDefine.ColorType.Light) or BIND_BONUS_YELLOW_FALLBACK
  end
  do return StrUtils.GetColorText, attrText end
  return StrUtils.GetColorText, attrText, color
end

function AwakerTrinketDataUtils.WrapAttrTextWithBindBonus(attrText, itemDataOrUid)
  local itemData = itemDataOrUid
  if type(itemDataOrUid) == "number" then
    itemData = ItemDataUtils.GetItemByUid(itemDataOrUid)
  end
  if not AwakerTrinketDataUtils.IsTrinketBindBonusActive(itemData) then
    return attrText or ""
  end
  do return AwakerTrinketDataUtils.GetBindBonusAttrText end
  return AwakerTrinketDataUtils.GetBindBonusAttrText, attrText
end

return AwakerTrinketDataUtils
