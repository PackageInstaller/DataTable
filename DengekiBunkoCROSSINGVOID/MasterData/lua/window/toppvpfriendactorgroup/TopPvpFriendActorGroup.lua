local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local TPU = require("Common/TopPvpUtil")
local S = require("Common/Singleton")
local m_groups
local m_selectedGroupId = 1
local m_replayTween
local groupUrl = "fci/friendpvp/match/"
local m_count = 0
local m_invoke, m_isEnterFight
local m_startTime = 0
local m_data, m_timeOut, m_quit, m_isMatched, m_heart, m_needClose

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnActorGroupChanged(m_groups)
  end)
  WU.BindButtonEvent(REF.ButtonFight, Ready)
  m_needClose = false
end

function InitWindow()
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  m_isEnterFight = false
  m_isTimeOut = false
  m_quit = false
  m_isMatched = false
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  this:RegisterGameEvent("OnRoomMatchedNotify", function()
    m_isMatched = true
  end)
  this:RegisterGameEvent("DealFriendFightRes", function(res)
    if res.resultCode ~= 0 then
      ForceClose(true)
    end
  end)
  local data = this:GetData(groupUrl)
  if data == nil then
    this:GameRequest(groupUrl):Get(function(data)
      local groups = {}
      groups["1"] = data
      this:SetData(groupUrl, groups)
    end)
  end
  this:Bind(groupUrl, OnActorGroupChanged)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
  local timeOut = PB.all("Misc"):first().friendPvpConf.readyTimeOut
  m_startTime = 0
  REF.LabelCount.gameObject:SetActive(false)
  REF.ButtonFight.UISprite.graify = false
  if m_invoke then
    this:StopCoroutine(m_invoke)
    m_invoke = nil
  end
  m_invoke = this:RepeatInvokeInSeconds(1, function()
    if m_startTime ~= 0 then
      local startTime = m_startTime + timeOut
      REF.LabelCount.gameObject:SetActive(true)
      local count = startTime - CS.GameTime.serverUtc
      m_count = count
      REF.LabelCount.UILabel.text = tostring(count)
      if count <= 0 then
        if m_invoke then
          this:StopCoroutine(m_invoke)
          m_invoke = nil
        end
        TimeOut()
      end
    end
  end)
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
  local nav = WU.FindWindow("Navigation")
  if nav then
    _ENV["$"](nav)["$$Save"]()
    _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
    _ENV["$"](nav)["$$SetHomeCallback"](Home)
  end
end

function Home()
  if m_isEnterFight then
    return
  end
  SendQuit(true)
end

function OnWindowInited(window)
  if window.name == "Navigation" then
    local nav = window
    _ENV["$"](nav)["$$Save"]()
    _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
    _ENV["$"](nav)["$$SetHomeCallback"](Home)
  end
end

function SendHeart()
  if m_data == nil or m_isMatched or m_needClose then
    return
  end
  this:GameRequest("fci/friendpvp/heartbeat/"):SyncInput(false):Post({
    roomUid = m_data.roomUid
  }, function(res)
    if res.isOver then
      ForceClose(true)
    end
  end, function()
    this:DelayInvokeInSeconds(1, function()
      ForceClose()
    end)
    return true
  end)
end

function OnBackCallback()
  if m_isEnterFight then
    return
  end
  local top = WU.TopWindow()
  if top and top.name == "TopPvpFriendActorGroup" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function SendQuit(isHome)
  if not m_quit then
    this:GameRequest("fci/friendpvp/cancel/" .. m_data.roomUid):Delete(function(res)
      m_quit = true
      if isHome then
        local winName = "City"
        if WU.IsStandaloneGame() then
          winName = "StoryMode"
        end
        S:Get("TutorialManager").SetNavigation(winName)
        this:BroadcastGameEvent("OnNavigation", winName)
      else
        ForceClose()
      end
    end)
  end
end

function OnBackValidate()
  if m_data == nil or m_isEnterFight then
    return
  end
  SendQuit()
end

function GetCount()
  return m_count
end

function DisableInteractive()
  m_isEnterFight = true
  REF.ButtonFight.UISprite.graify = true
end

function TimeOut()
  DisableInteractive()
  this:GameRequest("fci/friendpvp/timeover/"):Post({
    roomUid = m_data.roomUid
  }, function(res)
    if res.leftTime > 0 then
      if m_timeOut then
        this:StopCoroutine(m_timeOut)
        m_timeOut = nil
      end
      local leftTime = res.leftTime
      m_timeOut = this:RepeatInvokeInSeconds(1, function()
        leftTime = leftTime - 1
        if leftTime <= 0 then
          TimeOut()
        end
      end)
    end
  end, function(res)
    if res.notify.code ~= "Error_FriendPvpRoomNotFound" then
      TimeOutCloseWindow()
      return false
    else
      return true
    end
  end)
end

function CloseImpl()
  m_needClose = true
  local top = WU.TopWindow()
  if top and top.name == "TopPvpFriendActorSelect" then
    _ENV["$"](top)["$$OnBackValidate"](nil, true)
    this:DelayInvokeInFrames(1, function()
      WU.RecycleWindow(this)
    end)
  elseif top.name == "TopPvpFriendActorGroup" then
    WU.RecycleWindow(this)
  end
end

function TimeOutCloseWindow()
  CloseImpl()
end

function ForceClose(showTips)
  if showTips then
    WU.ShowHintText(WU.GetString("TopPvpJoin_Tips67"))
  end
  CloseImpl()
end

function Ready()
  if m_isEnterFight then
    return
  end
  local members = m_groups[tostring(m_selectedGroupId)].members
  if not GU.GroupIsOK(members, true) then
    return false
  end
  DisableInteractive()
  local selectedGroupId = Base.GetData("selectedGroupId")
  this:GameRequest("fci/friendpvp/match/"):Put({
    groupInfo = m_groups[tostring(m_selectedGroupId)]
  }, function(response)
    TPU.EnterFriendPvpReady(m_data.roomUid)
  end)
end

function SetPlayerInfo(info)
  if info == nil then
    return
  end
  local temp = {}
  temp.playerInfo = info
  REF.WidgetPlayerName["$SetData"](temp)
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](info)
  REF.LabelLv.UILabel.text = "Lv." .. info.level
end

function UninitWindow()
  m_needClose = false
  this:SetData("equipMinRequireLevelPosMap", nil)
  local nav = WU.FindWindow("Navigation")
  if nav ~= nil then
    _ENV["$"](nav)["$$Load"]()
  end
end

function SetStartTime(time)
  m_startTime = time
end

function OnActorGroupButtonClick(go)
  if m_isEnterFight then
    return
  end
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("TopPvpFriendActorSelect", function()
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.FriendPvp)
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil and not m_isEnterFight then
    m_groups = actorGroup
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
  end
end

function SetData(data)
  m_data = data
  SetStartTime(data.startTime)
  if m_heart then
    this:StopCoroutine(m_heart)
    m_heart = nil
  end
  local heartTime = PB.all("Misc"):first().friendPvpConf.heartBeatTime
  m_heart = this:RepeatInvokeInSeconds(heartTime, function()
    SendHeart()
  end)
end

function CheckNeedClose()
  if m_needClose then
    CloseImpl()
  end
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("TopPvpFriendActorGroup", "ActorGroup")
    if m_needClose then
      this:DelayInvokeInFrames(1, function()
        CloseImpl()
      end)
    end
  else
    local nav = WU.FindWindow("Navigation")
    if nav ~= nil then
      _ENV["$"](nav)["$$Load"]()
    end
  end
end
