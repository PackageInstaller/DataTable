local DropdownComponent, Super = System.NewComponent("DropdownComponent")

function DropdownComponent:ctor(res, textList, itemClickCallback, showSubItemSortOrder)
  Super.ctor(self)
  self.ui = Com_FiltrateResource(res)
  self.textList = textList
  self.itemClickCallback = itemClickCallback
  self.expanded = Vue.ref(false)
  self.chosenIndex = Vue.ref(0)
  self.dropItems = {}
  self.banClickCallback = nil
  self.sortType = Vue.ref(CommonDefine.SortOrder.Descend)
  self.showSubItemSortOrder = nil == showSubItemSortOrder and true or showSubItemSortOrder
end

function DropdownComponent:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClick))
  binder:BindToRaw(function(_, nowVal)
    binder:SetActive(self.ui.Group_Dropdown, nowVal)
    binder:SetActive(self.ui.Btn_Mask, nowVal)
  end, function()
    return self.expanded.value
  end)
  binder:BindToRaw(function(own, n, o)
    binder:SetActive(self.ui.Image_Up, n == CommonDefine.SortOrder.Ascend)
    binder:SetActive(self.ui.Image_Down, n == CommonDefine.SortOrder.Descend)
    for i, item in ipairs(self.dropItems) do
      if i == self.chosenIndex.value then
        item:SetSortType(self.sortType.value)
      end
    end
  end, function()
    return self.sortType.value
  end)
  binder:BindToRaw(function(_, nowVal)
    if not nowVal or nowVal <= 0 then
      return
    end
    binder:SetText(self.ui.Text_Selected, self.textList[nowVal])
    for i, item in ipairs(self.dropItems) do
      if item then
        item:SetSelected(i == nowVal)
      end
    end
  end, function()
    return self.chosenIndex.value
  end)
  if not self.textList or #self.textList <= 0 then
    return
  end
  for i = 1, #self.textList do
    local dropItem = self.dropItems[i]
    if not dropItem then
      dropItem = binder:BindNewComponent(self.ui.Content_Dropdown, DropdownItem, Item_AwakerList_FilterResource, self.textList[i], function()
        if self.chosenIndex.value == i then
          if not self.showSubItemSortOrder then
            self:CloseDrop()
            return
          end
          if self.sortType.value == CommonDefine.SortOrder.Descend then
            self.sortType.value = CommonDefine.SortOrder.Ascend
          else
            self.sortType.value = CommonDefine.SortOrder.Descend
          end
        else
          self.sortType.value = CommonDefine.SortOrder.Descend
        end
        self.itemClickCallback(i, self.sortType.value)
        self.chosenIndex.value = i
        binder:SetActive(self.ui.Image_Up, self.sortType.value == CommonDefine.SortOrder.Ascend)
        binder:SetActive(self.ui.Image_Down, self.sortType.value == CommonDefine.SortOrder.Descend)
        for k, item in ipairs(self.dropItems) do
          if k == self.chosenIndex.value then
            item:SetSortType(self.sortType.value)
          end
        end
        self:CloseDrop()
      end, self.showSubItemSortOrder)
      dropItem:SetVisible(true)
      self.dropItems[i] = dropItem
    end
  end
  if #self.dropItems > #self.textList then
    for i = #self.textList + 1, #self.dropItems do
      self.dropItems[i]:SetVisible(false)
    end
  end
end

function DropdownComponent:OnClick()
  if self.banClickCallback then
    local banClick = self.banClickCallback()
    if nil ~= banClick and true == banClick then
      return
    end
  end
  self.expanded.value = not self.expanded.value
end

function DropdownComponent:SetBanClickCallback(banClickCallback)
  self.banClickCallback = banClickCallback
end

function DropdownComponent:SetChosenIndex(index)
  self.chosenIndex.value = index
end

function DropdownComponent:SetOrder(order)
  self.sortType.value = order
end

function DropdownComponent:CloseDrop()
  self.expanded.value = false
end

return DropdownComponent
