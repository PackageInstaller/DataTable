local ExcelBoolType = CommonDefine.ExcelBoolType
local TaskState = CommonDefine.TaskState
local AchievementSubTaskType = CommonDefine.AchievementSubTaskType
local AchievementTrophyType = CommonDefine.AchievementTrophyType
local taskShowStateGroup = {
  TaskState.Receive,
  TaskState.Done
}
local taskTabGroup = DT.GetOriginalConstant("AchieveTabSort")

local function IsTaskShow(taskCfg, state)
  if 0 == ExcelBoolType[taskCfg.AchieveNotDisplay] then
    return true
  end
  if table.contains(taskShowStateGroup, state) then
    return true
  end
  return false
end

local function createHomeAchievementPanelState()
  local state = {}
  state.curTaskType = taskTabGroup and taskTabGroup[1] or AchievementSubTaskType.Exploration
  state.toggleTypeGroup = taskTabGroup
  
  function state.curTaskTypeCompleteNum()
    local rst = 0
    for _, taskData in pairs(state.achievementTaskMap[state.curTaskType]) do
      if taskData.state == TaskState.Done then
        rst = rst + 1
      end
    end
    return rst
  end
  
  function state.curTaskTypeTotolNum()
    local rst = 0
    for _, taskData in pairs(state.achievementTaskMap[state.curTaskType]) do
      local taskCfg = DT.Task[taskData.tid]
      if IsTaskShow(taskCfg, taskData.state) then
        rst = rst + 1
      end
    end
    return rst
  end
  
  state.achievementTaskMap = {
    [AchievementSubTaskType.All] = {},
    [AchievementSubTaskType.Growth] = {},
    [AchievementSubTaskType.Exploration] = {},
    [AchievementSubTaskType.Battle] = {},
    [AchievementSubTaskType.Other] = {}
  }
  
  function state.showTaskGroup()
    local rst = table.clone(state.achievementTaskMap[state.curTaskType])
    for i = #rst, 1, -1 do
      local taskData = rst[i]
      local taskCfg = DT.Task[taskData.tid]
      if 1 == ExcelBoolType[taskCfg.AchieveNotDisplay] and not table.contains(taskShowStateGroup, taskData.state) then
        table.remove(rst, i)
      end
    end
    do return TaskDataUtils.SortTasksData end
    return TaskDataUtils.SortTasksData, rst, -1, nil, rst[i], DT.Task[taskData.tid], table.remove, rst, i
  end
  
  function state.showTrophyNumGroup()
    local rst = {
      [AchievementTrophyType.Gold] = 0,
      [AchievementTrophyType.Silver] = 0,
      [AchievementTrophyType.Bronze] = 0
    }
    local allAchievementTask = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Achivement)
    for _, taskData in pairs(allAchievementTask) do
      local taskCfg = DT.Task[taskData.tid]
      if not taskCfg.AchieveQuality then
      elseif taskData.state == TaskState.Done then
        rst[taskCfg.AchieveQuality] = rst[taskCfg.AchieveQuality] + 1
      end
    end
    return rst
  end
  
  return state
end

local function createHomeAchievementPanelViews(data)
  local views = {}
  
  function views.GetCurTaskType()
    return data.curTaskType
  end
  
  return views
end

local function createHomeAchievementPanelActions(data)
  local actions = {}
  
  function actions.SetCurTaskType(val)
    if not val then
      Logger.Error("error val")
      return
    end
    data.curTaskType = val
  end
  
  function actions.UpdateAchievementShow(type)
    local allAchievementTask = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Achivement)
    data.achievementTaskMap = {
      [AchievementSubTaskType.All] = {},
      [AchievementSubTaskType.Growth] = {},
      [AchievementSubTaskType.Exploration] = {},
      [AchievementSubTaskType.Battle] = {},
      [AchievementSubTaskType.Other] = {}
    }
    for _, taskData in pairs(allAchievementTask) do
      local taskCfg = DT.Task[taskData.tid]
      if not taskCfg.AchieveType then
      else
        table.insert(data.achievementTaskMap[taskCfg.AchieveType], taskData)
        table.insert(data.achievementTaskMap[AchievementSubTaskType.All], taskData)
      end
    end
  end
  
  return actions
end

local function onSetup(_, model)
  model.UpdateAchievementShow()
end

local HomeAchievementPanelModel = Vue.model("HomeAchievementPanelModel", createHomeAchievementPanelState):views(createHomeAchievementPanelViews):actions(createHomeAchievementPanelActions):setup(onSetup)
return HomeAchievementPanelModel
