local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_StandSwitch = class("WCI_StandSwitch", base)

function WCI_StandSwitch:ctor()
  self.needWalk = true
  self.isWalk2NearBy = false
end

return WCI_StandSwitch
