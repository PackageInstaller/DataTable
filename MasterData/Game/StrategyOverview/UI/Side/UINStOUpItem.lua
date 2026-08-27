local UINStOUpItem = class("UINStOUpItem", UIBaseNode)
local base = UIBaseNode

function UINStOUpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStOUpItem:InitStOUpItem(curInfo, curValue, nextValue, isMaxLevel)
  self.ui.tex_Name.text = curInfo
  if isMaxLevel then
    self.ui.tex_Value:SetIndex(2, curValue)
  elseif string.IsNullOrEmpty(nextValue) then
    self.ui.tex_Value:SetIndex(0, curValue)
  else
    self.ui.tex_Value:SetIndex(1, curValue, nextValue)
  end
end

function UINStOUpItem:OnDelete()
  base.OnDelete(self)
end

return UINStOUpItem
