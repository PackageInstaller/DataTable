local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local NU = require("Common/NotepadUtil")
local WidgetGroupMembers = REF.WidgetGroupMembers
local m_displayActorTable, m_currentActorUid, m_actorType, m_groups
local m_selectedGroupId = 1
local m_selectedSlotIndex, m_actorGroupUri, m_displayMode, m_resetActorSelect, m_mode, m_initWindow, m_linksActorId, m_openWindowName
local m_replaceTop = false
local m_groupActorsForSkill

function SetupWindow()
  WU.BindButtonEvent(REF.ActorSkill, function()
    if WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
      return
    end
    if m_currentActorUid ~= nil and 0 < m_currentActorUid then
      local _ignore, actor
      if m_groupActorsForSkill then
        _ignore, actor = table.find(m_groupActorsForSkill, function(_, v)
          return v.uid == m_currentActorUid
        end)
      else
        local actorPool = this:GetData("fci/BurstLinkPvpActor")
        _ignore, actor = table.find(actorPool, function(_, v)
          return v.uid == m_currentActorUid
        end)
      end
      NU.OpenNotepadForActor(actor)
    else
      WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
    end
  end)
  WU.BindButtonEvent(REF.Confirm, OnConfirmFormation)
  WidgetGroupMembers["$SetClickCallback"](OnSlotSelected)
  WidgetGroupMembers["$AllowDragDrop"](function(patchData, index)
    m_selectedSlotIndex = index
    OnGroupSlotChangeSuccess(patchData)
  end, OnGroupSlotChangeCancel)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateSlot
  })
end

function InitWindow()
  m_mode = this:GetData("ActorGroup/Mode")
  m_initWindow = true
  m_linksActorId = nil
  m_actorType = nil
  m_openWindowName = nil
  m_selectedGroupId = 1
  m_replaceTop = false
  m_groupActorsForSkill = nil
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(REF.ActorSelectWidgetGrid, false)
  local groupUids = this:GetData("GroupActorUids")
  local copyUids = _ENV["!"]({})
  _ENV["!"](groupUids):copy(copyUids)
  this:SetData("GroupActorUidsCopy", copyUids)
  m_actorGroupUri = this:GetData("ActorGroup/GroupUri")
  this:BindRemote(DB:GameRequest("fci/BurstLinkPvpActorGroup/"), OnActorGroupChanged)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  local nav = WU.FindWindow("Navigation")
  if nav then
    _ENV["$"](nav)["$$SetBackCallback"]()
    _ENV["$"](nav)["$$SetHomeCallback"]()
  end
end

function OnSlotSelected(go)
  local ref = _ENV["$"](go)
  local index = ref["@index"]
  m_selectedSlotIndex = index
  ClearAllSelect()
  ref.WidgetActorCard["$SetHighlighted"](true)
  local actorPool = this:GetData("fci/BurstLinkPvpActor")
  m_linksActorId = WidgetGroupMembers["$GetBurstLinkActorIdByIndex"](index, actorPool)
  m_currentActorUid = ref["@uid"]
  local mode = 2
  if GU.IsMainIndex(index) then
    mode = 1
  end
  RefreshWrapContent(mode)
end

function OnGetActorPool(actorPool)
  if actorPool ~= nil and actorPool.actor then
    AU.OnActorClassify(actorPool.actor, "ActorSelect")
    this:SetData("fci/BurstLinkPvpActor", actorPool.actor)
    WU.ToggleRendering(REF.Panel, true)
    WidgetGroupMembers["$SetBurstLinkGroupMembers"](m_groups[tostring(m_selectedGroupId)].members, actorPool.actor)
    WidgetGroupMembers["$ShowCustom"]({
      showQuality = false,
      showStar = false,
      showLevel = false,
      showNew = false,
      showName = true
    })
    WidgetGroupMembers.UIPlayTween:Play(true)
    SetGroupActorsForSkill()
    if m_initWindow then
      ResetState()
      m_initWindow = false
      REF.root.Animator:Play("DelayOpen", -1, 0)
    end
  end
end

function DepCopyActorGroup(groups)
  m_groups = {}
  for k, v in pairs(groups) do
    local members = {}
    for i = 1, #v.members do
      local member = v.members[i]
      table.insert(members, {
        index = member.index,
        actorUid = member.actorUid
      })
    end
    m_groups[k] = {members = members}
  end
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    DepCopyActorGroup(actorGroup)
    local actorPool = this:GetData("fci/BurstLinkPvpActor")
    if actorPool == nil then
      DB:GameRequest("fci/BurstLinkPvpActor"):Get(OnGetActorPool)
      return
    end
    AU.OnActorClassify(actorPool, "ActorSelect")
    WidgetGroupMembers["$SetBurstLinkGroupMembers"](m_groups[tostring(m_selectedGroupId)].members, actorPool)
    WidgetGroupMembers["$ShowCustom"]({
      showQuality = false,
      showStar = false,
      showLevel = false,
      showNew = false,
      showName = true
    })
    SetGroupActorsForSkill()
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      ResetState()
      m_initWindow = false
      REF.root.Animator:Play("DelayOpen", -1, 0)
      WidgetGroupMembers.UIPlayTween:Play(true)
    end
  end
end

function AutoSlotSelection()
  local members = m_groups[tostring(m_selectedGroupId)].members
  local index = this:GetData("AutoSlotSelection")
  this:SetData("AutoSlotSelection", nil)
  if index == nil then
    for i = 1, 3 do
      if members[i].actorUid == 0 then
        index = members[i].index
        break
      end
      if members[i + 3].actorUid == 0 then
        index = members[i + 3].index
        break
      end
    end
  end
  local go = WidgetGroupMembers["$GetSlotByIndex"](index or 0)
  OnSlotSelected(go)
end

function ResetState()
  ClearAllSelect()
  RefreshWrapContent(3)
  m_selectedSlotIndex = nil
  m_currentActorUid = nil
  AutoSlotSelection()
end

function ShowConfirmTips()
  OnConfirm()
end

function UpdateSlot(ref, wrapIndex, realIndex)
  if realIndex < #m_displayActorTable then
    local actor = m_displayActorTable[realIndex + 1]
    ref["$$ResetState"]()
    ref["$$SetActor"](actor)
    ref["$$ShowCustom"]({showLevel = false, showStar = false})
    ref["$$SetClickCallback"](OnActorHeadClick)
    if m_linksActorId ~= nil then
      ref["$$SetMemberLink"](m_linksActorId[actor.id])
    end
    ref["@uid"] = actor.uid
  end
end

function OnGroupSlotChangeSuccess(patchData)
  local copy = {}
  _ENV["!"](m_groups):copy(copy)
  copy[tostring(m_selectedGroupId)] = patchData
  GU.UpdateGroupActorUids(m_groups, copy, m_mode)
  m_groups[tostring(m_selectedGroupId)] = patchData
  OnActorGroupChanged(m_groups)
  local go = WidgetGroupMembers["$GetSlotByIndex"](m_selectedSlotIndex)
  OnSlotSelected(go)
end

function OnGroupSlotChangeCancel()
  if m_selectedSlotIndex then
    local go = WidgetGroupMembers["$GetSlotByIndex"](m_selectedSlotIndex)
    OnSlotSelected(go)
  end
end

function OnActorHeadClick(go)
  local ref = _ENV["$"](go)
  local actorUid = ref["@uid"]
  if actorUid == nil then
    info("Actor", "actorUid nil?")
    return
  end
  if m_currentActorUid == actorUid then
    return
  end
  ClearAllSelect()
  if m_selectedSlotIndex == nil then
    ref["$$SetHighlighted"](true)
  else
    local eventData = {index = m_selectedSlotIndex}
    local actorPool = this:GetData("fci/BurstLinkPvpActor")
    local _, actorS = table.find(actorPool, function(_, v)
      return v.uid == actorUid
    end)
    eventData.cardS = actorS
    local _, actor = table.find(actorPool, function(_, v)
      return v.uid == m_currentActorUid
    end)
    eventData.card = actor
    WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, OnGroupSlotChangeSuccess, OnGroupSlotChangeCancel)
  end
  m_currentActorUid = actorUid
end

function RefreshWrapContent(displayMode)
  if displayMode ~= nil then
    if m_displayMode ~= displayMode then
      m_resetActorSelect = true
    end
    m_displayMode = displayMode
  end
  WU.ToggleRendering(REF.ActorSelectWidgetGrid, true)
  if m_displayMode == 1 then
    if m_actorType ~= PB.enum.ActorType.Main then
      m_actorType = PB.enum.ActorType.Main
      this:Unbind("ActorSelect/Actor/Sub/", InitSubActorSelect)
      this:Unbind("ActorSelect/Actor/All/", InitAllActorSelect)
      this:Bind("ActorSelect/Actor/Main/", InitMainActorSelect)
    else
      InitMainActorSelect(this:GetData("ActorSelect/Actor/Main/"))
    end
  elseif m_displayMode == 2 then
    if m_actorType ~= PB.enum.ActorType.Sub then
      m_actorType = PB.enum.ActorType.Sub
      this:Unbind("ActorSelect/Actor/Main/", InitMainActorSelect)
      this:Unbind("ActorSelect/Actor/All/", InitAllActorSelect)
      this:Bind("ActorSelect/Actor/Sub/", InitSubActorSelect)
    else
      InitSubActorSelect(this:GetData("ActorSelect/Actor/Sub/"))
    end
  elseif m_actorType ~= PB.enum.ActorType.None then
    m_actorType = PB.enum.ActorType.None
    this:Unbind("ActorSelect/Actor/Main/", InitMainActorSelect)
    this:Unbind("ActorSelect/Actor/Sub/", InitSubActorSelect)
    this:Bind("ActorSelect/Actor/All/", InitAllActorSelect)
  else
    InitAllActorSelect(this:GetData("ActorSelect/Actor/All/"))
  end
end

function InitAllActorSelect(result)
  if result then
    m_displayActorTable = _ENV["!"]({})
    _ENV["!"](result):copy(m_displayActorTable)
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, m_resetActorSelect)
    if m_resetActorSelect then
      m_resetActorSelect = false
    end
  end
end

function InitSubActorSelect(result)
  if result then
    m_displayActorTable = _ENV["!"]({})
    _ENV["!"](result):copy(m_displayActorTable)
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, m_resetActorSelect)
    if m_resetActorSelect then
      m_resetActorSelect = false
    end
  end
end

function InitMainActorSelect(result)
  if result then
    m_displayActorTable = _ENV["!"]({})
    _ENV["!"](result):copy(m_displayActorTable)
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, m_resetActorSelect)
    if m_resetActorSelect then
      m_resetActorSelect = false
    end
  end
end

function ClearAllSelect()
  WU.TraverseChildren(REF.ActorSelectWidgetGrid, function(go)
    _ENV["$"](go)["$$SetHighlighted"](false)
  end)
  WidgetGroupMembers["$ClearSelection"]()
end

function OnConfirm(isHome)
  local function Recycle()
    if isHome then
      Home()
    else
      DB:HandleRemoteChanged("fci/tournament/summary")
      if m_openWindowName then
        WU.AcquireWindowAsync(m_openWindowName, nil, m_replaceTop)
      else
        WU.RecycleWindow(this)
      end
    end
  end
  
  this:GameRequest(m_actorGroupUri):Put({actorGroups = m_groups}, function(response)
    this:SetData(m_actorGroupUri, m_groups)
    Recycle()
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "ActorSelect" then
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
  this:BroadcastGameEvent("OnNavigation", winName)
end

function OnBackValidate(isHome)
  local function DontSave()
    this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopy"))
    
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local groups = this:GetData(m_actorGroupUri)
  for k, v in pairs(groups) do
    for i = 1, #v.members do
      local member = v.members[i]
      if member.actorUid ~= m_groups[k].members[i].actorUid then
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
  end
  DontSave()
end

function SetOpenWindowName(windowName, replaceTop)
  m_openWindowName = windowName
  m_replaceTop = replaceTop
end

function OnConfirmFormation()
  OnConfirm(nil)
end

function SetGroupActorsForSkill()
  m_groupActorsForSkill = {}
  local actorPool = this:GetData("fci/BurstLinkPvpActor")
  if actorPool then
    for i = 1, 3 do
      if i <= #m_groups[tostring(m_selectedGroupId)].members then
        local member = m_groups[tostring(m_selectedGroupId)].members[i]
        local _, actor = table.find(actorPool, function(k, v)
          return v.uid == member.actorUid
        end)
        if actor then
          table.insert(m_groupActorsForSkill, actor)
        end
      end
      if i + 3 <= #m_groups[tostring(m_selectedGroupId)].members then
        local member = m_groups[tostring(m_selectedGroupId)].members[i + 3]
        local _, actor = table.find(actorPool, function(k, v)
          return v.uid == member.actorUid
        end)
        if actor then
          table.insert(m_groupActorsForSkill, actor)
        end
      end
    end
    table.reverse(m_groupActorsForSkill)
  end
end
