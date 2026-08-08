local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local LU = require("Common/ListUtil")
local m_repeatedContext = {}
local m_dungeonId, m_replayTween, m_groups
local m_pills = {}

function SetupWindow()
  Base.SetupWindow()
  this:SetData("TowerNew/PillSelected", {})
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    OnActorGroupChanged(patchData.members)
  end)
  Base.SetData("Fight", Fight)
end

function InitWindow()
  this:Bind("ActorGroupTower/DungeonId", OnActorGroupDungeonId)
  this:Bind("TowerNew/PillSelected", ManagePillSelected)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId})
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ActorGroupTower/DungeonId", context.dungeonId)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnActorGroupDungeonId(dungeonId)
  if dungeonId == nil then
    return
  end
  m_dungeonId = dungeonId
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  Base.SetData("displayAttrs", false)
  Base.SetData("powerMultiple", 1)
  Base.RefreshAttrDisplay()
  Base.OnDungeonInfo(dungeonId)
  m_replayTween = true
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/select-actors/"), function(response)
    if response == nil then
      return
    end
    this:BindRemote(DB:GameRequest("fci/extreme-challenge/actorgroup/"), OnActorGroupChanged)
  end)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function OnActorGroupChanged(result)
  if result ~= nil then
    m_groups = result.actorGroup or result
    if this:GetData("CurrentTutorial") == 7 then
      this:BroadcastGameEvent("Tutorial/StepReady")
    end
    RefreshGroupMembersAndTweenTower(m_groups, m_replayTween)
    m_replayTween = false
  end
end

function RefreshGroupMembersAndTweenTower(members, replay)
  if members then
    REF.WidgetGroupMembers["$SetTowerNewGroupMembers"](members)
    REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
    WU.ToggleRendering(REF.WidgetGroupMembers, true)
    if replay then
      REF.WidgetGroupMembers.UIPlayTween.enabled = false
      REF.WidgetGroupMembers.UIPlayTween.enabled = true
    end
  end
end

function Focus(on)
  if on and m_groups then
    local members = m_groups
    RefreshGroupMembersAndTweenTower(members, true)
  end
end

function Fight()
  if m_groups == nil then
    return
  end
  local members = SplitUid(m_groups)
  if GU.GroupIsOK(members, true) and HasActorDead() then
    Base.Member2FightActorInfo(members)
    RequestPostDungeon()
  end
end

function SplitUid(groups)
  for k, v in pairs(groups) do
    if v.actor then
      v.actorUid = v.actor.uid
    end
  end
  return groups
end

function HasActorDead()
  for _, member in pairs(m_groups) do
    if member.hp and member.actor then
      local hp = member.hp or member.actor.hp
      if hp < 0 then
        WU.ShowHintText(WU.GetString("Someone may not be able to fight"))
        return false
      end
    end
  end
  return true
end

function RequestPostDungeon()
  local summary = this:GetData("fci/extreme-challenge/summary/")
  local groupParam = {}
  for k, v in pairs(m_groups) do
    if v.actor then
      groupParam[k] = v.actor.index or v.index
    else
      groupParam[k] = 0
    end
  end
  local pillUse = {}
  for i = 1, 3 do
    if m_pills[i] then
      pillUse[i] = m_pills[i].id
    else
      pillUse[i] = 0
    end
  end
  local wireFormatTable = ProtobufT("ApiExtremeChallengeActorGroup", {actorIndexs = groupParam})
  this:GameRequest("fci/extreme-challenge/actorgroup/"):Post(wireFormatTable, function(groupResponse)
    m_groups = groupResponse.actorGroup
    local reduceInfo = {}
    local param = {
      dungeonId = m_dungeonId,
      multiPower = 1,
      price = DU.GetDungeonPrice(m_dungeonId),
      isChallengeMode = true,
      reduceInfo = reduceInfo
    }
    this:SetData("PowerMultiple", 1)
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = m_groups})
    this:GameRequest("fci/extreme-challenge/"):Post({buffItemUse = pillUse}, function(result)
      DBH.ResChange(result.resChange)
      local fightActorInfo = {
        {
          playerId = this:GetData("playerId"),
          actors = m_groups
        }
      }
      this:SetData("FightActorInfo", fightActorInfo)
      if m_groups ~= nil then
        local fightInitInfo = {
          {
            hp = result.challengeInfo.myHpList,
            monsterList = {
              0,
              0,
              0,
              0,
              0,
              0
            }
          },
          {
            hp = {
              0,
              0,
              0,
              0,
              0,
              0
            },
            monsterList = result.challengeInfo.enemyList
          }
        }
        this:SetData("FightInitInfo", fightInitInfo)
        WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, PB.enum.DungeonType.TowerNew, 1)
      end
    end)
  end)
end

function OnActorGroupButtonClick(go)
  this:SetData("fci/extreme-challenge/actorgroup/", m_groups)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("TowerNewActorSelect")
end

function ManagePillSelected(pills)
  pills = pills or {}
  WU.TraverseChildren(REF.PillGroup, function(go, index)
    local ref = _ENV["$"](go)
    local root = ref.root
    local realIndex = index + 1
    m_pills = pills
    if pills[realIndex] then
      ref.WidgetIconSlot["$SetData"](pills[realIndex].type, pills[realIndex].id)
    end
    ref.WidgetIconSlot.gameObject:SetActive(pills[realIndex])
    ref.ButtonEmpty.gameObject:SetActive(not pills[realIndex])
    if not root.bindB4 then
      WU.BindButtonEvent(ref.ButtonEmpty, function()
        WU.AcquireWindowAsync("TowerNewPillsSelect", function(ui)
          _ENV["$"](ui)["$$SetSelectedIndex"](realIndex)
        end)
      end)
      root.bindB4 = true
    end
  end)
end
