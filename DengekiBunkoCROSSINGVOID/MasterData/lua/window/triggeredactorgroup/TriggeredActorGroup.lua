local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local m_groups, m_selectedGroupId, m_dungeonId
local m_repeatedContext = {}
local m_reloadAura, m_replayTween

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnActorGroupChanged(m_groups)
  end)
  Base.SetData("Fight", Fight)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.Triggered)
  m_reloadAura = true
  this:Bind("TriggeredActorGroup/DungeonId", OnActorGroupDungeonId)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId})
  m_reloadAura = true
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("TriggeredActorGroup/DungeonId", context.dungeonId)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnActorGroupDungeonId(dungeonId)
  if dungeonId == nil then
    return
  end
  m_dungeonId = dungeonId
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  if not WU.IsStandaloneGame() and m_reloadAura then
    m_reloadAura = false
    Base.ResetAuraSelection()
  end
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward then
    REF.WidgetTicketLabel["$UpdateTickets"](dungeonReward.costWin[1])
  else
    warning("TriggeredActorGroup", "no dungeonReward for dungeonId " .. tostring(dungeonId))
  end
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/triggeredEvent"), OnSelectedActorGroupId)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function OnSelectedActorGroupId(result)
  if result then
    m_selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    this:Unbind("fci/ActorGroup/", OnActorGroupChanged)
    this:BindRemote(DB:GameRequest("fci/ActorGroup/"), OnActorGroupChanged)
  end
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("ActorSelect", function()
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Triggered)
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    m_groups = actorGroup
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.Member2FightActorInfo(members)
    Base.RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
  end
end

function Fight()
  local members = m_groups[tostring(m_selectedGroupId)].members
  if GU.GroupIsOK(members, true) then
    this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
      this:BroadcastGameEvent("MedalAttrAppend")
      local triggeredEvent = this:GetData("CurrentTriggeredEvent") or {}
      local param = {
        activityId = triggeredEvent.activityId,
        selectActorGroupId = m_selectedGroupId,
        eventKey = triggeredEvent.eventKey or 0,
        activityType = PB.enum.ActivityType.TriggeredEvent
      }
      Base.AppendAuraAttrs(param)
      this:SetData("BalanceInfo/Groups", {groups = m_groups, selectedGroupId = m_selectedGroupId})
      this:GameRequest("fci/triggered-dungeon/"):Post(param, function(result)
        DBH.ResChange(result.resChange)
        WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, PB.enum.DungeonType.Triggered, 1, true)
      end)
    end)
  end
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("TriggeredActorGroup", "ActorGroup")
  end
end
