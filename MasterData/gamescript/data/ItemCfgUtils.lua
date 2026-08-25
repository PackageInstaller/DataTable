local ItemCfgUtils = {}

function ItemCfgUtils.GetCfg(itemTid)
  if not itemTid then
    return nil
  end
  return DT.Item[itemTid]
end

function ItemCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ItemCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ItemCfgUtils.CommonItemSortFunc(itemTidA, itemTidB)
  local cfgA = ItemCfgUtils.GetCfg(itemTidA)
  local cfgB = ItemCfgUtils.GetCfg(itemTidB)
  if not cfgA or not cfgB then
    return false
  end
  local qualityWeightA = DT.ItemQuality[cfgA.Quality].Sort
  local qualityWeightB = DT.ItemQuality[cfgB.Quality].Sort
  if qualityWeightA ~= qualityWeightB then
    return qualityWeightA > qualityWeightB
  end
  return cfgA.BaseSortID < cfgB.BaseSortID
end

function ItemCfgUtils.CheckItemSubType(itemTid, targetSubType)
  if not targetSubType then
    return false
  end
  local subType = ItemCfgUtils.GetCfgField("SubType", itemTid)
  return subType == targetSubType
end

function ItemCfgUtils.IsAwakerChest(tid)
  do return ItemCfgUtils.CheckItemSubType, tid end
  return ItemCfgUtils.CheckItemSubType, tid, CommonDefine.ItemSubType.AwakerChest
end

function ItemCfgUtils.IsWeaponChest(tid)
  do return ItemCfgUtils.CheckItemSubType, tid end
  return ItemCfgUtils.CheckItemSubType, tid, CommonDefine.ItemSubType.WeaponChest
end

function ItemCfgUtils.IsAwakerRandomChest(tid)
  do return ItemCfgUtils.CheckItemSubType, tid end
  return ItemCfgUtils.CheckItemSubType, tid, CommonDefine.ItemSubType.AwakerRandomChest
end

function ItemCfgUtils.IsWeaponRandomChest(tid)
  do return ItemCfgUtils.CheckItemSubType, tid end
  return ItemCfgUtils.CheckItemSubType, tid, CommonDefine.ItemSubType.WeaponRandomChest
end

function ItemCfgUtils.IsAwakerChip(tid)
  local itemTid = tid
  local itemCfg = DT.Item[itemTid]
  local itemSubType = itemCfg.SubType
  local checkTypeGroup = {
    [1] = CommonDefine.ItemSubType.AwakerChip,
    [2] = CommonDefine.ItemSubType.Awaker
  }
  do return table.contains, checkTypeGroup end
  return table.contains, checkTypeGroup, itemSubType
end

function ItemCfgUtils.GetTrinketSuitCfg(trinketTid)
  local itemCfg = ItemCfgUtils.GetCfg(trinketTid)
  if not itemCfg or itemCfg.Type ~= CommonDefine.ItemType.Trinket then
    return
  end
  local cfgSpParam = itemCfg.SpParam
  local trinketSuitTid = cfgSpParam and cfgSpParam[2]
  return DT.TrinketSuitEffect[trinketSuitTid]
end

function ItemCfgUtils.GetItemAwakerTid(itemTid)
  local cfgSpParam = ItemCfgUtils.GetCfgField("SpParam", itemTid)
  local awakerTid = cfgSpParam and cfgSpParam[1]
  if AwakerCfgUtils.GetCfg(awakerTid) then
    return awakerTid
  end
  return nil
end

ItemCfgUtils.QualitySortValueTable = {
  White = 1,
  Green = 2,
  Blue = 3,
  Purple = 4,
  Orange = 5
}

function ItemCfgUtils.GetItemQualitySort(itemTid)
  local config = ItemDataUtils.GetItemConfig(itemTid)
  local qualitySort = config and config.Quality and ItemCfgUtils.QualitySortValueTable[config.Quality]
  return qualitySort
end

function ItemCfgUtils.GetRandomAbsolutelyDropItemInfoList(itemTid)
  local itemCfg = ItemCfgUtils.GetCfg(itemTid)
  if not itemCfg or itemCfg.Type ~= CommonDefine.ItemType.DropItem then
    return {}
  end
  local dropTid = itemCfg.SpParam and itemCfg.SpParam[1]
  do return DropCfgUtils.GetRandomAbsolutelyDropItemInfoList end
  return DropCfgUtils.GetRandomAbsolutelyDropItemInfoList, dropTid
end

return ItemCfgUtils
