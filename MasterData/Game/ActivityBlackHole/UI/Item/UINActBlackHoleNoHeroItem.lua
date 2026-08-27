local base = UIBaseNode
local UINActBlackHoleNoHeroItem = class("UINActBlackHoleNoHeroItem", base)

function UINActBlackHoleNoHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActBlackHoleNoHeroItem:OnDelete()
end

return UINActBlackHoleNoHeroItem
