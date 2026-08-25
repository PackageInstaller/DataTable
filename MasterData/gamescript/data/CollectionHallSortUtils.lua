local CollectionHallSortUtils = {}

function CollectionHallSortUtils.CommonSort(a, b)
  local aIsUnlock = ArtCollectionModel.Instance:IsUnlock(a) and 1 or 0
  local bIsUnlock = ArtCollectionModel.Instance:IsUnlock(b) and 1 or 0
  if aIsUnlock ~= bIsUnlock then
    return aIsUnlock > bIsUnlock
  end
  local aCfg = CollectionHallCfgUtils.GetCfg(a)
  local bCfg = CollectionHallCfgUtils.GetCfg(b)
  if aCfg and bCfg then
    return aCfg.BaseSortID < bCfg.BaseSortID
  end
  return a < b
end

function CollectionHallSortUtils.SortWeaponBySchool(a, b)
  local aIsUnlock = ArtCollectionModel.Instance:IsUnlock(a) and 1 or 0
  local bIsUnlock = ArtCollectionModel.Instance:IsUnlock(b) and 1 or 0
  if aIsUnlock ~= bIsUnlock then
    return aIsUnlock > bIsUnlock
  end
  local aCfg = CollectionHallCfgUtils.GetCfg(a)
  local bCfg = CollectionHallCfgUtils.GetCfg(b)
  if aCfg and bCfg then
    local aItemData = {
      tid = aCfg.UnlockCondPara and aCfg.UnlockCondPara[1] or 0,
      level = 0,
      timestamp = 0
    }
    local bItemData = {
      tid = bCfg.UnlockCondPara and bCfg.UnlockCondPara[1] or 0,
      level = 0,
      timestamp = 0
    }
    if 0 == aItemData.tid or 0 == bItemData.tid then
      do return CollectionHallSortUtils.CommonSort, a end
      return CollectionHallSortUtils.CommonSort, a, b, nil
    end
    do return AwakerTrinketDataUtils.SortWeaponBySchool, aItemData, bItemData end
    return AwakerTrinketDataUtils.SortWeaponBySchool, aItemData, bItemData, CommonDefine.SortOrder.Descend
  else
    do return CollectionHallSortUtils.CommonSort, a end
    return CollectionHallSortUtils.CommonSort, a, b, aItemData, bItemData, CommonDefine.SortOrder.Descend
  end
end

return CollectionHallSortUtils
