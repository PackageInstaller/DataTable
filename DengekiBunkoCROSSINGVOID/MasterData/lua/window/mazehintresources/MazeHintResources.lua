local WU, DB, REF = require("Common/WindowUtil")(this)
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local m_effectScale = 2.38
local m_coroutine
local m_closing = false
local m_resources, m_callback

function SetupWindow()
  REF.NodeMask["$SetCallback"](OnClose)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_resources and m_resources[dataIndex]
    end,
    updateSlot = function(ref, item)
      if item == nil then
        return
      end
      ref["$$SetData"](item.type, item.id, item.countDelta or item.count)
      ref["$$SetOwnerBox"](item.ownerBoxId)
      ref["$$SetClickCallback"](nil)
    end,
    delta = 0.01
  })
end

function OnClose()
  if m_closing then
    return
  end
  m_closing = true
  ShowEffect("UI_panle_bg_middleB")
  REF.Resources.gameObject:SetActive(false)
  if m_coroutine ~= nil then
    this:StopCoroutine(m_coroutine)
    m_coroutine = nil
  end
  this:DelayInvokeInScaledSeconds(REF.EffectBG.EffectGenerator.Duration, function()
    WU.RecycleWindow(this)
    m_closing = false
    if m_callback then
      m_callback()
    end
  end)
end

function ShowHintIcon(items, callback, bSkinExchange)
  m_callback = callback
  m_resources = items
  REF.Resources.gameObject:SetActive(true)
  REF.LabelTitle.gameObject:SetActive(bSkinExchange)
  local cols = #REF.WidgetSlotRow7
  LU.Set(REF.WrapContent, math.ceil(#items / cols))
  ShowEffect("UI_panle_bg_middleA")
  local scale = REF.EffectPanel.transform.localScale
  scale.y = scale.y * m_effectScale
  REF.EffectPanel.transform.localScale = scale
end

function ShowEffect(effectName)
  REF.EffectBG.EffectGenerator.m_EffectName = effectName
  REF.EffectBG.EffectGenerator:Reset()
end
