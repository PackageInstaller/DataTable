local UINSkadaInfoItem = class("UINSkadaInfoItem", UIBaseNode)
local base = UIBaseNode

function UINSkadaInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSkadaInfoItem:InitSkadaInfoItem(color, name, count, value, progress)
  self.ui.img_Cube.color = color
  self.ui.img_bar.color = color
  self.ui.tex_name.text = name
  self.ui.tex_Count.text = count and tostring(count) or ""
  self.ui.tex_Value.text = tostring(value)
  self.ui.tex_Percent.text = string.format("%.f%%", progress * 100)
  self.ui.img_bar.fillAmount = progress
end

function UINSkadaInfoItem:OnDelete()
  base.OnDelete(self)
end

return UINSkadaInfoItem
