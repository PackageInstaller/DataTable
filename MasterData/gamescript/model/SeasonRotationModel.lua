local SeasonRotationModel = NewClass("SeasonRotationModel", BaseModel)
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local PvpType = PvpDefine.PvpType

function SeasonRotationModel:OnInit()
  self:OnReset()
end

function SeasonRotationModel:OnReset()
  self.seasonDataMap = {}
  self.gameplaySeasonIdMap = {}
  self.firstRotationCfg = self:_CalFirstRotationCfg()
end

function SeasonRotationModel:_MapToGameplayType(modeType)
  if modeType == PvpType.PreBuilt then
    return SeasonGameplayType.PvpPreBuilt
  end
  if modeType == PvpType.Draft then
    return SeasonGameplayType.PvpDraft
  end
  if modeType == SeasonGameplayType.ConsciousnessDiving or modeType == SeasonGameplayType.PvpPreBuilt or modeType == SeasonGameplayType.ConsciousnessRailway or modeType == SeasonGameplayType.PvpDraft then
    return modeType
  end
  return nil
end

function SeasonRotationModel:GetSeasonData(gameplayType)
  return self.seasonDataMap[gameplayType]
end

function SeasonRotationModel:GetSeasonDataByModeType(modeType)
  local gameplayType = self:_MapToGameplayType(modeType)
  if not gameplayType then
    return nil
  end
  do return self.GetSeasonData, self end
  return self.GetSeasonData, self, gameplayType
end

function SeasonRotationModel:GetPvpPrebuildSeasonData()
  do return self.GetSeasonData, self end
  return self.GetSeasonData, self, SeasonGameplayType.PvpPreBuilt
end

function SeasonRotationModel:GetPvpDraftSeasonData()
  do return self.GetSeasonData, self end
  return self.GetSeasonData, self, SeasonGameplayType.PvpDraft
end

function SeasonRotationModel:GetSeasonId(gameplayType)
  local seasonId = self.gameplaySeasonIdMap[gameplayType] or 0
  if seasonId and seasonId > 0 then
    return seasonId
  end
  do return self._CalcSeasonIdByTime, self end
  return self._CalcSeasonIdByTime, self, gameplayType
end

function SeasonRotationModel:GetScoreByModeType(modeType)
  local seasonData = self:GetSeasonDataByModeType(modeType)
  return seasonData and seasonData.score or 0
end

function SeasonRotationModel:GetAccWinCountByModeType(modeType)
  local seasonData = self:GetSeasonDataByModeType(modeType)
  return seasonData and (seasonData.accWinCount or 0) or 0
end

function SeasonRotationModel:SetSeasonDataMap(seasonDataMap)
  self.seasonDataMap = seasonDataMap or {}
  self.gameplaySeasonIdMap = {}
  for gameplayType, seasonData in pairs(self.seasonDataMap) do
    if type(seasonData) == "table" then
      self.gameplaySeasonIdMap[gameplayType] = seasonData.seasonId or 0
    end
  end
end

function SeasonRotationModel:SetSeasonData(gameplayType, seasonData)
  if not gameplayType then
    return
  end
  if nil == seasonData then
    self.seasonDataMap[gameplayType] = nil
    self.gameplaySeasonIdMap[gameplayType] = nil
    return
  end
  self.seasonDataMap[gameplayType] = seasonData
  self.gameplaySeasonIdMap[gameplayType] = seasonData.seasonId or 0
end

function SeasonRotationModel:GetGameplaySeasonIdMap()
  return self.gameplaySeasonIdMap
end

function SeasonRotationModel:GetFirstRotationCfg()
  return self.firstRotationCfg
end

function SeasonRotationModel:GetFirstRotationId()
  return self.firstRotationCfg and self.firstRotationCfg.ID or 0
end

function SeasonRotationModel:GetFirstRotationStartTime()
  if self.firstRotationCfg then
    local miniTime = math.huge
    for _, data in pairs(self.firstRotationCfg.data_list) do
      if miniTime > data.StartTime then
        miniTime = data.StartTime
      end
    end
    return miniTime
  end
  return 0
end

function SeasonRotationModel:_CalFirstRotationCfg()
  local baseSortId = math.huge
  local firstRotationCfg
  for seasonId, cfg in pairs(DT.SeasonRotation or {}) do
    if baseSortId > cfg.BaseSortID then
      baseSortId = cfg.BaseSortID
      firstRotationCfg = cfg
    end
  end
  return firstRotationCfg
end

function SeasonRotationModel:_CalcSeasonIdByTime(gameplayType)
  local nowTime = TimeUtils.GetServerTime()
  local activeSeasonId = 0
  local activeStartTime = -1
  local latestPastSeasonId = 0
  local latestPastStartTime = -1
  local earliestFutureSeasonId = 0
  local earliestFutureStartTime = math.huge
  for seasonId, _ in pairs(DT.SeasonRotation or {}) do
    local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
    if cfg and cfg.StartTime and cfg.StartTime > 0 then
      local startTime = cfg.StartTime
      local endTime = cfg.EndTime or 0
      local isActive = nowTime >= startTime and (endTime <= 0 or nowTime < endTime)
      if isActive and activeStartTime < startTime then
        activeSeasonId = seasonId
        activeStartTime = startTime
      end
      if nowTime >= startTime and latestPastStartTime < startTime then
        latestPastSeasonId = seasonId
        latestPastStartTime = startTime
      end
      if nowTime < startTime and earliestFutureStartTime > startTime then
        earliestFutureSeasonId = seasonId
        earliestFutureStartTime = startTime
      end
    end
  end
  if activeSeasonId > 0 then
    return activeSeasonId
  end
  if latestPastSeasonId > 0 then
    return latestPastSeasonId
  end
  if earliestFutureSeasonId > 0 then
    return earliestFutureSeasonId
  end
  return 0
end

function SeasonRotationModel:CalcSeasonIdByTime(gameplayType)
  do return self._CalcSeasonIdByTime, self end
  return self._CalcSeasonIdByTime, self, gameplayType
end

function SeasonRotationModel:IsRotaionSeason(seasonTid)
  do return SeasonRotationCfgUtils.IsHaveSeasonCfg end
  return SeasonRotationCfgUtils.IsHaveSeasonCfg, seasonTid
end

function SeasonRotationModel:IsOldPVPSeason(seasonTid)
  return not self:IsRotaionSeason(seasonTid) and DT.PVPSeason[seasonTid] ~= nil
end

function SeasonRotationModel:GetHistRotationSeasonCfgList(gameplayType, curSeasonTid)
  if not gameplayType then
    return {}
  end
  curSeasonTid = curSeasonTid or self:GetSeasonId(gameplayType) or self:GetFirstRotationId()
  if not curSeasonTid or 0 == curSeasonTid then
    return {}
  end
  local seasonCfgs = {}
  local allSeasonCfgs = SeasonRotationCfgUtils.GetSeasonCfgList()
  local curSeasonCfg = SeasonRotationCfgUtils.GetSeasonCfg(curSeasonTid)
  for seasonId, cfg in pairs(allSeasonCfgs) do
    if cfg.BaseSortID <= curSeasonCfg.BaseSortID then
      table.insert(seasonCfgs, {
        ID = seasonId,
        Name = SeasonRotationCfgUtils.GetName(seasonId, gameplayType),
        BaseSortID = cfg.BaseSortID or 0
      })
    end
  end
  table.sort(seasonCfgs, function(a, b)
    return (a.BaseSortID or 0) > (b.BaseSortID or 0)
  end)
  if #seasonCfgs >= 2 then
    seasonCfgs = {
      seasonCfgs[1],
      seasonCfgs[2]
    }
    seasonCfgs[1].Name = LT.Text("AbyssChallengeRankThisPeriod")
    seasonCfgs[2].Name = LT.Text("AbyssChallengeRankPreviousPeriod")
  else
    seasonCfgs[1].Name = LT.Text("AbyssChallengeRankThisPeriod")
  end
  return seasonCfgs
end

function SeasonRotationModel:GetSeasonRankRewardRowList(seasonId, gameplayType)
  if not seasonId or 0 == seasonId or not gameplayType then
    return {}
  end
  local groupCfg = SeasonRotationCfgUtils.GetSeasonRankRewardGroupCfg(seasonId, gameplayType)
  return groupCfg and groupCfg.data_list or {}
end

function SeasonRotationModel:GetSeasonRankRewardRowByRewardIndex(seasonId, gameplayType, rewardRankIndex, playersNum)
  if not (seasonId and 0 ~= seasonId and gameplayType and rewardRankIndex) or 0 == rewardRankIndex then
    return nil
  end
  local rowList = self:GetSeasonRankRewardRowList(seasonId, gameplayType)
  rowList = table.clone(rowList or {})
  table.sort(rowList, function(a, b)
    return (a.RankLowerInterval or 0) < (b.RankLowerInterval or 0)
  end)
  if not rowList or 0 == #rowList then
    return nil
  end
  playersNum = math.max(playersNum or 0, 100)
  local lastTo = 0
  for _, row in ipairs(rowList) do
    local miniCount = math.ceil((row.RankLowerInterval or 0) * playersNum / 100)
    miniCount = math.max(miniCount, lastTo + 1)
    local maxCount = math.ceil((row.RankUpperInterval or 0) * playersNum / 100)
    maxCount = math.max(maxCount, miniCount)
    lastTo = maxCount
    if rewardRankIndex >= miniCount and rewardRankIndex <= maxCount then
      return row
    end
  end
  return nil
end

return SeasonRotationModel
