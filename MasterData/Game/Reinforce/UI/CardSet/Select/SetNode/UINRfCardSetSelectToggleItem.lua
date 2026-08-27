local base = UIBaseNode
local UINRfCardSetSelectToggleItem = class("UINRfCardSetSelectToggleItem", base)

function UINRfCardSetSelectToggleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.togItem, self, self.OnToggleValueChange)
end

function UINRfCardSetSelectToggleItem:InitRfCardSetSelectToggleItem(index, callback)
  self.index = index
  self.callback = callback
  self:RefreshToggleItemShow()
end

function UINRfCardSetSelectToggleItem:RefreshToggleItemShow()
  self.ui.tex_Title:SetIndex(self.index - 1)
end

function UINRfCardSetSelectToggleItem:RefreshSelectState(bool)
  self.ui.tex_Title.text.color = bool and self.ui.col_fontSelect or self.ui.col_notSelect
  self.ui.img_Line.color = bool and self.ui.col_lineSelect or self.ui.col_notSelect
end

function UINRfCardSetSelectToggleItem:SetToggleOpen()
  self.ui.togItem.isOn = true
end

function UINRfCardSetSelectToggleItem:OnToggleValueChange(bool)
  if self.callback then
    self.callback(self.index, bool)
  end
  self:RefreshSelectState(bool)
end

function UINRfCardSetSelectToggleItem:OnDelete()
end

return UINRfCardSetSelectToggleItem
