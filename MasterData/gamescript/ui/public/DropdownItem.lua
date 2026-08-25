local DropdownItem, Super = System.NewComponent("DropdownItem")

function DropdownItem:ctor(uiNode, text, itemClickCallback, showSortOrderBtn)
  Super.ctor(self)
  self.ui = Item_AwakerList_FilterResource(uiNode)
  self.text = Vue.ref(text)
  self.itemClickCallback = itemClickCallback
  self.selected = Vue.ref(false)
  self.sortType = Vue.ref(CommonDefine.SortOrder.Descend)
  self.showSortOrderBtn = showSortOrderBtn
end

function DropdownItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Filter, System.fn(self, self.OnClickCallback))
  binder:BindToRaw(function(_, nowVal)
    if not nowVal then
      return
    end
    binder:SetText(self.ui.Text_Normal, nowVal)
    binder:SetText(self.ui.Text_Selected, nowVal)
  end, function()
    return self.text.value
  end)
  binder:BindToRaw(function(_, nowVal)
    binder:SetActive(self.ui.Group_Selected, nowVal)
    binder:SetActive(self.ui.Text_Normal, not nowVal)
  end, function()
    return self.selected.value
  end)
  binder:SetActive(self.ui.Group_Sort_Arrow, self.showSortOrderBtn)
  binder:BindToRaw(function(own, n, o)
    binder:SetActive(self.ui.Image_Up, n == CommonDefine.SortOrder.Ascend)
    binder:SetActive(self.ui.Image_Down, n == CommonDefine.SortOrder.Descend)
  end, function()
    return self.sortType.value
  end)
end

function DropdownItem:OnClickCallback()
  if self.itemClickCallback then
    self.itemClickCallback()
  end
end

function DropdownItem:SetCallback(callback)
  self.itemClickCallback = callback
end

function DropdownItem:SetSelected(selected)
  self.selected.value = selected
end

function DropdownItem:SetSortType(type)
  self.sortType.value = type
end

function DropdownItem:SetVisible(show)
  self.binder:SetActive(self.ui.uiNode, show)
end

function DropdownItem:SetText(text)
  self.text.value = text
end

return DropdownItem
