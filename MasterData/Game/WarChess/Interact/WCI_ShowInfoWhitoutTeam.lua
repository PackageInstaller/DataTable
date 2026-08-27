local base = require("Game.WarChess.Interact.WCI_ShowInfo")
local WCI_ShowInfoWhitoutTeam = class("WCI_ShowInfoWhitoutTeam", base)

function WCI_ShowInfoWhitoutTeam:ctor()
  self.needWalk = false
end

return WCI_ShowInfoWhitoutTeam
