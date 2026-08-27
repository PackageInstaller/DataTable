local UINSkadaValueItem = class("UINSkadaValueItem", UIBaseNode)
local base = UIBaseNode

function UINSkadaValueItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSkadaValueItem:InitSkadaValueItem(color)
  self.ui.img_Color.color = color
end

function UINSkadaValueItem:SetSkadaValue(progress, value, alpha)
  self.ui.slider.value = progress
  self.ui.tex_Value:SetIndex(0, tostring(value), string.format("%.f", progress * 100))
  self.ui.canvasGroup.alpha = alpha
end

function UINSkadaValueItem:OnDelete()
  base.OnDelete(self)
end

return UINSkadaValueItem
