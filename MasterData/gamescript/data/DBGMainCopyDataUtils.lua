local DBGMainCopyDataUtils = {}

function DBGMainCopyDataUtils.ResetAll()
  DataCenter.dbgMainCopyData.mainCopies = {}
  DataCenter.dbgMainCopyData.storyLines = {}
  DataCenter.dbgMainCopyData.selectCopyId = 0
  DataCenter.dbgMainCopyData.selectStoryLineId = 0
  DataCenter.dbgMainCopyData.selectHardType = TownDefine.DBGCopyLevelHardType.Normal
  DataCenter.dbgMainCopyData.hardTypeAwakerTids = {}
  DataCenter.dbgMainCopyData.hardTypePos = {}
end

DBGMainCopyDataUtils.StoryLineBelongCopyMap = nil

function DBGMainCopyDataUtils.CreateCopyData(tid, prev, next, sort, hard)
  local data = {
    tid = tid,
    dbgStoryLineTids = {},
    sort = sort,
    hard = hard,
    prev = prev,
    next = next,
    unLock = false
  }
  return data
end

function DBGMainCopyDataUtils.CreateDBGStoryLineData(tid, prev, next, sort, hard)
  local data = {
    tid = tid,
    unLock = false,
    isNew = false,
    star = 0,
    hard = hard,
    sort = sort,
    prev = prev,
    next = next,
    buyTimes = 0,
    challengeCount = -1,
    passed = false
  }
  return data
end

function DBGMainCopyDataUtils.GetCopyConfig(tid)
  if not tid then
    Logger.Info("[DBGMainCopyDataUtils.GetCopyConfig] Error: tid is null")
    return
  end
  if not DataCenter.dbgMainCopyData.mainCopies[tid] then
    Logger.Info("[DBGMainCopyDataUtils.GetCopyConfig] Error: copy map not found:", tid)
    return
  end
  return DT.StageGroup[tid]
end

function DBGMainCopyDataUtils.InitHardStageData(serverStageListData)
  if not serverStageListData then
    return
  end
  for _, copyData in pairs(serverStageListData) do
    if copyData and copyData.stageList then
      for _, storyLineData in pairs(copyData.stageList) do
        DBGMainCopyDataUtils.UpdateDBGStoryLineData(storyLineData)
      end
      DBGMainCopyDataUtils.UpdateCopyLock(copyData.stageGroupID, true)
    end
  end
end

function DBGMainCopyDataUtils.InitMainCopyDataByServerData(serverStageListData)
  if not serverStageListData then
    return
  end
  for _, copyData in pairs(serverStageListData) do
    if copyData and copyData.stageList then
      for _, storyLineData in pairs(copyData.stageList) do
        DBGMainCopyDataUtils.UpdateDBGStoryLineData(storyLineData)
      end
      DBGMainCopyDataUtils.UpdateCopyLock(copyData.stageGroupID, true)
    end
  end
end

function DBGMainCopyDataUtils.InitMainCopyData()
  local tableInsert = table.insert
  local tableSort = table.sort
  DataCenter.dbgMainCopyData.mainCopies = {}
  DataCenter.dbgMainCopyData.storyLines = {}
  local copySortMap = {}
  local hardCopySortMap = {}
  for _, cfg in pairs(DT.FeatureUnlock) do
    if cfg and cfg.Key then
      local data = {
        copyId = cfg.Key
      }
      if cfg.Feature == "MainCopy" then
        data.hard = TownDefine.DBGCopyLevelHardType.Normal
        tableInsert(copySortMap, data)
      end
      if cfg.Feature == "MainCopyHard" then
        data.hard = TownDefine.DBGCopyLevelHardType.Hard
        tableInsert(hardCopySortMap, data)
      end
    end
  end
  tableSort(copySortMap, function(a, b)
    return a.copyId < b.copyId
  end)
  tableSort(hardCopySortMap, function(a, b)
    return a.copyId < b.copyId
  end)
  
  local function GetPrevCopyId(copyID)
    local pos = 0
    for index, value in ipairs(copySortMap) do
      if value.copyId == copyID then
        pos = index
        break
      end
    end
    if not copySortMap[pos - 1] or copySortMap[pos].hard ~= copySortMap[pos - 1].hard then
      return 0
    end
    return copySortMap[pos - 1].copyId
  end
  
  local function GetNextCopyId(copyID)
    local pos = 0
    for index, value in ipairs(copySortMap) do
      if value.copyId == copyID then
        pos = index
        break
      end
    end
    if not copySortMap[pos + 1] or copySortMap[pos].hard ~= copySortMap[pos + 1].hard then
      return 0
    end
    return copySortMap[pos + 1].copyId
  end
  
  local function GetHardPrevCopyId(copyID)
    local pos = 0
    for index, value in ipairs(hardCopySortMap) do
      if value.copyId == copyID then
        pos = index
        break
      end
    end
    if not hardCopySortMap[pos - 1] or hardCopySortMap[pos].hard ~= hardCopySortMap[pos - 1].hard then
      return 0
    end
    return hardCopySortMap[pos - 1].copyId
  end
  
  local function GetHardNextCopyId(copyID)
    local pos = 0
    for index, value in ipairs(hardCopySortMap) do
      if value.copyId == copyID then
        pos = index
        break
      end
    end
    if not hardCopySortMap[pos + 1] or hardCopySortMap[pos].hard ~= hardCopySortMap[pos + 1].hard then
      return 0
    end
    return hardCopySortMap[pos + 1].copyId
  end
  
  local function InitStoryLines(copyID, hard)
    local tableFindValue = table.findvalue
    local ids = WorldStageManager.Instance:GetStageIdList(copyID)
    tableSort(ids, function(a, b)
      return a < b
    end)
    for index, tid in ipairs(ids) do
      local prev = ids[index - 1] or 0
      local after = ids[index + 1] or 0
      local data = DBGMainCopyDataUtils.CreateDBGStoryLineData(tid, prev, after, index, hard)
      DataCenter.dbgMainCopyData.storyLines[tid] = data
      local list = DataCenter.dbgMainCopyData.mainCopies[copyID].dbgStoryLineTids
      if not tableFindValue(list, tid) then
        tableInsert(DataCenter.dbgMainCopyData.mainCopies[copyID].dbgStoryLineTids, tid)
      end
    end
  end
  
  for index, data in ipairs(copySortMap) do
    if not data then
    else
      local copyId = data.copyId
      data.sort = index
      local copyData = DataCenter.dbgMainCopyData.mainCopies[copyId]
      if not copyData then
        local prev = GetPrevCopyId(copyId)
        local after = GetNextCopyId(copyId)
        local hard = TownDefine.DBGCopyLevelHardType.Normal
        copyData = DBGMainCopyDataUtils.CreateCopyData(copyId, prev, after, index, hard)
        DataCenter.dbgMainCopyData.mainCopies[copyId] = copyData
      end
      InitStoryLines(copyId, TownDefine.DBGCopyLevelHardType.Normal)
    end
  end
  for index, data in ipairs(hardCopySortMap) do
    if not data then
    else
      local copyId = data.copyId
      data.sort = index
      local copyData = DataCenter.dbgMainCopyData.mainCopies[copyId]
      if not copyData then
        local prev = GetHardPrevCopyId(copyId)
        local after = GetHardNextCopyId(copyId)
        local hard = TownDefine.DBGCopyLevelHardType.Hard
        copyData = DBGMainCopyDataUtils.CreateCopyData(copyId, prev, after, index, hard)
        DataCenter.dbgMainCopyData.mainCopies[copyId] = copyData
      end
      InitStoryLines(copyId, TownDefine.DBGCopyLevelHardType.Hard)
    end
  end
end

function DBGMainCopyDataUtils.GetStoryLineBelongCopy(tid)
  if not tid then
    Logger.Info("[DBGMainCopyDataUtils.GetStoryLineBelongCopy] Error: tid is nil")
    return
  end
  local config = DT.Stage[tid]
  if not config then
    Logger.Info("[DBGMainCopyDataUtils.GetStoryLineBelongCopy] Error: config not found:", tostring(tid))
    return
  end
  return config.BelongGroup
end

function DBGMainCopyDataUtils.GetShowCopyId(selectHardType)
  if selectHardType == TownDefine.DBGCopyLevelHardType.Normal then
    local copyID = DBGMainCopyDataUtils.GetLatestCopyID(selectHardType)
    local plot = DBGMainCopyDataUtils.GetLatestStoryLineId(copyID)
    return copyID, plot
  else
    do return end
    return DBGMainCopyDataUtils.GetShowCopyIdByHardCopy, DBGMainCopyDataUtils.GetLatestStoryLineId(copyID), copyID, plot
  end
end

function DBGMainCopyDataUtils.GetShowCopyIdByHardCopy()
  local storyLineTid = DBGMainCopyDataUtils.GetHardTypePos(TownDefine.DBGCopyLevelHardType.Hard)
  if not DT.Stage[storyLineTid] then
    do return DBGMainCopyDataUtils.GetLatestCopyID end
    return DBGMainCopyDataUtils.GetLatestCopyID, TownDefine.DBGCopyLevelHardType.Hard, nil, nil, nil, nil, nil
  end
  local copyId = DT.Stage[storyLineTid].BelongGroup
  while true do
    local copyInfo = DataCenter.dbgMainCopyData.mainCopies[copyId]
    if not copyInfo then
      do return DBGMainCopyDataUtils.GetLatestCopyID end
      return DBGMainCopyDataUtils.GetLatestCopyID, TownDefine.DBGCopyLevelHardType.Hard, nil, nil, nil
    end
    local featureType = CommonDefine.FeatureId.MainCopyHard
    local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureType, copyId, false)
    if isUnlock then
      return copyId, storyLineTid
    end
    copyId = copyInfo.prev or 0
    storyLineTid = copyInfo.dbgStoryLineTids[1]
  end
end

function DBGMainCopyDataUtils.IsHardCopy(curCopyId)
  if DataCenter.dbgMainCopyData.mainCopies[curCopyId] then
    return 1 == DataCenter.dbgMainCopyData.mainCopies[curCopyId].hard and true or false
  end
  return false
end

function DBGMainCopyDataUtils.IsHardStoryLine(storyLineTid)
  local storyData = DataCenter.dbgMainCopyData.storyLines[storyLineTid]
  if storyData then
    return 1 == storyData.hard and true or false
  end
  return false
end

function DBGMainCopyDataUtils.IsSelectHardType()
  return DataCenter.dbgMainCopyData.selectHardType == TownDefine.DBGCopyLevelHardType.Hard
end

function DBGMainCopyDataUtils.UpdateCopyLock(copyId, unlocked)
  local copyData = DBGMainCopyDataUtils.GetCopyData(copyId)
  if not copyData then
    return
  end
  copyData.unLock = unlocked
end

function DBGMainCopyDataUtils.IsCopyUnlock(curCopyId)
  local copyData = DBGMainCopyDataUtils.GetCopyData(curCopyId)
  if not copyData then
    return false
  end
  return copyData.unLock
end

function DBGMainCopyDataUtils.IsStoryLineUnlock(storyLineTid)
  local storyData = DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  if not storyData then
    return false
  end
  return storyData.unLock
end

function DBGMainCopyDataUtils.IsStoryLinePassed(storyLineTid)
  local storyData = DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  if not storyData then
    return false
  end
  return storyData.passed
end

function DBGMainCopyDataUtils.IsThreeAward(storyLineTid, tid)
  local config = DT.Stage[storyLineTid]
  local list = {}
  for index, value in ipairs(config.PerfectAward) do
    if 1 == index % 2 then
      table.insert(list, value)
    end
  end
  if table.findvalue(list, tid) then
    return true
  end
  return false
end

function DBGMainCopyDataUtils.IsFirstAward(storyLineTid, tid)
  local config = DT.Stage[storyLineTid]
  local list = {}
  for index, value in ipairs(config.FirstCompleteAward) do
    if 1 == index % 2 then
      table.insert(list, value)
    end
  end
  if table.findvalue(list, tid) then
    return true
  end
  return false
end

function DBGMainCopyDataUtils.GetCopyData(curCopyId)
  return DataCenter.dbgMainCopyData.mainCopies[curCopyId]
end

function DBGMainCopyDataUtils.GetNextCopyID(curCopyId)
  local copy = DBGMainCopyDataUtils.GetCopyData(curCopyId)
  if not copy then
    return nil
  end
  return copy.next or 0
end

function DBGMainCopyDataUtils.GetPrevCopyID(curCopyId)
  local copy = DBGMainCopyDataUtils.GetCopyData(curCopyId)
  if not copy then
    return nil
  end
  return copy.prev or 0
end

function DBGMainCopyDataUtils.GetLatestCopyID(hardType)
  local diffList = {}
  for _, copyData in pairs(DataCenter.dbgMainCopyData.mainCopies) do
    if copyData.hard == hardType then
      table.insert(diffList, copyData)
    end
  end
  table.sort(diffList, function(a, b)
    return a.sort < b.sort
  end)
  local copyID = 0
  local plotId = 0
  for _, value in ipairs(diffList) do
    if value.unLock then
      copyID = value.tid
      plotId = value.dbgStoryLineTids[1]
    end
  end
  return copyID, plotId
end

function DBGMainCopyDataUtils.UpdateHardTypeByStoryLineTid(storyLineTid)
  local hardType = TownDefine.DBGCopyLevelHardType.Normal
  local stageData = DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  hardType = stageData and stageData.hard or hardType
  DataCenter.dbgMainCopyData.selectHardType = hardType
end

function DBGMainCopyDataUtils.SetHardTypeAwakerTids(hardType, awakerTids)
  if not DataCenter.dbgMainCopyData.hardTypeAwakerTids[hardType] then
    DataCenter.dbgMainCopyData.hardTypeAwakerTids[hardType] = {
      0,
      0,
      0,
      0
    }
  end
  local team = DataCenter.dbgMainCopyData.hardTypeAwakerTids[hardType]
  for index, value in ipairs(awakerTids) do
    team[index] = value
  end
end

function DBGMainCopyDataUtils.GetHardTypeAwakerTids(hardType)
  if not DataCenter.dbgMainCopyData.hardTypeAwakerTids[hardType] then
    DataCenter.dbgMainCopyData.hardTypeAwakerTids[hardType] = {
      0,
      0,
      0,
      0
    }
  end
  local list = {}
  for _, value in ipairs(DataCenter.dbgMainCopyData.hardTypeAwakerTids[hardType]) do
    table.insert(list, value)
  end
  return list
end

function DBGMainCopyDataUtils.SetHarTypePos(hardType, storyLineTid)
  if not DataCenter.dbgMainCopyData.hardTypePos[hardType] then
    DataCenter.dbgMainCopyData.hardTypePos[hardType] = DBGMainCopyDataUtils.GetLatestStoryLineId(DBGMainCopyDataUtils.GetLatestCopyID(hardType))
  end
  DataCenter.dbgMainCopyData.hardTypePos[hardType] = storyLineTid
end

function DBGMainCopyDataUtils.SetHarTypePosByStoryLineTid(storyLineTid)
  local hardType = TownDefine.DBGCopyLevelHardType.Normal
  local stageData = DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  hardType = stageData and stageData.hard or hardType
  DBGMainCopyDataUtils.SetHarTypePos(hardType, storyLineTid)
end

function DBGMainCopyDataUtils.GetHardTypePos(hardType)
  if not DataCenter.dbgMainCopyData.hardTypePos[hardType] then
    DataCenter.dbgMainCopyData.hardTypePos[hardType] = DBGMainCopyDataUtils.GetLatestStoryLineId(DBGMainCopyDataUtils.GetLatestCopyID(hardType))
  end
  return DataCenter.dbgMainCopyData.hardTypePos[hardType]
end

function DBGMainCopyDataUtils.ResetHardTypePos()
  DataCenter.dbgMainCopyData.hardTypePos = {}
end

function DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  return DataCenter.dbgMainCopyData.storyLines[storyLineTid]
end

function DBGMainCopyDataUtils.GetLeftChallengeCount(storyLineTid)
  local data = DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  return data.challengeCount or 0
end

function DBGMainCopyDataUtils.GetMaxChallengeCount(storyLineTid)
  local data = DBGMainCopyDataUtils.GetStoryLineData(storyLineTid)
  if data.hard == TownDefine.DBGCopyLevelHardType.Hard then
    return -1
  end
  return -1
end

function DBGMainCopyDataUtils.GetNextStoryLineId(storyLineTid)
  return DBGMainCopyDataUtils.GetStoryLineData(storyLineTid).next or 0
end

function DBGMainCopyDataUtils.GetPrevStoryLineId(storyLineTid)
  return DBGMainCopyDataUtils.GetStoryLineData(storyLineTid).prev or 0
end

function DBGMainCopyDataUtils.GetLatestStoryLineId(curCopyId)
  local copy = DBGMainCopyDataUtils.GetCopyData(curCopyId)
  if not copy then
    return 0
  end
  local storyList = {}
  for _, tid in ipairs(copy.dbgStoryLineTids) do
    local data = DBGMainCopyDataUtils.GetStoryLineData(tid)
    if data.unLock then
      table.insert(storyList, tid)
    end
  end
  if #storyList <= 0 then
    return 0
  end
  table.sort(storyList, function(a, b)
    return DBGMainCopyDataUtils.GetStoryLineData(a).sort > DBGMainCopyDataUtils.GetStoryLineData(b).sort
  end)
  local latestIndex
  for index, tid in ipairs(storyList) do
    local data = DBGMainCopyDataUtils.GetStoryLineData(tid)
    if data.unLock and not data.passed then
      latestIndex = index
      break
    end
  end
  latestIndex = latestIndex or #storyList
  return storyList[latestIndex]
end

function DBGMainCopyDataUtils.UpdateStageData(serverData)
  if not serverData then
    return
  end
  for _, copyData in pairs(serverData) do
    if copyData and copyData.stageList then
      for _, storyLineData in pairs(copyData.stageList) do
        DBGMainCopyDataUtils.UpdateDBGStoryLineData(storyLineData)
      end
      DBGMainCopyDataUtils.UpdateCopyLock(copyData.stageGroupID, true)
    end
  end
end

function DBGMainCopyDataUtils.UpdateDBGStoryLineData(data)
  local storyData = DataCenter.dbgMainCopyData.storyLines[data.stageID]
  if not storyData then
    return
  end
  if data.star then
    storyData.star = data.star or 0
    if storyData.star > 0 then
      storyData.passed = true
    end
  end
  if data.unlocked then
    storyData.unLock = data.unlocked or false
  end
  storyData.firstRewardDraw = data.firstRewardDraw or storyData.firstRewardDraw
  if storyData.firstRewardDraw and data.stageID == DT.GetConstant("StageFinalId") then
    PlayerDataUtils.SavePassedFinalStage()
  end
end

function DBGMainCopyDataUtils.UpdateDBGStoryLinePassedData(maxPassedLineTid)
  local storyData = DataCenter.dbgMainCopyData.storyLines[maxPassedLineTid]
  if not storyData then
    return
  end
  local hard = storyData.hard
  for _, value in pairs(DataCenter.dbgMainCopyData.storyLines) do
    if value.hard == hard and maxPassedLineTid >= value.tid then
      value.passed = true
    end
  end
end

function DBGMainCopyDataUtils.ReqChooseCopy(copyTid, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameCopyRequest", "ChooseCopies", function(data)
    if data.storyLines then
      for _, value in pairs(data.storyLines) do
        DBGMainCopyDataUtils.UpdateDBGStoryLineData(value)
      end
    end
    DataCenter.dbgMainCopyData.selectCopyId = copyTid
    if callback then
      callback()
    end
  end, nil, copyTid)
end

function DBGMainCopyDataUtils.ReqChooseStoryLine(storyLineTid, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameCopyRequest", "ChooseStoryLine", function(data)
    DBGMainCopyDataUtils.UpdateDBGStoryLineData(data)
    DataCenter.dbgMainCopyData.selectStoryLineId = data.tid
    if callback then
      callback()
    end
  end, nil, storyLineTid)
end

function DBGMainCopyDataUtils.ReqMoppingup(count, copyId, plot, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameCopyRequest", "OnMoppingup", function(data)
    local function OnMoppingUp()
      if callback then
        callback(data)
      end
    end
    
    OnMoppingUp()
  end, nil, count, copyId, plot)
end

function DBGMainCopyDataUtils.ReqBuyPlotChallengeTimes(plotTid, times, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameCopyRequest", "BuyPlotChallengeTimes", function(data)
    DBGMainCopyDataUtils.UpdateDBGStoryLineData({
      tid = plotTid,
      buyTimes = data.buyTimes,
      chalTimes = data.chalTimes or data.chalTime
    })
    if callback then
      callback(data)
    end
  end, nil, plotTid, times)
end

return DBGMainCopyDataUtils
