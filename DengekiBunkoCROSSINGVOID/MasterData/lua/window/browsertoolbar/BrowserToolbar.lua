local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")

function SetupWindow()
  WU.BindButtonEvent(REF.PicSkip, function(go)
    WU.RecordButtonClick(100135001)
    this:BroadcastGameEvent("CloseBrowser")
    WU.RecycleWindow("BrowserToolbar")
  end)
  WU.BindButtonEvent(REF.PicBack, function(go)
    this:BroadcastGameEvent("BrowserGoBack")
  end)
  WU.BindButtonEvent(REF.PicForward, function(go)
    this:BroadcastGameEvent("BrowserGoForward")
  end)
end

function InitWindow()
end

function UninitWindow()
end

function UpdateWindow(delta)
end

function Focus(on)
  WU.RecordWindowFocus(100135, on)
end
