local ActivityKarenUtils = {}

function ActivityKarenUtils.GetSignTaskDataList(activityData)
  do return ActivityDataUtils.GetActivityTaskDataListByCompleteCond, activityData end
  return ActivityDataUtils.GetActivityTaskDataListByCompleteCond, activityData, TaskDefine.CompleteCond.TaskLoginDays
end

local notContainsCompleteCondList = {
  TaskDefine.CompleteCond.TaskLoginDays,
  TaskDefine.CompleteCond.ActivityStatCount
}

function ActivityKarenUtils.GetDailyTaskDataList(activityData)
  local rst = {}
  for tid, _ in pairs(activityData.taskList) do
    if not table.contains(notContainsCompleteCondList, TaskCfgUtils.GetCfgField("CompleteCond", tid)) then
      local taskData = TaskDataUtils.GetTaskData(tid)
      table.insert(rst, taskData)
    end
  end
  return rst
end

ActivityKarenUtils.taskTid2AvgTidDict = {}

function ActivityKarenUtils.GetTaskTid2AvgTidDict()
  if table.next(ActivityKarenUtils.taskTid2AvgTidDict) then
    return ActivityKarenUtils.taskTid2AvgTidDict
  end
  local targetConstantCfg = {
    DT.GetOriginalConstant("GoldenWeekTask1"),
    DT.GetOriginalConstant("GoldenWeekTask2"),
    DT.GetOriginalConstant("GoldenWeekTask3"),
    DT.GetOriginalConstant("GoldenWeekTask4"),
    DT.GetOriginalConstant("GoldenWeekTask5"),
    DT.GetOriginalConstant("GoldenWeekTask6"),
    DT.GetOriginalConstant("GoldenWeekTask7")
  }
  for _, cfgInfo in ipairs(targetConstantCfg) do
    ActivityKarenUtils.taskTid2AvgTidDict[cfgInfo[2]] = cfgInfo[1]
  end
  return ActivityKarenUtils.taskTid2AvgTidDict
end

function ActivityKarenUtils.GetAvgTidByTaskTid(taskTid)
  local dict = ActivityKarenUtils.GetTaskTid2AvgTidDict()
  return dict[taskTid]
end

function ActivityKarenUtils.GetTaskTidListWhenReceiveToPlayAvg()
  return {
    DT.GetOriginalConstant("GoldenWeekTask1")[2],
    DT.GetOriginalConstant("GoldenWeekTask2")[2],
    DT.GetOriginalConstant("GoldenWeekTask3")[2],
    DT.GetOriginalConstant("GoldenWeekTask4")[2],
    DT.GetOriginalConstant("GoldenWeekTask5")[2]
  }
end

function ActivityKarenUtils.GetTaskTidListWhenDoneToPlayAvg()
  return {
    DT.GetOriginalConstant("GoldenWeekTask6")[2],
    DT.GetOriginalConstant("GoldenWeekTask7")[2]
  }
end

function ActivityKarenUtils.OnKarenTaskToReceive(taskTid)
  local isActivityOpen = ActivityKarenUtils.CheckKarenCanInsertAvg()
  if not isActivityOpen then
    return
  end
  local targetTaskTidList = ActivityKarenUtils.GetTaskTidListWhenReceiveToPlayAvg()
  if not table.contains(targetTaskTidList, taskTid) then
    return
  end
  ActivityKarenUtils.AddAvgPopupQue(taskTid)
end

function ActivityKarenUtils.OnKarenTaskToDone(taskTid)
  local isActivityOpen = ActivityKarenUtils.CheckKarenCanInsertAvg()
  if not isActivityOpen then
    return
  end
  local targetTaskTidList = ActivityKarenUtils.GetTaskTidListWhenDoneToPlayAvg()
  if not table.contains(targetTaskTidList, taskTid) then
    return
  end
  ActivityKarenUtils.AddAvgPopupQue(taskTid)
end

function ActivityKarenUtils.AddAvgPopupQue(taskTid)
  local targetAvgTid = ActivityKarenUtils.GetAvgTidByTaskTid(taskTid)
  ActivityKarenUtils.AddFirstOpenPopupQue()
  ActivityKarenUtils.AddPassAnyStageTaskAvg()
  TimerManager.Instance:CreateTimer(0.5, 0, nil, function()
    PopupQueManager.Instance:InsertPopTutorialAvgInfo(targetAvgTid, tostring(taskTid))
  end)
end

function ActivityKarenUtils.AddFirstOpenPopupQue()
  local isActivityOpen = ActivityKarenUtils.CheckKarenCanInsertAvg()
  local isPlayed = AvgTutorialManager.Instance:CheckIsPlayed(CommonDefine.ClientDataMainKey.AVG, CommonDefine.AVGTutorialKeyWord.KarenActivityFirstOpen)
  if isActivityOpen and not isPlayed then
    local targetStoryTid = DT.GetConstant("GoldenWeekTask8")
    PopupQueManager.Instance:InsertPopTutorialAvgInfo(targetStoryTid, CommonDefine.AVGTutorialKeyWord.KarenActivityFirstOpen)
  end
end

function ActivityKarenUtils.AddPassAnyStageTaskAvg()
  local isActivityOpen = ActivityKarenUtils.CheckKarenCanInsertAvg()
  if not isActivityOpen then
    return
  end
  local targetPopInfo = DT.GetOriginalConstant("GoldenWeekTask2")
  local avgTid, taskTid = targetPopInfo[1], targetPopInfo[2]
  local isPlayed = AvgTutorialManager.Instance:CheckIsPlayed(CommonDefine.ClientDataMainKey.AVG, tostring(taskTid))
  if isPlayed then
    return
  end
  local taskData = TaskDataUtils.GetTaskData(taskTid)
  if taskData and taskData.state == CommonDefine.TaskState.Receive then
    PopupQueManager.Instance:InsertPopTutorialAvgInfo(avgTid, tostring(taskTid))
  end
end

function ActivityKarenUtils.CheckKarenCanInsertAvg()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Activity, 0)
  if not unlock then
    return false
  end
  do return ActivityManager.Instance.IsActivityOpenByType, ActivityManager.Instance end
  return ActivityManager.Instance.IsActivityOpenByType, ActivityManager.Instance, ActivityDefine.ActivityType.GoldenWeekActivity
end

return ActivityKarenUtils
