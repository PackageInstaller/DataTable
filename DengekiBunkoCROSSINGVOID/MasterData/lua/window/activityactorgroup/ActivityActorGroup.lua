local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local ATU = require("Common/AutumnUtil")
local m_groups, m_selectedGroupId, m_dungeonId
local m_repeatedContext = {}
local m_reloadAura, m_replayTween, m_activityId, m_activityType, m_mode
local m_wheelMode = false
local m_balanceDungeonId

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
  Base.InitAutoFight(PB.enum.DungeonType.WeekActivity)
  m_reloadAura = true
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](function()
    OnNavigation(false)
  end)
  _ENV["$"](nav)["$$SetHomeCallback"](function()
    OnNavigation(true)
  end)
  this:Bind("ActivityActorGroup/DungeonInfo", OnActorGroupDungeonInfo)
end

function UninitWindow()
  m_mode = nil
  this:SetData("equipMinRequireLevelPosMap", nil)
  local nav = WU.FindWindow("Navigation")
  if nav then
    _ENV["$"](nav)["$$Load"]()
  end
end

function SaveContext()
  table.insert(m_repeatedContext, {
    dungeonId = m_dungeonId,
    activityId = m_activityId,
    activityType = m_activityType,
    mode = m_mode,
    wheelMode = m_wheelMode
  })
  m_reloadAura = true
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ActivityActorGroup/DungeonInfo", context)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnActorGroupDungeonInfo(dungeonInfo)
  if dungeonInfo == nil then
    return
  end
  m_dungeonId = dungeonInfo.dungeonId
  m_activityId = dungeonInfo.activityId
  m_activityType = dungeonInfo.activityType
  m_wheelMode = dungeonInfo.wheelMode
  m_balanceDungeonId = dungeonInfo.balanceDungeonId
  m_mode = dungeonInfo.mode
  WU.SetActive(REF.ExtraHint, m_activityType == PB.enum.ActivityType.MaidCafe_DaemonMode)
  WU.SetActive(REF.NodeHintMultiPower, not m_wheelMode)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  Base.SetData("powerMultiple", 1)
  WU.SetActive(REF.ButtonAddTimes, not m_wheelMode)
  REF.WidgetStarGridMTargets["$SetStar"](0)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  if not WU.IsStandaloneGame() and m_reloadAura then
    m_reloadAura = false
    Base.ResetAuraSelection()
  end
  if m_balanceDungeonId and m_wheelMode then
    Base.OnDungeonInfo(m_dungeonId, m_balanceDungeonId)
  else
    Base.OnDungeonInfo(m_dungeonId)
  end
  OnActivityRecord(m_dungeonId, m_balanceDungeonId)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/activity-dun"), OnSelectedActorGroupId)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function OnActivityRecord(dungeonId, balanceDungeonId)
  local records
  if m_mode == "EventActivity" then
    if ATU.UsedForAutumn(m_activityType) then
      records = this:GetData("fci/event-dungeon/record/")
    else
      records = this:GetData(string.format("fci/activity/record/%s/%s", m_activityType, m_activityId))
      if records ~= nil then
        records = records.records
      else
        records = {}
      end
    end
  else
    records = this:GetData("fci/activity-dungeon/record/")
  end
  local _, record = table.find(records, function(_, v)
    return v.dungeonId == dungeonId
  end)
  if record == nil then
    record = {
      finished = false,
      multiPower = 0,
      targetsDone = {},
      doneTimes = 0
    }
  end
  local dungeonReward
  if balanceDungeonId then
    dungeonReward = PB.get("DungeonReward", balanceDungeonId)
  else
    dungeonReward = PB.get("DungeonReward", dungeonId)
  end
  Base.SetData("dungeonReward", dungeonReward)
  Base.SetData("canAddTimes", false)
  Base.SetLeftTimes(record)
  local isMultiPowerLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.MultiPower)
  local multiPowerShow = DU.IsShowStar(dungeonId) and not m_wheelMode
  REF.ButtonMultiPower.BoxCollider2D.enabled = multiPowerShow
  REF.SpriteMultiPower.gameObject:SetActive(multiPowerShow)
  REF.SpriteMultiPower.UISprite.alpha = fif(isMultiPowerLocked, 0.3, 1)
  local starCount = 0
  if multiPowerShow then
    starCount = fif(record.finished, #record.targetsDone, 0)
  end
  Base.ShowStars(starCount)
  WU.ToggleRendering(REF.PowerDropList, false)
  if not isMultiPowerLocked and multiPowerShow then
    Base.SetMultiPowerStatus(record)
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
  WU.AcquireWindowAsync("ActorSelect", function(win)
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Activity)
    if m_activityType == PB.enum.ActivityType.MaidCafe_DaemonMode then
      _ENV["$"](win)["$$SetBuffActivity"](m_activityType, m_activityId, true)
    end
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    m_groups = actorGroup
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.Member2FightActorInfo(members)
    ActivityRefreshGroupMembersAndTween(members, m_replayTween, m_activityType)
    m_replayTween = false
  end
end

function Fight()
  local members = m_groups[tostring(m_selectedGroupId)].members
  if GU.GroupIsOK(members, true) then
    local isReach, testResult = Base.FightAfterCultivationTest(members, m_dungeonId)
    if isReach then
      RequestPostDungeon()
    else
      Base.FightCultivationHint(testResult, RequestPostDungeon)
    end
  end
end

function RequestPostDungeon()
  local members = m_groups[tostring(m_selectedGroupId)].members
  Base.Member2FightActorInfo(members)
  local price
  if m_wheelMode then
    local price1 = DU.GetDungeonPrice(m_dungeonId)
    local price2 = DU.GetDungeonPrice(m_balanceDungeonId)
    price = {
      type = price1.type,
      id = price1.id,
      count = price1.count + price2.count
    }
  else
    price = DU.GetDungeonPrice(m_balanceDungeonId)
  end
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
    this:BroadcastGameEvent("MedalAttrAppend")
    local powerMultiple = Base.GetData("powerMultiple")
    local param = {
      activityId = m_activityId,
      activityType = m_activityType,
      dungeonId = m_dungeonId,
      selectActorGroupId = m_selectedGroupId,
      multiPower = powerMultiple,
      price = price,
      wheelMode = m_wheelMode,
      wheelModeBalanceDungeonId = m_balanceDungeonId
    }
    Base.AppendAuraAttrs(param)
    this:SetData("PowerMultiple", powerMultiple)
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = m_groups, selectedGroupId = m_selectedGroupId})
    if m_mode == "EventActivity" then
      this:SetData("Event/ActivityType", m_activityType)
      this:SetData("Event/ActivityId", m_activityId)
      PostDungeon("ApiEventDungeon", "fci/event-dungeon/", PB.enum.DungeonType.WeekActivity, param)
    else
      this:SetData("Event/ActivityType", nil)
      PostDungeon("ApiActivityDungeon", "fci/activity-dungeon/", PB.enum.DungeonType.WeekActivity, param)
    end
  end)
end

function PostDungeon(apiName, uri, DungeonType, param)
  local wireFormatTable = ProtobufT(apiName, param)
  this:GameRequest(uri):Post(wireFormatTable, function(response)
    DBH.ResChange(response.resChange)
    WU.EnterGameLevel(response.dungeonUid, response.baseInfo, m_dungeonId, DungeonType, 1, false)
  end)
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    ActivityRefreshGroupMembersAndTween(members, true, m_activityType)
  end
  if on then
    WU.SetWindowTitle("ActivityActorGroup", "ActorGroup")
  end
end

function OnButtonAddTimesClick()
  WU.Exchange(PB.enum.ResourceType.ResDungeonPlayTimesLimit, m_dungeonId, true)
end

function ActivityRefreshGroupMembersAndTween(members, replay, activityType)
  if activityType == nil then
    return
  end
  local typeName = PB.enum.ActivityType.__keys[activityType]
  local _Func = rawget(_ENV, typeName .. "RefreshGroupMembersAndTween")
  if _Func then
    _Func(members, replay)
  else
    Base.RefreshGroupMembersAndTween(members, replay)
  end
end

function MaidCafe_DaemonModeRefreshGroupMembersAndTween(members, replay)
  if members then
    REF.WidgetGroupMembers["$SetBuffActivityGroupMember"](members, nil, m_activityType, m_activityId)
    if REF.WidgetGroupCultivation then
      REF.WidgetGroupCultivation["$SetGroupMembers"](members)
    elseif REF.WidgetGroupCultivation4Group then
      REF.WidgetGroupCultivation4Group["$SetGroupMembers"](members)
    end
    REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
    WU.ToggleRendering(REF.WidgetGroupMembers, true)
    if replay then
      REF.WidgetGroupMembers.UIPlayTween.enabled = false
      REF.WidgetGroupMembers.UIPlayTween.enabled = true
    end
  end
end

function OnNavigation(isHome)
  local function Next(isHome)
    if isHome then
      this:BroadcastGameEvent("OnNavigation", "City")
    else
      this:BroadcastGameEvent("OnNavigation", "Back")
    end
  end
  
  local function FuncBack(isHome)
    WU.ShowMessageYesNo(WU.GetString("ArmWarmup_LeaveDungeonTips"), function(result)
      if result == "YES" then
        Next(isHome)
      end
    end)
  end
  
  if m_activityType == PB.enum.ActivityType.Warmup_Chapter and m_activityId == 87006 then
    local top = WU.TopWindow()
    if isHome == false then
      if top and top.name == "ActivityActorGroup" then
        FuncBack(isHome)
      else
        Next(isHome)
      end
    else
      FuncBack(isHome)
    end
  else
    Next(isHome)
  end
end
