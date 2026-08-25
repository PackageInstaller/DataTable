local SeasonRotationCfgUtils = {}
local DAY_SECONDS = 86400
local FAR_FROM_CLOSE_SECONDS = 7 * DAY_SECONDS

local function _GetNowTime(nowTime)
  return nowTime or TimeUtils.GetServerTime()
end

local function _WrapColor(text, color)
  do return string.format, "<color=%s>%s</color>", color end
  return string.format, "<color=%s>%s</color>", color, text
end

local function _GetLeftTimeRawText(leftTime)
  local d, h, m = TimeUtils.ConvertTime(math.max(0, leftTime))
  if d >= 1 then
    do return LT.Textf, "BattlePassLeftTimeMore", d end
    return LT.Textf, "BattlePassLeftTimeMore", d, h
  end
  do return LT.Textf, "BattlePassLeftTimeLess", h end
  return LT.Textf, "BattlePassLeftTimeLess", h, m
end

function SeasonRotationCfgUtils.IsHaveSeasonCfg(seasonId)
  return DT.SeasonRotation[seasonId] ~= nil
end

function SeasonRotationCfgUtils.GetSeasonCfgList()
  return DT.SeasonRotation or {}
end

function SeasonRotationCfgUtils.GetSeasonCfg(seasonId)
  if not SeasonRotationCfgUtils.IsHaveSeasonCfg(seasonId) then
    return nil
  end
  local seasonGroupCfg = DT.SeasonRotation[seasonId]
  return seasonGroupCfg
end

function SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  if not SeasonRotationCfgUtils.IsHaveSeasonCfg(seasonId) then
    return nil
  end
  local seasonGroupCfg = DT.SeasonRotation[seasonId]
  return seasonGroupCfg.data_list and seasonGroupCfg.data_list[gameplayType] or nil
end

function SeasonRotationCfgUtils.GetTypeName(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  return cfg and cfg.SeasonType or nil
end

function SeasonRotationCfgUtils.GetDateText(timestamp)
  if not timestamp or timestamp <= 0 then
    return ""
  end
  local serverDate = TimeUtils.GetServerDate(timestamp)
  if not serverDate then
    return ""
  end
  local year = (serverDate.year or 0) % 100
  local month = serverDate.month or 0
  local day = serverDate.day or 0
  do return string.format, "%02d.%02d.%02d", year, month end
  return string.format, "%02d.%02d.%02d", year, month, day
end

function SeasonRotationCfgUtils.GetDateRangeText(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  if not cfg then
    return ""
  end
  local startDateText = SeasonRotationCfgUtils.GetDateText(cfg.StartTime)
  local endDateText = SeasonRotationCfgUtils.GetDateText(cfg.EndTime)
  if "" == startDateText or "" == endDateText then
    return ""
  end
  local dateRangeText = LT.Textf("DateFormat", startDateText, endDateText)
  if not dateRangeText or "" == dateRangeText or "DateFormat" == dateRangeText then
    do return string.format, "%s~%s", startDateText end
    return string.format, "%s~%s", startDateText, endDateText
  end
  return dateRangeText
end

function SeasonRotationCfgUtils.GetName(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  if not cfg then
    return ""
  end
  local seasonName = LT.Text(cfg.SeasonName or "")
  local dateText = SeasonRotationCfgUtils.GetDateRangeText(seasonId, gameplayType)
  if "" == dateText then
    return seasonName
  end
  if "" == seasonName then
    return dateText
  end
  do return string.format, "%s %s", seasonName end
  return string.format, "%s %s", seasonName, dateText
end

function SeasonRotationCfgUtils.GetEndTime(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  return cfg and (cfg.EndTime or 0) or 0
end

function SeasonRotationCfgUtils.GetStartTime(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  return cfg and (cfg.StartTime or 0) or 0
end

function SeasonRotationCfgUtils.GetLeftTime(seasonId, gameplayType, nowTime)
  local endTime = SeasonRotationCfgUtils.GetEndTime(seasonId, gameplayType)
  if endTime <= 0 then
    return 0
  end
  do return math.max, 0 end
  return math.max, 0, endTime - _GetNowTime(nowTime), nowTime
end

function SeasonRotationCfgUtils.IsNearClose(seasonId, gameplayType, nowTime)
  return SeasonRotationCfgUtils.GetLeftTime(seasonId, gameplayType, nowTime) < DAY_SECONDS
end

function SeasonRotationCfgUtils.IsInMiddleSeason(seasonId, gameplayType, nowTime)
  local leftTime = SeasonRotationCfgUtils.GetLeftTime(seasonId, gameplayType, nowTime)
  return leftTime >= DAY_SECONDS and leftTime <= FAR_FROM_CLOSE_SECONDS
end

function SeasonRotationCfgUtils.IsFarFromClose(seasonId, gameplayType, nowTime)
  return SeasonRotationCfgUtils.GetLeftTime(seasonId, gameplayType, nowTime) > FAR_FROM_CLOSE_SECONDS
end

function SeasonRotationCfgUtils.GetLeftTimeText(seasonId, gameplayType, nowTime)
  local leftTime = SeasonRotationCfgUtils.GetLeftTime(seasonId, gameplayType, nowTime)
  do return _GetLeftTimeRawText end
  return _GetLeftTimeRawText, leftTime, nowTime
end

function SeasonRotationCfgUtils.GetLeftTimeTextColored(seasonId, gameplayType, nowTime)
  local leftTime = SeasonRotationCfgUtils.GetLeftTime(seasonId, gameplayType, nowTime)
  local rawText = SeasonRotationCfgUtils.GetLeftTimeText(seasonId, gameplayType, nowTime)
  if leftTime < DAY_SECONDS then
    do return _WrapColor, rawText end
    return _WrapColor, rawText, cd.TimeEndShowColor.Near
  elseif leftTime <= FAR_FROM_CLOSE_SECONDS then
    do return _WrapColor, rawText end
    return _WrapColor, rawText, cd.TimeEndShowColor.Middle
  end
  do return _WrapColor, rawText end
  return _WrapColor, rawText, cd.TimeEndShowColor.Far
end

function SeasonRotationCfgUtils.GetLeftTimeHourglassIcon(seasonId, gameplayType, nowTime)
  if SeasonRotationCfgUtils.IsNearClose(seasonId, gameplayType, nowTime) then
    return CommonRes.HourglassIcon.Near
  end
  if SeasonRotationCfgUtils.IsInMiddleSeason(seasonId, gameplayType, nowTime) then
    return CommonRes.HourglassIcon.Middle
  end
  return CommonRes.HourglassIcon.Far
end

function SeasonRotationCfgUtils.GetTaskList(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  return cfg and (cfg.SeasonTask or {}) or {}
end

function SeasonRotationCfgUtils.GetTaskCfgList(seasonId, gameplayType)
  local taskCfgList = {}
  for _, taskTid in ipairs(SeasonRotationCfgUtils.GetTaskList(seasonId, gameplayType) or {}) do
    local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskTid)
    if taskCfg then
      taskCfgList[#taskCfgList + 1] = taskCfg
    end
  end
  return taskCfgList
end

function SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
  local taskList = SeasonRotationCfgUtils.GetTaskList(seasonId, gameplayType)
  return taskList and taskList[1]
end

function SeasonRotationCfgUtils.GetSeasonRewardList(seasonId, gameplayType)
  local taskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
  if not taskTid then
    return {}
  end
  return TaskDataUtils.GetTaskCompleteAward(taskTid) or {}
end

function SeasonRotationCfgUtils.GetSeasonReward(seasonId, gameplayType)
  do return SeasonRotationCfgUtils.GetSeasonRewardList, seasonId end
  return SeasonRotationCfgUtils.GetSeasonRewardList, seasonId, gameplayType
end

function SeasonRotationCfgUtils.GetSeasonTaskDesc(seasonId, gameplayType)
  local taskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
  if not taskTid then
    return ""
  end
  do return TaskDataUtils.GetTaskProgressDesc end
  return TaskDataUtils.GetTaskProgressDesc, taskTid
end

function SeasonRotationCfgUtils.GetSeasonRankRewardGroupCfg(seasonGroupId, gameplayType)
  local seasonCfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonGroupId, gameplayType)
  if not seasonCfg or not seasonCfg.SeasonRankAward then
    return nil
  end
  return DT.SeasonRankReward[seasonCfg.SeasonRankAward]
end

function SeasonRotationCfgUtils.GetSeasonRankRewardRowByRankId(seasonGroupId, gameplayType, rankId)
  if not rankId or 0 == rankId then
    return nil
  end
  local groupCfg = SeasonRotationCfgUtils.GetSeasonRankRewardGroupCfg(seasonGroupId, gameplayType)
  if not groupCfg or not groupCfg.data_list then
    return nil
  end
  for _, row in ipairs(groupCfg.data_list) do
    if row.BaseSortID and row.BaseSortID == rankId then
      return row
    end
  end
  for idx, row in ipairs(groupCfg.data_list) do
    if idx == rankId then
      return row
    end
  end
  return nil
end

function SeasonRotationCfgUtils.GetSeasonRankRewardTierStrength(seasonGroupId, gameplayType, rankId)
  if not rankId or 0 == rankId then
    return 0
  end
  local groupCfg = SeasonRotationCfgUtils.GetSeasonRankRewardGroupCfg(seasonGroupId, gameplayType)
  if not groupCfg or not groupCfg.data_list then
    return 0
  end
  for idx, row in ipairs(groupCfg.data_list) do
    if row.BaseSortID and row.BaseSortID == rankId then
      return idx
    end
  end
  for idx, _ in ipairs(groupCfg.data_list) do
    if idx == rankId then
      return idx
    end
  end
  return 0
end

function SeasonRotationCfgUtils.GetSeasonStageGroupId(seasonId, gameplayType)
  local cfg = SeasonRotationCfgUtils.GetGameSeasonCfg(seasonId, gameplayType)
  if not (cfg and cfg.ExtraParam) or not cfg.ExtraParam[1] then
    return nil
  end
  do return tonumber end
  return tonumber, cfg.ExtraParam[1]
end

function SeasonRotationCfgUtils.GetCurrentRailWaySeasonId()
  local gameplayType = CommonDefine.SeasonGameplayType.ConsciousnessRailway
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
  if not seasonId or 0 == seasonId then
    return nil
  end
  return seasonId
end

function SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
  local gameplayType = CommonDefine.SeasonGameplayType.ConsciousnessRailway
  local seasonId = SeasonRotationModel.Instance:CalcSeasonIdByTime(gameplayType)
  if not seasonId or 0 == seasonId then
    return nil
  end
  return seasonId
end

function SeasonRotationCfgUtils.GetCurrentRailWayStageGroupId()
  local gameplayType = CommonDefine.SeasonGameplayType.ConsciousnessRailway
  local currentSeasonId = SeasonRotationCfgUtils.CalcCurrentRailWaySeasonId()
  if not currentSeasonId then
    return nil
  end
  do return SeasonRotationCfgUtils.GetSeasonStageGroupId, currentSeasonId end
  return SeasonRotationCfgUtils.GetSeasonStageGroupId, currentSeasonId, gameplayType
end

function SeasonRotationCfgUtils.isSeasonTaskDoneForGameplay(gameplayType)
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType)
  if not seasonId or 0 == seasonId then
    return false
  end
  local taskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
  if not taskTid or 0 == taskTid then
    return false
  end
  do return TaskDataUtils.IsTaskDoneByTaskId end
  return TaskDataUtils.IsTaskDoneByTaskId, taskTid
end

return SeasonRotationCfgUtils
