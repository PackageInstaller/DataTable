local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoDeployMark = class("UINWarChessInfoInfoDeployMark", base)

function UINWarChessInfoInfoDeployMark:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoDeployMark:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoDeployMark
