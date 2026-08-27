local base = UIBaseNode
local UINCardSetRewindSortItem = class("UINCardSetRewindSortItem", base)

function UINCardSetRewindSortItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINCardSetRewindSortItem:InitCardSetRewindSortItem(sortType, isReverse, changeSortFunc)
  self._sortType = sortType
  self._isReverse = isReverse
  self._changeSortFunc = changeSortFunc
  self:_UpdState()
end

function UINCardSetRewindSortItem:ClearCardSetRewindSort()
  self._isReverse = nil
  self:_UpdState()
end

function UINCardSetRewindSortItem:_UpdState()
  if self._isReverse == nil then
    self.ui.up:SetActive(false)
    self.ui.down:SetActive(false)
  else
    self.ui.up:SetActive(not self._isReverse)
    self.ui.down:SetActive(self._isReverse)
  end
end

function UINCardSetRewindSortItem:_OnClickRoot()
  if self._isReverse == nil then
    self._isReverse = false
  else
    self._isReverse = not self._isReverse
  end
  self:_UpdState()
  if self._changeSortFunc ~= nil then
    self._changeSortFunc(self._sortType, self._isReverse)
  end
end

function UINCardSetRewindSortItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetRewindSortItem
