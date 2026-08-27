local base = UIBaseNode
local UINDmSortItem = class("UINDmSortItem", base)

function UINDmSortItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self._OnClickRoot)
end

function UINDmSortItem:InitDmSortItem(sortTypeId, sortData, clickFunc)
  self._clickFunc = clickFunc
  self._sortTypeId = sortTypeId
  self._sortData = sortData
  self.ui.tex_SortName:SetIndex(sortTypeId - 1)
  self:UpdDmSortItem()
end

function UINDmSortItem:UpdDmSortItem()
  local isCur = self._sortData:IsDmThemeCurSortType(self._sortTypeId)
  self.ui.tex_SortName.text.color = isCur and self.ui.textColor[1] or self.ui.textColor[2]
  self.ui.img_bg.color = isCur and self.ui.bgColor[1] or self.ui.bgColor[2]
  local isReverse = self._sortData:GetDmThemeCurSortTypeReverse(self._sortTypeId)
  self.ui.img_Ascend.color = isReverse and Color.white or Color.gray
  self.ui.img_Descend.color = isReverse and Color.gray or Color.white
end

function UINDmSortItem:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self, self._sortTypeId)
  end
end

function UINDmSortItem:OnDelete()
  base.OnDelete(self)
end

return UINDmSortItem
