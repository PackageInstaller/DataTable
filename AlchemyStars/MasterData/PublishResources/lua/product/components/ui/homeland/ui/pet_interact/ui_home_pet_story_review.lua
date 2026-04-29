_class("UIHomePetStoryReview", UIController)
UIHomePetStoryReview = UIHomePetStoryReview

function UIHomePetStoryReview:OnShow(uiParams)
  self._content = uiParams[1]
  self._itemCountPerRow = 1
  self._listCount = #self._content
  self:InitReviewList()
  self._dialogReviewScrollView:MovePanelToItemIndex(table.count(self._content) - 1, 0)
end

function UIHomePetStoryReview:InitReviewList()
  self._dialogReviewScrollView = self:GetUIComponent("UIDynamicScrollView", "scrollView")
  self._dialogReviewScrollView:InitListView(self._listCount, function(scrollView, index)
    return self:_InitScrollView(scrollView, index)
  end)
end

function UIHomePetStoryReview:_InitScrollView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHomePetStoryReviewItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local item = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowItem(item, itemIndex)
  end
  local rt = item.gameObject:GetComponent("RectTransform")
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rt)
  return item
end

function UIHomePetStoryReview:_ShowItem(item, idx)
  local data = self._content[idx]
  local showLine = idx < self._listCount
  item:SetData(data, showLine, function(go)
    self:bgOnClick()
  end)
end

function UIHomePetStoryReview:bgOnClick(go)
  self:CloseDialog()
end
