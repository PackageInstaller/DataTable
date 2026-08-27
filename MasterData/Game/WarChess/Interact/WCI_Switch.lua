local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_Switch = class("WCI_Switch", base)

function WCI_Switch:ctor()
  self.needWalk = true
  self.isWalk2NearBy = true
end

return WCI_Switch
