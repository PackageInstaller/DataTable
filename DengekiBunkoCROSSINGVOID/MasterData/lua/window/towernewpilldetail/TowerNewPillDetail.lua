local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local SE = require("Common/SkillEffect")

function SetPillDetail(data)
  local towerSumry = this:GetData("fci/extreme-challenge/summary/")
  local count = 0
  local desc = SE.GetTowerPillDesc(data.id, true)
  for k, v in pairs(towerSumry.challengeItems) do
    if v.id == data.id then
      count = count + v.count
    end
  end
  REF.LabelDesc.UIHtmlLabel.text = desc
  REF.LabelName.UIHtmlLabel.text = WU.GetString("Tower_PillName_" .. data.id)
  REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowItem_OwnCount") .. count
  REF.WidgetIconSlot["$SetData"](data.type, data.id, data.count)
end
