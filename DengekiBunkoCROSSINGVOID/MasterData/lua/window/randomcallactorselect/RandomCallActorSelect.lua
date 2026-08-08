local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local SDU = require("Common/SoundUtil")
local WidgetGroupMembers = REF.WidgetGroupMembers
local m_displayActorTable, m_initWindow
local m_repeatedContext = {}
local m_selectedActors = {}
local m_members, m_mode
local m_select = 1
local m_group = 2
local m_allActors = {}

function SetupWindow()
  Base.SetupWindow()
  CustomizeWidgetGroup()
  WidgetGroupMembers["$ClearClickCallback"]()
  WidgetGroupMembers["$SetClickCallback"](OnSlotClick)
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirmGroup()
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
  Base.SetData("OnGroupSlotChangeCancel", SlotChangeCancel)
  Base.SetData("GroupSlotChangeSuccCallb", SlotChangeSuccCallb)
  Base.SetData("GroupMemberslegalCheck", LegalCheck)
  Base.SetData("GetMembers", function(groups)
    return groups
  end)
  Base.SetData("SetMembers", function(groups, patchData)
    m_members = patchData.members
    Base.SetData("groups", m_members)
    return true
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirm)
end

function InitWindow()
  m_initWindow = true
  Base.InitWindow()
  m_allActors = this:GetData("RandomCall/Actors")
  this:Bind("RandomCall/ActorGroup", OnActorGroupChanged)
  this:Bind("RandomCall/ActorGroup/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("RandomCall/ActorGroup/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list)
    end
  end)
  InitOpponents()
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.FightService, "ScLoadStartNtf", OnLoadStart)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.FightService, "ScConfirmGroupRsp", OnConfirmResponse)
end

function UninitWindow()
  Base.UninitWindow()
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    local groups = _ENV["!"]({})
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    m_members = groups
    WU.ToggleRendering(REF.Panel, true)
    REF.WidgetGroupMembers["$SetRandomCallMembers"](m_members)
    if m_initWindow then
      Base.ClearAllSelect()
      REF["$Animator"]:Play("DelayOpen", -1, 0)
    end
    OnActorClassify()
    SetMode(m_group)
    m_initWindow = false
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    local currentActor
    local currentActorUid = Base.GetData("currentActorUid")
    if currentActorUid ~= nil then
      currentActor = GetActor(currentActorUid)
    end
    rowRef["$$SetActorCustom"](actor)
    rowRef["$$SetClickCallback"](OnActorHeadClick)
    rowRef["$$SetHoldCallback"](function()
      OnActorHeadHold(actor)
    end)
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
    rowRef["@uid"] = actor.uid
    rowRef["$$ShowCustom"]({showSpeed = true})
  end
end

function OnActorHeadClick(go)
  local ref = _ENV["$"](go)
  local actorUid = ref["@uid"]
  if actorUid == nil then
    info("Actor", "actorUid nil?")
    return
  end
  local currentActorUid = Base.GetData("currentActorUid")
  local slotIndex = Base.GetData("slotIndex")
  if currentActorUid == actorUid then
    return
  end
  ClearAllSelect()
  local eventData = {
    index = slotIndex,
    card = GetActor(currentActorUid or 0),
    cardS = GetActor(actorUid)
  }
  WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, Base.GetData("OnGroupSlotChangeCancel"))
  Base.SetData("currentActorUid", actorUid)
end

function OnActorHeadHold(actor)
  WU.ShowActorPeek(actor)
end

function RefreshWrapContent(displayMode)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](displayMode):copy(m_displayActorTable)
  Base.RemoveActorsInGroup(m_displayActorTable)
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function OnSlotClick(go)
  local ref = _ENV["$"](go)
  local index = ref["@index"]
  Base.SetData("slotIndex", index)
  ClearAllSelect()
  ref.WidgetActorCard["$SetHighlighted"](true)
  Base.SetData("linksActorId", WidgetGroupMembers["$GetLinksActorIdByIndex"](index, m_allActors))
  Base.SetData("currentActorUid", ref["@uid"])
  WU.ToggleRendering(REF.Remove, ref["@actor"])
  local actorType = fif(GU.IsMainIndex(index), PB.enum.ActorType.Main, PB.enum.ActorType.Sub)
  Base.SetData("resetActorSelect", actorType ~= Base.GetData("actorType"))
  Base.SetData("actorType", actorType)
  SetMode(m_select)
  if actorType == PB.enum.ActorType.Main then
    RefreshWrapContent(DB:GetData("RandomCall/ActorGroup/MainActors/"))
  else
    RefreshWrapContent(DB:GetData("RandomCall/ActorGroup/SubActors/"))
  end
end

function OnActorClassify()
  local actors = this:GetData("RandomCall/Actors")
  local main = {}
  local sub = {}
  if actors ~= nil then
    for i = 1, #actors do
      if actors[i].kind == PB.enum.ActorType.Main then
        table.insert(main, actors[i])
      elseif actors[i].kind == PB.enum.ActorType.Sub then
        table.insert(sub, actors[i])
      end
    end
  end
  DB:SetData("RandomCall/ActorGroup/MainActors/", main)
  DB:SetData("RandomCall/ActorGroup/SubActors/", sub)
  return main, sub
end

function SetMode(mode)
  m_mode = mode
  REF.NodeGroup.gameObject:SetActive(m_mode == m_group)
  REF.NodeSelect.gameObject:SetActive(m_mode == m_select)
end

function GetActor(uid)
  local _, ac = table.find(m_allActors, function(k, v)
    return v.uid == uid
  end)
  return ac
end

function SlotChangeCancel()
  if Base.GetData("slotIndex") then
    local go = WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex"))
    OnSlotClick(go)
  end
end

function SlotChangeSuccCallb()
  local go = WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex"))
  if go then
    local ref = _ENV["$"](go)
    if ref["@actor"] ~= nil then
      if Base.GetData("currentActorID") then
        SDU.StopActorAdded(Data.currentActorID)
        Base.SetData("currentActorID", ref["@actor"].id)
      end
      SDU.PlayActorAdded(ref["@actor"].id)
    end
  end
  OnSlotClick(go)
end

function OnConfirmGroup(isHome)
  local groups = Base.GetData("groups")
  this:SetData("RandomCall/ActorGroup", groups)
  SetMode(m_group)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "MazeActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function Home()
  local winName = "City"
  if WU.IsStandaloneGame() then
    winName = "StoryMode"
  end
  S:Get("TutorialManager").SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function OnBackValidate(isHome)
end

function Focus(on)
  if on then
  end
  SetMode(m_group)
end

function CustomizeWidgetGroup()
  REF.WidgetGroupMembers.transform.localScale = CS.UnityEngine.Vector3(0.85, 0.85, 1)
  REF.Grid.UIGrid.cellWidth = 548
  for i = 1, 3 do
    local root = _ENV["$"](REF["TweenNode" .. i])
    local pos = REF["TweenNode" .. i].transform.localPosition
    root.WidgetActorCardEffectMain.transform.localScale = CS.UnityEngine.Vector3(0.85, 0.85, 1)
    root.WidgetActorCardEffectSub.transform.localScale = CS.UnityEngine.Vector3(0.85, 0.85, 1)
    root.Attrs.UISprite.height = 350
  end
end

function OnConfirm()
  local idxs = {}
  for i = 1, 6 do
    if m_members[i] then
      if m_members[i].actorUid ~= 0 then
        table.insert(idxs, m_members[i].actorUid)
      else
        WU.ShowHintText("Actors not Legal")
      end
    else
      WU.ShowHintText("Actors not Legal")
    end
  end
  warning("Client Send Confirm Info : " .. table.dump({
    dungeonId = this:GetData("RandomCall/DungeonUid"),
    actorIndexs = idxs
  }))
  this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsConfirmGroupReq", {
    dungeonId = this:GetData("RandomCall/DungeonUid"),
    actorIndexs = idxs
  })
end

function OnLoadStart(response)
  warning("load start ...")
  local matchInfo = this:GetData("RandomCall/MatchInfo")
  local teamIndex = this:GetData("RandomCall/TeamIndex")
  local dungeonInfo = response.dungeonInfo
  local team = dungeonInfo.teams
  CS.Restifizer.RestifizerManager.Instance:SetFightWebSocketUrl(response.fightsvrUrl)
  local fightActorInfo = {
    {
      playerId = team[1].members[1].playerId,
      actors = team[1].members[1].actors,
      name = team[1].members[1].name,
      level = team[1].members[1].level
    },
    {
      playerId = team[2].members[1].playerId,
      actors = team[2].members[1].actors,
      name = team[2].members[1].name,
      level = team[2].members[1].level
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  local parm = {
    matchInfo.dungeonInfo.dungeonUid,
    nil,
    matchInfo.dungeonInfo.dungeonId,
    PB.enum.DungeonType.RD,
    teamIndex,
    false
  }
  warning("param : " .. table.dump(parm))
  WU.EnterGameLevel(matchInfo.dungeonInfo.dungeonUid, nil, matchInfo.dungeonInfo.dungeonId, PB.enum.DungeonType.RD, teamIndex, false)
end

function InitOpponents()
  local opnPool = this:GetData("RandomCall/OpnPool")
  WU.TraverseChildren(REF.ActorOpponents, function(go, index)
    local ref = _ENV["$"](go)
    local actor = opnPool[index + 1]
    if actor ~= nil then
      ref["$$SetData"](actor.id)
    end
  end)
end

function OnConfirmResponse(result)
  warning("confirm result : " .. table.dump(result))
end

function LegalCheck(members)
  local legal = true
  for _, v in pairs(members) do
    if v.actorUid ~= 0 then
      local actor = GetActor(v.actorUid)
      if actor ~= nil and 0 < actor.id then
        local actorConfig = PB.get("ActorConfig", actor.id)
        local mainIndex = GU.IsMainIndex(v.index)
        if mainIndex and actorConfig.kind == PB.enum.ActorType.Sub or not mainIndex and actorConfig.kind == PB.enum.ActorType.Main then
          legal = false
          v.actorUid = 0
        end
      end
    end
  end
  return legal
end
