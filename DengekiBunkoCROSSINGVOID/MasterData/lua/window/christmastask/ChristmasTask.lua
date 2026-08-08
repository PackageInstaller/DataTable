local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local TU = require("Common/TaskUtil")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local m_setDailyNew, m_setWeeklyNew, m_WeekTaskEndTime
local m_TaskCategory = {
  PB.enum.TaskCategory.ChristmasDaily,
  PB.enum.TaskCategory.ChristmasWeekly
}
local m_category, m_taskLists, m_ownActivePoint, m_allActivePointRewardRef
local m_specialActivity = false
local m_specialIndex, m_specialIconOpen, m_specialIconClose, m_specialIconEffect

function SetupWindow()
  for i = 1, #m_TaskCategory do
    local tab = _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. i]
    tab["$SetTab"](WU.GetString("Window_Task" .. (PB.enum.TaskCategory.__keys[m_TaskCategory[i]] or "")), "Lobby", "mission/mission_icon_" .. i, false)
    tab["$SetClickCallback"](function()
      SwitchTaskCategory(i)
    end)
  end
  WU.ToggleRendering(REF.ScrollView, false)
end

function InitWindow()
  m_taskLists = {}
  m_setDailyNew = false
  m_setWeeklyNew = false
  WU.ToggleRendering(REF.ScrollView, false)
  SwitchTaskCategory(1)
  LU.Bind(REF.WrapContent, {
    updateRow = OnTaskItemShow
  })
  this:Bind("fci/christmasDailyTasks", function(list)
    OnTasksChange(PB.enum.TaskCategory.ChristmasDaily, list)
  end)
  this:Bind("fci/christmasWeeklyTasks", function(list)
    OnTasksChange(PB.enum.TaskCategory.ChristmasWeekly, list)
  end)
  for i = 1, #m_TaskCategory do
    RU.BindRedMark(this, "Welfare/Christmas/Task/" .. m_TaskCategory[i], function(flag)
      _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. i]["$SetNew"](flag)
    end)
  end
end

function UpdateWindow()
  local showRemainTime = m_category == PB.enum.TaskCategory.ChristmasWeekly
  local list = m_taskLists[m_category]
  if not showRemainTime or list == nil or #list == 0 or m_WeekTaskEndTime == nil or m_WeekTaskEndTime == 0 then
    WU.SetActive(REF.NodeRemainTime, false)
    return
  end
  local remain = m_WeekTaskEndTime - CS.GameTime.serverUtc
  if remain < 0 then
    m_WeekTaskEndTime = GetWeekTaskEndTime()
    WU.SetActive(REF.NodeRemainTime, false)
    return
  end
  WU.SetActive(REF.NodeRemainTime, true)
  REF.LabelRemainTime.UIHtmlLabel.text = WU.RenderCountDownTime(remain, REF.LabelRemainTime.UIHtmlLabel.fontSize)
end

function SwitchTaskCategory(index)
  if m_TaskCategory[index] == m_category then
    return
  end
  m_category = m_TaskCategory[index]
  SetListView()
  RU.SetRedMark("Welfare/Christmas/Task/" .. m_category .. "/New", false)
  _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. index].UIToggle.value = true
  REF.WrapContent.UIPlayTween:Play(true)
end

function SetListView()
  if m_category == nil or m_taskLists == nil then
    return
  end
  local list = m_taskLists[m_category]
  if list == nil then
    list = {}
  end
  LU.Set(REF.WrapContent, #list)
  REF.TaskEmpty.gameObject:SetActive(#list == 0)
  WU.ToggleRendering(REF.ScrollView, true)
  local showRemainTime = m_category == PB.enum.TaskCategory.ChristmasWeekly
  REF.NodeRemainTime.gameObject:SetActive(false)
end

function OnTasksChange(category, list)
  if category == PB.enum.TaskCategory.ChristmasDaily and m_setDailyNew == false then
    m_setDailyNew = true
    TU.TaskSetNewByTime(category, list)
  end
  if category == PB.enum.TaskCategory.ChristmasWeekly and m_setWeeklyNew == false then
    m_setWeeklyNew = true
    TU.TaskSetNewByTime(category, list)
    m_WeekTaskEndTime = GetWeekTaskEndTime()
  end
  if m_category == category then
    RU.SetRedMark("Welfare/Christmas/Task/" .. m_category .. "/New", false)
  end
  m_taskLists[category] = list
  local canReward = TU.TaskCanReward(list)
  RU.SetRedMark("Welfare/Christmas/Task/" .. category .. "/Reward", canReward)
  if m_category == category then
    SetListView()
  end
end

function OnTaskItemShow(goRef, wrapIndex, realIndex)
  local taskList = m_taskLists[m_category]
  if taskList and realIndex < #taskList then
    local taskInfo = taskList[realIndex + 1]
    goRef["$$SetView"](taskInfo)
    goRef["$$SetRewardClick"](OnTaskRewardClick)
  end
end

function OnTaskRewardClick(go)
  local taskInfo = _ENV["$"](go)["@taskInfo"]
  this:GameRequest("fci/task/" .. taskInfo.id .. "/reward/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    local path = fif(m_category == PB.enum.TaskCategory.ChristmasDaily, "fci/christmasDailyTasks", "fci/christmasWeeklyTasks")
    local taskList = this:GetData(path)
    local index, task = _ENV["!"](taskList):find(function(k, v)
      return v.id == taskInfo.id
    end)
    if task ~= nil then
      task.rewardGot = true
      table.remove(taskList, index)
      table.insert(taskList, task)
      this:SetData(path, taskList)
    end
  end)
end

function GetWeekTaskEndTime()
  local activity = AM.GetActivitySync(PB.enum.ActivityType.Task, 11016)
  if activity and ACU.IsOpenForDoing(activity) then
    return activity.timestampEnd
  end
  activity = AM.GetActivitySync(PB.enum.ActivityType.Task, 11017)
  if activity and ACU.IsOpenForDoing(activity) then
    return activity.timestampEnd
  end
  activity = AM.GetActivitySync(PB.enum.ActivityType.Task, 11018)
  if activity and ACU.IsOpenForDoing(activity) then
    return activity.timestampEnd
  end
  return 0
end
