local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")

function InitWindow()
  REF.ScrollView.UIScrollView:ResetPosition()
  this:DelayInvokeInFrames(1, function()
    REF.Table.UITable:Reposition()
  end)
end
