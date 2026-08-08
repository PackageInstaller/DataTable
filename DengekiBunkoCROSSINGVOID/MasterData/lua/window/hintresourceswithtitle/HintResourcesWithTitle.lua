local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local m_closing = false
local m_callback, m_items

function SetupWindow()
  REF.NodeMask["$SetCallback"](OnClose)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateWidget
  })
end

function OnClose()
  if m_closing then
    return
  end
  ShowEffectBG("UI_panle_bg_EquipB")
  m_closing = true
  WU.SetActive(REF.NodeContent, false)
  WU.SetActive(REF.NodeTitle, false)
  this:DelayInvokeInScaledSeconds(REF.EffectBG.EffectGenerator.Duration, function()
    WU.RecycleWindow(this)
    m_closing = false
    if m_callback then
      m_callback()
    end
  end)
end

function ShowHintIconImpl(titleText)
  WU.SetActive(REF.NodeContent, true)
  LU.Set(REF.WrapContent, #m_items)
  REF.WrapContent.UIPlayTween:Play(true)
  WU.SetActive(REF.NodeTitle, titleText ~= nil)
  if titleText then
    REF.LabelTitle.UILabel.text = titleText
  end
  ShowEffectBG("UI_panle_bg_middleA02")
end

function ShowHintIcon(items, callback, effectTitleName, titleText)
  m_items = items
  m_callback = callback
  REF.ScrollViewContent.UIScrollView.contentPivot = fif(#items <= 7, CS.UIWidget.Pivot.Center, CS.UIWidget.Pivot.Left)
  WU.SetActive(REF.NodeTitle, false)
  WU.SetActive(REF.NodeContent, false)
  REF.EffectTitle.EffectGenerator.m_EffectName = effectTitleName
  REF.EffectTitle.EffectGenerator:Reset()
  REF.EffectTitle.EffectGenerator:Play(function()
    ShowHintIconImpl(titleText, effectTitleName)
  end)
end

function ShowEffectBG(effectName)
  REF.EffectBG.EffectGenerator.m_EffectName = effectName
  REF.EffectBG.EffectGenerator:Reset()
  REF.EffectBG.EffectGenerator:Play()
end

function UpdateWidget(slotRef, wrapIndex, realIndex)
  if m_items and realIndex and realIndex < #m_items then
    local item = m_items[realIndex + 1]
    if item.type == PB.enum.ResourceType.ResActor then
      slotRef["$$SetActorCustom"]({
        id = item.id,
        quality = item.quality
      })
    elseif item.type == PB.enum.ResourceType.ResUniqueWeapon then
      local custom = {
        hideLevel = true,
        showEquip = false,
        phase = 1,
        showStar = false,
        isPreview = true
      }
      slotRef["$$SetData"](item.type, item.id, item.count, "S")
      slotRef["$$ShowCustom"](custom)
    else
      slotRef["$$SetData"](item.type, item.id, item.countDelta or item.count)
    end
    slotRef["$$SetOwnerBox"](item.ownerBoxId)
    slotRef["$$SetClickCallback"](nil)
  end
end
