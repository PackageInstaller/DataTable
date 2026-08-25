local Pvp2ndKeeperSkillCollection = DT.GetOriginalConstant("Pvp2ndKeeperSkillCollection")
local PVPCollectionType = CommonDefine.PVPCollectionType
local PVPCollectionDataUtils = {}
local __PvpCollectItemTidMap
local __CollectionSecondSortValue = {
  [PVPCollectionType.Awaker] = 1,
  [PVPCollectionType.Weapon] = 2,
  [PVPCollectionType.KeeperSkill] = 3
}

function PVPCollectionDataUtils._InitPvpCollectItemTidMap()
  if __PvpCollectItemTidMap then
    return
  end
  __PvpCollectItemTidMap = {}
  for _, cfg in pairs(DT.PVPCollect) do
    local itemTid = cfg.Item
    if itemTid and 0 ~= itemTid then
      __PvpCollectItemTidMap[itemTid] = true
    end
  end
end

function PVPCollectionDataUtils.HasReqServerData()
  return DataCenter.pvpCollectionData.hasReqServerData
end

function PVPCollectionDataUtils.SetHasReqServerData(state)
  DataCenter.pvpCollectionData.hasReqServerData = state
end

function PVPCollectionDataUtils.ReqServerData(reqSuccCb, reqFailCb)
  if PVPCollectionDataUtils.HasReqServerData() then
    if reqSuccCb then
      reqSuccCb()
    end
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnGetPvpCollection", function(data)
    Logger.Info("=========== PVP收藏数据 =============\n", table.tostring(data))
    PVPCollectionDataUtils.UpdateCollectionDataMap(data)
    PVPCollectionDataUtils.SetHasReqServerData(true)
    PvPSeasonDataUtils.InitPvpCollectTimesList(data)
    if reqSuccCb then
      reqSuccCb()
    end
  end, function(data)
    Logger.Info("========== 拉取PvP收藏数据失败 ==========\n", table.tostring(data or {}))
    if reqFailCb then
      reqFailCb()
    end
  end)
end

function PVPCollectionDataUtils.InitCollectionDataMap()
  local map = {}
  for tid, _ in pairs(DT.PVPCollect) do
    local data = {
      tid = tid,
      winTimes = 0,
      owned = false,
      ts = 0
    }
    map[tid] = data
  end
  DataCenter.pvpCollectionData.collectionMap = map
  PVPCollectionDataUtils.SetHasReqServerData(false)
  PVPCollectionDataUtils._InitPvpCollectItemTidMap()
end

function PVPCollectionDataUtils._OnAddItemForPvpCollection(itemData)
  if not itemData or not itemData.tid then
    return
  end
  if not PVPCollectionDataUtils.HasReqServerData() then
    return
  end
  PVPCollectionDataUtils._InitPvpCollectItemTidMap()
  if __PvpCollectItemTidMap and __PvpCollectItemTidMap[itemData.tid] then
    PVPCollectionDataUtils.SetHasReqServerData(false)
    Logger.Info("PVPCollectionDataUtils: 新增与 PVP 收藏相关道具, 清除 OnGetPvpCollection 缓存, itemTid = ", itemData.tid)
  end
end

function PVPCollectionDataUtils.UpdateCollectionDataMap(serverData)
  for _, v in pairs(DataCenter.pvpCollectionData.collectionMap) do
    v.owned = false
  end
  serverData = serverData or {}
  for i, list in ipairs({
    serverData.removedCollectList,
    serverData.collectList
  }) do
    local isOwned = 2 == i
    for tid, collectionData in pairs(list) do
      if DataCenter.pvpCollectionData.collectionMap[tid] then
        for k, v in pairs(collectionData) do
          DataCenter.pvpCollectionData.collectionMap[tid][k] = v
        end
      else
        DataCenter.pvpCollectionData.collectionMap[tid] = collectionData
      end
      DataCenter.pvpCollectionData.collectionMap[tid].owned = isOwned
    end
  end
end

function PVPCollectionDataUtils.SortForAwaker(cfgA, cfgB)
  local sortValueA = PVPCollectionDataUtils.GetPositionSortValue(cfgA.ID) or 999
  local sortValueB = PVPCollectionDataUtils.GetPositionSortValue(cfgB.ID) or 999
  if sortValueA ~= sortValueB then
    return sortValueA < sortValueB
  end
  return (cfgA.BaseSortID or 0) < (cfgB.BaseSortID or 0)
end

function PVPCollectionDataUtils.SortForWeapon(cfgA, cfgB)
  local itemTidA = cfgA.Item
  local itemTidB = cfgB.Item
  local aItemData = {
    tid = itemTidA or 0,
    level = 0,
    timestamp = 0
  }
  local bItemData = {
    tid = itemTidB or 0,
    level = 0,
    timestamp = 0
  }
  if 0 == aItemData.tid or 0 == bItemData.tid then
    return cfgA.BaseSortID < cfgB.BaseSortID
  end
  do return AwakerTrinketDataUtils.SortWeaponBySchool, aItemData, bItemData end
  return AwakerTrinketDataUtils.SortWeaponBySchool, aItemData, bItemData, CommonDefine.SortOrder.Descend
end

function PVPCollectionDataUtils.SortForKeeperSkill(cfgA, cfgB)
  return cfgA.BaseSortID < cfgB.BaseSortID
end

local __CollectionThirdSortFuncs = {
  [PVPCollectionType.Awaker] = PVPCollectionDataUtils.SortForAwaker,
  [PVPCollectionType.Weapon] = PVPCollectionDataUtils.SortForWeapon,
  [PVPCollectionType.KeeperSkill] = PVPCollectionDataUtils.SortForKeeperSkill
}

function PVPCollectionDataUtils.SortCollections(list)
  if not list then
    return
  end
  if #list <= 1 then
    return list
  end
  
  local function sortFunc(a, b)
    local collectCfgA = PvpCollectCfgUtils.GetCfg(a)
    local collectCfgB = PvpCollectCfgUtils.GetCfg(b)
    local ownedA = PVPCollectionDataUtils.HasOwnedCollection(a)
    local ownedB = PVPCollectionDataUtils.HasOwnedCollection(b)
    if ownedA == ownedB then
      local typeSortValueA = __CollectionSecondSortValue[collectCfgA.Type]
      local typeSortValueB = __CollectionSecondSortValue[collectCfgB.Type]
      if typeSortValueA == typeSortValueB then
        do return __CollectionThirdSortFuncs[collectCfgA.Type], collectCfgA end
        return __CollectionThirdSortFuncs[collectCfgA.Type], collectCfgA, collectCfgB
      end
      return typeSortValueA < typeSortValueB
    end
    return ownedA
  end
  
  table.sort(list, sortFunc)
  return list
end

function PVPCollectionDataUtils.GetCollectionPotrait(tid)
  local config = PvpCollectCfgUtils.GetCfg(tid)
  if not config then
    return
  end
  if config.Type == PVPCollectionType.KeeperSkill and not PVPCollectionDataUtils.IsRealOwnedCollection(tid) then
    do return PVPCollectionDataUtils.GetKeeperSkillPosseUnknowIcon end
    return PVPCollectionDataUtils.GetKeeperSkillPosseUnknowIcon, tid, nil
  end
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(tid)
  if awakerTid then
    do return AwakerDataUtils.GetAwakerBust end
    return AwakerDataUtils.GetAwakerBust, awakerTid
  end
  return config.CollectImage
end

function PVPCollectionDataUtils.GetCollectWeaponSkillId(tid)
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(tid)
  local skillId = itemCfg.PVPSkill and itemCfg.PVPSkill[1]
  return skillId
end

function PVPCollectionDataUtils.GetAwakerCollectionSchool(tid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(tid)
  if not awakerTid then
    return
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
  if not awakerConfig then
    return
  end
  return awakerConfig.School
end

function PVPCollectionDataUtils.GetAwakerSchoolIcon(collectTid)
  local schoolTid = PVPCollectionDataUtils.GetAwakerCollectionSchool(collectTid)
  do return AwakerDataUtils.GetSchoolIcon end
  return AwakerDataUtils.GetSchoolIcon, schoolTid
end

function PVPCollectionDataUtils.GetKeeperSkillDetailsImage(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= PVPCollectionType.KeeperSkill then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.DetailsImage then
    return
  end
  if config.Type == PVPCollectionType.KeeperSkill and not PVPCollectionDataUtils.IsRealOwnedCollection(collectTid) then
    do return PVPCollectionDataUtils.GetKeeperSkillDetailUnknowIcon end
    return PVPCollectionDataUtils.GetKeeperSkillDetailUnknowIcon, collectTid
  end
  return config.DetailsImage
end

function PVPCollectionDataUtils.GetWeaponCollectionPortrait(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= PVPCollectionType.Weapon then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.Item then
    return
  end
  do return ItemDataUtils.GetSpIcon end
  return ItemDataUtils.GetSpIcon, config.Item
end

function PVPCollectionDataUtils.GetKeeperSkillCollectionPortrait(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= PVPCollectionType.KeeperSkill then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.DetailsMiniImage then
    return
  end
  if config.Type == PVPCollectionType.KeeperSkill and not PVPCollectionDataUtils.IsRealOwnedCollection(collectTid) then
    do return PVPCollectionDataUtils.GetKeeperSkillPosseUnknowMiniIcon end
    return PVPCollectionDataUtils.GetKeeperSkillPosseUnknowMiniIcon, collectTid
  end
  return config.DetailsMiniImage
end

function PVPCollectionDataUtils.GetKeeperSkillPosseUnknowMiniIcon(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= PVPCollectionType.KeeperSkill then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.UnknownDetailsMiniImage then
    return
  end
  return config.UnknownDetailsMiniImage
end

function PVPCollectionDataUtils.GetKeeperSkillDetailUnknowIcon(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= PVPCollectionType.KeeperSkill then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.UnknownDetailsImage then
    return
  end
  return config.UnknownDetailsImage
end

function PVPCollectionDataUtils.GetKeeperSkillPosseUnknowIcon(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= PVPCollectionType.KeeperSkill then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.UnknownCollectImage then
    return
  end
  return config.UnknownCollectImage
end

function PVPCollectionDataUtils.GetPvpPositionList()
  local list = {}
  local tmp = {}
  for _, cfg in pairs(DT.PVPPosition) do
    if cfg then
      table.insert(tmp, cfg)
    end
  end
  table.sort(tmp, function(a, b)
    return a.Sort < b.Sort
  end)
  for _, cfg in ipairs(tmp) do
    table.insert(list, cfg.ID)
  end
  return list
end

function PVPCollectionDataUtils.GetPvpPostionSortMap()
  local map = {}
  for _, cfg in pairs(DT.PVPPosition) do
    if cfg and cfg.Sort then
      map[cfg.ID] = cfg.Sort
    end
  end
  return map
end

function PVPCollectionDataUtils.GetCollectionNameFrameImage(tid)
  local config = PvpCollectCfgUtils.GetCfg(tid)
  if not config then
    return
  end
  local collectType = config.Type
  if collectType == PVPCollectionType.Awaker then
    do return PVPCollectionDataUtils.GetPositionColorFrameImage end
    return PVPCollectionDataUtils.GetPositionColorFrameImage, tid
  elseif collectType == PVPCollectionType.Weapon then
    return CommonRes.PVPCollectionNameFrame.Weapon
  elseif collectType == PVPCollectionType.KeeperSkill then
    return CommonRes.PVPCollectionNameFrame.KeeperSkill
  end
end

function PVPCollectionDataUtils.GetPositionColorFrameImage(collectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  local awakerConfig = awakerTid and AwakerDataUtils.GetAwakerConfig(awakerTid)
  if not awakerConfig then
    return
  end
  local positionConfig = PVPPositionCfgUtils.GetCfg(awakerConfig.PVPPosition)
  return positionConfig and positionConfig.CollectPositionColour
end

function PVPCollectionDataUtils.GetPositionFilterIcon(collectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  local awakerConfig = awakerTid and AwakerDataUtils.GetAwakerConfig(awakerTid)
  if not awakerConfig then
    return
  end
  local positionConfig = PVPPositionCfgUtils.GetCfg(awakerConfig.PVPPosition)
  return positionConfig and positionConfig.FilterPositionIcon
end

function PVPCollectionDataUtils.GetPositionSortValue(collectionTid)
  local positionTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(collectionTid)
  local positionConfig = PVPPositionCfgUtils.GetCfg(positionTid)
  return positionConfig and positionConfig.Sort
end

function PVPCollectionDataUtils.IsOpenedInTime(tid)
  local data = PVPCollectionDataUtils.GetCollectionData(tid)
  if not data then
    return false
  end
  local serverTime = TimeUtils.GetServerTime()
  if tid == Pvp2ndKeeperSkillCollection then
    local displayActivityTidMap = ActivityManager.Instance.model.displayTidMap
    for activityTid, _ in pairs(displayActivityTidMap) do
      local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
      if not activityCfg then
      elseif activityCfg.ActivityType == ActivityDefine.ActivityType.TwoAnniversaryWorldBossActivity then
        local activityData = ActivityDataUtils.GetActivityData(activityTid)
        if not activityData then
          break
        end
        if not activityData.finishTime or 0 == activityData.finishTime then
          return false
        end
        return serverTime > activityData.finishTime
      end
    end
  end
  local displayData = PvpCollectCfgUtils.GetCfgField("DisplayDate", tid)
  return serverTime > (displayData or 0)
end

function PVPCollectionDataUtils.IsRealOwnedCollection(tid)
  local data = PVPCollectionDataUtils.GetCollectionData(tid)
  return data and data.owned
end

function PVPCollectionDataUtils.HasOwnedCollection(tid)
  if PVPCollectionDataUtils.IsRealOwnedCollection(tid) then
    return true
  end
  do return PVPCollectionDataUtils.IsUnlockByBattlePass end
  return PVPCollectionDataUtils.IsUnlockByBattlePass, tid
end

function PVPCollectionDataUtils.IsUnlockByBattlePass(tid)
  if not tid or 0 == tid then
    return false
  end
  local data = PVPCollectionDataUtils.GetCollectionData(tid)
  if data and data.owned then
    return false
  end
  do return end
  return BattlePassDataUtils.IsCore
end

function PVPCollectionDataUtils.IsAvailable(tid)
  if not tid or 0 == tid then
    return true
  end
  local result = PVPCollectionDataUtils.HasOwnedCollection(tid)
  if not result then
    local data = PVPCollectionDataUtils.GetCollectionData(tid)
    local collectCfg = DT.PVPCollect[tid]
    Logger.Info("[PVP预组BUG排查] IsAvailable=false", " tid=", tostring(tid), " collectType=", tostring(collectCfg and collectCfg.Type), " collectName=", tostring(collectCfg and collectCfg.Name), " dataExists=", tostring(nil ~= data), " owned=", tostring(data and data.owned), " isRealOwned=", tostring(PVPCollectionDataUtils.IsRealOwnedCollection(tid)), " isUnlockByBP=", tostring(PVPCollectionDataUtils.IsUnlockByBattlePass(tid)), " isCore=", tostring(BattlePassDataUtils.IsCore()), " hasReqServerData=", tostring(PVPCollectionDataUtils.HasReqServerData()), " collectionMapHasTid=", tostring(nil ~= DataCenter.pvpCollectionData.collectionMap[tid]))
  end
  return result
end

function PVPCollectionDataUtils.IsOwnedAll()
  for _, collectData in pairs(DataCenter.pvpCollectionData.collectionMap) do
    local collectCfg = DT.PVPCollect[collectData.tid]
    if collectCfg and PVPCollectionDataUtils.IsOpenedInTime(collectData.tid) and not collectData.owned then
      return false
    end
  end
  return true
end

function PVPCollectionDataUtils.GetCollectionData(tid)
  if not tid then
    return
  end
  return DataCenter.pvpCollectionData.collectionMap[tid]
end

function PVPCollectionDataUtils.GetDisplayCollection(onlyShowOwned)
  local rst = {}
  for _, collectData in pairs(DataCenter.pvpCollectionData.collectionMap) do
    local collectCfg = DT.PVPCollect[collectData.tid]
    if collectCfg and PVPCollectionDataUtils.IsOpenedInTime(collectData.tid) and (not onlyShowOwned or collectData.owned) then
      table.insert(rst, collectData)
    end
  end
  return rst
end

function PVPCollectionDataUtils.GetCollectionWinTimes(tid)
  local data = PVPCollectionDataUtils.GetCollectionData(tid)
  return data and data.winTimes or 0
end

function PVPCollectionDataUtils.OpenCollectionListPanel(filterType)
  UIManager.Instance:Reopen(Urls.PVPCollectionListPanel, filterType)
end

function PVPCollectionDataUtils.OpenCollectionDetailPanel(selectCollectionFunc)
  local initData = {currCollectTidFunc = selectCollectionFunc}
  UIManager.Instance:Reopen(Urls.PVPCollectionDetailPanel, initData)
end

function PVPCollectionDataUtils.CloseCollectionDetailPanel()
  UIManager.Instance:CloseByUrl(Urls.PVPCollectionDetailPanel)
end

return PVPCollectionDataUtils
