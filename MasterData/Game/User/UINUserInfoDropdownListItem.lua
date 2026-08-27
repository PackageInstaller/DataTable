local UINUserInfoDropdownListItem = class("UINUserInfoDropdownListItem", UIBaseNode)
local base = UIBaseNode

function UINUserInfoDropdownListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.OnClickBtnItem)
end

function UINUserInfoDropdownListItem:InitItem(index, clickFunc)
  self.ui.tex_item:SetIndex(index)
  self.clickFunc = clickFunc
end

function UINUserInfoDropdownListItem:OnClickBtnItem()
  if self.clickFunc then
    self.clickFunc()
  end
end

function UINUserInfoDropdownListItem:OnDelete()
  base.OnDelete(self)
end

return UINUserInfoDropdownListItem
