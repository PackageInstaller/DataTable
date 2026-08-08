local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_confirmCallback, m_cancelCallback, m_sliderMaxValue, m_sliderMinValue, m_windowName, m_invertFill, m_curValue
local m_scales = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  WU.BindButtonEvent(REF.ButtonClose, OnCancelClick)
  WU.BindButtonEvent(REF.Black, OnCancelClick)
  CS.EventDelegate.Add(REF.Slider.UISlider.onChange, OnSliderChange)
end

function OnSliderChange()
  if m_sliderMaxValue and m_sliderMinValue then
    local realValue = REF.Slider.UISlider.value * (m_sliderMaxValue - m_sliderMinValue) + m_sliderMinValue
    local intValue = math.ceil(REF.Slider.UISlider.value * (m_sliderMaxValue - m_sliderMinValue) + m_sliderMinValue)
    if 0.5 < intValue - realValue then
      m_curValue = intValue - 1
    else
      m_curValue = intValue
    end
    if m_windowName == "FriendApplicationForm" then
      REF.LabelSlider.UIHtmlLabel.text = WU.GetString("Window_FriendApplyLevelLimit2", m_curValue)
    end
    if m_invertFill then
      REF.Foreground.UISprite.invert = m_invertFill
      REF.Foreground.UISprite.fillAmount = 1 - REF.Slider.UISlider.value
    end
  end
end

function ShowSliderBox(context, confirmCallback, cancelCallback)
  REF.LabelSlider.UIHtmlLabel.text = context.tips
  REF.LabelTitle.UIHtmlLabel.text = context.title
  m_windowName = context.windowName
  m_sliderMaxValue = context.maxValue
  m_sliderMinValue = context.minValue
  REF.Slider.UISlider.value = (context.value - m_sliderMinValue) / (m_sliderMaxValue - m_sliderMinValue)
  m_scales = context.scales
  m_invertFill = context.invertFill
  if m_invertFill then
    REF.Foreground.UISprite.invert = m_invertFill
    REF.Foreground.UISprite.fillAmount = 1 - REF.Slider.UISlider.value
  end
  local refRoot = REF.ScaleGrid[0].root.gameObject
  for i = 1, #m_scales - 1 do
    local go = CS.NGUITools.AddChild(REF.ScaleGrid.gameObject, refRoot)
  end
  for i = 0, #m_scales - 1 do
    local ref = REF.ScaleGrid[i].root
    ref.UIHtmlLabel.text = m_scales[i + 1]
    ref.transform.localPosition = {
      x = (m_scales[i + 1] - m_sliderMinValue) * REF.Slider.UISprite.width / (m_sliderMaxValue - m_sliderMinValue),
      y = 0,
      z = 0
    }
  end
  if confirmCallback then
    m_confirmCallback = confirmCallback
  end
  if cancelCallback then
    m_cancelCallback = cancelCallback
  end
end

function OnConfirmClick()
  if m_confirmCallback then
    m_confirmCallback(m_curValue)
  end
  CloseWindow()
end

function OnCancelClick()
  if m_cancelCallback then
    m_cancelCallback()
  end
  CloseWindow()
end

function CloseWindow()
  RemoveAllClone(REF.ScaleGrid)
  WU.RecycleWindow("SliderBox")
end

function RemoveAllClone(node)
  if node ~= nil then
    local childCnt = #node
    if 0 < childCnt then
      for i = childCnt - 1, 1, -1 do
        local obj = node[i]["$gameObject"]
        obj.transform.parent = nil
        CS.UnityEngine.GameObject.Destroy(obj)
      end
    end
  end
end
