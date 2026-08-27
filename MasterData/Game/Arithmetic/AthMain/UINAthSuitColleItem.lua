local UINAthSuitColleItem = class("UINAthSuitColleItem", UIBaseNode)
local base = UIBaseNode

function UINAthSuitColleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthSuitColleItem:InitAthSuitColleItem(num)
  self.ui.tex_Colle:SetIndex(0, tostring(num))
end

function UINAthSuitColleItem:InitAthSuitColleItemValid(num, valid)
  self:InitAthSuitColleItem(num)
  self.ui.canvasGroup.alpha = valid and 1 or 0.5
  self.ui.img.color = valid and self.ui.color_Highlight or self.ui.color_Gray
end

function UINAthSuitColleItem:OnDelete()
  base.OnDelete(self)
end

return UINAthSuitColleItem
