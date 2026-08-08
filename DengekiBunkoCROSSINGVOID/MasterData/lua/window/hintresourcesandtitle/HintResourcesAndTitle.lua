local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local m_closing = false
local m_callback, m_resources, m_UIConfig

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
      if item.type == PB.enum.ResourceType.ResActor then
        ref["$$SetActorCustom"](item)
      else
        ref["$$SetData"](item.type, item.id, item.countDelta or item.count)
      end
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
  ShowEffectBG(m_UIConfig.effectBgLeave)
  WU.SetActive(REF.Resources, false)
  WU.SetActive(REF.EffectPanelTitle, false)
  WU.SetActive(REF.NodeTitle, false)
  this:DelayInvokeInScaledSeconds(REF.EffectBG.EffectGenerator.Duration, function()
    WU.RecycleWindow(this)
    m_closing = false
    if m_callback then
      m_callback()
    end
  end)
end

function ShowHintIcon(items, callback, fromWindow, params)
  m_resources = items
  m_callback = callback
  m_UIConfig = GetUIConfig(#items <= 7, fromWindow)
  WU.SetActive(REF.Resources, false)
  WU.SetActive(REF.NodeTitle, false)
  WU.TraverseChildren(REF.NodeTitle, function(go)
    WU.SetActive(go, false)
  end)
  REF.EffectBG.transform.localScale = m_UIConfig.effectBgScale
  REF.EffectTitle.EffectGenerator.m_EffectName = m_UIConfig.effectTitle
  REF.EffectTitle.transform.localPosition = m_UIConfig.effectTitlePos
  WU.SetActive(REF.EffectPanelTitle, true)
  REF.EffectTitle.EffectGenerator:Reset()
  REF.EffectTitle.EffectGenerator:Play(function()
    ShowHintIconImpl(params)
  end)
end

function ShowHintIconImpl(params)
  ShowSpecialUI(params)
  WU.SetActive(REF.NodeFewResources, m_UIConfig.isFew)
  WU.SetActive(REF.NodeManyResources, not m_UIConfig.isFew)
  WU.SetActive(REF.Resources, true)
  if m_UIConfig.isFew then
    for i = 0, #REF.NodeFewResources - 1 do
      local widget = REF.NodeFewResources[i]
      local item = m_resources[i + 1]
      widget["$gameObject"]:SetActive(item ~= nil)
      if item ~= nil then
        local count = item.count
        if item.countDelta and 0 < item.countDelta then
          count = item.countDelta
        end
        if item.type == PB.enum.ResourceType.ResActor then
          widget["$$SetActorCustom"]({
            id = item.id,
            quality = item.quality
          })
        else
          widget["$$SetData"](item.type, item.id, count)
        end
        widget["$$SetOwnerBox"](item.ownerBoxId)
      end
    end
    REF.NodeFewResources.UIGrid:Reposition()
    REF.NodeFewResources.UIPlayTween:Play(true)
  else
    local cols = #REF.WidgetSlotRow7
    LU.Set(REF.WrapContent, math.ceil(#m_resources / cols))
    REF.WrapContent.UIPlayTween:Play(true)
  end
  ShowEffectBG(m_UIConfig.effectBgEnter)
end

function ShowEffectBG(effectName)
  REF.EffectBG.EffectGenerator.m_EffectName = effectName
  REF.EffectBG.EffectGenerator:Reset()
end

function ShowSpecialUI(param)
  if m_UIConfig.fromWindow == "HotPotLevelUp" then
    REF.NodeTitle.transform.localPosition = m_UIConfig.nodeTitlePos
    WU.SetActive(REF.NodeHotPotLevelUp, true)
    local ref = _ENV["$"](REF.NodeHotPotLevelUp)
    ref.LabelPreLevel.UILabel.text = WU.GetString("Window_Level", param[1])
    ref.LabelNowLevel.UILabel.text = WU.GetString("Window_Level", param[2])
    WU.SetActive(REF.NodeTitle, true)
  end
end

function GetUIConfig(few, fromWindow)
  local config = {}
  config.fromWindow = fromWindow
  config.isFew = few
  if fromWindow == "HotPotLevelUp" then
    config.effectTitle = "result_title_25"
    config.effectTitlePos = fif(few, CS.UnityEngine.Vector3(0, -95, 0), CS.UnityEngine.Vector3(0, 15, 0))
    config.nodeTitlePos = fif(few, CS.UnityEngine.Vector3(0, -245, 0), CS.UnityEngine.Vector3(0, -350, 0))
    config.effectBgEnter = fif(few, "UI_panle_bg_middleA_PlayerLevelUp", "UI_panle_bg_bigA")
    config.effectBgLeave = fif(few, "UI_panle_bg_middleB_PlayerLevelUp", "UI_panle_bg_bigB")
    config.effectBgScale = fif(few, CS.UnityEngine.Vector3(1, 1, 1), CS.UnityEngine.Vector3(1, 1, 1))
  end
  return config
end
