local QualitySortID = CommonDefine.QualitySortID
local SummonData = DataCenter.summonData
local SummonPoolType = CommonDefine.SummonPoolType
local SummonDataUtils = {}
local typeSortWeight = {
  AwakerItem = 1,
  Material = 1,
  Weapon = 2
}

function SummonDataUtils.Init()
  SummonData.summonPoolData = {}
  SummonData.isInit = false
  SummonData.summonPoolGroupData = {}
  SummonDataUtils.id2FivePullFreeCounts = {}
  SummonDataUtils.InitLimitMap()
end

function SummonDataUtils.InitLimitMap()
  local limitMap = {}
  local summonPoolGroupData = {}
  for _, cfg in pairs(DT.Summon) do
    if cfg.Type == cd.SummonPoolType.LimitAwaker then
      local itemTid = cfg.DetailItem and cfg.DetailItem[1]
      local itemCfg = itemTid and DT.Item[itemTid]
      if itemCfg and itemCfg.SubType == cd.ItemSubType.Awaker and itemCfg.SpParam and itemCfg.SpParam[1] then
        limitMap[itemCfg.SpParam[1]] = true
      end
    end
    local groupId = cfg.PoolGroup
    if groupId then
      local group = summonPoolGroupData[groupId]
      if not group then
        summonPoolGroupData[groupId] = SummonDataUtils.CreateEmptyPoolGroup(groupId)
        group = summonPoolGroupData[groupId]
      end
      table.insert(group.poolTidList, cfg.ID)
    end
  end
  SummonData.limitMap = limitMap
  SummonData.summonPoolGroupData = summonPoolGroupData
end

function SummonDataUtils.IsSummonLimit(awakerTid)
  return SummonData.limitMap[awakerTid]
end

function SummonDataUtils.IsLuckyBagPool(poolId)
  local poolCfg = DT.Summon[poolId]
  return poolCfg and poolCfg.Type == SummonPoolType.LuckyBag
end

function SummonDataUtils.IsWishPool(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  return poolCfg and poolCfg.Type == SummonPoolType.WishPool
end

function SummonDataUtils.IsCategorySelectPool(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  return poolCfg and poolCfg.Type == SummonPoolType.CategorySelect
end

function SummonDataUtils.GetSelectedAwakerTidList(poolId)
  do return SummonCategorySelectDataUtils.BuildSlotListFromServerData, SummonDataUtils.GetId2SummonData(poolId) end
  return SummonCategorySelectDataUtils.BuildSlotListFromServerData, SummonDataUtils.GetId2SummonData(poolId)
end

function SummonDataUtils.HasConfirmedSelection(poolId)
  if SummonDataUtils.IsCategorySelectPool(poolId) then
    do return SummonCategorySelectDataUtils.IsSelectionConfirmed end
    return SummonCategorySelectDataUtils.IsSelectionConfirmed, poolId, nil
  end
  local selectedMap = SummonDataUtils.GetWishedAwakerMap(poolId)
  return nil ~= selectedMap and nil ~= next(selectedMap)
end

function SummonDataUtils.NeedSelectBeforeSummon(poolId)
  if SummonDataUtils.IsWishPool(poolId) or SummonDataUtils.IsCategorySelectPool(poolId) then
    return not SummonDataUtils.HasConfirmedSelection(poolId)
  end
  return false
end

function SummonDataUtils.CanSummon(poolId)
  return not SummonDataUtils.NeedSelectBeforeSummon(poolId)
end

function SummonDataUtils.IsInited()
  return SummonData.isInit
end

function SummonDataUtils.ReqChooseUpAwaker(poolType, summonPoolTid, itemTid, callback)
  if not poolType or not itemTid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnChooseUpAwaker", function(data)
    Logger.Info("OnChooseUpAwaker Successful")
    SummonDataUtils.SetChooseUpSSR(poolType, data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("OnChooseUpAwaker failed")
  end, poolType, summonPoolTid, itemTid)
end

local summonLock = false
local lockTime = DT.GetConstant("SummonCallbackMax", 30)
local summonTimer

function SummonDataUtils.MergeSummonExtraItems(extraItems)
  if not extraItems then
    return {}
  end
  local mergedItems = {}
  local mergedMap = {}
  for _, extraItem in pairs(extraItems) do
    local mergeKey = tostring(extraItem.tid) .. "_" .. tostring(extraItem.reason)
    local mergedItem = mergedMap[mergeKey]
    if not mergedItem then
      mergedItem = table.clone(extraItem)
      mergedMap[mergeKey] = mergedItem
      table.insert(mergedItems, mergedItem)
    else
      mergedItem.changedNum = (mergedItem.changedNum or 0) + (extraItem.changedNum or 0)
      mergedItem.num = (mergedItem.num or 0) + (extraItem.num or 0)
      mergedItem.count = (mergedItem.count or 0) + (extraItem.count or 0)
      if extraItem.reason == cd.ItemReason.WeaponAutoRefine then
        mergedItem.targetLevel = math.max(mergedItem.targetLevel or 0, extraItem.targetLevel or 0)
        if extraItem.targetUid ~= nil then
          mergedItem.targetUid = extraItem.targetUid
        end
      end
    end
  end
  return mergedItems
end

function SummonDataUtils.ProcessSummonExtraItems(item)
  local filterExtraItems = {}
  local autoRefineInfo, uid
  local mergedExtraItems = SummonDataUtils.MergeSummonExtraItems(item.extraItems)
  local itemCfg = DT.Item[item.tid]
  local isWeaponItem = itemCfg and itemCfg.Type == CommonDefine.ItemType.Weapon
  for _, extraItem in pairs(mergedExtraItems) do
    local tid = extraItem.tid
    local cfg = DT.Item[tid]
    if isWeaponItem and extraItem.reason == cd.ItemReason.WeaponAutoRefine and extraItem.tid == item.tid then
      autoRefineInfo = extraItem
    elseif table.contains({
      CommonDefine.ItemType.TopBarItem,
      CommonDefine.ItemType.Material
    }, cfg.Type) or table.contains({
      CommonDefine.ItemSubType.WeaponChestChip,
      CommonDefine.ItemSubType.AwakerChestChip
    }, cfg.SubType) then
      table.insert(filterExtraItems, extraItem)
    end
    if not uid and extraItem.tid == item.tid and extraItem.reason ~= "AutoDecompose" then
      uid = extraItem.uid
    end
  end
  item.extraItems = filterExtraItems
  item.autoRefineInfo = autoRefineInfo
  item.uid = uid
end

function SummonDataUtils.ReqSummon(summonId, times, type, callback)
  if summonLock then
    Alert.ShowStr(LT.Text("SummonNoCallbackTips"))
    return
  end
  local summonPoolType = DT.Summon[summonId].Type
  local awakerFragmentCount = SummonDataUtils.CountAwakerFragments()
  summonLock = true
  summonTimer = TimerManager.Instance:CreateTimer(lockTime, 0, nil, function()
    summonLock = false
  end)
  
  local function ResetSummonLockFunc()
    summonLock = false
    if summonTimer then
      TimerManager.Instance:StopTimer(summonTimer)
      summonTimer = nil
    end
  end
  
  local awakerState = {}
  for tid, data in pairs(DataCenter.awakerData.awakerMap) do
    awakerState[tid] = data.state
  end
  local weaponCountInfo = ItemDataUtils.GetWeaponCountInfo()
  local PopTipsManager = require("Managers.UI.PopTipsManager")
  ProtoManager.Instance:SetReqWithoutMask(true)
  PopTipsManager.Instance:SetTutorialLock(true)
  PopupQueManager.Instance:SetForbidShowRewardTime(2)
  local isFirstResummon = SummonDataUtils.IsFirstResummon(summonId) and times == CommonDefine.MultiSummonTimes
  local summonProtoName = isFirstResummon and "OnResummon" or "OnSummon"
  ProtoManager.Instance:ReqServer("GameRequest", summonProtoName, function(data)
    if data.chooseUpData and data.chooseUpData[summonPoolType] then
      SummonDataUtils.SetChooseUpSSR(summonPoolType, data.chooseUpData[summonPoolType])
    end
    ResetSummonLockFunc()
    for _, item in pairs(data.items) do
      SummonDataUtils.ProcessSummonExtraItems(item)
    end
    local items = data.items
    local poolData = SummonDataUtils.GetPoolData(summonId)
    if nil ~= poolData then
      poolData.summonTimes = data.summonTimes
    end
    if data.deletePool == summonId then
      SummonData.summonPoolData[data.deletePool] = nil
    end
    SummonDataUtils.ProcessSummonItems(items, awakerState, weaponCountInfo)
    SummonDataUtils.SetLastSummonType(DT.Summon[summonId].Type)
    if data.reSummonTimes and data.reSummonTimes > 0 then
      for _, v in pairs(data.items) do
        if v then
          v.reason = "Summon"
        end
      end
      EventMgr.Instance.TempAddGainItemEvent:Dispatch(data.items)
    end
    if poolData and data.leftSummonSSRNum then
      poolData.leftSummonSSRNum = data.leftSummonSSRNum
    end
    local summonResult = {
      highestQuality = SummonDataUtils.GetHighestQuality(data.items),
      reSummonTimes = data.reSummonTimes,
      itemList = {},
      awakerFragmentCount_1 = awakerFragmentCount,
      awakerFragmentCount_2 = table.clone(awakerFragmentCount)
    }
    local isMultipleReward = summonPoolType == CommonDefine.SummonPoolType.TripleLuckyBag
    for index, item in ipairs(data.items) do
      local summonResultItem = {
        tid = item.tid,
        count = item.num,
        isNew = item.isNew,
        firstGain = item.firstGain,
        extraItems = item.extraItems,
        autoRefineInfo = item.autoRefineInfo,
        uid = item.uid,
        isMultipleReward = isMultipleReward,
        summonType = type,
        _qualityValue = ItemDataUtils.GetQualitySortValue(item.tid)
      }
      table.insert(summonResult.itemList, summonResultItem)
    end
    DataCenter.summonData.deletePool = data.deletePool
    if "OnSummon" == summonProtoName then
      SummonDataUtils.SetNotSSRUpNum(data.notSSRUpNum or {})
      if data.SSRTypeComboNum then
        SummonDataUtils.SetSSRTypeComboNum(data.SSRTypeComboNum or {})
      end
      SummonDataUtils.SetHistoryCorrectNum(data.historyCorrectNum or {})
    end
    if callback then
      callback(summonResult)
    end
    EventMgr.Instance.OnSummonRefresh:Dispatch()
  end, function(data)
    ResetSummonLockFunc()
    Logger.Warn("Error", table.tostring(data))
    local msg = data and data[1]
    if msg then
      Alert.ShowStr(msg)
    end
  end, summonId, times, type)
end

function SummonDataUtils.ReqReSummon(summonId, callback)
  local awakerState = {}
  for tid, data in pairs(DataCenter.awakerData.awakerMap) do
    awakerState[tid] = data.state
  end
  local weaponCountInfo = ItemDataUtils.GetWeaponCountInfo()
  EventMgr.Instance.OpenReqMask:Dispatch()
  PopupQueManager.Instance:SetForbidShowRewardTime(2)
  ProtoManager.Instance:ReqServer("GameRequest", "OnResummon", function(data)
    local items = {}
    for _, v in ipairs(data.items) do
      if not v.groupIndex or 1 == v.groupIndex then
        table.insert(items, v)
      end
    end
    SummonDataUtils.ProcessSummonItems(items, awakerState, weaponCountInfo)
    local ret = {
      items = items,
      reSummonTimes = data.reSummonTimes
    }
    if callback then
      callback(ret)
    end
  end, function(data)
    Logger.Warn("Error", table.tostring(data))
    local msg = data and data[1]
    if msg then
      Alert.ShowStr(msg)
    end
  end, summonId)
end

function SummonDataUtils.ReqConfirmSummonResult(summonId, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  PopupQueManager.Instance:SetForbidShowRewardTime(2)
  ProtoManager.Instance:ReqServer("GameRequest", "ConfirmResummon", function(data)
    if data.deletePool == summonId then
      SummonData.summonPoolData[data.deletePool] = nil
    end
  end, function(data)
    Logger.Warn("Error", table.tostring(data))
    local msg = data and data[1]
    if msg then
      Alert.ShowStr(msg)
    end
  end, summonId)
end

function SummonDataUtils.ReqChooseUpSSR(poolType, weaponTid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnChooseUpSSR", function(data)
    Logger.Debug("OnChooseUpSSR Success", table.tostring(data))
    SummonDataUtils.Update_chooseUpMap(poolType, weaponTid)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Error("OnChooseUpSSR failed!", table.tostring(data))
  end, poolType, weaponTid)
end

function SummonDataUtils.ApplyChooseMultiAwakerTargets(summonId, awakerTidList, data)
  local poolId = data and data.summonId or summonId
  local selectedMap = data and data.selectedAwakerTidMap
  if not selectedMap and awakerTidList then
    selectedMap = {}
    for i = 1, #awakerTidList do
      local itemTid = awakerTidList[i]
      if itemTid then
        selectedMap[itemTid] = true
      end
    end
  end
  if poolId and selectedMap then
    local existData = SummonData.id2SummonData[poolId] or {}
    existData.selectedAwakerTidMap = selectedMap
    SummonData.id2SummonData[poolId] = existData
  end
  EventMgr.Instance.OnChooseWishAwaker:Dispatch(poolId, awakerTidList)
end

function SummonDataUtils.ReqChooseMultiAwakerTargets(summonId, awakerTidList, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "ChooseMultiAwakerTargets", function(data)
    Logger.Info("ChooseMultiAwakerTargets Success", table.tostring(data))
    SummonDataUtils.ApplyChooseMultiAwakerTargets(summonId, awakerTidList, data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Error("ChooseMultiAwakerTargets failed!", table.tostring(data))
  end, summonId, awakerTidList)
end

function SummonDataUtils.ApplyChooseMultiCategoryAwakerTargets(summonId, awakerItemTids, data)
  local poolId = data and data.summonId or summonId
  local selectedList = SummonCategorySelectDataUtils.BuildSlotListFromServerData(data)
  if (not selectedList or not next(selectedList)) and awakerItemTids then
    selectedList = {}
    for i = 1, #awakerItemTids do
      selectedList[i] = awakerItemTids[i]
    end
  end
  if poolId and selectedList then
    local existData = SummonData.id2SummonData[poolId] or {}
    existData.selectedAwakerTidList = selectedList
    existData.selectedSlotAwakerTidMap = selectedList
    SummonData.id2SummonData[poolId] = existData
  end
  EventMgr.Instance.OnChooseCategorySelectAwaker:Dispatch(poolId, selectedList or awakerItemTids)
end

function SummonDataUtils.ReqChooseMultiCategoryAwakerTargets(summonId, awakerItemTids)
  ProtoManager.Instance:ReqServer("GameRequest", "ChooseMultiCategoryAwakerTargets", function(data)
    Logger.Info("ChooseMultiCategoryAwakerTargets Success", table.tostring(data))
    SummonDataUtils.ApplyChooseMultiCategoryAwakerTargets(summonId, awakerItemTids, data)
  end, function(data)
    Logger.Error("ChooseMultiCategoryAwakerTargets failed!", table.tostring(data))
  end, summonId, awakerItemTids)
end

function SummonDataUtils.ReqSummonPoolData(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenSummon", function(data)
    Logger.Info("OnOpenSummon Success", table.tostring(data))
    SummonData.isInit = true
    SummonDataUtils.SyncSummonPool(data.pools)
    SummonDataUtils.SetSelectCareer(data.chooseCareer or 0)
    SummonDataUtils.Set_chooseUpMap(data.chooseUp or {})
    SummonDataUtils.SetLastSummonType(data.lastSummonType or SummonPoolType.NormalWeapon)
    SummonDataUtils.SetDiscountCareer(data.discountCareer or 0)
    SummonDataUtils.SetNotSSRUpNum(data.notSSRUpNum or {})
    SummonDataUtils.SetSSRTypeComboNum(data.SSRTypeComboNum or {})
    SummonDataUtils.SetHistoryCorrectNum(data.historyCorrectNum or {})
    if data.chooseUpSSR then
      for poolType, poolData in pairs(data.chooseUpSSR) do
        SummonDataUtils.SetChooseUpSSR(poolType, poolData)
      end
    end
    SummonDataUtils.SetId2SummonData(data.id2SummonData or {})
    SummonDataUtils.id2FivePullFreeCounts = data.id2FivePullFreeCounts
    if callback then
      callback()
    end
    EventMgr.Instance.OnSummonRefresh:Dispatch()
    SummonDataUtils.CheckCloseSummonGuide()
  end, function(data)
    Logger.Error("OnOpenSummon failed!", table.tostring(data))
  end)
end

function SummonDataUtils.CheckCloseSummonGuide()
  local guideTid = 81502
  local isFindNewbiePool = false
  for tid, _ in pairs(SummonData.summonPoolData) do
    local poolCfg = SummonDataUtils.GetSummonConfig(tid)
    if poolCfg.Type == SummonPoolType.NewbiePool then
      isFindNewbiePool = true
      break
    end
  end
  if not isFindNewbiePool then
    NewbieGuideManager.Instance:SetGuideFinish(guideTid)
  end
end

function SummonDataUtils.CheckPoolIsSummonOut(poolTid)
  for tid, v in pairs(SummonData.summonPoolData) do
    if tid == poolTid then
      local poolCfg = SummonDataUtils.GetSummonConfig(poolTid)
      if poolCfg.MaxSummonTimes and 0 == v.summonTimes then
        return true
      else
        return false
      end
    end
  end
  return false
end

function SummonDataUtils.CheckPoolListItemIsShow(poolTidList)
  if not SummonDataUtils.IsLuckyBagPool(poolTidList[1]) then
    return true
  end
  for index = 1, #poolTidList do
    if not SummonDataUtils.CheckPoolIsSummonOut(poolTidList[index]) then
      return true
    end
  end
  return false
end

function SummonDataUtils.CheckPoolListItemIsHint(poolTidList)
  if not SummonDataUtils.IsLuckyBagPool(poolTidList[1]) then
    return false
  end
  for index = 1, #poolTidList do
    local poolTid = poolTidList[index]
    local subKey = cd.ClientSubKey.TimeLimitedLuckyBagGroupFirstOpen_ .. poolTid
    local isFirstShow = ClientDataUtils.GetData(cd.ClientDataMainKey.TimeLimitedLuckyBagGroupFirstOpen, subKey)
    if 0 ~= isFirstShow then
      return true
    end
  end
  return false
end

function SummonDataUtils.ReqChooseCareer(numId, clickCb)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnChooseCareer", function(_)
    Logger.Debug("OnChooseCareer Success")
    SummonDataUtils.SetSelectCareer(numId, clickCb)
  end, function(_)
    Logger.Debug("OnChooseCareer fail")
  end, numId)
end

function SummonDataUtils.ReqSummonHistory(type, page, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnQuerySummonHistory", function(data)
    Logger.Debug("ReqSummonHistory Success data", table.tostring(data))
    if data.records then
      SummonDataUtils.UpdateSummonHistory(type, page, data.records)
    end
    if data.count then
      SummonDataUtils.UpdateSummonHistoryCount(type, data.count)
    end
    if callback then
      callback()
    end
  end, function(_)
    Logger.Debug("ReqSummonHistory fail")
  end, type, page)
end

function SummonDataUtils.ReqTaskReward(taskTid)
  TaskController.Instance:ReqOnTaskGainPrize(taskTid, {}, nil, false)
end

function SummonDataUtils.SetSummonGainShowList(tbl)
  SummonData.gainShowList = tbl
end

function SummonDataUtils.AddSummonGainShowList(showData)
  if showData.reason == CommonDefine.ItemReason.Summon then
    return
  end
  if showData.reason == CommonDefine.ItemReason.Weapon then
    return
  end
  table.insert(SummonData.gainShowList, showData)
end

function SummonDataUtils.GetSummonGainShowList()
  return SummonData.gainShowList or {}
end

function SummonDataUtils.GetSummonPoolNum(summonPool)
  local rst = 0
  for _, _ in pairs(summonPool) do
    rst = rst + 1
  end
  return rst
end

function SummonDataUtils.GetId2SummonData(poolId)
  return SummonData.id2SummonData[poolId]
end

function SummonDataUtils.GetWishedAwakerMap(poolId)
  local id2SummonData = SummonDataUtils.GetId2SummonData(poolId)
  return id2SummonData and id2SummonData.selectedAwakerTidMap
end

function SummonDataUtils.IsInWishConfigList(poolId, tid)
  if not (poolId and tid) or not SummonDataUtils.IsWishPool(poolId) then
    return false
  end
  local choiceItemTidList = SummonDataUtils.GetWishAwakerChoiceItemTidList(poolId)
  if table.contains(choiceItemTidList, tid) then
    return true
  end
end

function SummonDataUtils.IsExcludeFromWishList(poolId, tid)
  if not (poolId and tid) or not SummonDataUtils.IsWishPool(poolId) then
    return false
  end
  local wishedAwakerMap = SummonDataUtils.GetWishedAwakerMap(poolId)
  if not wishedAwakerMap then
    return false
  end
  return not wishedAwakerMap[tid]
end

local _wishAwakerChoiceItemTidMap = {}

function SummonDataUtils.GetWishAwakerChoiceItemTidList(poolId)
  if _wishAwakerChoiceItemTidMap[poolId] then
    return _wishAwakerChoiceItemTidMap[poolId]
  end
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if not poolCfg then
    return {}
  end
  local constKey = "SummonType_" .. poolCfg.Type .. "SSRSelectDropList"
  local constValue = DT.GetOriginalConstant(constKey)
  if not constValue then
    return {}
  end
  local dropId
  for i = 1, #constValue, 2 do
    if constValue[i] == poolId then
      dropId = constValue[i + 1]
      break
    end
  end
  local dataList = DropCfgUtils.GetCfgByfield("data_list", dropId)
  if not dataList then
    return {}
  end
  local rst = {}
  for _, data in pairs(dataList) do
    table.insert(rst, data.DropItem)
  end
  _wishAwakerChoiceItemTidMap[poolId] = rst
  return rst
end

function SummonDataUtils.GetWishAwakerSelectNum(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if not poolCfg then
    return 0
  end
  local constKey = "SummonType_" .. poolCfg.Type .. "SSRSelectNum"
  local constValue = DT.GetOriginalConstant(constKey)
  if not constValue then
    return 0
  end
  for i = 1, #constValue, 2 do
    if constValue[i] == poolId then
      return constValue[i + 1]
    end
  end
  return 0
end

function SummonDataUtils.GetDiscountCareer()
  return SummonData.discountCareer or 0
end

function SummonDataUtils.GetPlayerStatsTypeByPoolId(poolId)
  return "Summon_" .. poolId
end

function SummonDataUtils.GetRedTypeByPoolId(poolId)
  return "Summon_" .. poolId
end

local _hintedErr = {}

function SummonDataUtils.GetSummonConfig(id)
  assert(nil ~= id, "GetSummomnConfig Param error")
  local config = DT.Summon[id]
  if not config and not _hintedErr[id] then
    _hintedErr[id] = true
    Logger.Error("GetSummomnConfig failed, config is nil, id:" .. id)
  end
  return config
end

function SummonDataUtils.GetPoolList()
  local list = {}
  local now = TimeUtils.GetServerTime()
  for _, v in pairs(SummonData.summonPoolData) do
    if not v.endTime or v.endTime and now < v.endTime then
      table.insert(list, v)
    end
  end
  return list
end

function SummonDataUtils.GetBgImage(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  local bgImage = poolCfg.BackgroundImage
  if bgImage and string.contains(bgImage, ";") then
    local imgPathList = string.split(bgImage, ";")
    if PlayerDataUtils.IsMale() then
      return imgPathList[1]
    end
    return imgPathList[2]
  end
  return bgImage
end

function SummonDataUtils.GetSelectCareerList()
  local rst = table.deepclone(DT.Constant.SummonCareerSelectList.Data)
  table.insert(rst, DT.GetConstant("SchoolSummonInitShow"))
  return rst
end

function SummonDataUtils.GetSelectCareer()
  return SummonData.selectCareer
end

function SummonDataUtils.Get_chooseUpMap()
  return SummonData.chooseUpMap
end

function SummonDataUtils.IsFirstResummon(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  local isResummonType = poolCfg.Type == cd.SummonPoolType.NewbiePool
  local isFirstResummoned = ClientDataUtils.GetData(CommonDefine.ClientDataMainKey.Client, CommonDefine.ClientSubKey.FirstResummon)
  return isResummonType and not isFirstResummoned
end

function SummonDataUtils.Set_chooseUpMap(tbl)
  SummonData.chooseUpMap = tbl
end

function SummonDataUtils.Update_chooseUpMap(poolType, weaponTid)
  SummonData.chooseUpMap[poolType] = weaponTid
end

function SummonDataUtils.GetChooseUpMapByType(poolType)
  if not poolType then
    return nil
  end
  return SummonData.chooseUpMap[poolType]
end

function SummonDataUtils.GetLastSummonType()
  return SummonData.lastSummonType
end

function SummonDataUtils.GetPoolData(poolId)
  return SummonData.summonPoolData[poolId]
end

function SummonDataUtils.GetSortedPoolList()
  local list = {}
  list = SummonDataUtils.FilterCloseSummonList()
  list = SummonDataUtils.MergeCareerPool(list)
  list = SummonDataUtils.SortSummonList(list)
  return list
end

function SummonDataUtils.GetShowPoolList()
  local showList = {}
  local summonGroupMap = {}
  local list = SummonDataUtils.GetSortedPoolList()
  local showLuckyBag = false
  local hasLuckyBag = false
  for i, poolData in ipairs(list) do
    local poolCfg = SummonDataUtils.GetCfg(poolData.tid)
    local groupId = poolCfg.PoolGroup
    if groupId then
      local group = summonGroupMap[groupId]
      if not group then
        summonGroupMap[groupId] = SummonDataUtils.CreateEmptyPoolGroup(groupId)
        group = summonGroupMap[groupId]
        table.insert(showList, group)
      end
      table.insert(group.poolTidList, poolData.tid)
      if SummonDataUtils.IsLuckyBagPool(poolData.tid) then
        hasLuckyBag = true
        if 0 ~= poolData.summonTimes then
          showLuckyBag = true
        end
      end
    else
      table.insert(showList, SummonDataUtils.CreateEmptyPoolGroup(nil, poolData.tid))
    end
  end
  if not showLuckyBag and hasLuckyBag then
    EventMgr.Instance.OnSummonPoolClosed:Dispatch()
  end
  return showList
end

function SummonDataUtils.GetDefaultPoolTidByGroup(poolTidList)
  if 1 == #poolTidList then
    return poolTidList[1]
  end
  local poolRecordStr = table.concat(poolTidList, "|")
  local poolId = ClientDataUtils.GetData(cd.ClientDataMainKey.PoolGroupRecord, poolRecordStr, poolTidList[1])
  if SummonDataUtils.IsLuckyBagPool(poolId) and SummonDataUtils.CheckPoolIsSummonOut(poolId) then
    for i = 1, #poolTidList do
      if not SummonDataUtils.CheckPoolIsSummonOut(poolTidList[i]) then
        do return tonumber end
        return tonumber, poolTidList[i]
      end
    end
  end
  do return tonumber end
  return tonumber, poolId, 1, nil, tonumber, poolTidList[i]
end

function SummonDataUtils.SetLastSelectedGroupPoolTid(poolTidList, tid)
  if not table.contains(poolTidList, tid) then
    return
  end
  local recordStr = table.concat(poolTidList, "|")
  ClientDataUtils.SetData(cd.ClientDataMainKey.PoolGroupRecord, recordStr, tid)
end

function SummonDataUtils.CreateEmptyPoolGroup(groupId, tid)
  return {
    poolGroupId = groupId,
    poolTidList = tid and {tid} or {}
  }
end

function SummonDataUtils.IsLeftSummonTimes(poolId)
  local poolData = SummonDataUtils.GetPoolData(poolId)
  if not poolData then
    return false
  end
  if not poolData.summonTimes then
    return true
  end
  return poolData.summonTimes > 0
end

function SummonDataUtils.GetSummonCostInfo(poolId)
  local config = SummonDataUtils.GetSummonConfig(poolId)
  if not config then
    return nil
  end
  local itemTid = SummonCfgUtils.GetPoolPriorityConsumeItemTid(poolId)
  local itemNum = config.ConsumeTicket and config.ConsumeTicket[2] or 0
  return itemTid, itemNum
end

function SummonDataUtils.GetSummonDiscountCostInfo(poolId)
  local config = SummonDataUtils.GetSummonConfig(poolId)
  if not config then
    return nil
  end
  local itemTid = config.DiscountTicket and config.DiscountTicket[1]
  local itemNum = config.DiscountTicket and config.DiscountTicket[2]
  return itemTid, itemNum
end

function SummonDataUtils.Get10TimesPrice(poolId)
  local config = SummonDataUtils.GetSummonConfig(poolId)
  if not config then
    Logger.Error("GetSummonCostInfo failed, config is nil:" .. tostring(poolId))
    return 0, 0
  end
  local rstId, rstNum
  if config.TenTimesConsumeTicket then
    rstNum = config.TenTimesConsumeTicket[2]
  else
    rstNum = config.ConsumeTicket[2] * CommonDefine.MultiSummonTimes
  end
  rstId = SummonCfgUtils.GetPoolPriorityConsumeItemTid(poolId)
  if SummonDataUtils.GetBeginPoolIsFree(poolId) then
    rstNum = 0
  end
  if SummonDataUtils.IsFirstResummon(poolId) then
    rstNum = 0
  end
  return rstId, rstNum
end

function SummonDataUtils.GetBeginPoolIsFree(poolId)
  if not poolId then
    return false
  end
  local beginPoolCfg, beginPoolData
  for _, poolData in pairs(SummonData.summonPoolData) do
    local poolConfig = DT.Summon[poolId]
    if poolConfig.Type == SummonPoolType.Begin then
      beginPoolCfg = poolConfig
      beginPoolData = poolData
    end
  end
  if beginPoolCfg then
    local freeTimes = DT.GetConstant("BeginnerSummonFreeNum")
    local maxTimes = beginPoolCfg.MaxSummonTimes[2]
    local leftTimes = beginPoolData.summonTimes or 0
    if freeTimes > maxTimes - leftTimes then
      return true
    end
  end
  return false
end

function SummonDataUtils.GetTicketCostInfo(poolId)
  local config = SummonDataUtils.GetSummonConfig(poolId)
  assert(nil ~= config, "GetTicketCostInfo failed, config is nil:" .. tostring(poolId))
  local itemTid = config.TicketPrice[1]
  local itemNum = config.TicketPrice[2]
  return itemTid, itemNum
end

function SummonDataUtils.GetSummonHistory(type, page)
  if not SummonData.historyDataMap[type] or not SummonData.historyDataMap[type][page] then
    return {}
  else
    return SummonData.historyDataMap[type][page]
  end
end

function SummonDataUtils.GetSummonHistoryCount(type)
  if not SummonData.historyCountMap[type] then
    return 0
  else
    return SummonData.historyCountMap[type]
  end
end

function SummonDataUtils.GetSummonShowSchoolConfig(poolId)
  if not poolId then
    Logger.Error("error poolId ", poolId)
    return
  end
  local poolCfg = DT.Summon[poolId]
  local schoolConfig = poolCfg and DT.SchoolConfig[poolCfg.ShowSchool] or nil
  return schoolConfig
end

function SummonDataUtils.GetWorldSettleAwakerShowAnimData()
  if #SummonData.gainShowList <= 0 then
    return nil
  end
  local list = {}
  for _, data in ipairs(SummonData.gainShowList) do
    table.insert(list, {
      tid = data.configId
    })
  end
  local animData = {
    summonNum = #SummonData.gainShowList,
    skipBeginAnim = true,
    summonQuality = SummonDataUtils.GetHighestQuality(list)
  }
  return animData
end

function SummonDataUtils.GetHighestQuality(list)
  local returnQuality = "White"
  for _, data in pairs(list) do
    local itemCfg = ItemDataUtils.GetItemConfig(data.tid)
    if QualitySortID[itemCfg.Quality] > QualitySortID[returnQuality] then
      returnQuality = itemCfg.Quality
    end
    if QualitySortID[itemCfg.Quality] > QualitySortID.Orange then
      Logger.Error(string.format("唤醒体道具:[%s] 品质配置大于 Orange 应当配置为 Orange", itemCfg.CnID))
    end
  end
  return returnQuality
end

function SummonDataUtils.GetChooseUpSSRItemTid(summonPoolType, summonTid)
  local poolData = SummonData.chooseUpSSR[summonPoolType]
  return poolData and poolData.isSummonIdInitChoose and poolData.isSummonIdInitChoose[summonTid]
end

function SummonDataUtils.GetChooseUpComboNum(summonPoolType)
  local poolData = SummonData.chooseUpSSR[summonPoolType]
  return poolData and poolData.comboNum or 0
end

function SummonDataUtils.GetLastDropChooseUpItemType(summonPoolType)
  local poolData = SummonData.chooseUpSSR[summonPoolType]
  return poolData and poolData.lastDropSSRItemType
end

function SummonDataUtils.GetChooseUpSSRAwakerTid(summonPoolType, summonTid)
  local awakerItemTid = SummonDataUtils.GetChooseUpSSRItemTid(summonPoolType, summonTid)
  if not awakerItemTid then
    return nil
  end
  do return ItemDataUtils.GetAwakerTidByItemTid end
  return ItemDataUtils.GetAwakerTidByItemTid, awakerItemTid
end

function SummonDataUtils.GetChooseUpSSRWeaponTid(summonPoolType, summonTid)
  local awakerTid = SummonDataUtils.GetChooseUpSSRAwakerTid(summonPoolType, summonTid)
  if not awakerTid then
    return nil
  end
  do return AwakerCfgUtils.GetFirstRecommendWeapon end
  return AwakerCfgUtils.GetFirstRecommendWeapon, awakerTid
end

function SummonDataUtils.GetChooseUpSSRShool(summonPoolType, summonTid)
  local awakerTid = SummonDataUtils.GetChooseUpSSRAwakerTid(summonPoolType, summonTid)
  if not awakerTid then
    return nil
  end
  do return AwakerCfgUtils.GetCfgField, "School" end
  return AwakerCfgUtils.GetCfgField, "School", awakerTid
end

function SummonDataUtils.SetChooseUpSSR(summonPoolType, tbl)
  if not tbl then
    return
  end
  for k, v in pairs(tbl.isSummonIdInitChoose or {}) do
    if -1 == v then
      tbl.isSummonIdInitChoose[k] = nil
    end
  end
  SummonData.chooseUpSSR[summonPoolType] = tbl
  EventMgr.Instance.OnSummonSelectAwakerUP:Dispatch()
end

function SummonDataUtils.SetDiscountCareer(numVal)
  if not numVal then
    return
  end
  SummonData.discountCareer = numVal
end

function SummonDataUtils.SetNotSSRUpNum(notSSRUpNum)
  Logger.Info("SummonDataUtils.SetNotSSRUpNum ", table.tostring(notSSRUpNum))
  SummonData.notSSRUpNum = notSSRUpNum
end

function SummonDataUtils.SetSSRTypeComboNum(SSRTypeComboNum)
  Logger.Info("SummonDataUtils.SetSSRTypeComboNum ", table.tostring(SSRTypeComboNum))
  SummonData.SSRTypeComboNum = SSRTypeComboNum
end

function SummonDataUtils.GetSSRTypeComboNum(poolType, itemType)
  local comboNumInfo = SummonData.SSRTypeComboNum and SummonData.SSRTypeComboNum[poolType]
  if comboNumInfo and comboNumInfo.itemType == itemType then
    return comboNumInfo.comboNum
  end
  return 0
end

function SummonDataUtils.SetId2SummonData(id2SummonData)
  SummonData.id2SummonData = id2SummonData
end

function SummonDataUtils.SetHistoryCorrectNum(historyCorrectNum)
  SummonData.historyCorrectNum = historyCorrectNum
end

function SummonDataUtils.GetNotSSRUpNum(summonType)
  return SummonData.notSSRUpNum[summonType] or 0
end

function SummonDataUtils.GetHistoryCorrectNum(summonType)
  return SummonData.historyCorrectNum[summonType] or 0
end

function SummonDataUtils.SetSelectCareer(numVal, clickCb)
  if not numVal then
    return
  end
  if 0 == numVal then
    numVal = DT.GetConstant("SchoolSummonInitShow")
  end
  print("--------------SummonDataUtils.SetSelectCareer ", numVal, debug.traceback())
  SummonData.selectCareer = numVal
  if clickCb then
    clickCb()
  end
end

function SummonDataUtils.SetLastSummonType(numVal)
  if not numVal then
    return
  end
  SummonData.lastSummonType = numVal
end

function SummonDataUtils.ResetSummonHistoryData()
  SummonData.historyDataMap = {}
end

function SummonDataUtils.UpdateSummonHistory(type, page, data)
  if not SummonData.historyDataMap[type] then
    SummonData.historyDataMap[type] = {}
  end
  SummonData.historyDataMap[type][page] = data
end

function SummonDataUtils.UpdateSummonHistoryCount(type, count)
  SummonData.historyCountMap[type] = count
end

function SummonDataUtils.UpdateItem(list, itemInfo)
  for _, v in ipairs(list) do
    if v.tid == itemInfo.tid then
      v.num = v.num + itemInfo.num
      v.changedNum = v.num
      return
    end
  end
  local rewardItem = table.deepclone(itemInfo)
  rewardItem.changedNum = itemInfo.num
  table.insert(list, rewardItem)
end

function SummonDataUtils.SyncSummonPool(data)
  if not data then
    return
  end
  SummonData.summonPoolData = {}
  for tid, poolItemData in pairs(data) do
    local clone = table.clone(poolItemData)
    clone.tid = tid
    SummonData.summonPoolData[tid] = clone
  end
end

function SummonDataUtils.FilterCloseSummonList()
  local rst = {}
  local now = TimeUtils.GetServerTime()
  local hasLuckyBag = false
  local luckyBagPoolGroupIndexList = {}
  local groupTidsDict = {}
  for tid, v in pairs(SummonData.summonPoolData) do
    if not SummonDataUtils.GetSummonConfig(tid) then
    elseif not v.endTime or v.endTime and now < v.endTime then
      table.insert(rst, v)
      local isLuckyBagLike = SummonDataUtils.IsLuckyBagPool(tid) or SummonCfgUtils.IsTripleLuckyBagPool(tid)
      if isLuckyBagLike then
        hasLuckyBag = hasLuckyBag or true
        local targetPoolGroupIndex = SummonDataUtils.GetSummonConfig(tid).PoolGroup
        table.insert(luckyBagPoolGroupIndexList, targetPoolGroupIndex)
        if not groupTidsDict[targetPoolGroupIndex] then
          groupTidsDict[targetPoolGroupIndex] = {}
        end
        table.insert(groupTidsDict[targetPoolGroupIndex], tid)
      end
    end
  end
  if hasLuckyBag then
    for _, luckyBagPoolGroupIndex in ipairs(luckyBagPoolGroupIndexList) do
      local groupListCount = #SummonData.summonPoolGroupData[luckyBagPoolGroupIndex].poolTidList
      local groupTidList = groupTidsDict[luckyBagPoolGroupIndex]
      if groupListCount > #groupTidList then
        for i = 1, groupListCount do
          local tid = SummonData.summonPoolGroupData[luckyBagPoolGroupIndex].poolTidList[i]
          if not table.contains(groupTidList, tid) then
            local data = {
              tid = tid,
              summonTimes = 0,
              leftSummonSSRNum = -1
            }
            table.insert(rst, data)
            SummonData.summonPoolData[tid] = data
          end
        end
      end
    end
  end
  return rst
end

function SummonDataUtils.IsSummonPoolOpen(poolId)
  local now = TimeUtils.GetServerTime()
  for tid, v in pairs(SummonData.summonPoolData) do
    if tid == poolId then
      local isEnd = v.endTime and now > v.endTime
      return not isEnd
    end
  end
end

function SummonDataUtils.GetDisplayBannerList()
  local poolList = SummonDataUtils.GetSortedPoolList()
  local rst = {}
  for _, poolData in ipairs(poolList) do
    local poolCfg = SummonDataUtils.GetSummonConfig(poolData.tid)
    local isOpenPool = SummonDataUtils.IsSummonPoolOpen(poolData.tid)
    if poolCfg and poolCfg.BannerResources and isOpenPool then
      table.insert(rst, poolData)
    end
  end
  return rst
end

function SummonDataUtils.IsDisplayBanner()
  local list = SummonDataUtils.GetDisplayBannerList()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.DrawCard, 0)
  return #list > 0 and unlock
end

function SummonDataUtils.SortSummonList(list)
  local function sortFunc(a, b)
    local cfgA = SummonDataUtils.GetSummonConfig(a.tid)
    
    local cfgB = SummonDataUtils.GetSummonConfig(b.tid)
    return cfgA.BaseSortID < cfgB.BaseSortID
  end
  
  table.sort(list, sortFunc)
  return list
end

function SummonDataUtils.ProcessSummonItems(items, awakerState, weaponCountInfo)
  for _, item in ipairs(items) do
    local cfg = DT.Item[item.tid]
    if cfg.Type == CommonDefine.ItemType.AwakerItem then
      local awakerTid = cfg.SpParam[1]
      local state = awakerState[awakerTid]
      if state == CommonDefine.AwakerState.NotOwn then
        item.isNew = true
        awakerState[awakerTid] = CommonDefine.AwakerState.Owned
      else
        item.isNew = false
      end
    elseif cfg.Type == CommonDefine.ItemType.Weapon then
      local ownedCount = weaponCountInfo[item.tid] or 0
      if 0 == ownedCount then
        item.isNew = true
      else
        item.isNew = false
      end
      weaponCountInfo[item.tid] = ownedCount + (item.num or 1)
    end
  end
end

function SummonDataUtils.CountAwakerFragments()
  local fragmentCount = {}
  for tid, cfg in pairs(DT.AwakerConfig) do
    local numFragmentsUsed = 0
    local awakerData = AwakerDataUtils.GetAwakerData(tid)
    if awakerData then
      numFragmentsUsed = AwakerDataUtils.GetAwakerPotencyIndex(tid, awakerData.potency)
    end
    local numFragmentsRemaining = ItemDataUtils.GetItemNum(cfg.AwakerSpecialItem)
    fragmentCount[tid] = numFragmentsUsed + numFragmentsRemaining
  end
  return fragmentCount
end

function SummonDataUtils.HasEnoughCurrencyForSummon(poolId, summonTimes)
  local config = SummonDataUtils.GetSummonConfig(poolId)
  local costItemId, costItemNum, ownedNum
  if 1 == summonTimes then
    costItemId, costItemNum = SummonDataUtils.GetSummonCostInfo(poolId)
  elseif summonTimes == CommonDefine.MultiSummonTimes then
    costItemId = config.TenTimesConsumeTicket[1]
    costItemNum = config.TenTimesConsumeTicket[2]
  end
  ownedNum = ItemDataUtils.GetItemNum(costItemId)
  return costItemNum <= ownedNum
end

function SummonDataUtils.HasEnoughPermantDrawCurrencyForSummon10(normalPoolId)
  local currencyId = 8
  local ownedNum = ItemDataUtils.GetItemNum(currencyId)
  for poolId, _ in pairs(SummonData.summonPoolData) do
    if SummonDataUtils.GetSummonConfig(poolId).Type == SummonPoolType.NormalWeapon then
      local costItemId, costItemNum = SummonDataUtils.Get10TimesPrice(poolId)
      if normalPoolId and poolId == normalPoolId and costItemId == currencyId then
        return ownedNum >= costItemNum
      elseif nil == normalPoolId and costItemId == currencyId then
        return ownedNum >= costItemNum
      end
    end
  end
  return false
end

function SummonDataUtils.HasBeginPoolMultSummon()
  for poolId, poolData in pairs(SummonData.summonPoolData) do
    local poolConfig = DT.Summon[poolId]
    local isFreshManPool = poolConfig.Type == SummonPoolType.Begin
    local hasSummonTimes = poolData.summonTimes ~= nil and poolData.summonTimes > 0
    local hasReSummonTimes = poolData.reSummonTimes and poolData.reSummonTimes > 0
    if isFreshManPool and (hasSummonTimes or hasReSummonTimes) then
      return true
    end
  end
  return false
end

function SummonDataUtils.HasBeginPool()
  local rst = false
  for poolId, _ in pairs(SummonData.summonPoolData) do
    local poolConfig = DT.Summon[poolId]
    if poolConfig.Type == SummonPoolType.Begin then
      rst = true
      break
    end
  end
  return rst
end

function SummonDataUtils.CheckPoolType(numPoolId, numType)
  if not numPoolId or not DT.Summon[numPoolId] then
    return false
  end
  return DT.Summon[numPoolId].Type == numType
end

function SummonDataUtils.CheckDiscountSummon(poolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  return poolCfg and poolCfg.DiscountTicket
end

function SummonDataUtils.OpenIntroPanel(model)
  UIManager.Instance:Reopen(Urls.SummonIntroPanel, model)
end

function SummonDataUtils.OpenSummonPanel(poolId, isMainBanner)
  SummonDataUtils.ReqSummonPoolData()
  UIManager.Instance:Reopen(Urls.SummonPanel, poolId, isMainBanner)
end

function SummonDataUtils.OpenCareerSelectPanel(model)
  UIManager.Instance:Reopen(Urls.SummonCareerSelectPanel, model)
end

function SummonDataUtils.IsSummonGainShowPanelOpen()
  if UIAsyncLoadMgr:IsOpened(Urls.SummonNewItemPanel) then
    return true
  end
  if UIManager.Instance:GetWindow(Urls.SummonNewItemPanel) or UIManager.Instance:GetWindow(Urls.SummonSkinResultNextPanel) then
    return true
  end
  return false
end

function SummonDataUtils.IsSummonGainShowPanelAtTop()
  local topFullScreen = UIManager.Instance:GetTopFullScreenPanel()
  return topFullScreen == Urls.SummonNewItemPanel or topFullScreen == Urls.SummonSkinResultNextPanel
end

function SummonDataUtils.ShowGainItems(data)
  local tmp = {}
  tmp.reason = data.reason
  if data.awakerItemTid then
    tmp.configId = data.awakerItemTid
    tmp.type = CommonDefine.SummonItemType.Awaker
    tmp.transItems = data.transData
  elseif data.weaponTid then
    tmp.configId = data.weaponTid
    tmp.type = CommonDefine.SummonItemType.Weapon
    tmp.transItems = data.transData
  elseif data.skinTid then
    tmp.configId = data.skinTid
    tmp.type = CommonDefine.SummonItemType.Skin
    tmp.transItems = data.transData
  end
  if SummonData.banTimes > 0 then
    SummonData.banTimes = SummonData.banTimes - 1
    return
  end
  SummonDataUtils.AddSummonGainShowList(tmp)
end

function SummonDataUtils.HasWorldSettleGotAwakerShow()
  if #SummonData.gainShowList <= 0 then
    return false
  end
  local data = SummonData.gainShowList[1]
  return data and data.reason == "WorldRet"
end

function SummonDataUtils.SortSummonItems(list)
  local tmpList = table.deepclone(list)
  for key, value in pairs(tmpList) do
    value.timeSortWeight = key
  end
  table.sort(tmpList, function(a, b)
    local aCfg = DT.Item[a.tid or a.configId]
    local bCfg = DT.Item[b.tid or b.configId]
    local aQualitySortWeight = QualitySortID[aCfg.Quality]
    local bQualitySortWeight = QualitySortID[bCfg.Quality]
    local aTypeSortWeight = typeSortWeight[aCfg.Type]
    local bTypeSortWeight = typeSortWeight[bCfg.Type]
    if aQualitySortWeight == bQualitySortWeight then
      if aTypeSortWeight == bTypeSortWeight then
        return a.timeSortWeight < b.timeSortWeight
      end
      return aTypeSortWeight < bTypeSortWeight
    end
    return aQualitySortWeight > bQualitySortWeight
  end)
  return tmpList
end

function SummonDataUtils.MergeCareerPool(list)
  if 0 == SummonDataUtils.GetSelectCareer() then
    return list
  end
  local rst = list or {}
  local haveSelect = false
  local summonDataTemplate
  local specialSummonList = SummonDataUtils.GetSelectCareerList()
  for i = #rst, 1, -1 do
    local summonData = rst[i]
    local selectCareer = SummonDataUtils.GetSelectCareer()
    if summonData.tid == selectCareer then
      haveSelect = true
    elseif table.contains(specialSummonList, summonData.tid) then
      summonDataTemplate = summonData
      table.remove(rst, i)
    end
  end
  if not haveSelect and summonDataTemplate then
    rst = SummonDataUtils.InsertSelectCareerPool(rst, summonDataTemplate)
  end
  return rst
end

function SummonDataUtils.InsertSelectCareerPool(list, tempData)
  local rst = list or {}
  tempData.tid = SummonDataUtils.GetSelectCareer()
  table.insert(rst, tempData)
  SummonData.summonPoolData = {}
  for _, poolItemData in pairs(rst) do
    local clone = table.clone(poolItemData)
    SummonData.summonPoolData[poolItemData.tid] = clone
  end
  return rst
end

function SummonDataUtils.GetCfg(poolTid)
  if not poolTid then
    return nil
  end
  return DT.Summon[poolTid]
end

function SummonDataUtils.GetCfgByField(field, poolTid)
  if not field or not poolTid then
    return nil
  end
  local cfg = SummonDataUtils.GetCfg(poolTid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function SummonDataUtils.GetPoolSSRItem(poolTid)
  local dropId = SummonDataUtils.GetCfgByField("SSRAward", poolTid)
  do return DropDataUtils.GetDropItemTids end
  return DropDataUtils.GetDropItemTids, dropId
end

function SummonDataUtils.GetUpAndNormalList(poolTid)
  local summonCfg = SummonDataUtils.GetSummonConfig(poolTid)
  assert(summonCfg.Type ~= cd.SummonPoolType.LuckyBag, "没有计算福袋卡池")
  local dropId = SummonDataUtils.GetCfgByField("SSRAward", poolTid)
  local dropCfg = DropDataUtils.GetCfg(dropId)
  local dropItemList = dropCfg.data_list or {}
  if 2 == #dropItemList then
    local isUpAndDropDrop = false
    for i = 1, #dropItemList do
      local dropItem = dropItemList[i]
      if not DropDataUtils.GetCfg(dropItem.DropItem) then
        break
      end
      if i == #dropItemList then
        isUpAndDropDrop = true
      end
    end
    if isUpAndDropDrop then
      local upDropTid = dropItemList[1].DropItem
      local normalDropTid = dropItemList[2] and dropItemList[2].DropItem or upDropTid
      if dropItemList[1].WeightOrRate > dropItemList[2].WeightOrRate then
        upDropTid, normalDropTid = normalDropTid, upDropTid
      end
      local upItemTids = DropDataUtils.GetDropItemTids(upDropTid)
      local normalItemTids = DropDataUtils.GetDropItemTids(normalDropTid)
      return upItemTids, normalItemTids
    end
  end
  local itemTids = DropDataUtils.GetDropItemTids(dropId)
  return {}, itemTids
end

function SummonDataUtils.GetLuckyBagPoolRateMap(poolTid)
  local poolCfg = SummonDataUtils.GetSummonConfig(poolTid)
  local schoolEn = poolCfg.ShowSchool and DT.SchoolConfig[poolCfg.ShowSchool].NameEn
  local dropRateKey = SummonCfgUtils.GetSummonDropRateKey(poolTid, schoolEn)
  print("[SummonIntroModel] dropRateKey", dropRateKey)
  local cfgDropRateList = DT.GetOriginalConstant(dropRateKey, {})
  local rateListKey = cfgDropRateList[1]
  local dropTidList = table.move(cfgDropRateList, 2, #cfgDropRateList, 1, {})
  local rateList = DT.GetOriginalConstant(rateListKey)
  assert(rateList, "唤醒概率展示错误没有配置: " .. dropRateKey)
  local rateMap = {}
  for i = 1, #dropTidList do
    local dropTid = dropTidList[i]
    local rate = rateList[i]
    local dropItemTids = DropDataUtils.GetDropItemTids(dropTid)
    for _, tid in ipairs(dropItemTids) do
      rateMap[tid] = rate / #dropItemTids
    end
  end
  return rateMap
end

function SummonDataUtils.OpenItemBuyPanel(shopId)
  local goodCfg = DT.Shop[shopId]
  local buyTid = goodCfg.Item[1]
  local costId, costNum = table.unpack(goodCfg.Price)
  local maxBuyCount = SummonDataUtils.GetMaxTicketBuyCount(shopId)
  local buyData = {
    shopId = shopId,
    buyTid = buyTid,
    costTid = costId,
    costNum = costNum,
    maxBuyCount = maxBuyCount,
    buyFunc = function(buyCount)
      local isMoneyEnough = costNum <= ItemDataUtils.GetItemNum(costId)
      if not isMoneyEnough then
        DiamondShopDataUtils.RechargeTips(costNum - ItemDataUtils.GetItemNum(costId))
        UIManager.Instance:CloseByUrl(Urls.ItemBuyPanel)
        return
      end
      MainShopDataUtils.ReqOnShopBuyGoods(goodCfg.ID, goodCfg.ShopType, buyCount, function(data)
        UIManager.Instance:CloseByUrl(Urls.ItemBuyPanel)
      end)
    end
  }
  UIManager.Instance:Reopen(Urls.ItemBuyPanel, buyData)
end

function SummonDataUtils.GetMaxTicketBuyCount(shopId)
  local goodCfg = DT.Shop[shopId]
  local buyMaxNum = goodCfg.BuyLimit or 9999999
  local costTid, price = table.unpack(goodCfg.Price)
  local haveMoney = ItemDataUtils.GetItemNum(costTid)
  do return math.min, (math.floor(haveMoney / price)) end
  return math.min, math.floor(haveMoney / price), buyMaxNum
end

function SummonDataUtils.CheckSummonHint()
  local isHint = false
  local isLuckyBag = false
  local showPoolList = SummonDataUtils.GetShowPoolList()
  for i, showData in ipairs(showPoolList) do
    if SummonDataUtils.CheckPoolListItemIsHint(showData.poolTidList) then
      isLuckyBag = SummonDataUtils.IsLuckyBagPool(showData.poolTidList[1])
      return true, isLuckyBag
    end
  end
  return isHint, isLuckyBag
end

function SummonDataUtils.GetPoolListByPoolGroup(poolGruopId)
  return SummonData.summonPoolGroupData[poolGruopId].poolTidList
end

function SummonDataUtils.IsSummonPoolHaveFree(poolId)
  if not SummonDataUtils.id2FivePullFreeCounts then
    SummonDataUtils.id2FivePullFreeCounts = {
      [78014] = 3
    }
  end
  local freeTime = poolId and SummonDataUtils.id2FivePullFreeCounts[poolId] or 0
  return freeTime
end

function SummonDataUtils.UseFreeFiveSummon(poolId, count)
  local freeCount = SummonDataUtils.IsSummonPoolHaveFree(poolId)
  SummonDataUtils.id2FivePullFreeCounts[poolId] = math.max(0, freeCount - count)
  EventMgr.Instance.OnFreeSummon:Dispatch(poolId, SummonDataUtils.id2FivePullFreeCounts[poolId])
end

function SummonDataUtils.BuildSummonResultCallback(poolId, modelData, onComplete)
  return function(summonResult)
    UIManager.Instance:CloseByUrl(Urls.SummonedAwakerPanel)
    if SummonUiUtils.isQuickSummon then
      local haveFirstSSR = false
      for _, resultData in ipairs(summonResult.itemList) do
        if SummonUiUtils.IsShowQuickSummonItem(resultData) then
          haveFirstSSR = true
          break
        end
      end
      if not haveFirstSSR then
        UIManager.Instance:Reopen(Urls.SummonedAwakerPanel, summonResult, poolId, modelData)
      else
        UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, poolId, false, nil, true, modelData)
      end
    else
      UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, poolId, false, nil, nil, modelData)
    end
    if SummonDataUtils.IsLuckyBagPool(poolId) then
      EventMgr.Instance.OnLuckyBagSummon:Dispatch()
    end
    if SummonDataUtils.IsFirstResummon(poolId) then
      EventMgr.Instance.OnSummonPoolClosed:Dispatch()
    end
    if onComplete then
      onComplete()
    end
  end
end

function SummonDataUtils.TryAutoSummonByItemCount(poolId)
  if summonLock then
    return false
  end
  local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
  if not poolCfg then
    Logger.Error("[SummonDataUtils] TryAutoSummonByItemCount: 找不到卡池配置 poolId=%s", tostring(poolId))
    return false
  end
  local tenTimesCfg = poolCfg.TenTimesConsumeTicket
  if not tenTimesCfg then
    Logger.Error("[SummonDataUtils] TryAutoSummonByItemCount: TenTimesConsumeTicket 未配置 poolId=%s", tostring(poolId))
    return false
  end
  local itemTid = tenTimesCfg[1]
  local consumeNum = tenTimesCfg[2]
  if not (itemTid and consumeNum) or consumeNum <= 0 then
    Logger.Error("[SummonDataUtils] TryAutoSummonByItemCount: 配置无效 poolId=%s itemTid=%s consumeNum=%s", tostring(poolId), tostring(itemTid), tostring(consumeNum))
    return false
  end
  local itemNum = ItemDataUtils.GetItemNum(itemTid)
  if consumeNum > itemNum then
    return false
  end
  SummonDataUtils.ReqSummon(poolId, CommonDefine.MultiSummonTimes, CommonDefine.SummonType.Normal, SummonDataUtils.BuildSummonResultCallback(poolId, nil, nil))
  return true
end

return SummonDataUtils
