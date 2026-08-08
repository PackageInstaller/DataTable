local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local SDU = require("Common/SoundUtil")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local m_displayActorTable, m_initWindow, m_dungeonId
local m_semiFixedDungeonNPC = {}
local m_npcIdsInGroup = {}
local m_targetSlot
local m_refreshNpcIds = false
local m_repeatedContext = {}

function SetupWindow()
  REF["$SortMate"] = REF.SortMatePlayer.SortMate
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  WU.BindButtonEvent(REF.ActorMain, OnActorMainClick)
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
  Base.SetData("SetMembers", function(groups, members)
    groups.groupInfo = members
    return true
  end)
  Base.SetData("GetMembers", function(groups)
    if groups and groups.groupInfo then
      return groups.groupInfo.members
    end
  end)
  Base.SetData("OnGroupMemberClick", function()
    OnActorClassify(this:GetData("SortFinished"))
  end)
  Base.SetData("ActorClassifyFunc", OnActorClassify)
  Base.SetData("GroupChangeCompare", GroupChangeCompare)
  Base.SetData("GroupSlotChangeSuccCallb", GroupSlotChangeSuccCallb)
  Base.SetData("OnGroupSlotChangeCancel", OnGroupSlotChangeCancel)
  Base.SetData("GroupMemberslegalCheck", GroupMemberslegalCheck)
  Base.SetData("OnActorRemoveFromGroup", OnActorRemoveFromGroup)
  Base.SetupWindow()
end

function InitWindow()
  REF["$SortMate"] = REF.SortMatePlayer.SortMate
  m_semiFixedDungeonNPC = {}
  m_npcIdsInGroup = _ENV["!"]({})
  Base.InitWindow()
  Base.SetData("refreshGroup", false)
  this:Bind("ActorGroup/DungeonId", On91ActorSelect)
  this:Bind("SemiFixedPlayer/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("SemiFixedPlayer/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("DisplayOptionChange", function()
    RefreshGroupMembers()
  end)
  this:RegisterGameEvent("WidgetGroupMembersDrop", RefreshNpcId)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  Base.UninitWindow()
end

function On91ActorSelect(dungeonId)
  if dungeonId == nil then
    return
  end
  if not DU.IsSemifixedDungeon(dungeonId) then
    return
  end
  m_dungeonId = dungeonId
  local groups = this:GetData("fci/npc-dungeon/actorgroup/" .. dungeonId)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_initWindow = true
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(Base.GetData("currentGrid"), false)
  OnActorGroupChanged(groups)
end

function RefreshSemiFixedDungeonNPC(dungeonId, groups)
  m_semiFixedDungeonNPC = {}
  local semiFixedDungeon = PB.get("NPCDungeonInfo", dungeonId)
  for i = 1, #semiFixedDungeon.npcId do
    local npcId = semiFixedDungeon.npcId[i]
    local inGroup, a = table.find(m_npcIdsInGroup, function(key, val)
      return val.npcId == npcId
    end)
    local npcInfo = PB.get("DungeonNPC", npcId)
    if npcInfo then
      npcInfo.grouped = inGroup ~= nil
      m_semiFixedDungeonNPC[npcId] = npcInfo
    else
      warning("Not Found: " .. i .. "  " .. tostring(npcId))
    end
  end
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    local groups = _ENV["!"]({})
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    RefreshGroupMembers(groups)
    RefreshSemiFixedDungeonNPC(m_dungeonId, groups)
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      m_initWindow = false
      local index = this:GetData("AutoSlotSelection")
      this:SetData("AutoSlotSelection", nil)
      Base.ResetState(0, true, index)
      REF["$Animator"]:Play("DelayOpen", -1, 0)
    end
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    rowRef["$$SetClickCallback"](OnActorHeadClick)
    rowRef["$$SetHoldCallback"](Base.DefaultActorHeadHold)
    rowRef["@isNpc"] = actor.uid == nil
    if actor.uid then
      SetNormalActor(actor, rowRef)
    else
      SetNpcActor(actor, rowRef)
    end
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
    local currentActor
    local slotIndex = Base.GetData("slotIndex")
    local ref = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
    if ref ~= nil then
      currentActor = ref["@actor"]
    end
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
  end
end

function SetNormalActor(actor, rowRef)
  rowRef["$$BindActor"](actor)
  rowRef["@uid"] = actor.uid
end

function SetNpcActor(actor, rowRef)
  rowRef["@npcId"] = actor.npcId
  rowRef["$$ResetState"]()
  rowRef["$$SetActor"](actor)
  rowRef["$$SetAsNpc"]()
end

function OnConfirm(isHome)
  local groups = Base.GetData("groups")
  for k, v in pairs(groups.groupInfo.members) do
    if v.isNpc and v.actorUid == 0 then
      v.actorUid = v.npcId
    end
  end
  
  local function Recycle()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  this:GameRequest("fci/npc-dungeon/actorgroup/" .. m_dungeonId):Put(groups, function(response)
    this:SetData("fci/npc-dungeon/actorgroup/" .. m_dungeonId, response)
    Recycle()
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "SemiFixedActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function Home()
  this:BroadcastGameEvent("OnNavigation", "City")
end

function OnBackValidate(isHome)
  local function DontSave()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local originalGroups = this:GetData("fci/npc-dungeon/actorgroup/" .. m_dungeonId)
  local groups = Base.GetData("groups")
  for i = 1, #originalGroups.groupInfo.members do
    local member = originalGroups.groupInfo.members[i]
    if member.actorUid ~= groups.groupInfo.members[i].actorUid or member.isNpc ~= groups.groupInfo.members[i].isNpc then
      WU.ShowMessageYesNo(WU.GetString("Window_ActorSelectBackValidate"), function(result)
        if result == "YES" then
          OnConfirm(isHome)
        else
          DontSave()
        end
      end)
      return
    end
  end
  DontSave()
end

function Focus(on)
  SortFocusBase.FocusActor(on, function()
    Base.SetData("resetActorSelect", true)
    return Base.GetData("advancedFilters")
  end)
  if on then
    local slotIndex = Base.GetData("slotIndex")
    local groups = Base.GetData("groups")
    if groups and slotIndex then
      RefreshGroupMembers(groups)
      local go = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
      Base.OnSlotSelected(go)
    end
    WU.SetWindowTitle("SemiFixedChapterActorSelect", "ActorSelect")
  end
end

function RefreshGroupMembers(groups)
  if groups == nil then
    groups = Base.GetData("groups")
  end
  if groups == nil then
    return
  end
  local members = groups.groupInfo.members
  for i = 1, #members do
    local idx = i - 1
    local ref = _ENV["$"](REF.WidgetGroupMembers["$GetSlotByIndex"](i - 1))
    local nIdx, n = table.find(m_npcIdsInGroup, function(_, v)
      return v.slotIdx == idx
    end)
    if members[i].isNpc then
      if m_initWindow or m_refreshNpcIds then
        if members[i].npcId and members[i].npcId ~= 0 then
          m_npcIdsInGroup[i] = {
            npcId = members[i].npcId,
            slotIdx = idx
          }
        end
      elseif n ~= nil then
        members[i].npcId = n.npcId
      else
        members[i].npcId = 0
      end
    elseif n ~= nil then
      members[i].npcId = 0
      m_npcIdsInGroup[nIdx] = nil
    end
  end
  m_refreshNpcIds = false
  REF.WidgetGroupMembers["$Set91GroupMembers"](members)
  local displayOption = SU.DisplayOption[WU.GetGameDataCache("LocalDisplayOption") or "name"]
  REF.WidgetGroupMembers["$ShowCustom"]({
    showNew = false,
    showEquips = displayOption == SU.DisplayOption.equip,
    showName = displayOption == SU.DisplayOption.name,
    showArm = displayOption == SU.DisplayOption.arm,
    showCultivationTotal = Base.GetData("displayNumbers") == SU.DisplayNumbers.Cultivation,
    showSpeed = Base.GetData("displayNumbers") == SU.DisplayNumbers.Speed,
    showStar = Base.GetData("displayNumbers") == SU.DisplayNumbers.Star
  })
  if REF.WidgetGroupCultivation then
    REF.WidgetGroupCultivation["$SetGroupMembers"](members)
  elseif REF.WidgetGroupCultivation4Group then
    REF.WidgetGroupCultivation4Group["$SetGroupMembers"](members)
  end
end

function RefreshWrapContent(list)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](list):copy(m_displayActorTable)
  Base.RemoveActorsInGroup(m_displayActorTable)
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  local slotIndex = Base.GetData("slotIndex")
  Base.SetData("linksActorId", REF.WidgetGroupMembers["$GetLinksActorIdByIndex"](slotIndex, m_displayActorTable))
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function AddMonster91()
  local actors = _ENV["!"]({})
  local main = Base.GetData("actorType") == PB.enum.ActorType.Main
  for k, v in pairs(m_semiFixedDungeonNPC) do
    local acInfo = PB.get("ActorConfig", v.actorId)
    local kindMatch = Base.GetData("actorType") == acInfo.kind
    if not v.grouped and kindMatch then
      AU.RenameDungeonNPCFields(v)
      table.insert(actors, v)
    end
  end
  actors:append(m_displayActorTable)
  return actors
end

function GetCurrentActor()
  local slotIndex = Base.GetData("slotIndex")
  local ref = _ENV["$"](REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex))
  local actor
  if ref then
    actor = ref["@actor"]
  end
  return actor
end

function OnActorLinkClick()
  local actor = GetCurrentActor()
  if actor then
    if actor.uid then
      WU.AcquireWindowAsync("ActorInfo", function()
        this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
        this:SetData("Actor/SelectedUid", actor.uid)
        this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
      end)
    else
      WU.AcquireWindowAsync("ActorInfoDisplay", function(ui)
        _ENV["$"](ui).TabEquipDisplay.gameObject:SetActive(false)
        this:SetData("Space/DisplayInfo", {actorInfo = actor})
        this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnActorMainClick()
  local actor = GetCurrentActor()
  if actor then
    if actor.uid then
      this:SetData("Actor/SelectedUid", nil)
      WU.AcquireWindowAsync("ActorMain", function()
        this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
        this:SetData("Actor/SelectedUid", actor.uid)
      end)
    else
      WU.AcquireWindowAsync("ActorInfoDisplay", function(ui)
        _ENV["$"](ui).TabEquipDisplay.gameObject:SetActive(false)
        this:SetData("Space/DisplayInfo", {actorInfo = actor})
        this:BroadcastGameEvent("EventSwitchTab", "TabTalent")
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function CreateRollerTraverse()
  local traverseData = _ENV["!"]({})
  local groups = Base.GetData("groups")
  local members = groups.groupInfo.members
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, this:GetData("fci/actor/" .. members[i].actorUid))
    end
  end
  return traverseData
end

function OnActorHeadClick(go)
  m_targetSlot = nil
  local ref = _ENV["$"](go)
  if ref["@isNpc"] then
    HandlerNpcActor(ref)
  else
    local actorUid = ref["@uid"]
    local changeAble = true
    local ac = this:GetData("fci/actor/" .. actorUid)
    for k, v in pairs(m_semiFixedDungeonNPC) do
      if v.actorId == ac.id and v.grouped then
        changeAble = false
        WU.ShowHintText(WU.GetString("Window_PosNpcSetRepeatly"))
        break
      end
    end
    if changeAble then
      Base.DefaultActorHeadClick(go)
    end
  end
end

function HandlerNpcActor(ref)
  local idx, info = table.find(m_semiFixedDungeonNPC, function(k, v)
    return k == ref["@npcId"]
  end)
  local slotIndex = Base.GetData("slotIndex")
  local npc = m_semiFixedDungeonNPC[idx]
  if npc == nil then
    warning("DungeonNPC", "Can't find npc id -> " .. tostring(info.npcId))
    return
  end
  local npcIndi = {
    npcId = ref["@npcId"],
    slotIdx = slotIndex
  }
  local _, _n = table.find(m_npcIdsInGroup, function(k, v)
    return v.npcId == npcIndi.npcId
  end)
  if _n == nil then
    m_npcIdsInGroup[slotIndex + 1] = npcIndi
  end
  AU.RenameDungeonNPCFields(npc)
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(npc)
  else
    local targetRef = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
    
    local function slotChangeSuccess(patchData)
      local idx, n = table.find(m_npcIdsInGroup, function(k, v)
        return v.slotIdx == slotIndex and v.npcId ~= npcIndi.npcId
      end)
      if n ~= nil then
        table.remove(m_npcIdsInGroup, idx)
      end
      Base.OnGroupSlotChangeSuccess(patchData)
      OnActorGroupChanged(Base.GetData("groups"))
      OnActorClassify(this:GetData("SortFinished"))
      REF.WidgetGroupMembers["$PlayActorCardEffect"]({slotIndex})
      local go = REF.WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex"))
      Base.OnSlotSelected(go)
    end
    
    local card = _ENV["$"](targetRef)["@actor"]
    ClearAllSelect()
    local eventData = {
      index = slotIndex,
      card = card,
      cardS = npc,
      actorS = npc
    }
    m_targetSlot = slotIndex
    Base.OnSlotSelected(REF.WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex")))
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, slotChangeSuccess, OnGroupSlotChangeCancel)
    Base.SetData("currentActorUid", npc.uid)
  end
end

function OnGroupSlotChangeCancel()
  local targetSlot = m_targetSlot or Base.GetData("slotIndex")
  if targetSlot then
    local go = REF.WidgetGroupMembers["$GetSlotByIndex"](targetSlot)
    Base.OnSlotSelected(go)
  end
end

function GroupSlotChangeSuccCallb()
  local slotIndex = Base.GetData("slotIndex")
  local currentActorId = Base.GetData("currentActorID")
  local go = REF.WidgetGroupMembers["$GetSlotByIndex"](m_targetSlot or slotIndex)
  if go then
    local ref = _ENV["$"](go)
    if ref["@actor"] ~= nil then
      if currentActorId then
        SDU.StopActorAdded(currentActorId)
        Base.SetData("currentActorID", ref["@actor"].id)
      end
      SDU.PlayActorAdded(ref["@actor"].id)
    end
  end
  Base.OnSlotSelected(go)
end

function GroupChangeCompare(membersBefore, members)
  local flag = 0
  local changedIndex = {}
  local semiFixedDungeon = PB.get("NPCDungeonInfo", m_dungeonId)
  local npcPos = semiFixedDungeon.isNpc
  table.sort(members, function(a, b)
    return a.index < b.index
  end)
  for i = 1, #members do
    if members[i].isNpc and npcPos[i] ~= 1 or not members[i].isNpc and npcPos[i] == 1 and (members[i].actorUid ~= 0 or members[i].npcId ~= 0) then
      WU.ShowHintText(WU.GetString("Window_PosNpcForbidden"))
      return 0, {}
    end
  end
  for i = 1, #membersBefore do
    if membersBefore[i].actorUid ~= members[i].actorUid or membersBefore[i].isNpc ~= members[i].isNpc or membersBefore[i].npcId ~= members[i].npcId then
      flag = flag + 1
      if members[i].actorUid ~= 0 or members[i].isNpc == true then
        table.insert(changedIndex, members[i].index)
      end
    end
  end
  return flag, changedIndex
end

function GroupMemberslegalCheck(members)
  local legal = true
  for _, v in pairs(members) do
    local actor
    if v.isNpc then
      actor = PB.get("DungeonNPC", v.npcId)
      if actor ~= nil then
        AU.RenameDungeonNPCFields(actor)
      end
    else
      actor = this:GetData("fci/actor/" .. v.actorUid)
    end
    if actor ~= nil and actor.id > 0 then
      local actorConfig = PB.get("ActorConfig", actor.id)
      local mainIndex = GU.IsMainIndex(v.index)
      if mainIndex and actorConfig.kind == PB.enum.ActorType.Sub or not mainIndex and actorConfig.kind == PB.enum.ActorType.Main then
        legal = false
        v.actorUid = 0
      end
    end
  end
  return legal
end

function OnActorRemoveFromGroup()
  local actor = GetCurrentActor()
  local slotIndex = Base.GetData("slotIndex")
  local idx, n = table.find(m_npcIdsInGroup, function(k, v)
    return v.slotIdx == slotIndex
  end)
  if m_npcIdsInGroup[idx] then
    m_npcIdsInGroup[idx] = nil
  end
  if actor then
    local eventData = {
      index = Base.GetData("slotIndex"),
      card = actor
    }
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, OnGroupSlotChangeCancel)
  end
  local go = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
  Base.OnSlotSelected(go)
end

function SwitchButtonGrid(go)
  local ref = _ENV["$"](go)
  WU.SetActive(REF.ActorLink, not ref["@isNpc"])
  WU.SetActive(REF.ActorMain, not ref["@isNpc"])
end

function OnActorClassify(sortData)
  if sortData == nil then
    return
  end
  local filteredList = sortData.list or sortData
  local npcDun = PB.get("NPCDungeonInfo", m_dungeonId)
  local slotIndex = Base.GetData("slotIndex")
  if npcDun == nil or slotIndex == nil then
    return
  end
  local isNpc = npcDun.isNpc[slotIndex + 1] == 1
  local main = {}
  local sub = {}
  REF.CardShowOption.transform.localPosition = CS.UnityEngine.Vector3(fif(not isNpc, 0, 130), 0, 0)
  this:DelayInvokeEndOfFrame(function()
    this:BroadcastGameEvent("SortActiveChange", not isNpc)
  end)
  if not isNpc then
    this:BroadcastGameEvent("SortActiveChange", true)
    main, sub = SU.OnActorClassify(filteredList)
    this:SetData("SemiFixedPlayer/MainActors/", main)
    this:SetData("SemiFixedPlayer/SubActors/", sub)
  else
    Base.SetData("resetActorSelect", true)
    REF.CardShowOption.transform.localPosition = CS.UnityEngine.Vector3(130, 0, 0)
    for k, v in pairs(m_semiFixedDungeonNPC) do
      local acInfo = PB.get("ActorConfig", v.actorId)
      if not v.grouped then
        AU.RenameDungeonNPCFields(v)
        if acInfo.kind == PB.enum.ActorType.Main then
          table.insert(main, v)
        else
          table.insert(sub, v)
        end
      end
    end
  end
  this:SetData("SemiFixedPlayer/MainActors/", main)
  this:SetData("SemiFixedPlayer/SubActors/", sub)
  Base.RefreshGroupMembers()
  local go = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex or 0)
  _ENV["$"](go).WidgetActorCard["$SetHighlighted"](true)
  return main, sub
end

function RefreshNpcId(flag)
  m_refreshNpcIds = flag
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId})
end

function LoadContext()
  local context = m_repeatedContext[#m_repeatedContext]
  this:SetData("ActorGroup/DungeonId", context.dungeonId)
  table.remove(m_repeatedContext, #m_repeatedContext)
end
