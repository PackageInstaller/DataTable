local GuildSensitive = inherit("Window/Guild/GuildSensitiveBase", _ENV)
local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local NU = require("Common/NotepadUtil")
local DU = require("Common/DungeonUtil")
local m_displayActorTable, m_initWindow, m_usedActor, m_usedHelper, m_notUseCount, m_members

function SetupWindow()
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  WU.BindButtonEvent(REF.ActorMain, OnActorMainClick)
  WU.BindButtonEvent(REF.CollectionActor, OnCollectionActorClick)
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if m_initWindow then
        return
      end
      if REF.TabRent.UIToggle.value then
        OnActorTabClick(REF.SortMateRent)
      end
      if REF.TabActors.UIToggle.value then
        OnActorTabClick(REF.SortMateActors)
      end
      if REF.TabArms.UIToggle.value then
        DB:SetData("DisplayOptionOrigin", WU.GetGameDataCache("LocalDisplayOption"))
        WU.SetDislayOption("arm")
        OnActorTabClick(REF.SortMateArm)
      else
        local displayOption = DB:GetData("DisplayOptionOrigin")
        if displayOption == nil then
          displayOption = WU.GetGameDataCache("LocalDisplayOption")
        end
        WU.SetDislayOption(displayOption)
      end
    end)
  end)
  WU.BindButtonEvent(REF.Confirm, OnFightClick)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
  Base.SetData("GroupChangeCompare", BGroupChangeCompare)
  Base.SetData("GroupMemberslegalCheck", BGroupMemberslegalCheck)
  Base.SetData("OnActorRemoveFromGroup", BOnActorRemoveFromGroup)
  Base.SetupWindow()
end

function InitWindow()
  REF.root.SortMate = REF.SortMateActors.SortMate
  this:Bind("guildId", function(guildId)
    GuildSensitive.ValidateRestrictions(guildId)
  end)
  local summary = this:GetData("DungeonGuild/Summary")
  m_usedActor = summary.playerRentInfo.usedActor or _ENV["!"]({})
  m_usedHelper = summary.playerRentInfo.usedGuildActor or _ENV["!"]({})
  Base.InitWindow()
  Base.SetData("sortMateControl", false)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  this:SetData("AutoSlotSelection", 0)
  m_initWindow = true
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(Base.GetData("currentGrid"), false)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/guild-dungeon/"), OnSelectedActorGroupId)
  this:Bind("DungeonGuildActorSelect/MainActors/", function(list)
    OnSelectActorListChange(list, PB.enum.ActorType.Main)
  end)
  this:Bind("DungeonGuildActorSelect/SubActors/", function(list)
    OnSelectActorListChange(list, PB.enum.ActorType.Sub)
  end)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  local activeRef, disactiveRef
  if not IsMyActorNow() then
    disactiveRef, activeRef = REF.SortMateActors, REF.SortMateRent
    local aSortMate = activeRef.SortMate
    local dSortMate = disactiveRef.SortMate
    dSortMate.reverse = aSortMate.reverse
    dSortMate.tabIndex = aSortMate.tabIndex
    dSortMate.showEquip = aSortMate.showEquip
    dSortMate.showName = aSortMate.showName
    local allContext = WU.GetGameDataCache("SortLocalContext")
    local context = allContext[dSortMate.contextName]
    context.id = dSortMate.ids[dSortMate.tabIndex]
    WU.SetGameDataCache("SortLocalContext", allContext)
  end
  Base.UninitWindow()
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
      RefreshGroupMembers(true)
      local go = REF.WidgetGroupMembers["$GetSlotByIndex"](slotIndex)
      Base.OnSlotSelected(go)
    end
    if on then
      WU.SetWindowTitle("DungeonGuildActorSelect", "ActorSelect")
    end
  end
end

function OnSelectedActorGroupId(result)
  if result then
    local selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    Base.SetData("selectedGroupId", selectedGroupId)
    local path = GU.GetGroupApi(PB.enum.ActorGroupType.Guild)
    this:Unbind(path, OnActorGroupChanged)
    this:BindRemote(DB:GameRequest(path), OnActorGroupChanged)
  end
end

function OnActorGroupChanged(groups)
  if groups then
    local selectedGroupId = Base.GetData("selectedGroupId")
    m_members = groups[tostring(selectedGroupId)].members
    local hasUsed = false
    for i = 1, #m_members do
      local member = m_members[i]
      if member.actorUid and member.actorUid ~= 0 then
        local _, v = table.find(m_usedActor, function(k1, v1)
          return v1 == member.actorUid
        end)
        if v then
          hasUsed = true
          break
        end
      elseif member.actorGuildUid and member.actorGuildUid ~= 0 then
        do
          local _, v = table.find(m_usedHelper, function(k1, v1)
            return v1 == member.actorGuildUid
          end)
          if v then
            hasUsed = true
            break
          end
        end
      end
    end
    for i = 1, #m_members do
      m_members[i].actorUid = fif(hasUsed, 0, m_members[i].actorUid or 0)
      m_members[i].actorGuildUid = fif(hasUsed, 0, m_members[i].actorGuildUid or 0)
      m_members[i].isGuildActor = m_members[i].actorGuildUid ~= 0
    end
    local tempGroups = _ENV["!"]({})
    table.copy(groups, tempGroups, true)
    Base.SetData("groups", tempGroups)
    RefreshGroupMembers(true)
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      m_initWindow = false
      local index = this:GetData("AutoSlotSelection")
      this:SetData("AutoSlotSelection", nil)
      OnActorTabClick()
      Base.ResetState(0, true, index)
    end
  end
end

function OnSelectActorListChange(list, type)
  local actorType = Base.GetData("actorType")
  if list and actorType == type then
    RefreshWrapContent(list)
  end
end

function RefreshGroupMembers(groups)
  if groups then
    local groups = Base.GetData("groups")
    local members = Base.DefaultGetMembers(groups)
    REF.WidgetGroupMembers["$SetDungeonGuildGroupMembers"](members)
    REF.WidgetGroupCultivation["$SetDungeonGuildGroupMembers"](members)
  end
  Base.RefreshGroupMembers(false)
end

function RefreshWrapContent(list)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](list):copy(m_displayActorTable)
  RemoveActorsInGroup(m_displayActorTable)
  SortByUseful()
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  local displayActorCount = #m_displayActorTable
  WU.SetActive(REF.EffectTutorial, displayActorCount ~= 0)
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, displayActorCount, resetPosition, not resetPosition)
  end
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local index = rowIndex + 1
    local actor = m_displayActorTable[index]
    rowRef["$$SetClickCallback"](OnActorHeadClick)
    rowRef["$$SetHoldCallback"](OnActorHeadHold)
    actor.isGuildActor = not IsMyActorNow()
    rowRef["@isGuildActor"] = actor.isGuildActor
    if not actor.isGuildActor then
      rowRef["@uid"] = actor.uid
    else
      rowRef["@uid"] = actor.uid
    end
    if actor.isGuildActor then
      rowRef["$$ResetState"]()
      rowRef["$$SetActor"](actor)
    else
      rowRef["$$BindActor"](actor)
    end
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
    if index > m_notUseCount then
      rowRef["$$SetTips"]("equipUsing")
    end
    rowRef["@hasUsed"] = index > m_notUseCount
    local currentActor = GetCurrentActor()
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
  end
end

function OnActorLinkClick()
  local actor = GetCurrentActor()
  if actor then
    WU.AcquireWindowAsync("ActorInfo", function()
      this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
      this:SetData("Actor/SelectedUid", actor.uid)
      this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
    end)
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnActorMainClick()
  local actor = GetCurrentActor()
  if actor then
    this:SetData("Actor/SelectedUid", nil)
    WU.AcquireWindowAsync("ActorMain", function()
      this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
      this:SetData("Actor/SelectedUid", actor.uid)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnCollectionActorClick()
  local curActor = GetCurrentActor()
  local id = curActor.id
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
    NU.GetCollectionsActor(function(actors)
      local _, actor = table.find(actors, function(k, v)
        return v.id == id
      end)
      actor = actor or {}
      WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
        _ENV["$"](w)["$$SetActor"](actor)
      end)
    end)
  end
end

function OnActorTabClick(sortMateRef)
  if sortMateRef == nil then
    sortMateRef = REF.SortMateActors
  end
  if sortMateRef == REF.SortMateRent then
    REF.SortMateRent.SortMate.tabIndex = REF.SortMateActors.SortMate.tabIndex
    REF.SortMateRent.SortMate.reverse = REF.SortMateActors.SortMate.reverse
  else
    REF.SortMateActors.SortMate.tabIndex = REF.SortMateRent.SortMate.tabIndex
    REF.SortMateActors.SortMate.reverse = REF.SortMateRent.SortMate.reverse
  end
  local sortMate = sortMateRef.SortMate
  REF.root.SortMate = sortMate
  local tabIndex = fif(sortMate.tabIndex ~= nil, sortMate.tabIndex, 0)
  local sortReverse = fif(sortMate.reverse ~= nil, sortMate.reverse, true)
  local allContext = WU.GetGameDataCache("SortLocalContext")
  local context = allContext[sortMate.contextName]
  if context == nil then
    context = {
      contextName = sortMate.contextName,
      kind = 0,
      tags1 = 0,
      tags2 = 0,
      displayOption = "name"
    }
  end
  allContext[sortMate.contextName] = context
  this:BroadcastGameEvent("ApplySortAlternative", tabIndex or sortMate.tabIndex, sortReverse or sortMate.reverse, context)
end

function OnActorHeadClick(go)
  local ref = _ENV["$"](go)
  local uid = ref["@uid"]
  local isGuildActor = ref["@isGuildActor"]
  local actor = GU.ChangeToActorInfo({isGuildActor = isGuildActor, uid = uid})
  if actor == nil then
    warning("OnActorHeadClick", "actorUid nil?")
    return
  end
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(actor)
  elseif ref["@hasUsed"] then
    return
  else
    local targetRef = REF.WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex"))
    if targetRef["@uid"] == uid and targetRef["@isGuildActor"] == isGuildActor then
      return
    end
    Base.ClearAllSelect()
    local eventData = {
      index = Base.GetData("slotIndex"),
      card = targetRef["@actor"],
      cardS = actor,
      actorS = actor
    }
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, Base.DefaultOnGroupSlotChangeCancel)
  end
end

function OnActorHeadHold(go)
  local ref = _ENV["$"](go)
  local actor = GU.ChangeToActorInfo({
    isGuildActor = ref["@isGuildActor"],
    uid = ref["@uid"]
  })
  if actor == nil then
    warning("OnActorHeadClick", "actorUid nil?")
    return
  end
  WU.ShowActorPeek(actor)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "DungeonGuildActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function OnBackValidate(isHome)
  local isChange = false
  local path = GU.GetGroupApi(PB.enum.ActorGroupType.Guild)
  local originalGroups = this:GetData(path)
  local groups = Base.GetData("groups")
  for k, v in pairs(originalGroups) do
    for i = 1, #v.members do
      local oriMember = v.members[i]
      local nowMember = groups[k].members[i]
      if nowMember.actorUid ~= oriMember.actorUid or nowMember.actorGuildUid ~= oriMember.actorGuildUid then
        isChange = true
        break
      end
    end
  end
  if isChange then
    WU.ShowMessageYesNo(WU.GetString("Window_ActorSelectBackValidate"), function(result)
      if result == "YES" then
        SaveGroupInfo(ReturnPage, isHome)
      else
        ReturnPage(isHome)
      end
    end)
  else
    ReturnPage(isHome)
  end
end

function OnFightClick()
  if not DU.IsWaitingForJob(OnButtonFightClick) then
    OnButtonFightClick()
  end
end

function OnButtonFightClick()
  if not m_members or m_members and not GU.GroupIsOK(m_members, true) then
    return
  end
  SaveGroupInfo(FightePrepare)
end

function FightePrepare()
  if not this:GetData("FightActorInfoSynced") then
    local actorList = {}
    for _, member in pairs(m_members) do
      local actor = GU.ChangeToActorInfo(member, true) or {}
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
    this:BroadcastGameEvent("MedalAttrAppend")
  end
  EnterDungeon()
end

function EnterDungeon()
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  local param = {
    dungeonId = dungeonId,
    selectActorGroupId = Base.GetData("selectedGroupId")
  }
  this:SetData("WindowDungeon/EnterParam", param)
  this:SetData("BalanceInfo/Groups", {
    groups = Base.GetData("groups")
  })
  local wireFormatTable = ProtobufT("ApiGuildDungeon", param)
  this:GameRequest("fci/guild-dungeon/v2"):Post(param, function(response)
    local hps = _ENV["!"]({
      0,
      0,
      0,
      0,
      0,
      0
    })
    local enemyHps = response.enemyHplist
    for i = 1, 6 do
      if enemyHps[i] == nil then
        enemyHps[i] = 0
      elseif enemyHps[i] == 0 then
        enemyHps[i] = -1
      end
    end
    local fightInitInfo = {
      {hp = hps},
      {hp = enemyHps}
    }
    this:SetData("FightInitInfo", fightInitInfo)
    local type = this:GetData("DungeonGuild/DungeonType")
    WU.EnterGameLevel(response.dungeonUid, response.baseInfo, dungeonId, type, 1, false)
  end)
end

function RemoveActorsInGroup(actors)
  local uids = {}
  local guildUids = {}
  for i = 1, #m_members do
    local member = m_members[i]
    if member.isGuildActor then
      guildUids[member.actorGuildUid] = true
    else
      uids[member.actorUid] = true
    end
  end
  for i = #actors, 1, -1 do
    local actor = actors[i]
    if actor.isGuildActor and guildUids[actor.uid] == true or not actor.isGuildActor and uids[actor.uid] == true then
      table.remove(actors, i)
    end
  end
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

function CreateRollerTraverse()
  local traverseData = _ENV["!"]({})
  local groups = Base.GetData("groups")
  local groupId = Base.GetData("selectedGroupId")
  local members = groups[tostring(groupId)].members
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, this:GetData("fci/actor/" .. members[i].actorUid))
    end
  end
  return traverseData
end

function ReturnPage(isHome)
  if isHome then
    S:Get("TutorialManager").SetNavigation("City")
    this:BroadcastGameEvent("OnNavigation", "City")
  else
    WU.RecycleWindow(this)
  end
end

function SaveGroupInfo(callBack, param1)
  local groups = Base.GetData("groups")
  local selectedGroupId = Base.GetData("selectedGroupId")
  local path = GU.GetGroupApi(PB.enum.ActorGroupType.Guild)
  local param = {actorGroups = groups}
  local wireFormatTable = ProtobufT("ApiGuildDungeonActorGroup", param)
  this:GameRequest(path):Put(wireFormatTable, function(response)
    this:SetData(path, groups)
    callBack(param1)
  end)
end

function SortByUseful()
  local m_usedList = fif(IsMyActorNow(), m_usedActor, m_usedHelper)
  local notUseList = _ENV["!"]({})
  local usedList = _ENV["!"]({})
  for i = 1, #m_displayActorTable do
    local actor = m_displayActorTable[i]
    local _, v = table.find(m_usedList, function(k1, v1)
      return v1 == actor.uid
    end)
    if v == nil then
      table.insert(notUseList, actor)
    else
      table.insert(usedList, actor)
    end
  end
  m_notUseCount = #notUseList
  m_displayActorTable = _ENV["!"]({}):append(notUseList):append(usedList)
end

function IsMyActorNow()
  return REF.TabActors.UIToggle.value
end

function BGroupChangeCompare(membersBefore, members)
  local flag = 0
  local changedIndex = {}
  for i = 1, #membersBefore do
    local isSame = members[i].actorGuildUid == membersBefore[i].actorGuildUid and members[i].actorUid == membersBefore[i].actorUid
    if not isSame then
      flag = flag + 1
      if members[i].isGuildActor and members[i].actorGuildUid ~= 0 or not members[i].isGuildActor and members[i].actorUid ~= 0 then
        table.insert(changedIndex, members[i].index)
      end
    end
  end
  return flag, changedIndex
end

function BGroupMemberslegalCheck()
  local legal = true
  local members = Base.DefaultGetMembers(Base.GetData("groups"))
  for _, v in pairs(members) do
    local actor = GU.ChangeToActorInfo(v, true)
    if actor and actor.id > 0 then
      local actorConfig = PB.get("ActorConfig", actor.id)
      local mainIndex = GU.IsMainIndex(v.index)
      if mainIndex and actorConfig.kind == PB.enum.ActorType.Sub or not mainIndex and actorConfig.kind == PB.enum.ActorType.Main then
        legal = false
        v.actorUid = 0
        v.actorGuildUid = 0
        v.isGuildActor = nil
      end
    end
  end
  return legal
end

function BOnActorRemoveFromGroup()
  local actor = GetCurrentActor()
  if actor then
    local eventData = {
      index = Base.GetData("slotIndex"),
      card = actor
    }
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess, Base.DefaultOnGroupSlotChangeCancel)
  end
end

function SwitchButtonGrid(go)
  local ref = _ENV["$"](go)
  local actor = ref["@actor"]
  local isGuildActor = ref["@isGuildActor"]
  local isGuildActorInSlot = actor and isGuildActor
  WU.SetActive(REF.ActorMain, not isGuildActorInSlot)
  WU.SetActive(REF.ActorLink, not isGuildActorInSlot)
  WU.SetActive(REF.CollectionActor, isGuildActorInSlot)
  REF.Grid.UIGrid:Reposition()
end
