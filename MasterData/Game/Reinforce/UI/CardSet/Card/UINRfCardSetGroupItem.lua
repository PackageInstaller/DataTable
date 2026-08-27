local base = UIBaseNode
local UINRfCardSetGroupItem = class("UINRfCardSetGroupItem", base)

function UINRfCardSetGroupItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClickItem)
end

function UINRfCardSetGroupItem:InitRfCardSetGroupItem(index, name, callback)
  self.index = index
  self.name = name
  self.callback = callback
  self:RefreshName()
end

function UINRfCardSetGroupItem:ResetName(name)
  self.name = name
  self:RefreshName()
end

function UINRfCardSetGroupItem:RefreshName()
  if string.IsNullOrEmpty(self.name) then
    self.ui.tex_Name:SetIndex(0, tostring(self.index))
  else
    self.ui.tex_Name:SetText(self.name)
  end
end

function UINRfCardSetGroupItem:OnClickItem()
  if self.callback then
    self.callback(self.index)
  end
end

function UINRfCardSetGroupItem:OnDelete()
end

return UINRfCardSetGroupItem
