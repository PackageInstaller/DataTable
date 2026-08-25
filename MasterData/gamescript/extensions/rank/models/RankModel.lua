local RankModel = NewClass("RankModel", BaseModel)
local NewSeasonRankTypeMap = {
  [RankDefine.RankType.SeasonRoPvpPrebuilt] = true,
  [RankDefine.RankType.SeasonRoPvpDraft] = true,
  [RankDefine.RankType.SeasonRoRailWay] = true,
  [RankDefine.RankType.SeasonRoDailyChallenge] = true
}

function RankModel:OnInit()
  self._rankKey2RankMODict = {}
  self._rankKey2SequenceDict = {}
  self._rankKey2LengthDict = {}
  self._rankKey2SelfRankDict = {}
  self._rankKey2PlayerCntInfoDict = {}
  self._rankKey2IntervalCountDict = {}
  self._rankKey2SettlingDict = {}
  self._rankKey2InvalidPageDict = {}
  self._rankKey2OverlapPendingRefreshDict = {}
end

function RankModel:_GetInvalidPageDict(rankKey)
  if not self._rankKey2InvalidPageDict[rankKey] then
    self._rankKey2InvalidPageDict[rankKey] = {}
  end
  return self._rankKey2InvalidPageDict[rankKey]
end

function RankModel:_HasIncomingRankShiftOverlap(rankKey, svrRankList)
  local moDict = self._rankKey2RankMODict[rankKey]
  if not moDict then
    return false
  end
  for _, svrItem in ipairs(svrRankList or {}) do
    if svrItem.uid and moDict[svrItem.uid] then
      return true
    end
  end
  return false
end

function RankModel:MarkRankPagesInvalid(rankType, subTid, fromPage, toPage)
  if not (fromPage and toPage) or toPage < fromPage then
    return
  end
  local rankKey = self:GetRankKey(rankType, subTid)
  local invalidPageDict = self:_GetInvalidPageDict(rankKey)
  for page = fromPage, toPage do
    invalidPageDict[page] = true
  end
end

function RankModel:IsRankPageInvalid(rankType, subTid, page)
  local rankKey = self:GetRankKey(rankType, subTid)
  local invalidPageDict = self._rankKey2InvalidPageDict[rankKey]
  return invalidPageDict and true == invalidPageDict[page]
end

function RankModel:ClearRankPageInvalid(rankType, subTid, fromPage, toPage)
  if not fromPage or not toPage then
    return
  end
  local rankKey = self:GetRankKey(rankType, subTid)
  local invalidPageDict = self._rankKey2InvalidPageDict[rankKey]
  if not invalidPageDict then
    return
  end
  for page = fromPage, toPage do
    invalidPageDict[page] = nil
  end
end

function RankModel:ConsumeRankOverlapPendingRefresh(rankType, subTid)
  local rankKey = self:GetRankKey(rankType, subTid)
  if not self._rankKey2OverlapPendingRefreshDict[rankKey] then
    return false
  end
  self._rankKey2OverlapPendingRefreshDict[rankKey] = nil
  return true
end

function RankModel:OnReset()
  self:OnInit()
end

function RankModel:UpdateBySvrData(rankType, rankSubTid, svrData, startIdx, endIdx)
  for _, rankSvrData in pairs(svrData.data) do
    self:UpdateRankMO(rankType, rankSubTid, rankSvrData)
  end
  self:UpdateRankMO(rankType, rankSubTid, svrData.playerRank)
  self:_UpdateLengthDict(rankType, rankSubTid, svrData)
  self:_UpdateSequenceDict(rankType, rankSubTid, svrData, startIdx, endIdx)
end

function RankModel:_UpdateLengthDict(rankType, rankSubTid, svrData)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  if not self._rankKey2LengthDict[rankKey] then
    self._rankKey2LengthDict[rankKey] = 0
  end
  self._rankKey2LengthDict[rankKey] = svrData.playerRank and svrData.playerRank.len or 0
end

function RankModel:_UpdateSequenceDict(rankType, rankSubTid, svrData, startIdx, endIdx)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  if not self._rankKey2SequenceDict[rankKey] then
    self._rankKey2SequenceDict[rankKey] = {}
  end
  local seekIdx = 1
  for idx = startIdx, endIdx do
    local rankSvrData = svrData.data[seekIdx]
    self._rankKey2SequenceDict[rankKey][idx] = rankSvrData and rankSvrData.uid
    seekIdx = seekIdx + 1
  end
end

function RankModel:_AddRankMO(rankType, rankSubTid, rankMO)
  if not rankMO then
    return
  end
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  if not self._rankKey2RankMODict[rankKey] then
    self._rankKey2RankMODict[rankKey] = {}
  end
  self._rankKey2RankMODict[rankKey][rankMO.uid] = rankMO
end

function RankModel:DelRankMO(rankType, rankSubTid, playerUid)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  if self._rankKey2RankMODict[rankKey][playerUid] then
    self._rankKey2RankMODict[rankKey][playerUid] = nil
  end
  for _, sequence in pairs(self._rankKey2SequenceDict[rankKey]) do
    for i, uid in ipairs(sequence) do
      if uid == playerUid then
        table.remove(sequence, i)
        break
      end
    end
  end
end

function RankModel:UpdateRankMO(rankType, rankSubTid, rankSvrData)
  if not rankSvrData then
    print("RankModel:UpdateRankMO empty rankSvrData", rankType, rankSubTid)
    return
  end
  local rankMO = self:GetRankMO(rankType, rankSubTid, rankSvrData.uid)
  if not rankMO then
    rankMO = self:CreateRankMOByType(rankType, rankSvrData)
    if not rankMO then
      return
    end
    self:_AddRankMO(rankType, rankSubTid, rankMO)
  end
  rankMO:UpdateData(rankSvrData)
end

local PvpRankTypeList = {
  RankDefine.RankType.PVPCollect,
  RankDefine.RankType.PVPCollectSeason,
  RankDefine.RankType.PVPCollectMonthly
}

function RankModel:CreateRankMOByType(rankType, rankSvrData)
  local targetMO
  if rankType == RankDefine.RankType.WorldBossKill then
    targetMO = RankWorldBossKillMO()
  elseif rankType == RankDefine.RankType.WorldBossAssist then
    targetMO = RankWorldBossAssistMO()
  elseif rankType == RankDefine.RankType.RaidActivityKill then
    targetMO = RankWorldBossKillMO()
  elseif rankType == RankDefine.RankType.RaidActivityAssist then
    targetMO = RankWorldBossAssistMO()
  elseif rankType == RankDefine.RankType.SeasonRoRailWay then
    targetMO = RankRailWayMO()
  elseif table.contains(PvpRankTypeList, rankType) then
    targetMO = RankPvpCollectionMO()
  else
    targetMO = RankBaseMO()
  end
  if not targetMO then
    return nil
  end
  targetMO:UpdateData(rankSvrData)
  return targetMO
end

function RankModel:GetRankKey(rankType, subRankTid)
  subRankTid = subRankTid or 0
  do return string.format, "%s_%s", rankType end
  return string.format, "%s_%s", rankType, subRankTid
end

function RankModel:GetRankMO(rankType, rankSubTid, uid)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  return self._rankKey2RankMODict[rankKey] and self._rankKey2RankMODict[rankKey][uid]
end

function RankModel:GetRankLength(rankType, rankSubTid)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  if not self._rankKey2LengthDict[rankKey] then
    return nil
  end
  return self._rankKey2LengthDict[rankKey]
end

function RankModel:GetRankSequence(rankType, rankSubTid)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  if not self._rankKey2SequenceDict[rankKey] then
    return {}
  end
  local rankLength = self:GetRankLength(rankType, rankSubTid)
  if not rankLength then
    return {}
  end
  local rst = {}
  for i = 1, rankLength do
    if self._rankKey2SequenceDict[rankKey][i] then
      table.insert(rst, self._rankKey2SequenceDict[rankKey][i])
    end
  end
  return rst
end

function RankModel:GetRailWayRankSeasonEndTs()
  local activityData = ActivityManager.Instance:GetActivityDataByType(ActivityDefine.ActivityType.RailWaySeasonRankActivity)
  return activityData and activityData.endTime
end

function RankModel:ClearRank(rankType, rankSubTid)
  local rankKey = self:GetRankKey(rankType, rankSubTid)
  self._rankKey2RankMODict[rankKey] = nil
  self._rankKey2SequenceDict[rankKey] = nil
  self._rankKey2LengthDict[rankKey] = nil
  self._rankKey2InvalidPageDict[rankKey] = nil
  self._rankKey2OverlapPendingRefreshDict[rankKey] = nil
end

local sortedCfgs = {}

function RankModel:GetSeasonSchemaTag(rankType)
  if NewSeasonRankTypeMap[rankType] then
    return "newSeason"
  end
  return "oldSeason"
end

function RankModel:BuildRawExt(data)
  return {
    score2 = data and data.score2,
    railWayTeam = data and data.railWayTeam,
    dailyChallengeTeam = data and data.dailyChallengeTeam,
    school2MaxScoreTeam = data and data.school2MaxScoreTeam
  }
end

function RankModel:ToRankMO(rankType, rankSvrData, subTid)
  if not rankSvrData then
    return nil
  end
  local rankMO = self:CreateRankMOByType(rankType, rankSvrData)
  if subTid and subTid > 0 then
    rankMO:SetSeasonTid(subTid)
  end
  local gameplayType = SeasonRankStrategy.GetGameplayTypeByRankType(rankType)
  rankMO:SetGameplayType(gameplayType)
  return rankMO
end

function RankModel:ResetAllRankData()
  self._rankKey2RankMODict = {}
  self._rankKey2SequenceDict = {}
  self._rankKey2LengthDict = {}
  self._rankKey2SelfRankDict = {}
  self._rankKey2PlayerCntInfoDict = {}
  self._rankKey2IntervalCountDict = {}
  self._rankKey2SettlingDict = {}
  self._rankKey2InvalidPageDict = {}
  self._rankKey2OverlapPendingRefreshDict = {}
end

function RankModel:ResetRankType(rankType, subTid)
  local exactKey = self:GetRankKey(rankType, subTid)
  local clearList = {
    self._rankKey2RankMODict,
    self._rankKey2SequenceDict,
    self._rankKey2LengthDict,
    self._rankKey2SelfRankDict,
    self._rankKey2PlayerCntInfoDict,
    self._rankKey2IntervalCountDict,
    self._rankKey2SettlingDict,
    self._rankKey2InvalidPageDict,
    self._rankKey2OverlapPendingRefreshDict
  }
  for _, dict in ipairs(clearList) do
    if dict[exactKey] then
      dict[exactKey] = nil
    end
    local prefix = RankDataUtils.GetRankKey(rankType, subTid) .. "_"
    for k, _ in pairs(dict) do
      if type(k) == "string" and k:startswith(prefix) then
        dict[k] = nil
      end
    end
  end
end

function RankModel:ApplyQueryRankResult(rankType, subTid, startIndex, svrData, count)
  if not table.next(svrData) then
    return
  end
  local pageSize = count or 10
  local rankKey = self:GetRankKey(rankType, subTid)
  self._rankKey2PlayerCntInfoDict[rankKey] = table.clone(svrData.playerCntInfo or {})
  self._rankKey2SettlingDict[rankKey] = svrData.settling or false
  self:UpdateRankParticipantCnt(rankType, subTid)
  local playerRankLen = "table" == type(svrData.playerRank) and svrData.playerRank.len
  local rankLen = playerRankLen or svrData.count or #(svrData.data or {})
  self._rankKey2LengthDict[rankKey] = rankLen or 0
  if svrData.playerRank then
    self:UpdateSelfRank(rankType, subTid, svrData.playerRank)
  end
  local svrRankList = svrData.data or {}
  local hasOverlap = startIndex > 1 and self:_HasIncomingRankShiftOverlap(rankKey, svrRankList)
  if hasOverlap then
    local incomingPage = math.floor((startIndex - 1) / pageSize) + 1
    if incomingPage > 1 then
      self:MarkRankPagesInvalid(rankType, subTid, 1, incomingPage - 1)
    end
    self._rankKey2OverlapPendingRefreshDict[rankKey] = true
  end
  if startIndex <= 1 then
    local sequence = self._rankKey2SequenceDict[rankKey]
    if not sequence or not next(sequence) then
      self._rankKey2SequenceDict[rankKey] = {}
      self._rankKey2RankMODict[rankKey] = {}
    else
      if not self._rankKey2SequenceDict[rankKey] then
        self._rankKey2SequenceDict[rankKey] = {}
      end
      if not self._rankKey2RankMODict[rankKey] then
        self._rankKey2RankMODict[rankKey] = {}
      end
    end
  else
    if not self._rankKey2SequenceDict[rankKey] then
      self._rankKey2SequenceDict[rankKey] = {}
    end
    if not self._rankKey2RankMODict[rankKey] then
      self._rankKey2RankMODict[rankKey] = {}
    end
  end
  for i, svrItem in ipairs(svrRankList) do
    local mo = self:ToRankMO(rankType, svrItem, subTid)
    if mo and svrItem.uid then
      self._rankKey2RankMODict[rankKey][svrItem.uid] = mo
      self._rankKey2SequenceDict[rankKey][startIndex + i - 1] = svrItem.uid
    end
  end
  if #svrRankList > 0 then
    local fromPage = math.floor((startIndex - 1) / pageSize) + 1
    local toPage = math.floor((startIndex + #svrRankList - 2) / pageSize) + 1
    self:ClearRankPageInvalid(rankType, subTid, fromPage, toPage)
  end
  EventMgr.Instance.RankUpdate:Dispatch(rankType, subTid)
  GlobalDispatcher:Dispatch(NotifyId.OnRankDataChanged, rankType)
end

function RankModel:ApplyOpenRankData(rankType, subTid, data)
  local rankKey = self:GetRankKey(rankType, subTid)
  if type(data) ~= "table" then
    data = {}
  end
  local rankLen = "table" == type(data.playerRank) and data.playerRank.len or data.count or 0
  if "table" == type(data.playerRank) then
    self:UpdateSelfRank(rankType, subTid, data.playerRank)
  elseif data.rankIndex ~= nil or nil ~= data.rewardRankIndex then
    self:UpdateSelfRank(rankType, subTid, data)
  elseif nil ~= data.rank and data.rank > 0 then
    self:UpdateSelfRank(rankType, subTid, data)
  end
  local playerCntInfo
  if "table" == type(data.playerCntInfo) then
    playerCntInfo = table.clone(data.playerCntInfo)
  else
    playerCntInfo = table.clone(data)
  end
  if rankLen > 0 and (not playerCntInfo.curCount or playerCntInfo.curCount <= 0) then
    playerCntInfo.curCount = rankLen
  end
  self._rankKey2PlayerCntInfoDict[rankKey] = playerCntInfo
  if rankLen > 0 then
    self._rankKey2LengthDict[rankKey] = rankLen
  end
  self._rankKey2SettlingDict[rankKey] = data.settling or false
  self:UpdateRankParticipantCnt(rankType, subTid)
  EventMgr.Instance.RankUpdate:Dispatch(rankType, subTid)
  GlobalDispatcher:Dispatch(NotifyId.OnRankDataChanged, rankType)
end

function RankModel:UpdateSelfRank(rankType, subTid, selfRank)
  local key = self:GetRankKey(rankType, subTid)
  if not selfRank then
    self._rankKey2SelfRankDict[key] = nil
    return
  end
  if type(selfRank) ~= "table" then
    return
  end
  local selfRankInfo = table.clone(selfRank)
  selfRankInfo.name = PlayerDataUtils.GetName()
  selfRankInfo.icon = DataCenter.playerData.DRole.icon
  selfRankInfo.rank = selfRankInfo.rankIndex
  local selfRankMO = self:ToRankMO(rankType, selfRankInfo, subTid)
  selfRankMO:SetSeasonTid(subTid)
  selfRankMO:SetType(rankType)
  local gameplayType = SeasonRankStrategy.GetGameplayTypeByRankType(rankType)
  selfRankMO:SetGameplayType(gameplayType)
  self._rankKey2SelfRankDict[key] = selfRankMO
end

function RankModel:UpdateRankParticipantCnt(rankType, subTid)
  local rankCfgName = "PVPNewRank"
  local rankCfg = rankCfgName and DT[rankCfgName]
  if not rankCfg then
    return
  end
  local miniParticipantCnt = 100
  if rankType == RankDefine.RankType.DailyPVP or rankType == RankDefine.RankType.DailyDraftPVP then
    miniParticipantCnt = DT.GetConstant("PVPRankBaseNum")
  end
  local key = self:GetRankKey(rankType, subTid)
  local rankIntervalMap = {}
  self._rankKey2IntervalCountDict[key] = rankIntervalMap
  local playerCntInfo = self._rankKey2PlayerCntInfoDict[key] or {}
  local curCount = math.max(playerCntInfo.curCount or 0, miniParticipantCnt)
  for rankTid, cfg in pairs(rankCfg) do
    local miniCount = math.floor(cfg.RankLowerInterval * curCount / 100)
    local maxCount = math.floor(cfg.RankUpperInterval * curCount / 100)
    rankIntervalMap[rankTid] = {
      rankTid = rankTid,
      miniCount = miniCount,
      maxCount = maxCount
    }
  end
end

function RankModel:GetRankListData(rankType, subTid)
  local rankKey = self:GetRankKey(rankType, subTid)
  local sequence = self._rankKey2SequenceDict[rankKey]
  local moDict = self._rankKey2RankMODict[rankKey]
  if not sequence or not moDict then
    return nil
  end
  local result = {}
  local seenUid = {}
  local rankLength = self._rankKey2LengthDict[rankKey] or 0
  for i = 1, rankLength do
    local uid = sequence[i]
    if uid and moDict[uid] and not seenUid[uid] then
      seenUid[uid] = true
      result[#result + 1] = moDict[uid]
    end
  end
  return result
end

function RankModel:GetSelfRankData(rankType, subTid)
  local key = self:GetRankKey(rankType, subTid)
  return self._rankKey2SelfRankDict[key]
end

function RankModel:GetSelfRankTid(rankType, subTid)
  local selfRank = self:GetSelfRankData(rankType, subTid)
  if not selfRank then
    return nil
  end
  local rewardRankIndex = selfRank:GetRewardRankIndex()
  local rankCfg = self:GetRankCfgByRewardIndex(rankType, subTid, rewardRankIndex)
  return rankCfg and rankCfg.ID
end

function RankModel:GetRankCountIntervalData(rankType, subTid, rankTid)
  local key = self:GetRankKey(rankType, subTid)
  local intervalMap = self._rankKey2IntervalCountDict[key] or {}
  local intervalInfo = intervalMap[rankTid]
  if not intervalInfo then
    return 0, 0
  end
  return intervalInfo.miniCount, intervalInfo.maxCount
end

function RankModel:GetRankLengthData(rankType, subTid)
  local key = self:GetRankKey(rankType, subTid)
  return self._rankKey2LengthDict[key]
end

function RankModel:GetRankCfgByRewardIndex(rankType, subTid, rewardIndex)
  if not rewardIndex or 0 == rewardIndex then
    return nil
  end
  local rankCfgName = "PVPNewRank"
  local rankCfg = rankCfgName and DT[rankCfgName]
  if not rankCfg then
    return nil
  end
  for rankTid, cfg in pairs(rankCfg) do
    local miniCount, maxCount = self:GetRankCountIntervalData(rankType, subTid, rankTid)
    if rewardIndex > miniCount and rewardIndex <= maxCount then
      return cfg
    end
  end
  return nil
end

function RankModel:GetPlayerCntInfoData(rankType, subTid)
  local key = self:GetRankKey(rankType, subTid)
  return self._rankKey2PlayerCntInfoDict[key]
end

function RankModel:GetRankSettlingData(rankType, subTid)
  local key = self:GetRankKey(rankType, subTid)
  return self._rankKey2SettlingDict[key] or false
end

function RankModel:GetIsWinByRankType(rankType, subTid)
  local rankKey = self:GetRankKey(rankType, subTid)
  local info = self._rankKey2PlayerCntInfoDict[rankKey]
  if info then
    return info.isWin
  end
  return nil
end

function RankModel:GetSortedCfg(rankCfg)
  if sortedCfgs[rankCfg] then
    return sortedCfgs[rankCfg]
  end
  local sortedCfg = {}
  for _, cfg in pairs(rankCfg) do
    table.insert(sortedCfg, cfg)
  end
  table.sort(sortedCfg, function(a, b)
    return a.RankLowerInterval < b.RankLowerInterval
  end)
  sortedCfgs[rankCfg] = sortedCfg
  return sortedCfg
end

return RankModel
