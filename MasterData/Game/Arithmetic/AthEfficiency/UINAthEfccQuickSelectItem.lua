local UINAthEfccQuickSelectItem = class("UINAthEfccQuickSelectItem", UIBaseNode)
local base = UIBaseNode

function UINAthEfccQuickSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self.__OnValueChage)
end

function UINAthEfccQuickSelectItem:InitAthEfccQuickSelectItem(index, selectedFunc)
  self.ui.tex_KindName:SetIndex(index - 1)
  self.index = index
  self.selectedFunc = selectedFunc
end

function UINAthEfccQuickSelectItem:__OnValueChage(isOn)
  self.ui.tex_KindName.text.color = isOn and Color.black or Color.white
  if self.selectedFunc ~= nil then
    self.selectedFunc(isOn)
  end
end

function UINAthEfccQuickSelectItem:OnDelete()
  base.OnDelete(self)
end

return UINAthEfccQuickSelectItem
