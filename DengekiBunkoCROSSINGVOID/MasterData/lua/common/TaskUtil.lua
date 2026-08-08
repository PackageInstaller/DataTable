local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local U = require("Common/Util")
local TU = {}
TU.TaskCategoryCount = 8
local m_disabledCategory = _ENV["!"]({})
local m_specialTaskPath = {
  [PB.enum.TaskCategory.Present] = "fci/presentTasks",
  [PB.enum.TaskCategory.Theme] = "fci/themeActivityTasks",
  [PB.enum.TaskCategory.HalfYear] = "fci/halfYearActivityTasks",
  [PB.enum.TaskCategory.NewYear] = "fci/newYearActivityTasks",
  [PB.enum.TaskCategory.LabourDay] = "fci/labourDayActivityTasks",
  [PB.enum.TaskCategory.Scene] = "fci/sceneTasks",
  [PB.enum.TaskCategory.ActorCultivation] = "fci/actorCultivationTasks",
  [PB.enum.TaskCategory.ChristmasDaily] = "fci/christmasDailyTasks",
  [PB.enum.TaskCategory.ChristmasWeekly] = "fci/christmasWeeklyTasks",
  [PB.enum.TaskCategory.CustomActorCultivation] = "fci/customActorCultivationTasks",
  [PB.enum.TaskCategory.PlayerBack] = "fci/playerBackTasks",
  [PB.enum.TaskCategory.Warmup] = "fci/warmupTasks",
  [PB.enum.TaskCategory.WarmupDaily] = "fci/warmupDailyTasks"
}

function TU.InitData(pushData)
  GetActivePointList(pushData)
  m_disabledCategory = _ENV["!"](pushData.disableCategory)
  local categorizedTasks, specialCategorizedTasks = Categorize(pushData)
  TU.CheckTaskReward(categorizedTasks)
  DB:SetData("fci/task/", categorizedTasks)
  DB:SetData("task/taskTargetDone", pushData.taskTargetDone)
  DB:SetData("task/taskWeekInfo", pushData.taskWeekInfo)
  RU.SetRedMark("Task/" .. PB.enum.TaskCategory.Week .. "/WeekDoneCountReward", TU.WeekDoneCountCanReward())
  for category, path in pairs(m_specialTaskPath) do
    local taskList = specialCategorizedTasks[category]
    if taskList then
      if category == PB.enum.TaskCategory.ChristmasDaily or category == PB.enum.TaskCategory.ChristmasWeekly then
        local canReward = TU.TaskCanReward(taskList)
        RU.SetRedMark("Welfare/Christmas/Task/" .. category .. "/Reward", canReward)
        local hasNew = TU.TaskHasNewByTime(category, taskList)
        RU.SetRedMark("Welfare/Christmas/Task/" .. category .. "/New", hasNew)
      end
      if category == PB.enum.TaskCategory.PlayerBack then
        local canReward = TU.TaskCanReward(taskList)
        RU.SetRedMark("Welfare/HalfYearBack/Task/" .. category .. "/Reward", canReward)
      end
    end
    DB:SetData(path, taskList)
  end
end

function Categorize(pushData)
  local data = PB.all("TaskInfo")
  if pushData.tasks ~= nil then
    for i, t in pairs(pushData.tasks) do
      t.timeout = false
      if t.res == nil or table.empty(t.res) or t.res.id == 0 then
        t.res = PB.get("TaskInfo", t.id)
        if t.res == nil then
          warning("Task", "no id:" .. t.id .. " in TaskInfo.xlsx")
          pushData.tasks[i] = nil
        end
      end
    end
  end
  local categorizedTasks = {}
  
  local function insert(task)
    if categorizedTasks[task.res.category] == nil then
      categorizedTasks[task.res.category] = {}
    end
    table.insert(categorizedTasks[task.res.category], task)
  end
  
  if pushData.clearAll then
    categorizedTasks = {}
    if pushData.tasks ~= nil then
      for _, task in pairs(pushData.tasks) do
        insert(task)
      end
    end
  else
    categorizedTasks = DB:GetData("fci/task/") or {}
    for category, path in pairs(m_specialTaskPath) do
      categorizedTasks[category] = DB:GetData(path)
    end
    if pushData.tasks ~= nil then
      for _, t in pairs(pushData.tasks) do
        local task, index
        for _, taskList in pairs(categorizedTasks) do
          index, task = _ENV["!"](taskList):find(function(k, v)
            return v.id == t.id
          end)
          if task ~= nil then
            taskList[index] = t
            break
          end
        end
        if task == nil then
          insert(t)
        end
      end
    end
    if pushData.delTasks ~= nil then
      for _, id in pairs(pushData.delTasks) do
        for _, taskList in pairs(categorizedTasks) do
          local i, d = _ENV["!"](taskList):find(function(k, v)
            return v.id == id
          end)
          if d ~= nil then
            table.remove(taskList, i)
            break
          end
        end
      end
    end
  end
  CheckWeekFakeTask(categorizedTasks)
  for _, taskList in pairs(categorizedTasks) do
    table.sort(taskList, TU.Sort)
  end
  local specialCategorizedTasks = {}
  for category, path in pairs(m_specialTaskPath) do
    specialCategorizedTasks[category] = categorizedTasks[category]
    categorizedTasks[category] = nil
  end
  return categorizedTasks, specialCategorizedTasks
end

function GetActivePointList(pushData)
  local activePointList = DB:GetData("fci/task/activepoint/")
  if activePointList == nil then
    activePointList = {}
    activePointList.progress = {}
    local taskActivePointReward = PB.all("TaskActivePointReward")
    for i = 1, taskActivePointReward:count() do
      local info = taskActivePointReward[i]
      info.rewardGot = false
      table.insert(activePointList.progress, info)
    end
  end
  activePointList.activePoint = pushData.activePoint
  if activePointList.activePoint == nil then
    activePointList.activePoint = 0
  end
  if pushData.activePointRewardGot ~= nil then
    for _, p in pairs(activePointList.progress) do
      p.rewardGot = _ENV["!"](pushData.activePointRewardGot):has(p.targetActivePoint)
    end
  end
  RU.SetRedMark("Task/" .. PB.enum.TaskCategory.Routine .. "/ActivePoint", TU.ActivePointCanReward(activePointList))
  DB:SetData("fci/task/activepoint/", activePointList)
end

function CheckWeekFakeTask(allTask)
  local weekList = allTask[PB.enum.TaskCategory.Week]
  if weekList ~= nil then
    local i, t
    local notDoneCount = 0
    for k, v in pairs(weekList) do
      if v.id == -1 then
        i = k
        t = v
      elseif not v.rewardGot then
        notDoneCount = notDoneCount + 1
      end
    end
    if t == nil and notDoneCount < 7 then
      local fakeTask = {
        id = -1,
        res = {},
        rewardGot = false,
        isDone = false
      }
      fakeTask.res.taskQuality = 0
      fakeTask.res.priority = 0
      table.insert(weekList, fakeTask)
    elseif t ~= nil and notDoneCount == 7 then
      table.remove(weekList, i)
    end
  end
end

function TU.Sort(a, b)
  if a.rewardGot ~= b.rewardGot then
    return b.rewardGot
  elseif a.isDone ~= b.isDone then
    return a.isDone
  elseif a.dailyRefresh ~= nil and b.dailyRefresh ~= nil and a.dailyRefresh ~= b.dailyRefresh then
    return a.dailyRefresh
  elseif a.actorCultivationVipOnly ~= nil and b.actorCultivationVipOnly ~= nil and a.actorCultivationVipOnly ~= b.actorCultivationVipOnly then
    return b.actorCultivationVipOnly
  elseif a.res.taskQuality ~= b.res.taskQuality then
    return a.res.taskQuality > b.res.taskQuality
  elseif a.res.priority ~= b.res.priority then
    return a.res.priority > b.res.priority
  else
    return a.id > b.id
  end
end

function IsTaskCategoryLocked(category)
  local isLocked = true
  if category == PB.enum.TaskCategory.Routine then
    isLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.TaskRoutine)
  elseif category == PB.enum.TaskCategory.Main then
    isLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.TaskMain)
  elseif category == PB.enum.TaskCategory.Deadline then
    isLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.TaskDeadline)
  elseif category == PB.enum.TaskCategory.Repeat then
    isLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.TaskRepeat)
  elseif category == PB.enum.TaskCategory.Favour then
    isLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.TaskFavour)
  elseif category == PB.enum.TaskCategory.Week then
    isLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.TaskWeek)
  end
  return isLocked
end

function CheckCategory()
  if DB:GetData("fci/baseinfo") == nil then
    return _ENV["!"]({})
  end
  local activeCategories = _ENV["!"]({})
  for category = 1, TU.TaskCategoryCount do
    if not IsTaskCategoryLocked(category) and not m_disabledCategory:has(category) then
      table.insert(activeCategories, category)
    end
  end
  DB:SetData("task/activeCategories", activeCategories)
  return activeCategories
end

function TU.CheckTaskTime(categorizedTasks)
  if categorizedTasks == nil then
    return
  end
  local changed = false
  for category = 1, TU.TaskCategoryCount do
    local taskList = categorizedTasks[category]
    if taskList then
      for i, task in pairs(taskList) do
        if task.id > 0 and task.endTime ~= 0 and 0 >= task.endTime - CS.GameTime.serverUtc then
          table.remove(taskList, i)
          changed = true
          break
        end
      end
    end
  end
  local timeoutTasks = {}
  for category = 1, TU.TaskCategoryCount do
    local taskList = categorizedTasks[category]
    if taskList then
      for i, task in pairs(taskList) do
        local old = task.timeout
        if task.id > 0 and task.res.goalType == PB.enum.TaskType.OnlineFromP0toP1 and not task.timeout then
          local hour = CS.GameTime.serverNow.Hour
          if hour == 0 then
            hour = 24
          end
          task.timeout = task.isDone and hour < task.res.taskParam[1] or hour >= task.res.taskParam[2]
          if old ~= task.timeout then
            changed = true
            if timeoutTasks[category] == nil then
              timeoutTasks[category] = {}
            end
            table.insert(timeoutTasks[category], task)
          end
        end
      end
    end
  end
  for category, taskList in pairs(timeoutTasks) do
    local list = _ENV["!"](categorizedTasks[category])
    for _, task in pairs(taskList) do
      local index, t = list:find(function(k, v)
        return v.id == task.id
      end)
      table.remove(list, index)
      table.insert(list, t)
    end
  end
  if changed then
    DB:SetData("fci/task/", categorizedTasks)
    TU.CheckTaskReward(categorizedTasks)
  end
end

function TU.CheckTaskReward(categorizedTasks)
  local activeCategories = CheckCategory()
  if categorizedTasks == nil then
    return
  end
  for mode = 1, TU.TaskCategoryCount do
    if activeCategories:has(mode) and categorizedTasks[mode] then
      local canReward = TU.TaskCanReward(categorizedTasks[mode])
      RU.SetRedMark("Task/" .. mode .. "/Reward", canReward)
      if mode == PB.enum.TaskCategory.Deadline or mode == PB.enum.TaskCategory.Week then
        local isNew = TU.TaskHasNew(mode, categorizedTasks[mode])
        RU.SetRedMark("Task/" .. mode .. "/New", isNew)
      end
    end
  end
end

function TU.TaskCanReward(taskList)
  if taskList == nil then
    return false
  end
  local canReward = false
  for i = 1, #taskList do
    local task = taskList[i]
    if task.id > 0 and task.isDone and not task.rewardGot and not task.timeout then
      canReward = true
      break
    end
  end
  return canReward
end

function TU.ActivePointCanReward(activePointList)
  local ownActivePoint = activePointList.activePoint
  for i = 1, #activePointList.progress do
    local canGetReward = ownActivePoint >= activePointList.progress[i].targetActivePoint and not activePointList.progress[i].rewardGot
    if canGetReward then
      return canGetReward
    end
  end
  return false
end

function TU.WeekDoneCountCanReward()
  local weekInfo = DB:GetData("task/taskWeekInfo")
  local rewardInfo = PB.index("Misc", 1).taskWeekStepReward
  for _, v in pairs(rewardInfo) do
    if not weekInfo.rewardGotRecord[v.step] and weekInfo.taskDoneCount >= v.step then
      return true
    end
  end
  return false
end

function TU.WeeklyActivePointCanReward(info)
  local allData = PB.all("WeekActivePointReward")
  for _, data in pairs(allData) do
    local _, got = table.find(info.rewardGot, function(k, v)
      return v == data.activePoint
    end)
    if got == nil and data.activePoint <= info.weekActivePoint then
      return true
    end
  end
  return false
end

function TU.ClearNewFlag(taskList)
  for _, t in pairs(taskList) do
    t.isNew = false
  end
end

function TU.TaskHasNew(taskCategory, taskList)
  if taskList == nil or table.empty(taskList) then
    return false
  end
  local all = DB:GetData("gameDataCache").newTasks or {}
  local cacheList = all[tostring(taskCategory)] or {}
  if table.empty(cacheList) then
    return true
  end
  local hasNew = false
  for i = 1, #taskList do
    local task = taskList[i]
    if task.id > 0 and cacheList[tostring(task.id)] == nil then
      hasNew = true
      task.isNew = true
    end
  end
  return hasNew
end

function TU.TaskSetNew(taskCategory, taskList)
  if taskList == nil then
    return
  end
  local DB = CS.DataBindingManager.Instance
  local gameDataCache = DB:GetData("gameDataCache")
  gameDataCache.newTasks = gameDataCache.newTasks or {}
  gameDataCache.newTasks[tostring(taskCategory)] = gameDataCache.newTasks[tostring(taskCategory)] or {}
  for i = 1, #taskList do
    local task = taskList[i]
    if task.id > 0 then
      gameDataCache.newTasks[tostring(taskCategory)][tostring(task.id)] = false
    end
  end
  if taskCategory == PB.enum.TaskCategory.Week then
    local list = gameDataCache.newTasks[tostring(taskCategory)]
    for k, v in pairs(list) do
      local i, t = _ENV["!"](taskList):find(function(__, n)
        return tostring(n.id) == k
      end)
      if t == nil then
        list[k] = nil
      end
    end
  end
  DB:SetData("gameDataCache", gameDataCache)
end

function TU.TaskHasNewByTime(taskCategory, taskList)
  if taskList == nil then
    return false
  end
  local DB = CS.DataBindingManager.Instance
  local newDeadline = false
  local gameDataCache = DB:GetData("gameDataCache")
  local hasNew = false
  for i = 1, #taskList do
    if gameDataCache.newTasksByTime == nil or gameDataCache.newTasksByTime[tostring(taskCategory)] == nil then
      hasNew = true
      break
    end
    local task = taskList[i]
    if gameDataCache.newTasksByTime[tostring(taskCategory)][tostring(task.id)] == nil then
      hasNew = true
      break
    end
    if gameDataCache.newTasksByTime[tostring(taskCategory)][tostring(task.id)] ~= task.endTime then
      hasNew = true
      break
    end
  end
  if hasNew and gameDataCache.newTasksByTime then
    gameDataCache.newTasksByTime[tostring(taskCategory)] = nil
    DB:SetData("gameDataCache", gameDataCache)
    TU.TaskSetNew(taskCategory, taskList)
  end
  return hasNew
end

function TU.TaskSetNewByTime(taskCategory, taskList)
  if taskList == nil then
    return
  end
  local DB = CS.DataBindingManager.Instance
  local gameDataCache = DB:GetData("gameDataCache")
  gameDataCache.newTasksByTime = gameDataCache.newTasksByTime or {}
  gameDataCache.newTasksByTime[tostring(taskCategory)] = gameDataCache.newTasksByTime[tostring(taskCategory)] or {}
  for i = 1, #taskList do
    local task = taskList[i]
    gameDataCache.newTasksByTime[tostring(taskCategory)][tostring(task.id)] = task.endTime
  end
  DB:SetData("gameDataCache", gameDataCache)
end

function TU.TaskFirstCheck(taskTargetDone)
  local tableTaskDone = DB:GetData("task/taskTargetDone")
  if not table.has(tableTaskDone, taskTargetDone) then
    table.insert(tableTaskDone, taskTargetDone)
    DB:GameRequest("fci/task/target-done-add/"):Post({targetId = taskTargetDone})
  end
end

function TU.GetParamLocalizationText(param, goalType)
  if param[1] ~= nil and (goalType == PB.enum.TaskType.BalanceP0DungeonMTimes or goalType == PB.enum.TaskType.BalanceP0DungeonMTimesP1Star or goalType == PB.enum.TaskType.BalanceP0DungeonMTimesActorPN or goalType == PB.enum.TaskType.BalanceP0GoldMTimes) then
    if param[1] == 0 then
      return WU.GetString("Task_AnyDugeon")
    else
      return WU.GetString("DungeonName_" .. param[1])
    end
  end
  return table.unpack(param)
end

function TU.GetTaskListByActivityId(TaskList, activityId)
  if TaskList == nil then
    return
  end
  local resList = {}
  for _, v in pairs(TaskList) do
    if v.actorCultivationActivityId == activityId then
      table.insert(resList, v)
    end
  end
  return resList
end

function TU.GetParam(task)
  local param = task.res.taskParam
  if param[1] ~= nil and (task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimes or task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimesP1Star or task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimesActorPN or task.res.goalType == PB.enum.TaskType.BalanceP0GoldMTimes) then
    if param[1] == 0 then
      return WU.GetString("Task_AnyDugeon")
    else
      return WU.GetString("DungeonName_" .. param[1])
    end
  end
  local p = {}
  for i = 1, #param do
    table.insert(p, HU.ApplyFontColor(param[i], "#0199E9"))
  end
  return table.unpack(p)
end

return TU
