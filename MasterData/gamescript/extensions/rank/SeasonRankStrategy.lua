local SeasonGameplayType = CommonDefine.SeasonGameplayType
local SeasonRankStrategy = {}
SeasonRankStrategy.PvpPreBuilt = {
  gameplayType = SeasonGameplayType.PvpPreBuilt,
  rankType = RankDefine.RankType.SeasonRoPvpPrebuilt,
  supportDualMode = true,
  supportAwakerFilter = false,
  ruleTitle = "PVPRankingRuleTitle",
  ruleDesc = "PVPRankingRuleDesc"
}
SeasonRankStrategy.PvpDraft = {
  gameplayType = SeasonGameplayType.PvpDraft,
  rankType = RankDefine.RankType.SeasonRoPvpDraft,
  supportDualMode = true,
  supportAwakerFilter = false,
  ruleTitle = "PVPRankingRuleTitle",
  ruleDesc = "PVPRankingRuleDesc"
}
SeasonRankStrategy.RailWay = {
  gameplayType = SeasonGameplayType.ConsciousnessRailway,
  rankType = RankDefine.RankType.SeasonRoRailWay,
  supportDualMode = false,
  supportAwakerFilter = false,
  ruleTitle = "RailWayRankingRuleTitle",
  ruleDesc = "RailWayRankingRuleDesc"
}
SeasonRankStrategy.DailyChallenge = {
  gameplayType = SeasonGameplayType.ConsciousnessDiving,
  rankType = RankDefine.RankType.SeasonRoDailyChallenge,
  supportDualMode = false,
  supportAwakerFilter = true,
  ruleTitle = "DailyChallengeRankingRuleTitle",
  ruleDesc = "DailyChallengeRankingRuleDesc"
}
local _rankTypeToStrategy

local function GetStrategyByRankType(rankType)
  if not _rankTypeToStrategy then
    _rankTypeToStrategy = {}
    local allStrategies = {
      SeasonRankStrategy.PvpPreBuilt,
      SeasonRankStrategy.PvpDraft,
      SeasonRankStrategy.RailWay,
      SeasonRankStrategy.DailyChallenge
    }
    for _, s in ipairs(allStrategies) do
      _rankTypeToStrategy[s.rankType] = s
    end
  end
  return _rankTypeToStrategy[rankType]
end

function SeasonRankStrategy.GetGameplayTypeByRankType(rankType)
  local strategy = GetStrategyByRankType(rankType)
  return strategy and strategy.gameplayType
end

function SeasonRankStrategy.GetCurrentSeasonTid(strategy)
  return SeasonRotationModel.Instance:GetSeasonId(strategy.gameplayType) or SeasonRotationModel.Instance:GetFirstRotationId() or 0
end

function SeasonRankStrategy.GetSeasonEndTime(strategy, seasonTid)
  if not seasonTid or 0 == seasonTid then
    seasonTid = SeasonRankStrategy.GetCurrentSeasonTid(strategy)
  end
  if not seasonTid or 0 == seasonTid then
    return 0
  end
  return SeasonRotationCfgUtils.GetEndTime(seasonTid, strategy.gameplayType) or 0
end

function SeasonRankStrategy.GetSeasonName(strategy, seasonTid)
  if not seasonTid or 0 == seasonTid then
    return ""
  end
  return SeasonRotationCfgUtils.GetName(seasonTid, strategy.gameplayType) or ""
end

function SeasonRankStrategy.GetHistSeasonCfgList(strategy, curSeasonTid)
  do return SeasonRotationModel.Instance.GetHistRotationSeasonCfgList, SeasonRotationModel.Instance, strategy.gameplayType end
  return SeasonRotationModel.Instance.GetHistRotationSeasonCfgList, SeasonRotationModel.Instance, strategy.gameplayType, curSeasonTid
end

function SeasonRankStrategy.GetRankRewardRowList(strategy, seasonTid)
  if not seasonTid or 0 == seasonTid then
    seasonTid = SeasonRankStrategy.GetCurrentSeasonTid(strategy)
  end
  do return SeasonRotationModel.Instance.GetSeasonRankRewardRowList, SeasonRotationModel.Instance, seasonTid end
  return SeasonRotationModel.Instance.GetSeasonRankRewardRowList, SeasonRotationModel.Instance, seasonTid, strategy.gameplayType
end

function SeasonRankStrategy.GetSortedRewardShowData(strategy, seasonTid)
  if not seasonTid or 0 == seasonTid then
    seasonTid = SeasonRankStrategy.GetCurrentSeasonTid(strategy)
  end
  local rowList = SeasonRankStrategy.GetRankRewardRowList(strategy, seasonTid)
  if not rowList or 0 == #rowList then
    return {}
  end
  local baseSortID, baseIdx
  for idx, row in ipairs(rowList) do
    if row and row.BaseSortID and row.BaseSortID > 0 then
      baseSortID = row.BaseSortID
      baseIdx = idx
      break
    end
  end
  local result = {}
  for idx, row in ipairs(rowList) do
    local rewardGroup = RankingBoardDataUtils.GetSeasonRankRowRewards(row)
    local rankID
    if row and row.BaseSortID and row.BaseSortID > 0 then
      rankID = row.BaseSortID
    elseif baseSortID and baseIdx then
      rankID = baseSortID + (idx - baseIdx)
    else
      rankID = idx
    end
    table.insert(result, {
      rankID = rankID,
      title = row and row.Name or "",
      titleBG = row and row.RankIcon or "",
      lowerLimit = row and row.RankLowerInterval or 0,
      higherLimit = row and row.RankUpperInterval or 0,
      rewardGroup = rewardGroup,
      rawRow = row
    })
  end
  table.sort(result, function(a, b)
    return (a.lowerLimit or 0) < (b.lowerLimit or 0)
  end)
  return result
end

function SeasonRankStrategy.BuildRankRangesModel(rewardShowData, totalPlayerNum, selfRewardRankIndex)
  local model = {
    rankRanges = {},
    currPlayerRank = 0,
    currPlayerRewardRankIndex = selfRewardRankIndex or 0
  }
  local playersNum = math.max(totalPlayerNum or 0, 100)
  local lastTo = 0
  for _, data in ipairs(rewardShowData or {}) do
    local from = math.ceil((data.lowerLimit or 0) * playersNum / 100) + 1
    local to = math.maxinteger
    if (data.higherLimit or 0) < 100 then
      to = math.ceil((data.higherLimit or 0) * playersNum / 100)
    end
    from = math.max(from, lastTo + 1)
    to = math.max(to, from)
    lastTo = to
    table.insert(model.rankRanges, {
      rankID = data.rankID,
      from = from,
      to = to
    })
  end
  selfRewardRankIndex = selfRewardRankIndex or 0
  if selfRewardRankIndex > 0 then
    for _, range in ipairs(model.rankRanges) do
      if selfRewardRankIndex >= range.from and selfRewardRankIndex <= range.to then
        model.currPlayerRank = range.rankID
        break
      end
    end
  end
  return model
end

function SeasonRankStrategy.FormatSettlementNotice(endTime)
  if not endTime or 0 == endTime then
    return nil
  end
  local leftTime = math.max(0, endTime - TimeUtils.GetServerTime())
  local d, h, m = TimeUtils.PVPSeasonEnd(leftTime)
  if d > 0 then
    do return LT.Textf, "SeasonRankListSettlementNotice1", d end
    return LT.Textf, "SeasonRankListSettlementNotice1", d, h
  else
    do return LT.Textf, "SeasonRankListSettlementNotice2", h end
    return LT.Textf, "SeasonRankListSettlementNotice2", h, m
  end
end

return SeasonRankStrategy
