local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FH = require("Common/FightHelper")
local itemIndex = -1

function Start()
  WU.BindButtonEvent(REF["$"].gameObject, OnSelectClick)
end

function UpdateData(gameObject, wrapIndex, realIndex)
  itemIndex = -realIndex + 1
  OnUpdateDir()
end

function OnUpdateDir()
  local talkTable = PB.all("TeamPVETalk")
  if talkTable then
    local buffCount = #talkTable
    if 0 < itemIndex and buffCount >= itemIndex then
      REF.LabelText.UILabel.text = WU.GetString(talkTable[itemIndex].talktag)
    end
  end
end

function OnSelectClick()
  this:BroadcastGameEvent("DungeonTeamGroupChatMsg", itemIndex, true)
end
