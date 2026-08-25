local function createState()
  local state = {}
  
  function state.taskTid()
    return TaskData.dailyTaskTid
  end
  
  function state.taskUid()
    return TaskData.dailyTaskTid
  end
  
  function state.endTime()
    do return end
    return TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp, nil
  end
  
  function state.taskInfo()
    do return TaskDataUtils.GetTaskData end
    return TaskDataUtils.GetTaskData, TaskData.dailyTaskTid
  end
  
  function state.currValue()
    return state.taskInfo and state.taskInfo.count
  end
  
  function state.maxValue()
    do return TaskDataUtils.GetTaskProgressLimit end
    return TaskDataUtils.GetTaskProgressLimit, TaskData.dailyTaskTid
  end
  
  function state.taskState()
    return state.taskInfo and state.taskInfo.state
  end
  
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
  
  function actions:ListeningTaskInfoEvent()
  end
  
  function actions:UnlisteningTaskInfoEvent()
  end
  
  return actions
end

local function onSetup(_, _)
end

local DailyTaskModel = Vue.model("DailyTaskModel", createState):views(createViews):actions(createActions):setup(onSetup)
return DailyTaskModel
