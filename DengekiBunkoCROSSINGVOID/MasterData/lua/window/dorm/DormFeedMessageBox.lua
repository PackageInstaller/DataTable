local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFeed, OnClickFeed)
  WU.BindButtonEvent(REF.ButtonCancel, OnClickCancel)
end

function OnClickCancel()
  WU.RecycleWindow(this)
end

function OnClickFeed()
  this:BroadcastGameEvent("DormNeedUninit")
  WU.AcquireWindowAsync("DormFeed", function()
    WU.RecycleWindow(this)
  end)
end
