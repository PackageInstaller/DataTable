local UINWAMMMapLevelCurItem = class("UINWAMMMapLevelCurItem", UIBaseNode)
local base = UIBaseNode

function UINWAMMMapLevelCurItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWAMMMapLevelCurItem:OnDelete()
  base.OnDelete(self)
end

return UINWAMMMapLevelCurItem
