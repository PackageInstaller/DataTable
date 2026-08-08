local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function InitWindow()
  local towerSumry = this:GetData("fci/extreme-challenge/summary/")
  REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowItem_OwnCount") .. towerSumry.curScore
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResExtremeChallengeScore, 1, 0)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
end
