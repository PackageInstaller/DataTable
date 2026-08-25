local SummonCategorySelectDataUtils = {}
local _dropIdListCache = {}
local _itemTidListCache = {}
local _mockByPoolId = {}
local _hintedErr = {}

function SummonCategorySelectDataUtils.GetConstKey(poolId, suffix)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if not poolCfg or not poolCfg.Type then
    return nil
  end
  return "SummonType_" .. poolCfg.Type .. suffix
end

function SummonCategorySelectDataUtils.GetPoolConstPairValue(constKey, poolId)
  if not constKey or not poolId then
    return nil
  end
  local constValue = DT.GetOriginalConstant(constKey)
  if not constValue then
    return nil
  end
  if type(constValue[1]) == "number" then
    for i = 1, #constValue, 2 do
      if constValue[i] == poolId then
        return constValue[i + 1]
      end
    end
    return nil
  end
  for i = 1, #constValue do
    local pair = constValue[i]
    if type(pair) == "table" and pair[1] == poolId then
      return pair[2]
    end
  end
  return nil
end

function SummonCategorySelectDataUtils.SetMockConfig(poolId, selectNum, dropIdList)
  if not poolId then
    return
  end
  _mockByPoolId[poolId] = {
    selectNum = selectNum or 0,
    dropIdList = dropIdList or {}
  }
  _dropIdListCache[poolId] = nil
  _itemTidListCache[poolId] = nil
end

function SummonCategorySelectDataUtils.ClearMockConfig(poolId)
  if poolId then
    _mockByPoolId[poolId] = nil
    _dropIdListCache[poolId] = nil
    _itemTidListCache[poolId] = nil
    return
  end
  _mockByPoolId = {}
  _dropIdListCache = {}
  _itemTidListCache = {}
end

function SummonCategorySelectDataUtils.GetSelectNum(poolId)
  if not poolId then
    return 0
  end
  local mockCfg = _mockByPoolId[poolId]
  if mockCfg then
    return mockCfg.selectNum or 0
  end
  local constKey = SummonCategorySelectDataUtils.GetConstKey(poolId, "SelectNum")
  local selectNum = SummonCategorySelectDataUtils.GetPoolConstPairValue(constKey, poolId)
  return selectNum or 0
end

function SummonCategorySelectDataUtils.GetRawDropIdList(poolId)
  if not poolId then
    return {}
  end
  local mockCfg = _mockByPoolId[poolId]
  if mockCfg then
    return mockCfg.dropIdList or {}
  end
  local constKey = SummonCategorySelectDataUtils.GetConstKey(poolId, "SelectDropList")
  local dropIdList = SummonCategorySelectDataUtils.GetPoolConstPairValue(constKey, poolId)
  if type(dropIdList) ~= "table" then
    return {}
  end
  return dropIdList
end

function SummonCategorySelectDataUtils.GetCategoryDropIdList(poolId)
  if not poolId then
    return {}
  end
  if _dropIdListCache[poolId] then
    return _dropIdListCache[poolId]
  end
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  local rawList = SummonCategorySelectDataUtils.GetRawDropIdList(poolId)
  if selectNum <= 0 then
    _dropIdListCache[poolId] = {}
    return _dropIdListCache[poolId]
  end
  if selectNum > #rawList then
    if not _hintedErr[poolId] then
      _hintedErr[poolId] = true
      Logger.Error("SummonType SelectDropList shorter than SelectNum, poolId:" .. tostring(poolId) .. ", dropCount:" .. tostring(#rawList) .. ", selectNum:" .. tostring(selectNum))
    end
    _dropIdListCache[poolId] = {}
    return _dropIdListCache[poolId]
  end
  local list = {}
  for i = 1, selectNum do
    list[i] = rawList[i]
  end
  _dropIdListCache[poolId] = list
  return list
end

function SummonCategorySelectDataUtils.GetDropItemTidList(dropId)
  if not dropId then
    return {}
  end
  local dataList = DropCfgUtils.GetCfgByfield("data_list", dropId)
  if not dataList then
    return {}
  end
  local rst = {}
  for i = 1, #dataList do
    local data = dataList[i]
    if data and data.DropItem then
      rst[#rst + 1] = data.DropItem
    end
  end
  if 0 == #rst then
    for _, data in pairs(dataList) do
      if data and data.DropItem then
        rst[#rst + 1] = data.DropItem
      end
    end
  end
  return rst
end

function SummonCategorySelectDataUtils.GetCategoryDropId(poolId, slot)
  local dropIdList = SummonCategorySelectDataUtils.GetCategoryDropIdList(poolId)
  return dropIdList[slot]
end

function SummonCategorySelectDataUtils.GetCategoryItemTidList(poolId, slot)
  if not poolId or not slot then
    return {}
  end
  local poolCache = _itemTidListCache[poolId]
  if poolCache and poolCache[slot] then
    return poolCache[slot]
  end
  local dropIdList = SummonCategorySelectDataUtils.GetCategoryDropIdList(poolId)
  local dropId = dropIdList[slot]
  local list = SummonCategorySelectDataUtils.GetDropItemTidList(dropId)
  if not _itemTidListCache[poolId] then
    _itemTidListCache[poolId] = {}
  end
  _itemTidListCache[poolId][slot] = list
  return list
end

function SummonCategorySelectDataUtils.IsItemInCategory(poolId, slot, itemTid)
  if not itemTid then
    return false
  end
  local list = SummonCategorySelectDataUtils.GetCategoryItemTidList(poolId, slot)
  do return table.contains, list end
  return table.contains, list, itemTid
end

function SummonCategorySelectDataUtils.GetRecommendWeaponItemTid(awakerItemTid)
  if not awakerItemTid or not DT.Item[awakerItemTid] then
    return nil
  end
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(awakerItemTid)
  if not awakerTid then
    return nil
  end
  do return AwakerCfgUtils.GetFirstRecommendWeapon end
  return AwakerCfgUtils.GetFirstRecommendWeapon, awakerTid
end

function SummonCategorySelectDataUtils.GetConflictSlot(poolId, itemTid, draftSlotMap, ignoreSlot)
  if not itemTid or not draftSlotMap then
    return nil
  end
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  for slot = 1, selectNum do
    if slot ~= ignoreSlot then
      local draftItemTid = draftSlotMap[slot]
      if draftItemTid and (draftItemTid == itemTid or awakerTid and ItemDataUtils.GetAwakerTidByItemTid(draftItemTid) == awakerTid) then
        return slot
      end
    end
  end
  return nil
end

function SummonCategorySelectDataUtils.GetListItemTid(itemTidList, index)
  if not itemTidList or not index then
    return nil
  end
  return itemTidList[index]
end

function SummonCategorySelectDataUtils.GetSelectTypeTextKey(poolId, slot)
  if not poolId or not slot then
    return nil
  end
  do return SummonCategorySelectDataUtils.GetConstKey, poolId end
  return SummonCategorySelectDataUtils.GetConstKey, poolId, "SelectType_" .. slot, slot
end

function SummonCategorySelectDataUtils.GetSelectTypeText(poolId, slot)
  local typeKey = SummonCategorySelectDataUtils.GetSelectTypeTextKey(poolId, slot)
  if not typeKey then
    return ""
  end
  do return LT.Text end
  return LT.Text, typeKey
end

function SummonCategorySelectDataUtils.IsValidImagePath(path)
  return type(path) == "string" and "" ~= path
end

function SummonCategorySelectDataUtils.GetSelectTypeIcon(poolId, slot)
  if not poolId or not slot then
    return nil
  end
  local slotConstKey = SummonCategorySelectDataUtils.GetConstKey(poolId, "SelectTypeIcon_" .. slot)
  local listConstKey = SummonCategorySelectDataUtils.GetConstKey(poolId, "SelectTypeIcon")
  local iconPath = slotConstKey and DT.GetConstant(slotConstKey)
  if type(iconPath) == "table" then
    iconPath = iconPath[slot] or SummonCategorySelectDataUtils.GetPoolConstPairValue(slotConstKey, poolId)
  end
  if type(iconPath) == "table" then
    iconPath = iconPath[slot]
  end
  if not SummonCategorySelectDataUtils.IsValidImagePath(iconPath) and slotConstKey then
    iconPath = SummonCategorySelectDataUtils.GetPoolConstPairValue(slotConstKey, poolId)
    if type(iconPath) == "table" then
      iconPath = iconPath[slot]
    end
  end
  if not SummonCategorySelectDataUtils.IsValidImagePath(iconPath) and listConstKey then
    local iconList = DT.GetConstant(listConstKey)
    if type(iconList) == "table" then
      iconPath = iconList[slot]
    end
    if not SummonCategorySelectDataUtils.IsValidImagePath(iconPath) then
      iconList = SummonCategorySelectDataUtils.GetPoolConstPairValue(listConstKey, poolId)
      if type(iconList) == "table" then
        iconPath = iconList[slot]
      end
    end
  end
  if SummonCategorySelectDataUtils.IsValidImagePath(iconPath) then
    return iconPath
  end
  return nil
end

function SummonCategorySelectDataUtils.GetConflictTips(poolId, itemTid, draftSlotMap, ignoreSlot)
  local conflictSlot = SummonCategorySelectDataUtils.GetConflictSlot(poolId, itemTid, draftSlotMap, ignoreSlot)
  if not conflictSlot then
    return nil
  end
  local tipsKey = SummonCategorySelectDataUtils.GetConstKey(poolId, "SelectedTips") or "SummonType_17SelectedTips"
  do return LT.Textf, tipsKey, SummonCategorySelectDataUtils.GetSelectTypeText(poolId, conflictSlot) end
  return LT.Textf, tipsKey, SummonCategorySelectDataUtils.GetSelectTypeText(poolId, conflictSlot)
end

function SummonCategorySelectDataUtils.GetFirstEmptySlot(poolId, draftSlotMap)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  for slot = 1, selectNum do
    if not draftSlotMap or not draftSlotMap[slot] then
      return slot
    end
  end
  return nil
end

function SummonCategorySelectDataUtils.GetDraftSelectedCount(poolId, draftSlotMap)
  if not draftSlotMap then
    return 0
  end
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  local count = 0
  for slot = 1, selectNum do
    if draftSlotMap[slot] then
      count = count + 1
    end
  end
  return count
end

function SummonCategorySelectDataUtils.GetDraftAwakerNames(poolId, draftSlotMap)
  local names = {}
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  for slot = 1, selectNum do
    local itemTid = draftSlotMap and draftSlotMap[slot]
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    names[#names + 1] = LT.Text(AwakerCfgUtils.GetCfgField("Name", awakerTid) or "")
  end
  return names
end

function SummonCategorySelectDataUtils.CanConfirm(poolId, draftSlotMap)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  if selectNum <= 0 then
    return false, "SelectNumInvalid"
  end
  local dropIdList = SummonCategorySelectDataUtils.GetCategoryDropIdList(poolId)
  if #dropIdList ~= selectNum then
    return false, "DropListInvalid"
  end
  if SummonCategorySelectDataUtils.GetDraftSelectedCount(poolId, draftSlotMap) ~= selectNum then
    return false, "NotEnough"
  end
  local usedItemTid = {}
  local usedAwakerTid = {}
  for slot = 1, selectNum do
    local itemTid = draftSlotMap[slot]
    if not SummonCategorySelectDataUtils.IsItemInCategory(poolId, slot, itemTid) then
      return false, "ItemNotInCategory"
    end
    if usedItemTid[itemTid] then
      return false, "Duplicated"
    end
    usedItemTid[itemTid] = true
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    if awakerTid then
      if usedAwakerTid[awakerTid] then
        return false, "Duplicated"
      end
      usedAwakerTid[awakerTid] = true
    end
  end
  return true
end

function SummonCategorySelectDataUtils.BuildConfirmItemTidList(poolId, draftSlotMap)
  local list = {}
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  for slot = 1, selectNum do
    list[slot] = draftSlotMap and draftSlotMap[slot]
  end
  return list
end

function SummonCategorySelectDataUtils.CopyDraftSlotMap(draftSlotMap)
  local copy = {}
  if not draftSlotMap then
    return copy
  end
  for slot, itemTid in pairs(draftSlotMap) do
    copy[slot] = itemTid
  end
  return copy
end

function SummonCategorySelectDataUtils.BuildSlotListFromServerData(summonData)
  if not summonData then
    return nil
  end
  local slotMap = summonData.selectedSlotAwakerTidMap
  if slotMap and next(slotMap) then
    local list = {}
    for slot, itemTid in pairs(slotMap) do
      list[tonumber(slot) or slot] = itemTid
    end
    return list
  end
  return summonData.selectedAwakerTidList
end

function SummonCategorySelectDataUtils.GetSortWeight(itemTid, isConflict)
  local conflictWeight = isConflict and 1 or 0
  local awakerTid = DT.Item[itemTid] and ItemDataUtils.GetAwakerTidByItemTid(itemTid)
  local awakerCfg = awakerTid and DT.AwakerConfig[awakerTid]
  local fullWeight = ItemDataUtils.IsAwakerChipOverFlow(itemTid) and 1 or 0
  local ownedWeight = awakerTid and AwakerDataUtils.HasOwnedAwaker(awakerTid) and 0 or 1
  local qualityWeight = awakerCfg and CommonDefine.QualitySortID[awakerCfg.Quality] or 0
  local schoolType = awakerTid and AwakerCfgUtils.GetAwakerSchoolType(awakerTid)
  local schoolWeight = schoolType and CommonDefine.ShoolTypeSortWeight[schoolType] or 0
  local potencyLevel = awakerTid and AwakerDataUtils.GetAwakerPotencyLevel(awakerTid) or 0
  local baseSortId = awakerCfg and awakerCfg.BaseSortID or 0
  return conflictWeight, fullWeight, ownedWeight, qualityWeight, schoolWeight, potencyLevel, baseSortId
end

function SummonCategorySelectDataUtils.SortCategoryItemList(poolId, slot, draftSlotMap, itemTidList)
  local list = {}
  if not itemTidList then
    return list
  end
  for i = 1, #itemTidList do
    list[i] = itemTidList[i]
  end
  table.sort(list, function(a, b)
    local conflictA = SummonCategorySelectDataUtils.GetConflictSlot(poolId, a, draftSlotMap, slot) ~= nil
    local conflictB = SummonCategorySelectDataUtils.GetConflictSlot(poolId, b, draftSlotMap, slot) ~= nil
    local cA, fA, oA, qA, sA, pA, bA = SummonCategorySelectDataUtils.GetSortWeight(a, conflictA)
    local cB, fB, oB, qB, sB, pB, bB = SummonCategorySelectDataUtils.GetSortWeight(b, conflictB)
    if cA ~= cB then
      return cA < cB
    end
    if fA ~= fB then
      return fA < fB
    end
    if oA ~= oB then
      return oA > oB
    end
    if qA ~= qB then
      return qA > qB
    end
    if sA ~= sB then
      return sA > sB
    end
    if pA ~= pB then
      return pA > pB
    end
    return bA < bB
  end)
  return list
end

function SummonCategorySelectDataUtils.IsSelectionConfirmed(poolId)
  local selectedList = SummonDataUtils.GetSelectedAwakerTidList(poolId)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  if not selectedList or selectNum <= 0 then
    return false
  end
  if selectNum > #selectedList then
    return false
  end
  for slot = 1, selectNum do
    if not selectedList[slot] then
      return false
    end
  end
  return true
end

function SummonCategorySelectDataUtils.GetAllCandidateAwakerItemTidList(poolId)
  local usedItemTid = {}
  local usedAwakerTid = {}
  local list = {}
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  for slot = 1, selectNum do
    local itemList = SummonCategorySelectDataUtils.GetCategoryItemTidList(poolId, slot)
    for i = 1, #itemList do
      local itemTid = SummonCategorySelectDataUtils.GetListItemTid(itemList, i)
      if itemTid and not usedItemTid[itemTid] then
        local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
        if not awakerTid or not usedAwakerTid[awakerTid] then
          usedItemTid[itemTid] = true
          if awakerTid then
            usedAwakerTid[awakerTid] = true
          end
          list[#list + 1] = itemTid
        end
      end
    end
  end
  return list
end

function SummonCategorySelectDataUtils.GetAllCandidateWeaponItemTidList(poolId)
  local awakerItemTidList = SummonCategorySelectDataUtils.GetAllCandidateAwakerItemTidList(poolId)
  local used = {}
  local list = {}
  for i = 1, #awakerItemTidList do
    local awakerItemTid = SummonCategorySelectDataUtils.GetListItemTid(awakerItemTidList, i)
    local weaponItemTid = SummonCategorySelectDataUtils.GetRecommendWeaponItemTid(awakerItemTid)
    if weaponItemTid and not used[weaponItemTid] then
      used[weaponItemTid] = true
      list[#list + 1] = weaponItemTid
    end
  end
  return list
end

function SummonCategorySelectDataUtils.GetDropRateMap(poolId)
  local rateMap = {}
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if not poolCfg then
    return rateMap
  end
  local dropRateKey = SummonCfgUtils.GetSummonDropRateKey(poolId)
  local poolRateCfg = DT.GetOriginalConstant(dropRateKey, {})
  local rateListKey = poolRateCfg and poolRateCfg[1]
  local rateList = rateListKey and DT.GetOriginalConstant(rateListKey, {})
  if not rateList or #rateList < 4 then
    Logger.Error("SummonCategorySelect GetDropRateMap missing rate config, poolId:" .. tostring(poolId) .. ", dropRateKey:" .. tostring(dropRateKey))
    return rateMap
  end
  local awakerItemList, weaponItemList
  if SummonCategorySelectDataUtils.IsSelectionConfirmed(poolId) then
    awakerItemList = {}
    local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
    for slot = 1, selectNum do
      local itemTid = SummonCategorySelectDataUtils.GetConfirmedSlotItemTid(poolId, slot)
      if itemTid then
        awakerItemList[#awakerItemList + 1] = itemTid
      end
    end
    weaponItemList = SummonCategorySelectDataUtils.GetConfirmedWeaponItemTidList(poolId)
  else
    awakerItemList = SummonCategorySelectDataUtils.GetAllCandidateAwakerItemTidList(poolId)
    weaponItemList = SummonCategorySelectDataUtils.GetAllCandidateWeaponItemTidList(poolId)
  end
  if #awakerItemList > 0 then
    local awakerRate = rateList[1] / #awakerItemList
    for i = 1, #awakerItemList do
      rateMap[awakerItemList[i]] = awakerRate
    end
  end
  if #weaponItemList > 0 then
    local weaponRate = rateList[2] / #weaponItemList
    for i = 1, #weaponItemList do
      rateMap[weaponItemList[i]] = weaponRate
    end
  end
  if poolCfg.SRAward and rateList[3] then
    local srWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.SRAward, rateList[3], srWeaponRateDict)
    for tid, srRate in pairs(srWeaponRateDict) do
      rateMap[tid] = srRate
    end
  end
  if poolCfg.RAward and rateList[4] then
    local rWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.RAward, rateList[4], rWeaponRateDict)
    for tid, rRate in pairs(rWeaponRateDict) do
      rateMap[tid] = rRate
    end
  end
  return rateMap
end

function SummonCategorySelectDataUtils.GetConfirmedAwakerItemTidList(poolId)
  local selectedList = SummonDataUtils.GetSelectedAwakerTidList(poolId)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  local list = {}
  if not selectedList or selectNum <= 0 then
    return list
  end
  for slot = 1, selectNum do
    if selectedList[slot] then
      list[#list + 1] = selectedList[slot]
    end
  end
  return list
end

function SummonCategorySelectDataUtils.GetConfirmedSlotItemTid(poolId, slot)
  local selectedList = SummonDataUtils.GetSelectedAwakerTidList(poolId)
  return selectedList and selectedList[slot]
end

function SummonCategorySelectDataUtils.GetConfirmedWeaponItemTidList(poolId)
  local awakerItemTidList = SummonCategorySelectDataUtils.GetConfirmedAwakerItemTidList(poolId)
  local used = {}
  local list = {}
  for i = 1, #awakerItemTidList do
    local awakerItemTid = SummonCategorySelectDataUtils.GetListItemTid(awakerItemTidList, i)
    local weaponItemTid = SummonCategorySelectDataUtils.GetRecommendWeaponItemTid(awakerItemTid)
    if weaponItemTid and not used[weaponItemTid] then
      used[weaponItemTid] = true
      list[#list + 1] = weaponItemTid
    end
  end
  return list
end

function SummonCategorySelectDataUtils.AppendItemTidList(targetList, sourceList)
  if not targetList or not sourceList then
    return
  end
  for i = 1, #sourceList do
    local itemTid = SummonCategorySelectDataUtils.GetListItemTid(sourceList, i)
    if itemTid then
      targetList[#targetList + 1] = itemTid
    end
  end
end

function SummonCategorySelectDataUtils.GetSsrRateDisplayItemTidList(poolId)
  local list = {}
  local awakerItemTidList, weaponItemTidList
  if SummonCategorySelectDataUtils.IsSelectionConfirmed(poolId) then
    awakerItemTidList = SummonCategorySelectDataUtils.GetConfirmedAwakerItemTidList(poolId)
    weaponItemTidList = SummonCategorySelectDataUtils.GetConfirmedWeaponItemTidList(poolId)
  else
    awakerItemTidList = SummonCategorySelectDataUtils.GetAllCandidateAwakerItemTidList(poolId)
    weaponItemTidList = SummonCategorySelectDataUtils.GetAllCandidateWeaponItemTidList(poolId)
  end
  SummonCategorySelectDataUtils.AppendItemTidList(list, awakerItemTidList)
  SummonCategorySelectDataUtils.AppendItemTidList(list, weaponItemTidList)
  return list
end

function SummonCategorySelectDataUtils.IsInConfirmedDropList(poolId, itemTid)
  if not poolId or not itemTid then
    return false
  end
  if not SummonCategorySelectDataUtils.IsSelectionConfirmed(poolId) then
    return false
  end
  local awakerItemTidList = SummonCategorySelectDataUtils.GetConfirmedAwakerItemTidList(poolId)
  if table.contains(awakerItemTidList, itemTid) then
    return true
  end
  local weaponItemTidList = SummonCategorySelectDataUtils.GetConfirmedWeaponItemTidList(poolId)
  do return table.contains, weaponItemTidList end
  return table.contains, weaponItemTidList, itemTid
end

function SummonCategorySelectDataUtils.DumpDebugInfo(poolId)
  if not poolId then
    Logger.Error("SummonCategorySelect Dump poolId is nil")
    return
  end
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  local selectNum = SummonCategorySelectDataUtils.GetSelectNum(poolId)
  local dropIdList = SummonCategorySelectDataUtils.GetCategoryDropIdList(poolId)
  local confirmed = SummonDataUtils.HasConfirmedSelection(poolId)
  Logger.Info("SummonCategorySelect Dump poolId:" .. tostring(poolId) .. " type:" .. tostring(poolCfg and poolCfg.Type) .. " selectNum:" .. tostring(selectNum) .. " dropCount:" .. tostring(#dropIdList) .. " confirmed:" .. tostring(confirmed) .. " canSummon:" .. tostring(SummonDataUtils.CanSummon(poolId)))
  for slot = 1, #dropIdList do
    local itemList = SummonCategorySelectDataUtils.GetCategoryItemTidList(poolId, slot)
    Logger.Info("  slot:" .. tostring(slot) .. " dropId:" .. tostring(SummonCategorySelectDataUtils.GetCategoryDropId(poolId, slot)) .. " itemCount:" .. tostring(#itemList) .. " items:" .. table.tostring(itemList))
  end
  Logger.Info("  confirmedAwakers:" .. table.tostring(SummonCategorySelectDataUtils.GetConfirmedAwakerItemTidList(poolId)))
  Logger.Info("  confirmedWeapons:" .. table.tostring(SummonCategorySelectDataUtils.GetConfirmedWeaponItemTidList(poolId)))
end

return SummonCategorySelectDataUtils
