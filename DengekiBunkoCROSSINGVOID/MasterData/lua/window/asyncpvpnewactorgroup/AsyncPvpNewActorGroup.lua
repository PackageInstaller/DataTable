local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DU = require("Common/DungeonUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local m_members = {}
local m_selectedGroupId, m_groups, m_targetActor, m_opponent
local m_displayAttrs = false
local m_activityInfo

function SetupWindow()
  Base.SetupWindow()
  WU.BindButtonEvent(REF.ButtonFight, function()
    if not DU.IsWaitingForJob(OnFightClick) then
      OnFightClick()
    end
  end)
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnActorGroupChanged(m_groups)
  end)
  CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
    m_displayAttrs = CS.UIToggle.current.value
    RefreshAttrDisplay()
  end)
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUnInited)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
  local playerId = this:GetData("playerId")
  local record = WU.GetGameDataCache("AsyncPvpNewConfirmFightGroup" .. playerId)
  if record ~= true then
    WU.SetGameDataCache("AsyncPvpNewConfirmFightGroup" .. playerId, true)
  end
  m_activityInfo = this:GetData("AsyncPvpNew/ActivityInfo")
  Base.InitAutoFight(PB.enum.DungeonType.AsyncPvpNew)
  m_opponent = this:GetData("AsyncPvpNew/Opponent")
  m_displayAttrs = false
  RefreshAttrDisplay()
  REF.WidgetGroupMembers.UIPlayTween.enabled = false
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  this:BindRemote(DB:GameRequest(this:GetData("ActorGroup/SelectedGroupIdUri")), OnSelectedActorGroupId)
end

function UninitWindow()
  local nav = WU.FindWindow("Navigation")
  if nav ~= nil then
    _ENV["$"](nav)["$$Load"]()
  end
end

function OnWindowUnInited(window)
  if window.name == "AsyncPvpNewOpponents" then
    WU.RecycleWindow("AsyncPvpNewActorGroup")
  end
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("AsyncPvpNewActorGroup", "ActorGroup")
  end
end

function OnSelectedActorGroupId(result)
  if result ~= nil then
    m_selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    this:BindRemote(DB:GameRequest(this:GetData("ActorGroup/GroupUri")), OnActorGroupChanged)
  end
end

function OnActorGroupChanged(groups)
  if groups ~= nil and m_selectedGroupId ~= nil then
    m_groups = groups
    m_members = m_groups[tostring(m_selectedGroupId)].members
    REF.WidgetGroupMembers["$SetGroupMembers"](m_members)
    REF.WidgetGroupCultivation4Group["$SetGroupMembers"](m_members)
    Base.ModifyMemberShowOption()
    WU.ToggleRendering(REF.WidgetGroupMembers, true)
    REF.WidgetGroupMembers.UIPlayTween.enabled = true
  end
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("ActorSelect", function(window)
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.AsyncPvpNew)
  end)
end

function OnFightClick()
  if not m_members or m_members and not GU.GroupIsOK(m_members, true) then
    return
  end
  local data = this:GetData("AsyncPvpNew/BaseInfo")
  data.setAttachGroup = true
  this:SetData("AsyncPvpNew/BaseInfo", data)
  if IsInBalanceTime() then
    WU.ShowHintText(WU.GetString("NAsyncPvp_NoOperatingInBalance"))
    DB:DelayInvokeInSeconds(1.5, function()
      WU.RecycleWindow("AsyncPvpNewActorGroup")
    end)
  end
  local asyncPvpInfo = this:GetData("AsyncPvpNew/BaseInfo")
  if not asyncPvpInfo.setDefendGroup then
    WU.ShowHintText(WU.GetString("NAsyncPvp_NotSetGuard"))
    OnBackCallback()
    return
  end
  this:GameRequest("fci/resbuyprice/" .. m_activityInfo.activityId):Get(function(response)
    if response then
      local itemId = response.buy.id
      local ticket = this:GetData("fci/item/" .. itemId)
      local count = ticket and ticket.count
      if count <= 0 then
        WU.Exchange(PB.enum.ResourceType.ResItem, nil, true, itemId)
        return
      else
        this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
          EnterMatch()
        end)
      end
    end
  end)
end

function EnterMatch()
  WU.AcquireWindowAsync("AsyncPvpNewOpponents", function(window)
    _ENV["$"](window)["$$SetView"](true)
  end)
end

function RefreshAttrDisplay()
  REF.WidgetGroupMembers["$DisplayAttrs"](m_displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= m_displayAttrs then
    REF.ToggleAttrs.UIToggle.value = m_displayAttrs
  end
end

function Focus(on)
  if on and m_groups then
    REF.WidgetGroupMembers["$SetGroupMembers"](m_groups[tostring(m_selectedGroupId)].members)
    REF.WidgetGroupCultivation4Group["$SetGroupMembers"](m_groups[tostring(m_selectedGroupId)].members)
    Base.ModifyMemberShowOption()
  end
  if on then
    WU.SetWindowTitle("AsyncPvpNewActorGroup", "ActorGroup")
  end
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "AsyncPvpNewActorGroup" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function OnBackValidate(isHome)
  local setAttachGroup = m_members and GU.GroupIsOK(m_members, false)
  local data = this:GetData("AsyncPvpNew/BaseInfo")
  data.setAttachGroup = setAttachGroup
  this:SetData("AsyncPvpNew/BaseInfo", data)
  if isHome then
    local winName = "City"
    if WU.IsStandaloneGame() then
      winName = "StoryMode"
    end
    S:Get("TutorialManager").SetNavigation(winName)
    this:BroadcastGameEvent("OnNavigation", winName)
  else
    WU.RecycleWindow("AsyncPvpNewActorGroup")
  end
end

function IsInBalanceTime()
  local flag
  local now = CS.GameTime.serverNow
  local day = U.ToInt(now.DayOfWeek)
  local hour = U.ToInt(now.Hour)
  if day == 0 then
    day = 7
  end
  local config = PB.index("Misc", 1).asyncPvpV2Info
  if day == config.balanceWeekDay and hour >= config.balanceBeginHour and hour <= config.balanceEndHour - 1 then
    flag = true
  end
  return flag
end
