local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local IU = require("Common/ItemUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_balance, m_rewards, m_skipAnim

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, false)
  WU.BindButtonEvent(REF.NodeContinue, function()
    BASE.OnButtonContinueClick()
  end)
  CS.EventDelegate.Add(REF.AcquirementContent.UIPlayTween.onFinished, function()
    OnTweenFinish()
  end)
  WU.BindButtonEvent(REF.AnimMask, function()
    m_skipAnim = true
    WU.ToggleRendering(REF.AnimMask, false)
    local hasReward = IsHasReward()
    WU.ToggleRendering(REF.NodeRewardTitle, hasReward)
    if hasReward then
      REF.AcquirementContent.UIPlayTween:Finish()
    else
      OnTweenFinish()
    end
  end)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "DungeonBalanceBurstLink",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    local groupData = DB:GetData("fci/BurstLinkPvpActorGroup/")
    local actorPool = DB:GetData("fci/BurstLinkPvpActor")
    local data = {
      groupData = groupData,
      resultInfo = m_balance,
      actorPool = actorPool
    }
    this:SetData("Share/DungeonBalanceBurstLink", data)
    WU.AcquireWindowAsync("Share")
  end)
  LU.Bind(REF.AcquirementContent, {
    updateRow = UpdateSlot
  })
end

function InitWindow()
  REF.ButtonShare.gameObject:SetActive(false)
  local fightDungeonType = this:GetData("FightDungeonType")
  if fightDungeonType == PB.enum.DungeonType.BurstLinkPvp and WU.IsShareSwitchOn() then
    REF.ButtonShare.gameObject:SetActive(true)
  end
  m_balance = this:GetData("DungeonBalance/result")
  if m_balance and m_balance.isWin then
    DB:SetData("fci/BurstLinkPvpBalance", m_balance)
  end
  info("burstlink m_balance", table.dump(m_balance))
  if m_balance then
    if m_balance.rewards then
      m_rewards = m_balance.rewards
    else
      m_rewards = DU.GetDungeonBalanceRewards(m_balance)
    end
  end
  WU.ToggleRendering(REF.NodeWinNum, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  InitAcquirement()
  NU.UpdateRoleFavour(m_balance.favourChange)
  WU.ToggleRendering(REF.AnimMask, true)
  local hasReward = false
  if hasReward then
    REF.AcquirementContent.UIPlayTween:Play(true)
  else
    OnTweenFinish()
  end
  if #m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
end

function OnTweenFinish()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, true)
  if m_balance.winNum > 0 then
    WU.ToggleRendering(REF.NodeWinNum, true)
    REF.LabelWinNum.UIHtmlLabel.text = m_balance.winNum
  end
  if m_rewards and #m_rewards > #REF.AcquirementContent - 1 then
    REF.AcquirementList.BoxCollider2D.enabled = true
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
    end)
  end
  BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
end

function IsHasReward()
  return m_balance and m_rewards and 0 < #m_rewards
end

function InitAcquirement()
  if m_rewards ~= nil then
    LU.Set(REF.AcquirementContent, #m_rewards)
    REF.AcquirementList.BoxCollider2D.enabled = false
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = false
    end)
  end
end

function UpdateSlot(ref, wrapIndex, realIndex)
  if m_rewards and realIndex < #m_rewards then
    local reward = m_rewards[realIndex + 1]
    ref["$$SetData"](reward.type, reward.id, reward.count)
    ref["$$SetOwnerBox"](reward.ownerBoxId)
  end
end
