local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local m_actor

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow("ActorTalentResult")
  end)
end

function InitWindow()
  REF.ConenteBGEffect.gameObject:SetActive(false)
end

function SetResult(actor, actorBefore, materials)
  m_actor = actor
  REF.EffectTitle.EffectGenerator:Play(function()
    REF.ConenteBGEffect.gameObject:SetActive(true)
    REF.ConenteBGEffect.EffectGenerator:Play()
  end)
  REF.PanelContent.gameObject:SetActive(false)
  this:DelayInvokeInScaledSeconds(1.48, function()
    REF.PanelContent.gameObject:SetActive(true)
    REF.NodeMaterial.gameObject:SetActive(0 < #materials)
    for i = 0, #REF.MaterialList - 1 do
      local iconSlot = REF.MaterialList[i]
      iconSlot["$gameObject"]:SetActive(i < #materials)
      if i < #materials then
        local material = materials[i + 1]
        iconSlot["$$SetData"](material.type, material.id, material.countDelta)
      end
    end
    REF.MaterialList.UIGrid:Reposition()
  end)
end
