local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local TU = require("Common/TaskUtil")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local m_activityManager = S:Get("ActivityManager")
local m_isInit = false
local m_activityInfo, m_activePointInfo, m_themeActivityTasks, m_ownActivePoint, m_activePointType, m_data
local _D = {
  [PB.enum.ActivePointType.Theme] = {
    taskPath = "fci/themeActivityTasks",
    taskIcon = "sports_02",
    APatlasPath = "Welfare",
    APglowEffectName = "UI_mission_Autumn",
    APgotSprite = "sports_01",
    APnormalSprite = "sports_02"
  },
  [PB.enum.ActivePointType.HalfYear] = {
    taskPath = "fci/halfYearActivityTasks",
    taskIcon = "garden_party_02",
    taskIconScale = CS.UnityEngine.Vector3(0.4, 0.4, 1),
    APatlasPath = "Welfare",
    APglowEffectName = "UI_NYguard",
    APgotSprite = "garden_party_01",
    APnormalSprite = "garden_party_02",
    labelOffset = CS.UnityEngine.Vector3(0, -83, 0)
  },
  [PB.enum.ActivePointType.NewYear] = {
    taskPath = "fci/newYearActivityTasks",
    taskIcon = "chinatown_02",
    taskIconScale = CS.UnityEngine.Vector3(0.4, 0.4, 1),
    APatlasPath = "Welfare",
    APglowEffectName = "UI_NYredpacket",
    APgotSprite = "chinatown_01",
    APnormalSprite = "chinatown_02",
    labelOffset = CS.UnityEngine.Vector3(0, -83, 0)
  },
  [PB.enum.ActivePointType.LabourDay] = {
    taskPath = "fci/labourDayActivityTasks",
    taskIcon = "fireworks_03",
    taskIconAtlas = "Welfare_2",
    taskIconScale = CS.UnityEngine.Vector3(0.32, 0.32, 1),
    APatlasPath = "Welfare_2",
    APglowEffectName = "UI_Mission_MidAutumn",
    APgotSprite = "fireworks_01",
    APnormalSprite = "fireworks_03",
    labelOffset = CS.UnityEngine.Vector3(0, -83, 0)
  }
}

function Awake()
  LU.Bind(REF.TaskWrapContent, {
    updateRow = UpdateTaskSlot
  })
  WU.TraverseChildren(REF.ActivePointGifts, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnActivePointRewardClick)
  end)
end

function OnEnable()
  WU.ToggleRendering(REF.TaskList, false)
  REF.ActivePointContent.gameObject:SetActive(false)
  this:Bind("WelfareTab", OnWlfTabChanage)
  this:DelayInvokeInFrames(1, function()
    m_isInit = true
    InitData()
  end)
end

function OnDisable()
  this:Unbind("WelfareTab", OnWlfTabChanage)
  this:Unbind("fci/task/extra-activepoint/", UpdateActivePoint)
  this:Unbind(m_data.taskPath, UpdateTaskList)
end

function OnWlfTabChanage(tab)
  if tab == nil then
    return
  end
  for _, type in pairs(PB.enum.ActivePointType) do
    if PB.enum.ActivePointType.__keys[type] == tab then
      m_activePointType = type
      if type then
        m_data = _D[type]
      end
      break
    end
  end
end

function InitData()
  m_activityInfo = m_activityManager.GetActivitySync(PB.enum.ActivityType.Theme, m_activePointType)
  UpdateBaseInfo()
  this:BindRemote(DB:GameRequest("fci/task/extra-activepoint/"), UpdateActivePoint)
  this:Bind(m_data.taskPath, UpdateTaskList)
  WU.SetGameDataCache("lastLoginTime" .. DB:GetData("playerId") .. "/" .. m_activePointType, CS.GameTime.serverUtc)
  local redMarkKey = "Welfare/" .. PB.enum.ActivePointType.__keys[m_activePointType]
  RU.SetRedMark("Welfare/" .. PB.enum.ActivePointType.__keys[m_activePointType] .. "/FirstLogin", false)
end

function UpdateBaseInfo()
  if m_activityInfo then
    local timeStart = ACU.RenderTime2(m_activityInfo.timestampStart, true)
    local timeEnd = ACU.RenderTime2(m_activityInfo.timestampClose, true)
    local t = WU.GetString("Window_TimeToTime", timeStart, timeEnd) .. "(" .. WU.GetString("Window_DailyRefresh", 6) .. ")"
    REF.LabelTime.UIHtmlLabel.text = t
  end
end

function UpdateActivePoint(data)
  if data == nil then
    return
  end
  m_activePointInfo = data.activePointInfos[m_activePointType]
  m_ownActivePoint = m_activePointInfo.extraActivePoint
  local maxPoint = m_activePointInfo.progress[#m_activePointInfo.progress].targetActivePoint
  REF.ActivePointProgress.UIProgressBar.value = m_ownActivePoint / maxPoint
  local giftCount = #m_activePointInfo.progress
  local progressWidth = REF.ActivePointProgress.UISprite.width
  for i = 1, #REF.ActivePointGifts do
    local giftRef = REF.ActivePointGifts[i - 1]
    local giftInfo = m_activePointInfo.progress[i]
    giftRef["$gameObject"]:SetActive(i <= giftCount)
    if i <= giftCount then
      local y = giftRef["$transform"].localPosition.y
      local x = giftInfo.targetActivePoint / maxPoint * progressWidth
      giftRef["$transform"].localPosition = {
        x = x,
        y = y,
        z = 1
      }
      SetActivePointView(giftRef, giftInfo, i)
    end
  end
  REF.ActivePointContent.gameObject:SetActive(true)
  local hasGift = false
  for i = 1, #m_activePointInfo.progress do
    if m_ownActivePoint >= m_activePointInfo.progress[i].targetActivePoint and not m_activePointInfo.progress[i].rewardGot then
      hasGift = true
      break
    end
  end
  RU.SetRedMark("Welfare/" .. PB.enum.ActivePointType.__keys[m_activePointType] .. "/ActivePoint", hasGift)
end

function SetActivePointView(ref, info, index)
  ref.Icon.UISprite.atlasPath = m_data.APatlasPath
  ref["@giftInfo"] = info
  ref["@index"] = index
  local canGetReward = m_ownActivePoint >= info.targetActivePoint and not info.rewardGot
  if canGetReward then
    ref.Glow.EffectGenerator.m_EffectName = m_data.APglowEffectName
  end
  ref.Glow.gameObject:SetActive(canGetReward)
  ref.Icon.gameObject:SetActive(not canGetReward)
  if info.rewardGot then
    ref["$UIButton"].normalSprite = m_data.APgotSprite
  else
    ref["$UIButton"].normalSprite = m_data.APnormalSprite
  end
  ref.Icon.UISprite:MakePixelPerfect()
  ref.Label.UILabel.text = info.targetActivePoint
  if m_data.labelOffset then
    ref.Label.transform.localPosition = m_data.labelOffset
  end
end

function OnActivePointRewardClick(go)
  local ref = _ENV["$"](go)
  local info = ref["@giftInfo"]
  if info == nil then
    return
  end
  local canGetReward = m_ownActivePoint >= info.targetActivePoint and not info.rewardGot
  if canGetReward then
    this:GameRequest("fci/task/extra-activepoint/reward/"):Post({
      extraActivePointType = m_activePointInfo.extraActivePointType,
      extraActivePoint = info.targetActivePoint
    }, function(result)
      DBH.ResChange(result.resChange)
      m_activePointInfo.progress[ref["@index"]].rewardGot = true
      this:SetData("fci/task/extra-activepoint/", this:GetData("fci/task/extra-activepoint/"))
      WU.ShowRewards(result.resChange)
    end)
  else
    local title = WU.GetString("Window_ActivePointRewardTitle")
    local buttonTitle
    local content = ""
    if info.rewardGot then
      buttonTitle = WU.GetString("WindowGacha_Close")
    else
      content = WU.GetString("TaskActivePointRewardPreview", m_ownActivePoint, info.targetActivePoint)
    end
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](info.reward, title, content, info.rewardGot, buttonTitle)
    end)
  end
end

function UpdateTaskList(data)
  if data == nil then
    LU.Set(REF.TaskWrapContent, 0)
    return
  end
  m_themeActivityTasks = data
  LU.Set(REF.TaskWrapContent, #m_themeActivityTasks)
  WU.ToggleRendering(REF.TaskList, true)
end

function UpdateTaskSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_themeActivityTasks == nil then
    return
  end
  if index > #m_themeActivityTasks then
    return
  end
  local taskInfo = m_themeActivityTasks[index]
  slotRef["$$SetView"](taskInfo, 2)
  slotRef["$$SetActivePointIcon"](m_data.taskIcon, m_data.taskIconAtlas)
  slotRef.SpriteActivePoint.UISprite:MakePixelPerfect()
  slotRef.SpriteActivePoint.transform.localScale = m_data.taskIconScale
  slotRef["$$ToggleRemainTime"](false)
  slotRef["$$SetRewardClick"](onTaskRewardClick)
end

function onTaskRewardClick(go)
  local ref = _ENV["$"](go)
  local taskInfo = ref["@taskInfo"]
  this:GameRequest("fci/task/" .. taskInfo.id .. "/reward/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    local index, task = _ENV["!"](m_themeActivityTasks):find(function(k, v)
      return v.id == taskInfo.id
    end)
    if task ~= nil then
      task.rewardGot = true
      table.sort(m_themeActivityTasks, TU.Sort)
      this:SetData(m_data.taskPath, m_themeActivityTasks)
    end
    m_activePointInfo.extraActivePoint = result.extraActivePoint
    this:SetData("fci/task/extra-activepoint/", this:GetData("fci/task/extra-activepoint/"))
  end)
end
