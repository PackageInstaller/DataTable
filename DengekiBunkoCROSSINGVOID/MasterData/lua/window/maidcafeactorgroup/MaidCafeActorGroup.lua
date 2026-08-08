local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local m_groups, m_selectedGroupId, m_dungeonId
local m_repeatedContext = {}
local m_replayTween, m_balanceDungeonId, m_rankType, m_cost, m_activityId, m_activityType

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnActorGroupChanged(m_groups)
  end)
  WU.BindButtonEvent(_ENV["$"](REF.Ticket).LabelCost, OnClickTickets)
  WU.BindButtonEvent(REF.ButtonFight, OnClickButtonFight)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.MaidCafe)
  this:Bind("MaidCafe/DungeonInfo", OnActorGroupDungeonInfo)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function OnActorGroupDungeonInfo(dungeonInfo)
  if dungeonInfo == nil then
    return
  end
  m_dungeonId = dungeonInfo.dungeonId
  m_activityId = dungeonInfo.activityId
  m_rankType = dungeonInfo.rankType
  m_balanceDungeonId = dungeonInfo.balanceDungeonId
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  local price1 = DU.GetDungeonPrice(m_dungeonId)
  local price2 = DU.GetDungeonPrice(m_balanceDungeonId)
  WU.SetActive(REF.LabelCost, price2.count ~= 0)
  if price2.count == 0 then
    m_cost = {
      type = 0,
      id = 0,
      count = 0
    }
  else
    m_cost = {
      type = price2.type,
      id = price2.id,
      count = price1.count + price2.count
    }
    REF.LabelCost.ResourcePrinter:SetResource(m_cost.type, m_cost.id, m_cost.count)
  end
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/activity-dun"), OnSelectedActorGroupId)
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
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Activity)
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    m_groups = actorGroup
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
  end
end

function OnClickButtonFight()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        local status = ACU.GetStatus(activity)
        if status == PB.enum.ActivityStatus.Started then
          local members = m_groups[tostring(m_selectedGroupId)].members
          if members and GU.GroupIsOK(members, true) then
            local isReach, testResult = Base.FightAfterCultivationTest(members, m_dungeonId)
            if isReach then
              if m_rankType == PB.enum.MaidCafeRankModeType.Free then
                RequestPostDungeon()
              else
                WU.TryToPay(m_cost.type, m_cost.id, m_cost.count, RequestPostDungeon)
              end
            else
              Base.FightCultivationHint(testResult, function()
                WU.TryToPay(m_cost.type, m_cost.id, m_cost.count, RequestPostDungeon)
              end)
            end
          end
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function RequestPostDungeon()
  local members = m_groups[tostring(m_selectedGroupId)].members
  Base.Member2FightActorInfo(members)
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
    this:BroadcastGameEvent("MedalAttrAppend")
    local powerMultiple = Base.GetData("powerMultiple")
    local param = {
      dungeonExCreateParam = {
        common = {
          dungeonId = m_dungeonId,
          selectActorGroupId = m_selectedGroupId,
          multiPower = powerMultiple,
          price = m_cost,
          wheelMode = true,
          wheelModeBalanceDungeonId = m_balanceDungeonId
        },
        maidcafe = {rankModeType = m_rankType}
      }
    }
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = m_groups, selectedGroupId = m_selectedGroupId})
    local uri = "fci/dungeon-ex/"
    local wireFormatTable = ProtobufT("ApiDungeonEx", param)
    this:GameRequest(uri):Post(wireFormatTable, function(response)
      local exResponse = response.dungeonExCreateResult
      DBH.ResChange(exResponse.common.resChange)
      WU.EnterGameLevel(exResponse.common.dungeonUid, exResponse.common.baseInfo, m_dungeonId, PB.enum.DungeonType.MaidCafe, 1, false)
    end)
  end)
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("MaidCafeActorGroup", "ActorGroup")
  end
end

function OnClickTickets()
  if m_cost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(m_cost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. m_cost.type))
  end
end
