local UIPieText = class("UIPieText", UIBaseNode)
local base = UIBaseNode

function UIPieText:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIPieText:InitPieText(proportion, position)
  self.ui.tex_Rate:SetIndex(0, string.format("%.1f", proportion * 100))
  self.transform.position = position
end

function UIPieText:OnDelete()
  base.OnDelete(self)
end

return UIPieText
