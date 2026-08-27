local UINHudTextItem = class("UINHudTextItem", UIBaseNode)
local base = UIBaseNode

function UINHudTextItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHudTextItem:RefreshHudTextItem(num)
  self.ui.tex_Left.text = tostring(num)
  self.ui.tex_Right.text = tostring(num)
end

function UINHudTextItem:OnDelete()
  base.OnDelete(self)
end

return UINHudTextItem
