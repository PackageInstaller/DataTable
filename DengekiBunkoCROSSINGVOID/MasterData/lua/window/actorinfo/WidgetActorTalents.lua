local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local m_actor

function Start()
  WU.BindButtonEvent(REF.ButtonAddChips, function()
    WU.RecordButtonClick(105029)
    WU.OpenActorDecompose({actor = m_actor})
  end)
  WU.BindButtonEvent(REF.ButtonStartReset, function()
    WU.RecordButtonClick(105027)
    if not DU.IsWaitingForJob(OnStartResetClick) then
      OnStartResetClick()
    end
  end)
  WU.BindButtonEvent(REF.ButtonUseGenericChip, OnUseGenericChipClick)
end

function OnEnable()
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
  local isResetUnlocked = not WU.WindowIsLocked(PB.enum.UnlockWindow.TalentReset)
  WU.SetActive(REF.NodeCostInfo, isResetUnlocked)
  WU.SetActive(REF.ButtonStartReset, isResetUnlocked)
  this:Bind("UseGenericChipForTalentReset", OnUseGenericChip)
  if this:GetData("fci/baseinfo").level >= 20 then
    WU.TriggerUnforcedTutorial(1108)
  end
end

function OnUseGenericChip(status)
  REF.SpriteCheck.gameObject:SetActive(status)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    UpdateTalent()
    REF.GridTalent.UIPlayTween:Play(true)
  end
end

function UpdateTalent()
  REF.LabelTotalScore.UIHtmlLabel.text = tostring(AU.ActorTalentScore(m_actor))
  local talentResetCost = PB.get("TalentResetCost", m_actor.id)
  local itemInfoCost = PB.get("ItemInfo", talentResetCost.cost.id)
  REF.SpriteCost.UISprite.spriteName = itemInfoCost.icon
  REF.LabelStock.ResourcePrinter:SetResource(talentResetCost.cost.type, talentResetCost.cost.id)
  local itemInfoCostSub = PB.get("ItemInfo", talentResetCost.costSub.id)
  REF.SpriteCostSub.UISprite.spriteName = itemInfoCostSub.icon
  REF.LabelStockSub.ResourcePrinter:SetResource(talentResetCost.costSub.type, talentResetCost.costSub.id)
  local talentCount = #m_actor.talentInfo
  local slotCount = #REF.GridTalent
  for i = 0, slotCount - 1 do
    local slotRef = REF.GridTalent[i]
    local pos = i + 1
    slotRef["$gameObject"]:SetActive(i < talentCount)
    if i < talentCount then
      slotRef["$$SetTalent"](m_actor.talentInfo[pos], {describe = true})
    end
  end
  REF.GridTalent.UIGrid:Reposition()
end

function OnStartResetClick()
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.TalentReset, PB.enum.UnlockWindow.TalentReset) then
    this:GameRequest("fci/talent/reset/" .. m_actor.uid):Get(OnGetResetResultResponse)
  end
end

function OnGetResetResultResponse(result)
  if result.talentPos > 0 and 0 < #result.talentResetInfo then
    WU.AcquireWindowAsync("ActorTalentResetResult", function(window)
      _ENV["$"](window)["$$SetResult"](m_actor, result)
    end)
  else
    local talentResetCost = PB.get("TalentResetCost", m_actor.id)
    local stock = this:GetData("fci/item/" .. talentResetCost.cost.id).count
    local stockSub = this:GetData("fci/item/" .. talentResetCost.costSub.id).count
    if 0 < stock + stockSub then
      WU.AcquireWindowAsync("ActorTalentReset")
    else
      WU.ShowHintText(WU.GetString("Talent_ResetCostNotEnough"))
    end
  end
end

function OnUseGenericChipClick()
  local toogle = this:GetData("UseGenericChipForTalentReset")
  if not toogle then
    WU.RecordButtonClick(105028)
  end
  this:SetData("UseGenericChipForTalentReset", not toogle)
end
