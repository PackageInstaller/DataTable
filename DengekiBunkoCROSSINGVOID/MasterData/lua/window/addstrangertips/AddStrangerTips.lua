local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local m_toggleValue
local m_configDataManager = S:Get("ConfigDataManager")
local m_callBack

function SetupWindow()
  WU.BindButtonEvent(REF.BtnYes, OnUIClose)
  REF.ButtonClose["$SetCallback"](OnUIClose)
  CS.EventDelegate.Add(REF.ToggleStrangerTips.UIToggle.onChange, function()
    m_toggleValue = CS.UIToggle.current.value
  end)
  local preferences = m_configDataManager.GetPreferences()
  m_toggleValue = preferences.auraHintControl
  if m_toggleValue ~= nil then
    REF.ToggleStrangerTips.UIToggle.value = m_toggleValue
  else
    REF.ToggleStrangerTips.UIToggle.value = true
  end
end

function OnUIClose()
  WU.RecycleWindow(this)
end

function UninitWindow(window)
  local preferences = m_configDataManager.GetPreferences()
  if m_toggleValue ~= nil then
    preferences.auraHintControl = m_toggleValue
    m_configDataManager.SetPreferences(preferences)
  end
  if m_callBack then
    m_callBack()
  end
end

function SetCallBack(call)
  m_callBack = call
end
