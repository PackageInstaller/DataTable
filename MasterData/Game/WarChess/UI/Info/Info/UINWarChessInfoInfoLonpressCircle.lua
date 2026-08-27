local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoLonpressCircle = class("UINWarChessInfoInfoLonpressCircle", base)

function UINWarChessInfoInfoLonpressCircle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoLonpressCircle:WCInfoLongPressCircleSetRate(rate)
  self.ui.img_longPressCircle.fillAmount = rate
end

function UINWarChessInfoInfoLonpressCircle:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoLonpressCircle
