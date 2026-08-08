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

function OnEnable()
  this:Bind("ActorInfo/CurrentActorDisplay", OnCurrentActorChange)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActorDisplay", OnCurrentActorChange)
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
