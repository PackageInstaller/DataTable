local TaskServerIndex = CommonDefine.TaskServerIndex
local taskTabNameMap = {
  [TaskServerIndex.Daily] = "BPTaskSubTabDaily",
  [TaskServerIndex.Weekly] = "BPTaskSubTabMonthly",
  [TaskServerIndex.Period] = "BPTaskSubTabPeriod"
}

local function createBattlePassTaskModelState(bpModel)
  local state = {}
  state.bpModel = bpModel
  state.curSelectTab = TaskServerIndex.Daily
  state.curTaskList = {}
  return state
end

local function createBattlePassTaskModelViews(_)
  local views = {}
  
  function views.GetTaskTabName(numPage)
    local rst = ""
    if numPage then
      rst = taskTabNameMap[numPage] or ""
    end
    return rst
  end
  
  function views.GetTaskTime(numPage)
    local rst = ""
    if numPage == TaskServerIndex.Weekly then
      local countDown = TimeCfgUtils.GetNextMonday()
      local d, h, m = TimeUtils.ConvertTime(countDown)
      if countDown >= 86400 then
        do return LT.Textf, "BattlePassLeftTimeMore", d end
        return LT.Textf, "BattlePassLeftTimeMore", d, h
      end
      do return LT.Textf, "BattlePassLeftTimeLess", h end
      return LT.Textf, "BattlePassLeftTimeLess", h, m
    elseif numPage == TaskServerIndex.Period then
      do return end
      return BattlePassDataUtils.GetEndCountDown, TimeUtils.ConvertTime(countDown)
    end
    return rst
  end
  
  function views.GetTaskState(numUid)
    local rst = CommonDefine.TaskState.Doing
    local taskData = TaskDataUtils.GetTaskData(numUid)
    if taskData and taskData.state then
      rst = taskData.state
    end
    return rst
  end
  
  function views.GetTaskCountDown(numUid)
    local taskData = TaskDataUtils.GetTaskData(numUid)
    local endTs = taskData.endTs
    if not endTs or endTs <= TimeUtils.GetServerTime() then
      return ""
    end
    local countDown = endTs - TimeUtils.GetServerTime()
    local d, h, m = TimeUtils.ConvertTime(countDown)
    if countDown >= 86400 then
      do return LT.Textf, "BattlePassLeftTimeMore", d end
      return LT.Textf, "BattlePassLeftTimeMore", d, h
    end
    do return LT.Textf, "BattlePassLeftTimeLess", h end
    return LT.Textf, "BattlePassLeftTimeLess", h, m
  end
  
  function views.GetTaskProgress(numUid)
    local taskCfg = TaskDataUtils.GetTaskConfigByUid(numUid)
    local count = TaskDataUtils.GetTaskData(numUid).count
    local taskProgressLimit = TaskDataUtils.GetTaskProgressLimit(taskCfg.ID)
    do return string.format, "%s/%s", count end
    return string.format, "%s/%s", count, taskProgressLimit
  end
  
  return views
end

local function createBattlePassTaskModelActions(data)
  local actions = {}
  
  function actions.SetCurSelectTab(numVal)
    if not numVal then
      Logger.Error("Error Input numVal", numVal)
      return
    end
    data.curSelectTab = numVal
    data.UpdateCurTaskList(numVal)
  end
  
  function actions.UpdateCurTaskList(numVal)
    if data.curSelectTab == numVal then
      local tmpList = TaskDataUtils.GetTaskDataListBySvrIdx(numVal)
      tmpList = TaskDataUtils.SortTasksData(tmpList)
      if numVal == CommonDefine.TaskServerIndex.Daily then
        tmpList = TaskDataUtils.RemoveJumpLockTasks(tmpList)
      end
      data.curTaskList = tmpList
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local BattlePassTaskModel = Vue.model("BattlePassTaskModel", createBattlePassTaskModelState):views(createBattlePassTaskModelViews):actions(createBattlePassTaskModelActions):setup(onSetup)
return BattlePassTaskModel
