local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local SDU = require("Common/SoundUtil")
local m_group, m_balance, m_rewards, m_skipAnim

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, false)
  WU.SetActive(REF.NewButton, false)
  REF.WidgetFightAgain["$SetContinueCall"](function()
    BASE.OnButtonContinueClick()
  end)
  CS.EventDelegate.Add(REF.TweenerGroup1.UIPlayTween.onFinished, function()
    if not m_skipAnim then
      REF.WidgetDungeonGroup["$SetLevelupExp"](m_balance.expChange, m_group, true)
    end
  end)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
end

function InitWindow()
  local recordUri = "fci/activity/record/" .. PB.enum.ActivityType.Carnival91 .. "/{SemiFixed/ActivityId}/"
  DB:SyncRemote(DB:GameRequest(recordUri))
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  BASE.SetActorTextureEffect(this:GetData("FightWinActor"))
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_balance = this:GetData("DungeonBalance/result")
  local changes = BASE.GetFavourChangeRoles(m_balance.favourChange)
  m_rewards = DU.GetDungeonBalanceRewards(m_balance)
  WU.ToggleRendering(REF.Targets, false)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.TitleLine2, false)
  WU.ToggleRendering(REF.WidgetDungeonGroup, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  local info = this:GetData("BalanceInfo/Groups")
  m_group = info.groups.groupInfo
  SemiFixedDungeonNPC(dungeonId, info.groups)
  REF.WidgetDungeonGroup["$SetView"](m_group)
  REF.WidgetDungeonGroup["$SetOldExp"](m_balance.expChange, m_group)
  REF.WidgetDungeonGroup["$SetFavourChangeIds"](changes)
  local balanceType = this:GetData("FightDungeonType")
  BASE.InitTargets(m_balance, dungeonId)
  local additionsInfo = AdditionsAcquirementInfo(m_group, dungeonId)
  BASE.InitAcquirement(m_balance, additionsInfo)
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
  BASE.InitPlayerInfo(m_balance)
  NU.UpdateRoleFavour(m_balance.favourChange)
  WU.ToggleRendering(REF.AnimMask, true)
  PlayPlayerExpAnim()
  local isShowStar = DU.IsShowStar(dungeonId)
  if isShowStar then
    if REF.LabelDesc then
      REF.LabelDesc.gameObject:SetActive(false)
    end
    if REF.Targets then
      REF.Targets.gameObject:SetActive(true)
    end
  else
    if REF.LabelDesc then
      REF.LabelDesc.gameObject:SetActive(true)
    end
    if REF.Targets then
      REF.Targets.gameObject:SetActive(false)
    end
    if REF.RightPanel then
      local curps = REF.RightPanel.transform.localPosition
      REF.RightPanel.transform.localPosition = CS.UnityEngine.Vector3(curps.x, REF.LabelDesc.transform.localPosition.y - 240, 0)
    end
    REF.LabelDesc.UILabel.text = WU.GetString("DungeonBalanceDescribe_" .. dungeonId)
  end
end

function OnWindowUninited(window)
  if window.name == "PlayerLevelupResult" then
    PlayOtherAnim()
  end
end

function SemiFixedDungeonNPC(dungeonId, groups)
  local semiFixedDungeon = PB.get("SemiFixedDungeon", dungeonId)
  local members = groups.groupInfo.members
  for i = 1, #semiFixedDungeon.npcId do
    local grouped = table.find(members, function(_, v)
      return v.index + 1 == i and v.isNpc
    end)
    if grouped then
      members[grouped].npcId = semiFixedDungeon.npcId[i]
    end
  end
end

function OnSkipAnimClick()
  if m_skipAnim then
    return
  end
  m_skipAnim = true
  WU.ToggleRendering(REF.Targets, true)
  WU.ToggleRendering(REF.TitleLine1, true)
  BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Right)
  WU.ToggleRendering(REF.TitleLine2, true)
  WU.ToggleRendering(REF.WidgetDungeonGroup, true)
  REF.SpriteExpAdd.TweenFillAmount.enabled = true
  REF.SpriteExpAdd.TweenFillAmount:FinishImmediately()
  BASE.ShiningStars(true)
  REF.Targets.UIPlayTween:Play(true)
  REF.Targets.UIPlayTween:Finish()
  REF.TweenerGroup1.UIPlayTween:Play(true)
  REF.TweenerGroup1.UIPlayTween:Finish()
  REF.WidgetDungeonGroup["$SetLevelupExp"](m_balance.expChange, m_group, false)
  WU.ToggleRendering(REF.AcquirementList, true)
  if 0 < #m_rewards then
    REF.AcquirementContent.UIPlayTween:Play(true)
    REF.AcquirementContent.UIPlayTween:Finish()
  end
  OnAnimFinished()
end

function PlayPlayerExpAnim()
  this:DelayInvokeInSeconds(0.5, function()
    if m_skipAnim then
      return
    end
    REF.SpriteExpAdd.TweenFillAmount.enabled = true
    if m_balance.playerLevelBeforeBalance == m_balance.playerLevel then
      this:DelayInvokeInSeconds(1, function()
        if m_skipAnim then
          return
        end
        PlayOtherAnim()
      end)
    end
  end)
end

function PlayOtherAnim()
  if m_skipAnim then
    return
  end
  WU.ToggleRendering(REF.Targets, true)
  REF.Targets.UIPlayTween:Play(true)
  BASE.ShiningStars()
  this:DelayInvokeInSeconds(BASE.ShiningStarDelay * #m_balance.targetsDone, function()
    if m_skipAnim then
      return
    end
    WU.ToggleRendering(REF.TitleLine1, true)
    REF.TitleLine1.UIPlayTween:Play(true)
    BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Right)
    this:DelayInvokeInSeconds(BASE.TitleAnimTime, function()
      if m_skipAnim then
        return
      end
      WU.ToggleRendering(REF.AcquirementList, true)
      REF.AcquirementContent.UIPlayTween:Play(true)
      this:DelayInvokeInSeconds(#m_rewards * BASE.RewardAnimTime, function()
        if m_skipAnim then
          return
        end
        WU.ToggleRendering(REF.TitleLine2, true)
        REF.TitleLine2.UIPlayTween:Play(true)
        this:DelayInvokeInSeconds(BASE.TitleAnimTime, function()
          if m_skipAnim then
            return
          end
          WU.ToggleRendering(REF.WidgetDungeonGroup, true)
          REF.TweenerGroup1.UIPlayTween:Play(true)
          this:DelayInvokeInSeconds(1, function()
            if m_skipAnim then
              return
            end
            OnAnimFinished()
          end)
        end)
      end)
    end)
  end)
end

function OnAnimFinished()
  local delayTime = 0
  this:DelayInvokeInSeconds(delayTime, function()
    WU.ToggleRendering(REF.AnimMask, false)
    WU.SetActive(REF.NewButton, true)
    if #m_rewards > #REF.AcquirementContent - 2 then
      REF.AcquirementList.BoxCollider2D.enabled = true
      WU.TraverseChildren(REF.AcquirementContent, function(go)
        go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
      end)
    end
    local bShake = false
    for i, v in ipairs(m_rewards) do
      if v.equip and v.equip.quality >= 4 then
        CS.GameUtility.Vibrate()
        break
      end
    end
    BASE.OnDungeonAnimFinished()
  end)
end

function OnDestroy()
  BASE.OnDestroy()
end

function AdditionsAcquirementInfo(groups, dungeonId)
  local indexToAdditions = {}
  local index = table.find(m_rewards, function(_, v)
    return v.extra
  end)
  if index then
    table.insert(indexToAdditions, index)
  end
  return indexToAdditions
end
