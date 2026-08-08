local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_playerId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonExit, function(go)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonContinue, OnButtonReportClick)
  WU.TraverseChildren(REF.Settings, function(go, i)
    CS.EventDelegate.Add(_ENV["$"](go)["$"].UIToggle.onChange, function()
      REF.ButtonContinue.UIButton.isEnabled = HasCheckedOptions()
    end)
  end)
end

function InitWindow()
  m_playerId = nil
  WU.TraverseChildren(REF.Settings, function(go, i)
    _ENV["$"](go)["$"].UIToggle.value = false
  end)
  REF.ButtonContinue.UIButton.isEnabled = false
end

function HasCheckedOptions()
  for i = 0, #REF.Settings - 1 do
    if REF.Settings[i]["$"].UIToggle.value then
      return true
    end
  end
  return false
end

function SetPlayerId(playerId)
  m_playerId = playerId
end

function OnButtonReportClick()
  if m_playerId ~= nil then
    local reason = 0
    WU.TraverseChildren(REF.Settings, function(go, i)
      if _ENV["$"](go)["$"].UIToggle.value then
        reason = 1 << i | reason
      end
    end)
    this:GameRequest("fci/report/"):Post({playerId = m_playerId, reason = reason}, function(result)
      WU.ShowHintText(WU.GetString("Window_ReportReceived"))
      WU.RecycleWindow(this)
    end)
  end
end
