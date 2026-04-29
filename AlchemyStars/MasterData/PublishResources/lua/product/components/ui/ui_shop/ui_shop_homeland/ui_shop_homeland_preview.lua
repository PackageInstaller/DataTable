_class("UIShopHomelandPreview", UIController)
UIShopHomelandPreview = UIShopHomelandPreview

function UIShopHomelandPreview:Constructor()
  self._currentIndex = 0
  self._items = {}
  self._deltaTime = 0
end

function UIShopHomelandPreview:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIShopHomelandPreview:OnShow(uiParams)
  self._pictures = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
end

function UIShopHomelandPreview:_GetComponents()
  self._scrollView = self:GetUIComponent("RectTransform", "ScrollView")
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._index = self:GetUIComponent("UISelectObjectPath", "Index")
end

function UIShopHomelandPreview:_OnValue()
  self._totalCount = #self._pictures
  self._index:SpawnObjects("UIShopHomelandIndex", self._totalCount)
  self._indexPointWidgets = self._index:GetAllSpawnList()
  for _, widget in pairs(self._indexPointWidgets) do
    widget:SetData(false)
  end
  self._canvas = self._safeArea.parent:GetComponent("RectTransform")
  local safesize = self._canvas.rect.size
  safesize.x = safesize.x * (self._safeArea.anchorMax.x - self._safeArea.anchorMin.x)
  safesize.x = safesize.x + 1
  safesize.y = safesize.y + 1
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "ScrollView", "UUIShopHomelandPreviewItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end)
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._totalCount then
      return
    end
    self:_ShowItemData(index + 1)
  end)
  self._scrollViewHelper:Init(self._totalCount, 1, safesize)
  self._scrollView.anchoredPosition = Vector2(0, 88)
end

function UIShopHomelandPreview:BackgroundOnClick(go)
  self:CloseDialog()
end

function UIShopHomelandPreview:_ShowItemData(index)
  self._deltaTime = 0
  if self._indexPointWidgets[self._currentIndex] then
    self._indexPointWidgets[self._currentIndex]:SetData(false)
  end
  self._currentIndex = index
  if self._indexPointWidgets[self._currentIndex] then
    self._indexPointWidgets[self._currentIndex]:SetData(true)
  end
end

function UIShopHomelandPreview:_OnShowItem(index, widget)
  widget:SetData(self._pictures[index])
  self._items[index] = widget
end

function UIShopHomelandPreview:OnHide()
  self._currentIndex = 0
  self._safeArea = nil
  if self._scrollViewHelper then
    self._scrollViewHelper:Dispose()
  end
end

function UIShopHomelandPreview:OnUpdate(ms)
  self._deltaTime = self._deltaTime + ms
  if self._deltaTime > 2000 then
    local nextIndex = self._currentIndex + 1
    if nextIndex > self._totalCount then
      nextIndex = 1
    end
    self._scrollViewHelper:MovePanelToIndex(nextIndex)
    self._deltaTime = 0
  end
end
