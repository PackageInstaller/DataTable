local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local m_groups, m_selectedGroupId, m_replayTween

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
  Base.InitAutoFight(PB.enum.DungeonType.Gold)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  if not WU.IsStandaloneGame() then
    Base.ResetAuraSelection()
  end
  local costWin = DU.GetDungeonGoldCost()
  local tickets = this:GetData("fci/item/" .. costWin.id).count
  if 0 < tickets then
    REF.resNumberLabel.UIHtmlLabel.text = tickets
  else
    REF.resNumberLabel.UIHtmlLabel.text = "<font color=#fd5454>" .. tickets .. "</font>"
  end
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/gold-dungeon"), OnSelectedActorGroupId)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
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
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Gold)
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    m_groups = actorGroup
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.Member2FightActorInfo(members)
    Base.RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
  end
end

function Fight()
  local members = m_groups[tostring(m_selectedGroupId)].members
  if GU.GroupIsOK(members, true) then
    this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
      this:BroadcastGameEvent("MedalAttrAppend")
      local costWin = DU.GetDungeonGoldCost()
      local tickets = this:GetData("fci/item/" .. costWin.id).count
      if tickets <= 0 then
        WU.ShowHintText(WU.GetString("Error_NotEnoughGoldTicket"))
        return
      end
      local param = {selectActorGroupId = m_selectedGroupId}
      Base.AppendAuraAttrs(param)
      local goldDungeonLevel = DU.GetDungeonGoldLevel()
      if goldDungeonLevel then
        this:SetData("WindowDungeon/EnterParam", param)
        local wireFormatTable = ProtobufT("ApiGoldDungeon", param)
        this:GameRequest("fci/gold-dungeon/"):Post(param, function(response)
          WU.EnterGameLevel(response.dungeonUid, response.baseInfo, goldDungeonLevel.dungeonId, PB.enum.DungeonType.Gold, 1, false)
        end)
      else
        warning("DungeonGoldActorGroup", "goldDungeonLevel is nil??")
      end
    end)
  end
end

function Focus(on)
  WU.RecordWindowFocus(100154, on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("DungeonGoldActorGroup", "ActorGroup")
  end
end
