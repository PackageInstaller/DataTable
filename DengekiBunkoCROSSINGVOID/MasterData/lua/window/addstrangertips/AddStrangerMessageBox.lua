local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local S = require("Common/Singleton")
local m_toggleValue = true
local m_configDataManager = S:Get("ConfigDataManager")

function SetupWindow()
  WU.BindButtonEvent(REF.BtnYes, OnUIClose)
  REF.ButtonClose["$SetCallback"](OnUIClose)
  CS.EventDelegate.Add(REF.ToggleStrangerTips.UIToggle.onChange, function()
    m_toggleValue = CS.UIToggle.current.value
  end)
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
end
