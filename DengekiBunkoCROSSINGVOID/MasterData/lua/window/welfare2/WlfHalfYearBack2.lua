local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local LU = require("Common/ListUtil")
local TU = require("Common/TaskUtil")
local DBH = require("Manager/DataBindingHandler")
local m_activityManager = S:Get("ActivityManager")
local m_activityId, m_processConfig, m_normalProcessConfig, m_buffProcessConfig, m_signinRewardConfig, m_backInfo, m_inited, m_taskList, m_processDisplayData

function Awake()
  WU.BindButtonEvent(REF.TabButtonMain, function()
    SetContentActive("Main")
  end)
  WU.BindButtonEvent(REF.TabButtonSignin, OnClickTabButtonSignin)
  WU.BindButtonEvent(REF.TabButtonTask, OnClickTabButtonTask)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "WlfHalfYearBack",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    WU.AcquireWindowAsync("Share")
  end)
  LU.Bind(REF.WrapContentTask, {
    updateRow = UpdateTaskSlot
  })
end

function OnEnable()
  SetContentActive("Main")
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.HalfYearBack)
  m_activityId = activities[1].activityId
  this:Bind("fci/half-year-back-activity/", OnActivityInfoChange)
end

function OnDisable()
  this:Unbind("fci/half-year-back-activity/", OnActivityInfoChange)
  this:Unbind("fci/playerBackTasks", OnTaskList)
end

function OnActivityInfoChange(acInfo)
  if acInfo == nil then
    return
  end
  m_backInfo = acInfo
  if not m_inited then
    m_processConfig = PB.all("PlayerBackProcess"):where(function(k, v)
      return v.activityId == m_activityId and acInfo.activeLevel >= v.levelMin and acInfo.activeLevel <= v.levelMax
    end):toarray()
    m_buffProcessConfig = m_processConfig:where(function(k, v)
      return v.isBuff
    end):toarray():sort(SortProcess)
    m_normalProcessConfig = m_processConfig:where(function(k, v)
      return not v.isBuff
    end):toarray():sort(SortProcess)
    m_signinRewardConfig = PB.all("ActivitySigninGift"):where(function(k, v)
      return v.activityId == m_activityId
    end):toarray():sort(function(a, b)
      return a.days < b.days
    end)
    for i = 0, #REF.NodeSignin - 1 do
      local reward = m_signinRewardConfig[i + 1].reward[1]
      REF.NodeSignin[i].WidgetIconSlot["$SetData"](reward.type, reward.id, reward.count)
      REF.NodeSignin[i].LabelDayNumber.UILabel.text = i + 1
    end
    for i = 0, #REF.GridReward - 1 do
      local ref = REF.GridReward[i]
      local config = m_normalProcessConfig[i + 1]
      local reward = config.reward[1]
      ref["$$SetData"](reward.type, reward.id)
      ref["@progress"] = config.progress
      ref["@index"] = i + 1
      ref["$$SetClickCallback"](OnClickTaskProcessReward)
    end
    for i = 0, #REF.GridProgress - 1 do
      local ref = REF.GridProgress[i]
      local config = m_normalProcessConfig[i + 1]
      ref.root.UIHtmlLabel.text = "<img src='Welfare_2.Back/backProgessIcon' width=30 height=30>" .. config.progress
    end
    m_processDisplayData = {}
    local percentage = 1 / (#REF.GridProgress - 1)
    for i = 1, #REF.GridReward - 1 do
      local config = m_normalProcessConfig[i]
      local nextConfig = m_normalProcessConfig[i + 1]
      local displayData = {
        progress = config.progress,
        position = (i - 1) / (#REF.GridReward - 1),
        percentage = nil
      }
      if nextConfig then
        displayData.unit = percentage / (nextConfig.progress - config.progress)
        table.insert(m_processDisplayData, displayData)
      end
    end
    m_inited = true
  end
  REF.LabelProgressComplete.UILabel.text = acInfo.completProgress
  local _, data = table.find(m_processDisplayData, function(k, v)
    return acInfo.completProgress >= v.progress and acInfo.reciveProgress < v.progress
  end)
  if data == nil then
    REF.ActivePointProgress.UIProgressBar.value = 0
  else
    REF.ActivePointProgress.UIProgressBar.value = data.position + (acInfo.completProgress - data.progress) * data.unit
  end
  for i = 0, #REF.NodeSignin - 1 do
    WU.SetActive(REF.NodeSignin[i].SpriteGot, i < acInfo.signStep)
    WU.SetActive(REF.NodeSignin[i].MaskGot, i < acInfo.signStep)
    local canReward = i == acInfo.signStep and not WU.IsToday(CS.GameTime.UtcToLocal(acInfo.lastSignTime))
    WU.SetActive(REF.NodeSignin[i].Effect, canReward)
    if canReward then
      REF.NodeSignin[i].Effect.transform.localScale = {
        x = 0.7,
        y = 0.7,
        z = 1
      }
    end
    REF.NodeSignin[i].IconItem.TweenScale.enabled = canReward
    local reward = m_signinRewardConfig[i + 1].reward[1]
    REF.NodeSignin[i].WidgetIconSlot["$SetClickCallback"](fif(canReward, OnClickSigninReward, function()
      WU.ShowResourceDetail(reward.type, reward.id)
    end))
  end
  for i = 0, #REF.GridReward - 1 do
    local ref = REF.GridReward[i]
    local config = m_normalProcessConfig[i + 1]
    ref["$$SetEffect"](config.progress > acInfo.reciveProgress and config.progress <= acInfo.completProgress)
    ref["$$SetGray"](config.progress <= acInfo.reciveProgress)
  end
  SetTimeView()
  SetBuffView()
end

function SortProcess(a, b)
  return a.progress < b.progress
end

function OnTaskList(taskList)
  if taskList == nil then
    WU.SetActive(REF.ScrollViewTaskHolder, false)
    WU.SetActive(REF.NodeEmpty, true)
    return
  end
  m_taskList = taskList
  local existTask = #m_taskList ~= 0
  WU.SetActive(REF.ScrollViewTaskHolder, existTask)
  WU.SetActive(REF.NodeEmpty, not existTask)
  LU.Set(REF.WrapContentTask, #m_taskList)
end

function SetContentActive(content)
  WU.SetActive(REF.NodeMain, content == "Main")
  WU.SetActive(REF.NodeSignin, content == "Signin")
  WU.SetActive(REF.NodeTask, content == "Task")
  REF.TabButtonMain.UISprite.spriteName = fif(content == "Main", "tab_button_3_s", "tab_button_3_n")
  REF.TabButtonSignin.UISprite.spriteName = fif(content == "Signin", "tab_button_3_s", "tab_button_3_n")
  REF.TabButtonTask.UISprite.spriteName = fif(content == "Task", "tab_button_3_s", "tab_button_3_n")
end

function SetBuffView()
  local reward
  if m_backInfo.profitId == 0 then
    reward = m_buffProcessConfig[1].reward[1]
  else
    for i = #m_buffProcessConfig, 1, -1 do
      if m_buffProcessConfig[i].progress <= m_backInfo.reciveProgress then
        reward = m_buffProcessConfig[i].reward[1]
        break
      end
    end
  end
  _ENV["$"](REF.NodeFinalReward).WidgetIconSlot["$SetData"](reward.type, reward.id)
end

function SetTimeView()
  local misc = PB.index("Misc", 1)
  local activeTime = CS.GameTime.UtcToLocal(m_backInfo.activeTime)
  local activeDay24 = CS.System.DateTime(activeTime.Year, activeTime.Month, activeTime.Day, 0, 0, 0):AddDays(misc.halfYearBackShowDay)
  local endDoTime = activeDay24:AddDays(misc.halfYearBackDuration)
  local lastTime = endDoTime - CS.GameTime.serverNow
  if endDoTime < CS.GameTime.serverNow then
    WU.SetActive(REF.LabelLastTime, false)
    return
  end
  local lastDay = lastTime.Days
  local lastHour = lastTime.Hours
  local lastMin = lastTime.Minutes
  local lastSecond = lastTime.Seconds
  if 0 < lastDay then
    REF.LabelLastTime.UILabel.text = WU.GetString("Welfare_LastTimeDay", lastDay, lastHour)
  elseif 0 < lastHour then
    REF.LabelLastTime.UILabel.text = WU.GetString("Welfare_LastTimeHour", lastHour, lastMin)
  else
    REF.LabelLastTime.UILabel.text = WU.GetString("Welfare_LastTimeMin", lastMin, lastSecond)
  end
end

function UpdateTaskSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_taskList == nil then
    return
  end
  if index > #m_taskList then
    return
  end
  local taskInfo = m_taskList[index]
  slotRef["$$SetView"](taskInfo, 2, {
    activePoint = PB.get("TaskInfo", taskInfo.id).halfYearBackPoint
  })
  slotRef["$$SetActivePointIcon"]("Back/backProgessIcon", "Welfare_2")
  slotRef.SpriteActivePoint.UISprite:MakePixelPerfect()
  slotRef.SpriteActivePoint.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
  slotRef["$$ToggleRemainTime"](false)
  slotRef["$$SetRewardClick"](OnTaskRewardClick)
end

function InShowTime()
  local misc = PB.index("Misc", 1)
  local showDay = misc.halfYearBackDuration + misc.halfYearBackShowDay
  local endTime = m_backInfo.activeTime + showDay * 86400
  return endTime > CS.GameTime.serverUtc
end

function OnTaskRewardClick(go)
  local ref = _ENV["$"](go)
  local taskInfo = ref["@taskInfo"]
  this:GameRequest("fci/task/" .. taskInfo.id .. "/half-year-back-activity/"):Post({}, function(resp)
    if resp then
      DBH.ResChange(resp.resChange)
      WU.ShowRewards(resp.resChange)
      local index, task = _ENV["!"](m_taskList):find(function(k, v)
        return v.id == taskInfo.id
      end)
      if task ~= nil then
        task.rewardGot = true
        table.sort(m_taskList, TU.Sort)
        this:SetData("fci/playerBackTasks", m_taskList)
      end
      m_backInfo.completProgress = resp.completProgress
      this:SetData("fci/half-year-back-activity/", m_backInfo)
    end
  end)
end

function OnClickSigninReward(go)
  this:GameRequest("fci/half-year-back-activity/sign/"):Post({}, function(resp)
    DBH.ResChange(resp.resChange)
    WU.ShowRewards(resp.resChange)
    m_backInfo.signStep = resp.signStep
    m_backInfo.lastSignTime = resp.lastSignTime
    m_backInfo.signAwardId = resp.signAwardId
    m_backInfo.lockSignAward = resp.lockSignAward
    this:SetData("fci/half-year-back-activity/", m_backInfo)
  end)
end

function OnClickTaskProcessReward(go)
  local ref = _ENV["$"](go)
  local progress = ref["@progress"]
  local configIdx = ref["@index"]
  local canReward = progress <= m_backInfo.completProgress and progress > m_backInfo.reciveProgress
  if canReward then
    this:GameRequest("fci/half-year-back-activity/progress"):Post({}, function(resp)
      DBH.ResChange(resp.resChange)
      WU.ShowRewards(resp.resChange)
      m_backInfo.completProgress = resp.completProgress
      m_backInfo.reciveProgress = resp.reciveProgress
      m_backInfo.profitId = resp.profitId
      this:SetData("fci/half-year-back-activity/", m_backInfo)
    end)
  else
    local rewardGot = progress <= m_backInfo.reciveProgress
    local title = WU.GetString("Window_HalfYearBack2_ActivePointRewardTitle")
    local buttonTitle = WU.GetString("Window_Back")
    local content = WU.GetString("Window_HalfYearBack2_ActivePointRewardDesc", m_backInfo.completProgress, progress)
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](m_normalProcessConfig[configIdx].reward, title, content, rewardGot, buttonTitle)
    end)
  end
end

function OnClickTabButtonTask()
  if not InShowTime() then
    WU.ShowHintText("Window_Activity_Close")
    return
  end
  SetContentActive("Task")
  this:Unbind("fci/playerBackTasks", OnTaskList)
  this:Bind("fci/playerBackTasks", OnTaskList)
end

function OnClickTabButtonSignin()
  if not InShowTime() then
    WU.ShowHintText(WU.GetString("Window_Activity_Close"))
    return
  end
  SetContentActive("Signin")
end
