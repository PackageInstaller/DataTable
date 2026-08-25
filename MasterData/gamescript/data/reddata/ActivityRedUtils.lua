local RedType = RedTypeDefine.RedType
local ActivityRedUtils = {}

function ActivityRedUtils.UpdateActivityRed(data)
  if not data then
    return
  end
  for activityTid, activityData in pairs(data) do
    if activityData then
      local config = DT.Activity[activityTid]
      if not config or 0 == config.ActivityDisplay then
      else
      end
    end
  end
end

function ActivityRedUtils.CheckRedValid(data)
  if not (data and data.base and data.base.tid) or data.base.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if not ActivityDataUtils.CheckActivityDataCondition(data) then
    return
  end
  return true
end

function ActivityRedUtils.IsActivityNew(args)
  local serverRedData = RedPointDataUtils.GetRedPointState(RedType.ActivityServer, args)
  if args and args[1] and not ActivityRedUtils.CheckActiveDisplay(args[1]) then
    return false
  end
  if serverRedData then
    return "isNew" == serverRedData
  end
end

function ActivityRedUtils.GetDailyRewardRed(activityTid)
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  if not ActivityDataUtils.IsActivityOpen(activityTid) then
    return false
  end
  local taskUid = activityConfig.ActivityPara2
  local taskState = TaskDataUtils.IsCanGetRward(taskUid)
  return taskState
end

function ActivityRedUtils.GetPreOrderClientRed(activityTid)
  local taskList = ActivityDataUtils.GetPreOrderCanGetTaskList(activityTid)
  return #taskList > 0 and RedPointDataUtils.RedAttrType.Red or false
end

function ActivityRedUtils.GetRailWayActivityRed(activityTid)
  local activityData = ActivityManager.Instance:GetActivityData(activityTid)
  if not activityData then
    return false
  end
  local taskList = activityData.taskList
  for tid, _ in pairs(taskList) do
    local taskData = TaskDataUtils.GetTaskData(tid)
    if taskData.state == CommonDefine.TaskState.Receive then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  do return end
  return RedPointDataUtils.IsRailWayEntryRed, pairs(taskList)
end

function ActivityRedUtils.GetBattlePassActivityRed(activityTid)
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  local cfg = ActivityDataUtils.GetConfig(activityTid)
  local normalTaskList = cfg.ActivityPara1
  for _, taskId in ipairs(normalTaskList) do
    if TaskDataUtils.IsTaskCanReward(taskId) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  if activityData.isUnlockExtraTask then
    local extraTaskList = string.split(cfg.ActivityPara2, ",")
    for _, taskId in ipairs(extraTaskList) do
      if TaskDataUtils.IsTaskCanReward(tonumber(taskId)) then
        return RedPointDataUtils.RedAttrType.Red
      end
    end
  end
  return false
end

function ActivityRedUtils.CheckActiveDisplay(activityTid)
  if not activityTid then
    return false
  end
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return false
  end
  if 0 == config.ActivityDisplay then
    return false
  end
  if config.WhereShow == ActivityDefine.WhereShow.GamePassport then
    return false
  end
  return true
end

function ActivityRedUtils.IsTaskUnlocked(activityTid, taskTid)
  local actCfg = ActivityDataUtils.GetConfig(activityTid)
  local actData = ActivityDataUtils.GetActivityData(activityTid) or {}
  if not actCfg or not actData then
    return false
  end
  if actCfg.ActivitySystemType == "BattlePassActivity" and not actData.isUnlockExtraTask and string.find(actCfg.ActivityPara2 or "", tostring(taskTid), 1, true) then
    return false
  end
  return true
end

return ActivityRedUtils
