local base = UIBaseNode
local UINActSum22BuffItem = class("UINActSum22BuffItem", base)

function UINActSum22BuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActSum22BuffItem:InitActSum22BuffItem(desStr)
  self.ui.tex_BuffInfo.text = desStr
end

function UINActSum22BuffItem:OnDelete()
  base.OnDelete(self)
end

return UINActSum22BuffItem
