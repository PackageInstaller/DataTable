local UINCardSetDot = class("UINCardSetDot", UIBaseNode)
local base = UIBaseNode

function UINCardSetDot:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCardSetDot:OnDelete()
  base.OnDelete(self)
end

return UINCardSetDot
