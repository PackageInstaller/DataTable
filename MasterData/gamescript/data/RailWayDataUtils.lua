local RailWayDataUtils = {}
RailWayDataUtils._preBattleSeasonId = nil
RailWayDataUtils._pendingSeasonSwitchTip = false

function RailWayDataUtils.ResetSeasonSwitchState()
  RailWayDataUtils._preBattleSeasonId = nil
  RailWayDataUtils._pendingSeasonSwitchTip = false
end

function RailWayDataUtils.OnBattleStart()
  RailWayDataUtils._pendingSeasonSwitchTip = false
  RailWayDataUtils._preBattleSeasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
end

function RailWayDataUtils.OnBattleFinish()
  local curSeasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
  if RailWayDataUtils._preBattleSeasonId and curSeasonId and curSeasonId ~= RailWayDataUtils._preBattleSeasonId then
    RailWayDataUtils._pendingSeasonSwitchTip = true
  end
  RailWayDataUtils._preBattleSeasonId = nil
end

function RailWayDataUtils.ConsumePendingSeasonSwitchTip()
  if RailWayDataUtils._pendingSeasonSwitchTip then
    RailWayDataUtils._pendingSeasonSwitchTip = false
    return true
  end
  return false
end

function RailWayDataUtils.GetRailWayStageMileExpProgress(stageId, stageData)
  if not stageId or not stageData then
    return 0, 0
  end
  local nowMileExp = stageData and stageData.railWayData and stageData.railWayData.scoreItemCount or 0
  local totalMileExp = StageCfgUtils.GetMapBossEliteRailWayExp(stageId)
  return nowMileExp, totalMileExp
end

function RailWayDataUtils.GetRailWayStageNow(stageId)
  local stageGroupId = stageId and DT.Stage[stageId] and DT.Stage[stageId].BelongGroup
  if not stageGroupId then
    return
  end
  local stageData = WorldStageManager.Instance:GetStageData(stageGroupId)
  if not stageId or not stageData then
    return
  end
  local nowPhase, nowNode, totalNode
  if DT.StageGroup[stageGroupId].Type == CommonDefine.StageGroupType.RailWay then
    if not stageData.railWayData then
      nowNode, totalNode = WorldStageManager.Instance:GetOneLineRoundInfo()
    else
      nowPhase = stageData.railWayData.currentStage or 0
      nowNode = stageData.railWayData.currentBattleNodeIndex or 0
      totalNode = stageData.railWayData.totalBattleNodes or 0
    end
  else
    nowNode, totalNode = WorldStageManager.Instance:GetOneLineRoundInfo()
  end
  print("rail stage now", stageId, nowPhase, nowNode, totalNode, table.tostring(stageData.railWayData))
  return nowPhase, nowNode, totalNode
end

function RailWayDataUtils.IsMadnessDifficulty(stageId)
  if not stageId or not DT.Stage[stageId] then
    return false
  end
  return DT.Stage[stageId].Sequence == RailWayDefine.RailWayDifficult.Madness
end

function RailWayDataUtils.IsSeasonSwitchedByTime(createTime)
  if not createTime then
    return false
  end
  local seasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
  if not seasonId then
    return false
  end
  local gameplayType = CommonDefine.SeasonGameplayType.ConsciousnessRailway
  local seasonStartTime = SeasonRotationCfgUtils.GetStartTime(seasonId, gameplayType)
  if seasonStartTime <= 0 then
    return false
  end
  return createTime < seasonStartTime
end

function RailWayDataUtils.IsSeasonSwitched(savedSeasonId)
  if not savedSeasonId then
    return false
  end
  local currentSeasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
  if not currentSeasonId then
    return false
  end
  return savedSeasonId ~= currentSeasonId
end

function RailWayDataUtils.IsSeasonStageGroupSwitched(savedStageGroupId)
  if not savedStageGroupId then
    return false
  end
  local currentStageGroupId = SeasonRotationCfgUtils.GetCurrentRailWayStageGroupId()
  if not currentStageGroupId then
    return false
  end
  return savedStageGroupId ~= currentStageGroupId
end

return RailWayDataUtils
