local function createState()
  local state = {}
  
  state.taskTid = 0
  state.taskUid = 0
  state.currValue = 0
  state.maxValue = 0
  state.taskState = 0
  return state
end

local function createViews(_)
  local views = {}
  return views
end

local function createActions(data)
  local actions = {}
  
  function actions:RequestGainTaskReward()
    TaskDataUtils.TaskComplete(data.taskUid)
  end
  
  local function OnTaskInfoAdded(taskInfo)
    data:_RefreshTaskInfo(taskInfo)
  end
  
  local function OnTaskInfoUpdated(taskInfo)
    data:_RefreshTaskInfo(taskInfo)
  end
  
  function actions:ListeningTaskInfoEvent()
    EventMgr.Instance.TaskInfoAdded:RegisterEvent(OnTaskInfoAdded)
    EventMgr.Instance.TaskInfoUpdated:RegisterEvent(OnTaskInfoUpdated)
  end
  
  function actions:UnlisteningTaskInfoEvent()
    EventMgr.Instance.TaskInfoAdded:RemoveEvent(OnTaskInfoAdded)
    EventMgr.Instance.TaskInfoUpdated:RemoveEvent(OnTaskInfoUpdated)
  end
  
  function actions:_RefreshTaskInfo(taskInfo)
    local cfg = DT.Task[taskInfo.tid]
    if cfg.TaskType == CommonDefine.TaskType.TaskType_PVPWeekly then
      data.taskTid = taskInfo.tid
      data.taskUid = taskInfo.uid
      data.currValue = taskInfo.count
      data.maxValue = TaskDataUtils.GetTaskProgressLimit(taskInfo.tid)
      data.taskState = taskInfo.state
    end
  end
  
  return actions
end

local function onSetup(_, model)
  local taskInfoList = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.PVPWeekly)
  for _, taskInfo in pairs(taskInfoList) do
    model:_RefreshTaskInfo(taskInfo)
  end
end

local PVPTaskModel = Vue.model("PVPTaskModel", createState):views(createViews):actions(createActions):setup(onSetup)
return PVPTaskModel
