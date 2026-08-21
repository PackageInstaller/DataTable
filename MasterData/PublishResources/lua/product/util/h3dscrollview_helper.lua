_class("H3DScrollViewHelper", Object)
H3DScrollViewHelper = H3DScrollViewHelper

function H3DScrollViewHelper:Constructor(uiController, scrollViewName, itemName, showfunction, hidefunction, centerfunction)
  self._itemName = itemName
  self._uiController = uiController
  self._freeWidgetList = ArrayList:New()
  self._useItems = {}
  self._showfunction = showfunction
  self._hidefunction = hidefunction
  self._centerfunction = centerfunction
  self._scrollView = self._uiController:GetUIComponent("H3DScrollView", scrollViewName)
end

function H3DScrollViewHelper:Init(itemcount, openindex, sizeDetal)
  self._listItemTotalCount = itemcount
  if self._scrollView then
    function self._scrollView.mOnHideItem(index, item)
      return self:_OnHideItem(index, item)
    end
    
    function self._scrollView.mOnShowItem(index, item)
      return self:_OnShowItem(index, item)
    end
    
    function self._scrollView.mOnCenterItem(index, item)
      return self:_OnCenterItem(index, item)
    end
    
    self._scrollView:Init(self._listItemTotalCount, openindex, sizeDetal.x, sizeDetal.y)
  end
end

function H3DScrollViewHelper:SetNextPageOffset(fRate)
  if self._scrollView then
    self._scrollView.NextPageOffset = fRate
  end
end

function H3DScrollViewHelper:_OnHideItem(index, item)
  local luaindex = index + 1
  local uiwidget = self._useItems[luaindex]
  self._useItems[luaindex] = nil
  self.minItem = self:_FirstItem()
  if self._hidefunction then
    self._hidefunction(luaindex, uiwidget)
  end
  self._freeWidgetList:PushBack(uiwidget)
end

function H3DScrollViewHelper:_FirstItem()
  local min
  if self._useItems == nil then
    return 1
  end
  if next(self._useItems) == nil then
    return 1
  end
  for k, v in pairs(self._useItems) do
    if min == nil then
      min = k
    elseif k < min then
      min = k
    end
  end
  if min == 1 then
    return 1
  else
    if min then
      return min + 1
    end
    return 1
  end
end

function H3DScrollViewHelper:GetFirstItem()
  if self.minItem == nil then
    return 1
  else
    return self.minItem
  end
end

function H3DScrollViewHelper:_OnShowItem(index, item)
  local luaindex = index + 1
  local uiwidget
  if self._freeWidgetList:Size() > 0 then
    uiwidget = self._freeWidgetList:PopBack()
  else
    uiwidget = self:_LoadItem(item)
  end
  self._useItems[luaindex] = uiwidget
  self.minItem = self:_FirstItem()
  self._showfunction(luaindex, uiwidget)
end

function H3DScrollViewHelper:_OnCenterItem(index, item)
  local luaindex = index + 1
  local uiwidget = self:GetUseItem(luaindex)
  self._centerfunction(luaindex, uiwidget)
end

function H3DScrollViewHelper:_LoadItem(item)
  local uiCustomWidget = _createInstance(self._itemName)
  local view = item:GetComponent("UIView")
  if not view then
    Log.fatal("[UI] H3DScrollViewHelper:_OnShowItem Error, View is Null ", self._itemName)
    return
  end
  uiCustomWidget:SetName(self._itemName)
  uiCustomWidget:Load(view, self._uiController)
  return uiCustomWidget
end

function H3DScrollViewHelper:Dispose()
  self._freeWidgetList:ForEach(function(v)
    if v ~= nil then
      v:UnLoad()
      v:Dispose()
    end
  end)
  for k, v in pairs(self._useItems) do
    if v ~= nil then
      v:UnLoad()
      v:Dispose()
    end
  end
  self._freeWidgetList:Clear()
  table.clear(self._useItems)
  self._scrollView:Dispose()
end

function H3DScrollViewHelper:SetCalcScale(bcalcSize)
  self._scrollView:SetCalcScale(bcalcSize)
end

function H3DScrollViewHelper:RefreshAllShownItem()
  for k, v in pairs(self._useItems) do
    if v ~= nil then
      self._showfunction(k, v)
    end
  end
end

function H3DScrollViewHelper:SetEndSnappingCallback(callback)
  self._scrollView.mOnEndSnapping = callback
end

function H3DScrollViewHelper:SetGroupChangedCallback(callback)
  self._scrollView.mOnGroupChanged = callback
end

function H3DScrollViewHelper:SetValueChangedCallback(callback)
  self._scrollView.mOnValueChangedEvent = callback
end

function H3DScrollViewHelper:MovePanelToIndex(index, onMoveBack)
  self._scrollView:MovePanelToIndex(index)
  self._scrollView.onMovePanelToIndex = onMoveBack
end

function H3DScrollViewHelper:SetItemPassSnapPosCallback(callback)
  self._scrollView.onItemPassSnapPos = callback
end

function H3DScrollViewHelper:GetUseItem(index)
  return self._useItems and self._useItems[index]
end

function H3DScrollViewHelper:SetItemName(itemName)
  self._itemName = itemName
  self._scrollView.m_item_prefab_name = itemName
end

function H3DScrollViewHelper:SetShowFunction(showFunc)
  self._showfunction = showFunc
end
