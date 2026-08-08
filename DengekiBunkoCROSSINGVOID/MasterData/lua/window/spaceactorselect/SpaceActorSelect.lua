local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local m_displayActorTable, m_initWindow, m_mode

function SetupWindow()
  Base.SetupWindow()
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  WU.BindButtonEvent(REF.ActorMain, OnActorMainClick)
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("UpdateGroupActorUids", function(groups, copy)
    GU.UpdateGroupActorUids(groups, copy, PB.enum.ActorGroupType.Show)
  end)
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
end

function InitWindow()
  m_initWindow = true
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(REF.ActorSelectWidgetGrid, false)
  m_mode = this:GetData("SpaceActorSelect/Mode")
  local groupUids = this:GetData("GroupActorUids")
  local copyUids = {}
  table.copy(groupUids, copyUids)
  this:SetData("GroupActorUidsCopySpace", copyUids)
  Base.InitWindow()
  local dataPath = m_mode .. "/SelectedPlayer"
  this:Bind(dataPath, function(data)
    if m_mode == "Space" then
      if data and data.showGroup then
        OnActorGroupChanged(data.showGroup)
      end
    elseif m_mode == "AsyncPvpNewGuard" and data then
      OnActorGroupChanged({
        ["1"] = data
      })
    end
  end)
  this:Bind("SpaceActorSelect/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("SpaceActorSelect/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list)
    end
  end)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  Base.UninitWindow()
end

function SaveContext()
  this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopySpace"))
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    Base.SetData("displayAttrs", false)
    Base.RefreshAttrDisplay()
    local groups = _ENV["!"]({})
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    Base.SetData("selectedGroupId", 1)
    Base.RefreshGroupMembers(true)
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
    rowRef["$$BindActor"](actor)
    rowRef["$$SetClickCallback"](Base.DefaultActorHeadClick)
    rowRef["$$SetHoldCallback"](Base.DefaultActorHeadHold)
    local currentActor
    local currentActorUid = Base.GetData("currentActorUid")
    if currentActorUid ~= nil then
      currentActor = this:GetData("fci/actor/" .. currentActorUid)
    end
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
    rowRef["@uid"] = actor.uid
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
  end
end

function OnConfirm(isHome)
  local groups = Base.GetData("groups")
  if WU.IsStandaloneGame() and m_mode == "Space" then
    this:SetData("fci/ActorGroup/", groups)
    return
  end
  if m_mode == "Space" then
    local showGroupTable = {
      showGroup = groups["1"]
    }
    local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", showGroupTable)
    this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
      this:SetData("Space/SelectedPlayer", result)
      if isHome then
        Home()
      else
        WU.RecycleWindow(this)
      end
    end)
  elseif m_mode == "AsyncPvpNewGuard" then
    local putData = groups["1"]
    local originalMembers = this:GetData("AsyncPvpNewGuard/SelectedPlayer")
    local groups = Base.GetData("groups")
    local data = groups["1"]
    local isDifferent, isFilled = AsyncPvpGuardGroupInvalidate(originalMembers.members, data.members)
    if isDifferent then
      if not isFilled then
        WU.ShowHintText(WU.GetString("NAsyncPvp_GuardGroupMustFilled"))
        return
      else
        this:GameRequest("fci/async_v2/actor_group/"):Put(putData, function(result)
          this:SetData("AsyncPvpNewGuard/SelectedPlayer", result)
          local data = this:GetData("AsyncPvpNew/BaseInfo")
          data.setDefendGroup = true
          this:SetData("AsyncPvpNew/BaseInfo", data)
          if isHome then
            Home()
          else
            WU.RecycleWindow(this)
          end
        end)
      end
    elseif isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "SpaceActorSelect" then
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
  local function DontSave()
    this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopySpace"))
    
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  if m_mode == "Space" then
    local originalGroups = this:GetData("Space/SelectedPlayer").showGroup
    local groups = Base.GetData("groups")
    for k, v in pairs(originalGroups) do
      for i = 1, #v.members do
        local member = v.members[i]
        if member.actorUid ~= groups[k].members[i].actorUid then
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
  elseif m_mode == "AsyncPvpNewGuard" then
    local originalMembers = this:GetData("AsyncPvpNewGuard/SelectedPlayer")
    local groups = Base.GetData("groups")
    local data = groups["1"]
    local isDifferent, isFilled = AsyncPvpGuardGroupInvalidate(originalMembers.members, data.members)
    if isFilled and isDifferent then
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
  Base.Focus(on)
  if on then
    WU.SetWindowTitle("SpaceActorSelect", "ActorSelect")
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
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function OnActorLinkClick()
  local currentActorUid = Base.GetData("currentActorUid")
  if currentActorUid ~= nil and 0 < currentActorUid then
    WU.AcquireWindowAsync("ActorInfo", function()
      this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
      this:SetData("Actor/SelectedUid", currentActorUid)
      this:BroadcastGameEvent("EventSwitchTab", "TabRelation")
    end)
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnActorMainClick()
  local currentActorUid = Base.GetData("currentActorUid")
  if currentActorUid ~= nil and 0 < currentActorUid then
    this:SetData("Actor/SelectedUid", nil)
    WU.AcquireWindowAsync("ActorMain", function()
      this:SetData("Actor/RollerTraverse", CreateRollerTraverse())
      this:SetData("Actor/SelectedUid", currentActorUid)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function CreateRollerTraverse()
  local traverseData = _ENV["!"]({})
  local groups = Base.GetData("groups")
  local members = groups["1"].members
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, this:GetData("fci/actor/" .. members[i].actorUid))
    end
  end
  return traverseData
end

function AsyncPvpGuardGroupInvalidate(oriMembers, members)
  local isDifferent = false
  local isFilled = true
  for i = 1, #members do
    local member = members[i]
    if member.actorUid ~= oriMembers[i].actorUid then
      isDifferent = true
    end
    if member.actorUid == 0 then
      isFilled = false
    end
  end
  return isDifferent, isFilled
end
