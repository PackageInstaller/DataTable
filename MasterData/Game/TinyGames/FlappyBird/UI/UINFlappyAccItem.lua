local UINFlappyAccItem = class("UINFlappyAccItem", UIBaseNode)
local base = UIBaseNode

function UINFlappyAccItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFlappyAccItem:OnDelete()
  base.OnDelete(self)
end

return UINFlappyAccItem
