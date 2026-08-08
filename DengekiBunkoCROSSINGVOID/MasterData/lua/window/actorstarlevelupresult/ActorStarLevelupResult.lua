local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local m_effectTable = {}
local m_unlockSkillId = 0
local m_StarPhases = PB.index("Misc", 1).starPhases
local m_actor, m_resChange

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow("ActorStarLevelupResult")
  end)
  WU.BindButtonEvent(REF.ButtonContinue, function()
    WU.RecycleWindow("ActorStarLevelupResult")
  end)
end

function InitWindow()
  REF.ConenteBGEffect.gameObject:SetActive(false)
  SetStar(0)
end

function UninitWindow()
  this:BroadcastGameEvent("StarUpgradeWindowUninited", m_actor.star, m_resChange)
end

function SetStar(starCount)
  for i = 0, #REF.StarGrid - 1 do
    REF.StarGrid[i].root.gameObject:SetActive(i < starCount)
    if i < starCount then
      this:DelayInvokeInScaledSeconds(0.1 * i, function()
        CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GetStar")
        REF.StarGrid[i].root.EffectGenerator:Play()
      end)
    end
  end
  REF.StarGrid.UIGrid:Reposition()
end

function SetActor(actor, resChange)
  m_actor = actor
  m_resChange = resChange
  local oldAttrs = AU.GenActorStarPromotionsAccumulated(m_actor.id, m_actor.quality, m_actor.star - 1, m_StarPhases[m_actor.star - 1])
  local newAttrs = AU.GenActorStarPromotionsAccumulated(m_actor.id, m_actor.quality, m_actor.star, m_actor.curPhase)
  m_effectTable = {}
  local displayList = PB.index("AttrTypeSortOrder", 1).list
  for i = 1, #displayList do
    local type = displayList[i]
    if oldAttrs[type] and newAttrs[type] then
      table.insert(m_effectTable, AttrToDesc(oldAttrs[type], newAttrs[type]))
    end
  end
  table.insert(m_effectTable, {
    title = WU.GetString("Window_StarPromoteSkill")
  })
  table.insert(m_effectTable, {
    title = WU.GetString("Window_StarPromoteRelation")
  })
  REF.EffectTitle.EffectGenerator:Play(function()
    REF.ConenteBGEffect.gameObject:SetActive(true)
    REF.ConenteBGEffect.EffectGenerator:Play()
  end)
  m_unlockSkillId = 0
  local actorAttrStarPromotion = PB.get("ActorAttrStarPromotion", actor.id, actor.star, actor.curPhase)
  if actorAttrStarPromotion then
    m_unlockSkillId = actorAttrStarPromotion.unlockSkillId
  end
  REF.PanelContent.gameObject:SetActive(false)
  this:DelayInvokeInScaledSeconds(1.48, function()
    REF.PanelContent.gameObject:SetActive(true)
    SetStar(actor.star)
    PopulateEffects()
    REF.EffectGrid.UIPlayTween:Play(true)
  end)
end

function PopulateEffects()
  for i = 0, #REF.EffectGrid - 1 do
    local slotRef = REF.EffectGrid[i]
    local dataIndex = i + 1
    slotRef["$gameObject"]:SetActive(dataIndex <= #m_effectTable)
    if dataIndex <= #m_effectTable then
      local effect = m_effectTable[dataIndex]
      slotRef.LabelLeft.UILabel.text = effect.title
      slotRef.LabelRight.UILabel.text = effect.value or ""
      slotRef.LabelRightOld.UILabel.text = effect.valueOld or ""
      if effect.color then
        slotRef.LabelRight.UILabel.color = effect.color
      end
    end
  end
  REF.EffectGrid.UIGrid:Reposition()
  REF.NodeUnlockSkill.gameObject:SetActive(0 < m_unlockSkillId)
  if 0 < m_unlockSkillId then
    REF.WidgetUnlockSkill["$SetSkill"](m_unlockSkillId)
  end
  REF.EffectTable.UITable:Reposition()
end

function AttrToDesc(oldAttr, newAttr)
  local result
  if oldAttr and newAttr then
    result = {
      title = WU.GetString("Window_ActorAttrName_" .. newAttr.type),
      value = "+" .. U.FormatAttrValue(newAttr),
      valueOld = "+" .. U.FormatAttrValue(oldAttr)
    }
    if newAttr.value > oldAttr.value then
      result.color = CS.NGUIMath.HexToColor(1927741439)
    end
  end
  return result
end
