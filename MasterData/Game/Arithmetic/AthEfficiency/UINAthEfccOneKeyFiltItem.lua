local UINAthEfccOneKeyFiltItem = class("UINAthEfccOneKeyFiltItem", UIBaseNode)
local base = UIBaseNode

function UINAthEfccOneKeyFiltItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

function UINAthEfccOneKeyFiltItem:InitAthEfccOneKeyFiltItem(index, onSelectFunc, select)
  self.index = index
  self.onSelectFunc = onSelectFunc
  self.select = select
  self.ui.tex_KindName:SetIndex(index)
  self:SetSelectUIActive()
end

function UINAthEfccOneKeyFiltItem:__OnKindItemClick()
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    self.onSelectFunc(self.index, self.select)
  end
end

function UINAthEfccOneKeyFiltItem:SetSelectUIActive()
  self.ui.obj_OnSelect:SetActive(self.select)
  local selColor = self.select and Color.black or Color.white
  self.ui.tex_KindName.text.color = selColor
end

function UINAthEfccOneKeyFiltItem:OnDelete()
  base.OnDelete(self)
end

return UINAthEfccOneKeyFiltItem
