local base = UIBaseNode
local UINActSum22TechEffectItem = class("UINActSum22TechEffectItem", base)

function UINActSum22TechEffectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActSum22TechEffectItem:InitActSum22TechEffectItem()
end

function UINActSum22TechEffectItem:OnDelete()
  base.OnDelete(self)
end

return UINActSum22TechEffectItem
