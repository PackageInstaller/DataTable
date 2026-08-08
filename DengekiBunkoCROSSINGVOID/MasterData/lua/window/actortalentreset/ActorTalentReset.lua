local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local m_actor, m_talentPos, m_oldTalentInfo, m_newTalentInfo, m_initWindow, m_openResultCoro, m_resetResult
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}
local ActorQualityColors = {
  [0] = 2661925119,
  [1] = 885694207,
  [2] = 531949055,
  [3] = 2976907263,
  [4] = 3938272511
}

function SetupWindow()
  this:RegisterGameEvent("StartToResetTalent", SetResetResult)
  this:RegisterGameEvent("EventConfirmSelection", OnAnimationOpen)
  WU.BindButtonEvent(REF.ButtonAddChips, function()
    WU.RecordButtonClick(105031)
    WU.OpenActorDecompose({actor = m_actor})
  end)
  WU.BindButtonEvent(REF.ColliderEffect, OnColliderEffectClick)
  WU.BindButtonEvent(REF.ButtonUseGenericChip, OnUseGenericChipClick)
  WU.PreloadWindow("ActorTalentResetResult")
end

function InitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", true)
  m_initWindow = true
  WU.ToggleRendering(REF.NodeTalent, false)
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
  this:Bind("UseGenericChipForTalentReset", OnUseGenericChip)
  WU.TriggerUnforcedTutorial(1109, function(refTutorial)
    local p = REF.WidgetActorTalentSlot.transform.position
    refTutorial.UnforcedTutorialTipRim.transform.position = p
    p = refTutorial.UnforcedTutorialTipRim.transform.localPosition
    p.y = p.y + 100
    refTutorial.UnforcedTutorialTipRim.transform.localPosition = p
  end)
end

function UninitWindow()
  this:SetData("DungeonTeamInviteHint/Hide", nil)
end

function OnUseGenericChip(status)
  REF.SpriteCheck.gameObject:SetActive(status)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    UpdateTalent()
    REF.GridTalent.gameObject:SetActive(false)
    REF.GridTalent.gameObject:SetActive(true)
  end
end

function OnAnimationOpen()
  REF.GridTalent.UIPlayTween:Play(true)
end

function UpdateTalent()
  SetResetResult(false)
  if m_actor then
    REF.LabelTotalScore.UIHtmlLabel.text = tostring(AU.ActorTalentScore(m_actor))
    local talentResetCost = PB.get("TalentResetCost", m_actor.id)
    local itemInfoCost = PB.get("ItemInfo", talentResetCost.cost.id)
    REF.SpriteCost.UISprite.spriteName = itemInfoCost.icon
    REF.LabelStock.ResourcePrinter:SetResource(talentResetCost.cost.type, talentResetCost.cost.id)
    local itemInfoCostSub = PB.get("ItemInfo", talentResetCost.costSub.id)
    REF.SpriteCostSub.UISprite.spriteName = itemInfoCostSub.icon
    REF.LabelStockSub.ResourcePrinter:SetResource(talentResetCost.costSub.type, talentResetCost.costSub.id)
    REF.LabelTips.UIHtmlLabel.text = WU.GetString("Talent_ResetCostTip", talentResetCost.cost.count)
    REF.GridEffectSelected.gameObject:SetActive(true)
    local talentCount = #m_actor.talentInfo
    local slotCount = #REF.GridTalent
    for i = 0, slotCount - 1 do
      local slotRef = REF.GridTalent[i]
      local pos = i + 1
      slotRef["$gameObject"]:SetActive(i < talentCount)
      if i < talentCount then
        slotRef["@pos"] = pos
        local talent = m_actor.talentInfo[pos]
        slotRef["@data"] = AU.GetTalentDisplayInfo(talent.talentId, talent.talentValue)
        slotRef["$$SetTalent"](m_actor.talentInfo[pos], {
          describe = true,
          showEffect = true,
          BGColor = 4294967218,
          isYellowLabel = true,
          resetMode = true
        })
        slotRef["$$SetClickCallback"](OnTalentClick)
      end
      slotRef = REF.GridEffectSelected[i]
      slotRef["$gameObject"]:SetActive(i < talentCount)
    end
    REF.GridEffectSelected.UIGrid:Reposition()
    REF.GridTalent.UIGrid:Reposition()
    if m_initWindow then
      WU.ToggleRendering(REF.NodeTalent, true)
      REF.GridTalent.UIPlayTween:Play(true)
      m_initWindow = false
    end
  end
end

function OnTalentClick(slot)
  m_talentPos = _ENV["$"](slot)["@pos"]
  WU.RecordButtonClick(105100 + m_talentPos)
  AU.TryResetTalent(m_actor, m_talentPos, RequestReset)
end

function RequestReset()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_TalentReset")
  this:GameRequest("fci/talent/reset/"):Post({
    actorUid = m_actor.uid,
    talentPos = m_talentPos
  }, OnResetResponse)
end

function OnResetResponse(result)
  m_resetResult = result
  local oldTalent = m_actor.talentInfo[result.talentPos]
  local newTalent = result.talentResetInfo[1]
  m_oldTalentInfo = AU.GetTalentDisplayInfo(oldTalent.talentId, oldTalent.talentValue)
  m_newTalentInfo = AU.GetTalentDisplayInfo(newTalent.talentId, newTalent.talentValue)
  SetResetResult(true)
  ShowTalentResetResult()
  DBH.ResChange(result.resChange)
end

function ShowTalentResetResult()
  WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, true)
  m_openResultCoro = this:DelayInvokeInSeconds(0.75, function()
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
    m_openResultCoro = nil
    local intervals = PB.all("TalentMisc")[1].interval
    local gradeCount = #intervals
    if 1 < gradeCount and intervals[gradeCount - 1].val < m_newTalentInfo.score and m_newTalentInfo.score <= intervals[gradeCount].val then
      CS.GameUtility.Vibrate()
    end
    WU.AcquireWindowAsync("ActorTalentResetResult", function(window)
      _ENV["$"](window)["$$SetResult"](m_actor, m_resetResult)
    end)
  end)
end

function SetResetResult(active)
  REF.EffectResetting.gameObject:SetActive(active)
  if active then
    AU.ChangeTalentEffectTexture(REF.ACtortalent_oldbg02, REF.ACtortalent_oldicon02, m_oldTalentInfo)
    AU.ChangeTalentEffectTexture(REF.ACtortalent_newbg, REF.ACtortalent_newicon, m_newTalentInfo)
  end
end

function OnColliderEffectClick()
  if m_openResultCoro ~= nil then
    this:StopCoroutine(m_openResultCoro)
    m_openResultCoro = nil
    SetResetResult(false)
    REF.GridEffectSelected.gameObject:SetActive(false)
    WU.AcquireWindowAsync("ActorTalentResetResult", function(window)
      _ENV["$"](window)["$$SetResult"](m_actor, m_resetResult)
    end)
  else
    SetResetResult(false)
  end
end

function GetChipCount()
  local talentResetCost = PB.get("TalentResetCost", m_actor.id)
  local costCount = this:GetData("fci/item/" .. talentResetCost.cost.id).count
  local costSubCount = this:GetData("fci/item/" .. talentResetCost.costSub.id).count
  return costCount + costSubCount
end

function OnUseGenericChipClick()
  local toogle = this:GetData("UseGenericChipForTalentReset")
  if not toogle then
    WU.RecordButtonClick(105030)
  end
  this:SetData("UseGenericChipForTalentReset", not this:GetData("UseGenericChipForTalentReset"))
end

function Focus(on)
  WU.RecordWindowFocus(100105, true)
end
