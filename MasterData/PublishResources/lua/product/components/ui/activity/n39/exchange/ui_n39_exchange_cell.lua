_class("UIN39ExchangeCell", UICustomWidget)
UIN39ExchangeCell = UIN39ExchangeCell

function UIN39ExchangeCell:OnShow()
  self.itemCountPerRow = 1
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._inited = false
end

function UIN39ExchangeCell:_OnShowItem(scrollview, index)
  if index < 0 then
    return nil
  end
  local count = 1
  local idx = index * self.itemCountPerRow + 1
  local data = self._itemList[idx]
  local itemName
  if data.sin then
    count = 1
    itemName = "itemSpecial"
  else
    count = #data.list
    itemName = "itemNormal"
  end
  local item = scrollview:NewListViewItem(itemName)
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  pool:SpawnObjects("UIN39ExchangeItem", count)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
  end
  local rowList = pool:GetAllSpawnList()
  for i = 1, count do
    local widget = rowList[i]
    local singleData = data.list[i]
    if singleData then
      widget:Enable(true)
      self:_RefreshTtemInfo(widget, singleData, idx)
    else
      widget:Enable(false)
    end
  end
  return item
end

function UIN39ExchangeCell:_RefreshTtemInfo(itemWidget, data, idx)
  itemWidget:SetData(data, self._component, self._tipsCallback, idx, not self._inited)
end

function UIN39ExchangeCell:SetData(itemList, component, tipsCallback)
  self._itemList = itemList
  self._component = component
  self._tipsCallback = tipsCallback
  self:ShowViewList()
end

function UIN39ExchangeCell:ShowViewList()
  if self._inited then
    self._scrollView:SetListItemCount(table.count(self._itemList))
    self._scrollView:RefreshAllShownItem()
  else
    self._scrollView:InitListView(table.count(self._itemList), function(scrollview, index)
      return self:_OnShowItem(scrollview, index)
    end)
  end
  if not self._inited then
    self._inited = true
  end
end
