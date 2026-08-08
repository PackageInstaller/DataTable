local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_displayActorTable, m_mode, m_initWindow
local m_repeatedContext = {}
local m_isCultivationPVPMode, m_ratioSwitch, m_activityType, m_activityId, m_showActivityHint
local m_TabScrollViewInitY = _ENV["$"](REF.Left).ScrollViewList.UIScrollView.transform.localPosition.y

function SetupWindow()
  Base.SetupWindow()
  BindTabs()
  WU.BindButtonEvent(REF.ActorLink, function()
    WU.RecordButtonClick(5327)
    OnActorLinkClick()
  end)
  WU.BindButtonEvent(REF.ActorMain, function()
    WU.RecordButtonClick(5326)
    OnActorMainClick()
  end)
  WU.BindButtonEvent(REF.Confirm, function()
    WU.RecordButtonClick(5329)
    OnConfirm()
  end)
  WU.BindButtonEvent(REF.SwitchRatio, function()
    SetRatioSwitch(not m_ratioSwitch, true)
  end)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  LU.Bind(REF.GroupTabNode, {
    updateRow = UpdateTab,
    delta = 0.01
  })
  Base.SetData("UpdateGroupActorUids", function(groups, copy)
    GU.UpdateGroupActorUids(groups, copy, m_mode)
  end)
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
end

function InitWindow()
  m_activityType = nil
  m_activityId = nil
  m_showActivityHint = false
  Base.InitWindow()
  this:Bind("ActorSelect/Mode", OnActorSelectMode)
  this:Bind("ActorSelect/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
  end)
  this:Bind("ActorSelect/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list)
    end
  end)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
  SetCultivationPVPMode(false)
  SetRatioSwitch(false, false)
  WU.SetActive(REF.ExtraHint, false)
end

function UninitWindow()
  this:SetData("ActorSelect/Mode", nil)
  Base.UninitWindow()
end

function SaveContext()
  table.insert(m_repeatedContext, {mode = m_mode, cultivationPVPMode = m_isCultivationPVPMode})
  this:SetData("GroupActorUids", this:GetData("GroupActorUidsCopy"))
  SetCultivationPVPMode(false)
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ActorSelect/Mode", context.mode)
    SetCultivationPVPMode(context.cultivationPVPMode)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnActorSelectMode(mode)
  if mode == nil then
    return
  end
  if m_mode ~= nil then
    this:Unbind("fci/SelectedGroupId/" .. GU.EnumToSelectedGroupApi[m_mode], OnSelectedActorGroupId)
  end
  local groupUids = this:GetData("GroupActorUids")
  local copyUids = {}
  table.copy(groupUids, copyUids)
  this:SetData("GroupActorUidsCopy", copyUids)
  m_mode = mode
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_initWindow = true
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(Base.GetData("currentGrid"), false)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/" .. GU.EnumToSelectedGroupApi[mode]), OnSelectedActorGroupId)
end

function OnSelectedActorGroupId(result)
  if result then
    local selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    Base.SetData("selectedGroupId", selectedGroupId)
    this:Unbind("fci/ActorGroup/", OnActorGroupChanged)
    this:BindRemote(DB:GameRequest("fci/ActorGroup/"), OnActorGroupChanged)
    local gourpsCount = table.count(Base.GetData("groups"))
    local currnetTab = Base.GetData("selectedGroupId") - 1
    local scrollView = _ENV["$"](REF.LeftSectionNode).ScrollViewList.UIScrollView
    local groupTip = _ENV["$"](REF.TipActorGroup)
    LU.Set(REF.GroupTabNode, gourpsCount)
    scrollView:MoveRelative(CS.UnityEngine.Vector3(0, REF.GroupTabNode.UIWrapContent.itemSize * currnetTab, 0))
    scrollView:RestrictWithinBounds(true)
    local preferences = m_configDataManager.GetPreferences()
    WU.SetActive(groupTip["$"], false)
    if not preferences.notFirstShowActorGroupTips and not S:Get("TutorialManager").IsTutorialDoing() then
      preferences.notFirstShowActorGroupTips = true
      m_configDataManager.SetPreferences(preferences)
      WU.SetActive(groupTip["$"], fif(5 < gourpsCount, true, false))
      WU.BindButtonEvent(groupTip.ButtonActorGroup, function()
        WU.SetActive(groupTip["$"], false)
      end)
    end
  end
end

local m_safeSwitchCallback

function SafeSwitch(GroupId)
  if Base.GetData("groups") ~= nil then
    Base.SwitchGroup(GroupId)
  else
    function m_safeSwitchCallback()
      Base.SwitchGroup(GroupId)
    end
  end
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    local groups = _ENV["!"]({})
    table.copy(actorGroup, groups, true)
    Base.SetData("groups", groups)
    local selectedGroupId = Base.GetData("selectedGroupId")
    RefreshGroupMembers(true, fif(m_isCultivationPVPMode, this:GetData("ActorGroup/CurrentCultivationRatios"), nil), m_showActivityHint, m_activityType, m_activityId)
    WU.ToggleRendering(REF.Panel, true)
    if m_initWindow then
      m_initWindow = false
      local index = this:GetData("AutoSlotSelection")
      this:SetData("AutoSlotSelection", nil)
      Base.ResetState(0, true, index)
      REF["$Animator"]:Play("DelayOpen", -1, 0)
    end
    if m_safeSwitchCallback then
      m_safeSwitchCallback()
      m_safeSwitchCallback = nil
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
    if m_mode == PB.enum.ActorGroupType.AsyncPvpNew then
      local showUp = AU.IsAsyncPvpNewUpActor(actor)
      rowRef["$$ShowBuffActivityInfo"](showUp)
    end
    if m_showActivityHint then
      local buffActors = PB.get("ActivityBuffActors", m_activityType, m_activityId)
      if buffActors then
        local showUP = table.has(buffActors.buffActor, actor.id)
        rowRef["$$ShowBuffActivityInfo"](showUP)
      end
    end
  end
end

function OnConfirm(isHome)
  local groups = Base.GetData("groups")
  if WU.IsStandaloneGame() then
    this:SetData("fci/ActorGroup/", groups)
    return
  end
  
  local function Recycle()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local selectedGroupId = Base.GetData("selectedGroupId")
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = groups}, function(response)
    this:SetData("fci/ActorGroup/", groups)
    local selectedGroup = this:GetData("fci/SelectedGroupId/" .. GU.EnumToSelectedGroupApi[m_mode])
    if selectedGroup ~= nil and selectedGroupId ~= selectedGroup.selectActorGroupId then
      this:GameRequest("fci/SelectedGroupId/" .. GU.EnumToSelectedGroupApi[m_mode]):Patch({selectActorGroupId = selectedGroupId}, function(response)
        this:SetData("fci/SelectedGroupId/" .. GU.EnumToSelectedGroupApi[m_mode], response)
        if m_isCultivationPVPMode then
          WU.ShowHintText(WU.GetString("Window_ActorGroupCultivationReplace"))
        end
        Recycle()
      end)
    else
      Recycle()
    end
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
  if WU.IsStandaloneGame() then
    winName = "StoryMode"
  end
  S:Get("TutorialManager").SetNavigation(winName)
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
  
  local originalGroups = this:GetData("fci/ActorGroup/")
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
  DontSave()
end

function Focus(on)
  WU.RecordWindowFocus(100153, on)
  if on then
    this:Bind("SortName", OnRecordSortOptionClick)
  else
    this:Unbind("SortName", OnRecordSortOptionClick)
  end
  Base.Focus(on)
  SetRatioSwitch(false, false)
end

function OnRecordSortOptionClick(sortName)
  if sortName then
    this:SetData("SortName", nil)
    WU.RecordButtonClick("153" .. sortName)
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
  local groupId = Base.GetData("selectedGroupId")
  local members = groups[tostring(groupId)].members
  for i = 1, #members do
    if members[i].actorUid ~= 0 then
      table.insert(traverseData, this:GetData("fci/actor/" .. members[i].actorUid))
    end
  end
  return traverseData
end

function SetCultivationPVPMode(isCultivationPVPMode)
  m_isCultivationPVPMode = false
  WU.SetActive(REF.SwitchRatio, m_isCultivationPVPMode)
end

function SetRatioSwitch(switch, refreshData)
  m_ratioSwitch = switch
  _ENV["$"](REF.SwitchRatio).Sprite.UISprite.color = CS.NGUIMath.HexToColor(fif(switch, 4294967295, 255))
  if refreshData then
    RefreshGroupMembers(true, fif(m_ratioSwitch, this:GetData("ActorGroup/CurrentCultivationRatios"), nil), m_showActivityHint, m_activityType, m_activityId)
  end
end

function ResetState()
  SetRatioSwitch(false, false)
end

function SetBuffActivity(activityType, activityId, showActivityHint)
  m_activityType = activityType
  m_activityId = activityId
  m_showActivityHint = showActivityHint
  WU.SetActive(REF.ExtraHint, activityType == PB.enum.ActivityType.MaidCafe_DaemonMode)
  RefreshGroupMembers(true, fif(m_ratioSwitch, this:GetData("ActorGroup/CurrentCultivationRatios"), nil), m_showActivityHint, m_activityType, m_activityId)
  LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable)
end

function RefreshGroupMembers(setMembers, ratios, showActivityHint, activityType, activityId)
  if m_mode == PB.enum.ActorGroupType.AsyncPvpNew then
    AsyncPvpNew_RefreshGroupMembers(setMembers, ratios)
  elseif showActivityHint then
    local typeName = PB.enum.ActivityType.__keys[activityType]
    local _Func = rawget(_ENV, typeName .. "RefreshGroupMembers")
    if _Func then
      _Func(setMembers, ratios, activityType, activityId)
    else
      Base.RefreshGroupMembers(setMembers, ratios)
    end
  else
    Base.RefreshGroupMembers(setMembers, ratios)
  end
end

function MaidCafe_DaemonModeRefreshGroupMembers(setMembers, ratios, activityType, activityId)
  if setMembers then
    local groups = Base.GetData("groups")
    local members = Base.DefaultGetMembers(groups)
    REF.WidgetGroupMembers["$SetBuffActivityGroupMember"](members, ratios, activityType, activityId)
    REF.WidgetGroupCultivation["$SetGroupMembers"](members, ratios)
  end
  REF.WidgetGroupMembers["$ShowCustom"]({
    showNew = false,
    showEquips = Base.GetData("displayOption") == SU.DisplayOption.equip,
    showName = Base.GetData("displayOption") == SU.DisplayOption.name,
    showArm = Base.GetData("displayOption") == SU.DisplayOption.arm,
    showCultivationTotal = Base.GetData("displayNumbers") == SU.DisplayNumbers.Cultivation,
    showSpeed = Base.GetData("displayNumbers") == SU.DisplayNumbers.Speed,
    showStar = Base.GetData("displayNumbers") == SU.DisplayNumbers.Star
  })
end

function UpdateTab(rowRef, wrapIndex, rowIndex)
  if rowIndex == nil then
    return
  end
  local trueIndex = rowIndex + 1
  local refLeft = _ENV["$"](REF.Left)
  local currentY = refLeft.ScrollViewList.UIScrollView.transform.localPosition.y
  if currentY - m_TabScrollViewInitY > refLeft.GroupTabNode.UIWrapContent.itemSize * 5 then
    WU.SetActive(refLeft.TipActorGroup, false)
  end
  rowRef["$UIToggle"].value = trueIndex == Base.GetData("selectedGroupId")
  rowRef.GroupGroupLabel.UILabel.text = trueIndex
  rowRef["@Index"] = trueIndex
  rowRef["@ClickCallBack"] = function()
    if Base.GetData("selectedGroupId") ~= trueIndex then
      if rowIndex < table.count(Base.GetData("groups")) then
        Base.SwitchGroup(trueIndex)
      else
        rowRef["$UIToggle"].value = false
        WU.TraverseChildren(refLeft.GroupTabNode, function(go)
          local ref = _ENV["$"](go)
          if ref["@Index"] == Base.GetData("selectedGroupId") then
            ref["$UIToggle"].value = true
          end
        end)
        WU.ShowHintText(WU.GetString("ActorSelect_GroupIsLocked"))
      end
    end
  end
end

function BindTabs()
  WU.TraverseChildren(REF.GroupTabNode, function(go)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(go, function()
      if ref["@ClickCallBack"] ~= nil then
        ref["@ClickCallBack"]()
        ref["$UIToggle"].value = true
      end
    end)
  end)
end

function AsyncPvpNew_RefreshGroupMembers(setMembers, ratios, activityType, activityId)
  if setMembers then
    local groups = Base.GetData("groups")
    local members = Base.DefaultGetMembers(groups)
    REF.WidgetGroupMembers["$SetAsyncPvpNewGroupMembers"](members, ratios)
    REF.WidgetGroupCultivation["$SetGroupMembers"](members, ratios)
  end
  Base.RefreshGroupMembers(false)
end
