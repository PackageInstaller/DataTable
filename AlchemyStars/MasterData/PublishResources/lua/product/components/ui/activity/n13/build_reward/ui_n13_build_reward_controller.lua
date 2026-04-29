_class("UIN13BuildRewardController", UIController)
UIN13BuildRewardController = UIN13BuildRewardController

function UIN13BuildRewardController:OnShow(uiParams)
  self._isOpen = true
  self._buildManager = uiParams[1]
  if not self._buildManager then
    Log.error("UIN13BuildRewardController:OnShow() buildManager == nil")
    self:CloseDialog()
    return
  end
  self:_SetDynamicList(true)
end

function UIN13BuildRewardController:OnHide()
  self._isOpen = false
end

function UIN13BuildRewardController:_SetDynamicListData()
  self._dynamicListInfo = self._buildManager:GetBuildRewardList()
  self._dynamicListSize = table.count(self._dynamicListInfo)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
end

function UIN13BuildRewardController:_SetDynamicList(resetPos, noAnim)
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._dynamicList, resetPos)
  end
end

function UIN13BuildRewardController:_RefreshList(count, list, resetPos)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
    list.ScrollRect.content.localPosition = contentPos
  end
end

function UIN13BuildRewardController:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN13BuildRewardListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UIN13BuildRewardController:_SetListItemData(listItem, index)
  local data = self._dynamicListInfo[index]
  listItem:SetData(self._buildManager, data, function(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "itemInfoPool", matid, pos)
  end)
end

function UIN13BuildRewardController:ListItemOnClick(progress)
end

function UIN13BuildRewardController:CloseBtnOnClick(go)
  self:CloseDialog()
end
