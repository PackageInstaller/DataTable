local base = UIBaseNode
local UINWarChessInfoInfoBase = class("UINWarChessInfoInfoBase", base)

function UINWarChessInfoInfoBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoBase:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoBase
