local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local m_activityInfo, m_tenCheckinInfo, m_rewardList
local m_dayCount = 10
local m_isInit, m_changeSlot

function Start()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateDayRow
  })
  WU.TraverseChildren(REF.WrapContent, function(go)
    WU.BindButtonEvent(_ENV["$"](go).SlotState, OnReceiveClick)
  end)
end

function OnEnable()
  WU.ToggleRendering(REF.TenCheckinWidget, false)
  this:DelayInvokeInFrames(1, function()
    m_isInit = true
    InitData()
  end)
end

function InitData()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.TenCheckin, function(activityList)
    if activityList then
      m_activityInfo = activityList[1]
    else
      m_activityInfo = nil
    end
  end)
  local detail = this:GetData("fci/activity-signin")
  if detail == nil then
    this:GameRequest("fci/activity-signin"):Get(function(res)
      res.GetDay = CS.GameTime.serverNow.Day
      this:SetData("fci/activity-signin", res)
      this:Bind("fci/activity-signin", OnActivityInfoChange)
    end)
  else
    this:Bind("fci/activity-signin", OnActivityInfoChange)
  end
end

function OnActivityInfoChange(res)
  if res == nil then
    return
  end
  UpdateUI(res)
  ChangeRedStatus(res)
end

function UpdateUI(res)
  if res == nil or m_activityInfo == nil then
    return
  end
  m_tenCheckinInfo = res
  if m_isInit then
    m_isInit = false
    m_rewardList = {}
    for i = 1, m_dayCount do
      local reward = PB.get("ActivitySigninGift", i, res.activityId)
      table.insert(m_rewardList, reward)
    end
    local timeStart = ACU.RenderTime2(m_activityInfo.timestampStart, true)
    local timeEnd = ACU.RenderTime2(m_activityInfo.timestampClose, true)
    local t = WU.GetString("WindowTenCheckin_Time", timeStart, timeEnd)
    REF.LabelTime.UIHtmlLabel.text = t
  end
  if m_changeSlot then
    m_changeSlot["@state"] = false
    m_changeSlot.ButtonGet.gameObject:SetActive(false)
    m_changeSlot.SpriteGot.gameObject:SetActive(true)
    m_changeSlot = nil
  else
    local row = math.ceil(#m_rewardList)
    LU.Set(REF.WrapContent, row)
    local index = res.day - 1
    local itemHeight = REF.WrapContent.UIWrapContent.itemSize
    local m_moveDistance = index * itemHeight
    REF.ScrollViewReward.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    REF.ScrollViewReward.UIScrollView:RestrictWithinBounds(true)
    WU.ToggleRendering(REF.TenCheckinWidget, true)
  end
end

function UpdateDayRow(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_rewardList and index <= #m_rewardList then
    local rewards = m_rewardList[index].reward
    local daytime = tostring(m_rewardList[index].days)
    slotRef.LabelDay.UIHtmlLabel.text = daytime
    for i = 1, #slotRef.Grid do
      if i <= #rewards then
        slotRef.Grid[i - 1]["$gameObject"]:SetActive(true)
        slotRef.Grid[i - 1]["@data"] = rewards[i]
        local count = rewards[i].countDelta
        if count == 0 then
          count = rewards[i].count or 0
        end
        slotRef.Grid[i - 1]["$$SetData"](rewards[i].type, rewards[i].id, count)
        slotRef.Grid[i - 1]["$$SetOwnerBox"](rewards[i].ownerBoxId)
        slotRef.Grid[i - 1]["$$SetClickCallback"](OnRewardClick)
      else
        slotRef.Grid[i - 1]["$gameObject"]:SetActive(false)
      end
    end
    slotRef.ButtonGet.gameObject:SetActive(index == m_tenCheckinInfo.day and m_tenCheckinInfo.signed == false)
    if slotRef.ButtonGet.gameObject.activeSelf then
      slotRef.EffectBox.UIPlayTween:Play(true)
    end
    slotRef.SpriteWillGet.gameObject:SetActive(index > m_tenCheckinInfo.day)
    slotRef.SpriteGot.gameObject:SetActive(index < m_tenCheckinInfo.day or index == m_tenCheckinInfo.day and m_tenCheckinInfo.signed)
    _ENV["$"](slotRef.SlotState)["@state"] = index == m_tenCheckinInfo.day and m_tenCheckinInfo.signed == false
    _ENV["$"](slotRef.SlotState)["@index"] = index
  end
end

function OnRewardClick(go)
  local type = _ENV["$"](go)["@data"].type
  local id = _ENV["$"](go)["@data"].id
  WU.ShowResourceDetail(type, id, false)
end

function OnReceiveClick(go)
  if not _ENV["$"](go)["@state"] then
    return
  end
  local index = _ENV["$"](go)["@index"]
  this:GameRequest("fci/activity-signin/" .. m_tenCheckinInfo.activityId):Post(nil, function(res)
    local t = res
    if res then
      DBH.ResChange(res.resChange)
      WU.ShowRewards(res.resChange)
      m_tenCheckinInfo.signed = true
      m_changeSlot = _ENV["$"](go)
      this:SetData("fci/activity-signin", m_tenCheckinInfo)
    end
  end)
end

function ChangeRedStatus(res)
  RU.SetRedMark("Welfare/TenCheckin", not res.signed)
end
