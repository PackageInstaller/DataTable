local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local m_dungeonId, m_selectedGroupId, m_members, m_groups, m_cost
local m_displayAttrs = false

function SetupWindow()
  Base.SetupWindow()
  CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
    m_displayAttrs = CS.UIToggle.current.value
    if m_displayAttrs then
      WU.RecordButtonClick(100126211)
    else
      WU.RecordButtonClick(100126210)
    end
    RefreshAttrDisplay()
  end)
  WU.BindButtonEvent(REF.ButtonFight, function()
    if not DU.IsWaitingForJob(OnFightClick) then
      OnFightClick()
    end
  end)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorSlotClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnGetActorGroup(m_groups)
  end)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.RacePVP)
  this:Bind("fci/RacePvp/ActorGroup/", function(res)
    if res == nil then
      return
    end
    OnSetMembers(res)
  end)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  m_displayAttrs = false
  RefreshAttrDisplay()
  this:Bind("WindowDungeon/DungeonId", OnDungeonInit)
  this:BindRemote(DB:GameRequest(this:GetData("ActorGroup/SelectedGroupIdUri")), OnRefreshSelectedActorGroupId)
end

function OnDungeonInit(dungeonId)
  m_dungeonId = dungeonId
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward then
    m_cost = dungeonReward.cost[1]
    if m_cost ~= nil then
      REF.LabelCost.ResourcePrinter:SetResource(m_cost.type, m_cost.id, m_cost.count)
    end
  else
    warning("DungeonReward not found", dungeonId)
  end
end

function OnRefreshSelectedActorGroupId(result)
  if result ~= nil then
    m_selectedGroupId = tonumber(result.selectActorGroupId)
    if m_selectedGroupId == 0 then
      m_selectedGroupId = 1
      result.selectActorGroupId = 1
    end
    this:BindRemote(DB:GameRequest(this:GetData("ActorGroup/GroupUri")), OnGetActorGroup)
  end
end

function OnGetActorGroup(actorGroup)
  if actorGroup ~= nil and m_selectedGroupId ~= nil then
    m_groups = actorGroup
    UpdateGroupMembers()
  end
end

function OnActorSlotClick()
  WU.AcquireWindowAsync("ActorSelect", function()
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.RacePvp)
  end)
end

function OnFightClick()
  WU.RecordButtonClick(100126201)
  if not m_members or m_members and not GU.GroupIsOK(m_members, true) then
    return
  end
  WU.TryToPay(m_cost.type, m_cost.id, m_cost.count, GroupCheck)
end

function GroupCheck()
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
    EnterDungeon()
  end)
end

function EnterDungeon()
  local actorList = {}
  for _, member in pairs(m_members) do
    local actor
    if member.actorUid ~= 0 then
      actor = this:GetData("fci/actor/" .. member.actorUid)
    else
      actor = {}
    end
    actorList[member.index + 1] = actor
  end
  local fightActorInfo = {
    {
      playerId = this:GetData("playerId"),
      actors = actorList
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  this:SetData("FightAgainInfo", fightActorInfo)
  local param = {dungeonId = m_dungeonId, selectActorGroupId = m_selectedGroupId}
  this:GameRequest("fci/racepvp-dungeon/"):Post(param, function(response)
    DBH.ResChange(response.resChange)
    this:BroadcastGameEvent("MedalAttrAppend")
    WU.EnterGameLevel(response.dungeonUid, response.baseInfo, m_dungeonId, PB.enum.DungeonType.RacePVP, 1, false)
  end)
end

function UpdateGroupMembers()
  if m_groups ~= nil then
    m_members = m_groups[tostring(m_selectedGroupId)].members
    REF.WidgetGroupMembers["$SetGroupMembers"](m_members)
    if REF.WidgetGroupCultivation then
      REF.WidgetGroupCultivation["$SetGroupMembers"](m_members)
    elseif REF.WidgetGroupCultivation4Group then
      REF.WidgetGroupCultivation4Group["$SetGroupMembers"](m_members)
    end
    Base.ModifyMemberShowOption()
    WU.ToggleRendering(REF.WidgetGroupMembers, true)
  end
end

function RefreshAttrDisplay()
  REF.WidgetGroupMembers["$DisplayAttrs"](m_displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= m_displayAttrs then
    REF.ToggleAttrs.UIToggle.value = m_displayAttrs
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001262, on)
end
