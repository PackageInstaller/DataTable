local UINSortButtonItem = class("UINSortButtonGroup", UIBaseNode)
local base = UIBaseNode

function UINSortButtonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SortItem, self, self.OnButtonClick)
  self:SetAllStateUI(false)
end

function UINSortButtonItem:InitSortButtonItem(sortType, isAscend, clickAction)
  self.sortType = sortType
  self.clickAction = clickAction
  self.isAscend = isAscend
  self.ui.tex_SortName:SetIndex(sortType)
end

function UINSortButtonItem:OnButtonClick()
  if self.clickAction ~= nil then
    self.clickAction(self.sortType)
  end
end

function UINSortButtonItem:ReversalAscend()
  self.isAscend = not self.isAscend
  self:RefeshSortStateUI()
end

function UINSortButtonItem:SetAllStateUI(active)
  self.ui.obj_Ascend:SetActive(active)
  self.ui.obj_Descend:SetActive(active)
end

function UINSortButtonItem:RefeshSortStateUI()
  self.ui.obj_Ascend:SetActive(self.isAscend)
  self.ui.obj_Descend:SetActive(not self.isAscend)
end

function UINSortButtonItem:OnDelete()
  base.OnDelete(self)
end

return UINSortButtonItem
