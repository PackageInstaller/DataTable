local S = require("Common/Singleton"):Register(_ENV, "UILogDataReporter")
local WU, DB, REF = require("Common/WindowUtil")(this)

function Start()
  this:RegisterGameEvent("OnPlayerLevelup", OnPlayerLevelup)
end

function OnPlayerLevelup(levelBefore, levelCurrent)
  WU.RecordLevelup(levelCurrent)
end
