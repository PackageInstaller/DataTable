local UINStarUpPromoteItem = class("UINStarUpPromoteItem", UIBaseNode)
local base = UIBaseNode

function UINStarUpPromoteItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStarUpPromoteItem:InitPromoteItem(type, new, old)
  self.ui.tex_Name.gameObject:SetActive(true)
  self.ui.tex_Count.gameObject:SetActive(true)
  new = tostring(new)
  old = tostring(old)
  if type == 4 then
    self.ui.tex_Name:SetIndex(type - 1, new)
  else
    self.ui.tex_Name:SetIndex(type - 1)
  end
  if type ~= 4 then
    self.ui.tex_Count:SetIndex(0, old, new)
  else
    self.ui.tex_Count.gameObject:SetActive(false)
  end
end

function UINStarUpPromoteItem:OnHide()
  self.ui.tex_Name.gameObject:SetActive(false)
  self.ui.tex_Count.gameObject:SetActive(false)
end

function UINStarUpPromoteItem:OnDelete()
  base.OnDelete(self)
end

return UINStarUpPromoteItem
