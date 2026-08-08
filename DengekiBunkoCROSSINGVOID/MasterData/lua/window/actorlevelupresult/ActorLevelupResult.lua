local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local m_effectTable = {}

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow("ActorLevelupResult")
  end)
  LU.Bind(REF.WrapContentEffects, {
    updateRow = UpdateEffect
  })
end

function InitWindow()
  REF.ConenteBGEffect.gameObject:SetActive(false)
end

function UpdateEffect(slotRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_effectTable then
    local dataIndex = realIndex + 1
    if dataIndex <= #m_effectTable then
      local effect = m_effectTable[dataIndex]
      slotRef.LabelLeft.UILabel.text = effect.title
      slotRef.LabelRight.UILabel.text = effect.value
      slotRef.LabelRightOld.UILabel.text = effect.valueOld
      if effect.color then
        slotRef.LabelRight.UILabel.color = effect.color
      end
    end
  end
end

function SetActor(actor, actorLevelOld)
  REF.LabelLevel.UIHtmlLabel.text = WU.GetString("Window_Level", actor.level)
  local affectedAttrs = AU.GetActorLevelPromotion(actor.id, actor.quality, actorLevelOld, actor.level)
  local displayList = PB.index("AttrTypeSortOrder", 1).list
  m_effectTable = {}
  for i = 1, #displayList do
    local type = displayList[i]
    if affectedAttrs[type] then
      local attr = {
        type = type,
        value = U.GetAttrValue(actor.attrs, type)
      }
      table.insert(m_effectTable, AttrToDesc(attr, affectedAttrs[type]))
    end
  end
  REF.EffectTitle.EffectGenerator:Play(function()
    REF.ConenteBGEffect.gameObject:SetActive(true)
    REF.ConenteBGEffect.EffectGenerator:Play()
  end)
  REF.PanelContent.gameObject:SetActive(false)
  this:DelayInvokeInScaledSeconds(1.48, function()
    REF.PanelContent.gameObject:SetActive(true)
    PopulateEffects()
    REF.WrapContentEffects.UIPlayTween:Play(true)
  end)
end

function PopulateEffects()
  LU.Set(REF.WrapContentEffects, #m_effectTable)
end

function AttrToDesc(attr, deltaAttr)
  local result
  if attr then
    local attrOld
    local valueOld = 0
    if deltaAttr then
      attrOld = {
        type = deltaAttr.type,
        isRatio = deltaAttr.isRatio,
        value = attr.value - deltaAttr.value
      }
      valueOld = U.FormatAttrValue(attrOld)
    end
    local color
    if not attrOld or attr.value > attrOld.value then
      color = CS.NGUIMath.HexToColor(1927741439)
    end
    result = {
      title = WU.GetString("Window_ActorAttrName_" .. attr.type),
      value = U.FormatAttrValue(attr),
      valueOld = valueOld,
      color = color
    }
  end
  return result
end
