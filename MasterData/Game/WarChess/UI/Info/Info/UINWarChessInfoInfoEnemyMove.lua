local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoEnemyMove = class("UINWarChessInfoInfoEnemyMove", base)

function UINWarChessInfoInfoEnemyMove:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoEnemyMove:SetCouldMoveDistance(num)
  self.ui.tex_move:SetIndex(0, tostring(num))
end

function UINWarChessInfoInfoEnemyMove:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoEnemyMove
