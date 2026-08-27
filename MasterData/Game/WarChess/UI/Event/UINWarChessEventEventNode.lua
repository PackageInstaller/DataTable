local base = require("Game.WarChess.UI.Event.UINWarChessEventTypeNodeBase")
local UINWarChessEventEventNode = class("UINWarChessEventEventNode", base)

function UINWarChessEventEventNode:OnInit()
  base.OnInit(self)
end

return UINWarChessEventEventNode
