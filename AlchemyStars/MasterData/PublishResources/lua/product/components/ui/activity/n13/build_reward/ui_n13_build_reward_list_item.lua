_class("UIN13BuildRewardListItem", UICustomWidget)
UIN13BuildRewardListItem = UIN13BuildRewardListItem

function UIN13BuildRewardListItem:_GetComponents()
  self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
  self._stateObj = {
    {
      self:GetGameObject("state_Accepted")
    },
    {
      self:GetGameObject("state_Taken")
    }
  }
end

function UIN13BuildRewardListItem:OnShow(uiParams)
end

function UIN13BuildRewardListItem:SetData(buildManager, data, tipsCallback)
  self:_GetComponents()
  self._buildManager = buildManager
  self._data = data
  self._tipsCallback = tipsCallback
  self._state = self._data.state
  self:_Refresh()
end

function UIN13BuildRewardListItem:OnHide(stamp)
end

function UIN13BuildRewardListItem:_Refresh()
  self:_SetState(self._state)
  self:_SetDesc()
  self:_SetDynamicList()
end

function UIN13BuildRewardListItem:_SetState(state)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN13BuildRewardListItem:_SetDesc()
  local id, st = self._buildManager._buildItemData:GetNeedBuildItemIdAndStatus(self._data.buildItemId, self._data.status)
  local str = UIActivityN13Helper.GetStrByStatus_Operator(st, self._data.name)
  local obj = self:GetUIComponent("UILocalizationText", "desTex")
  obj:SetText(str)
end

function UIN13BuildRewardListItem:_SetDynamicListData()
  self._dynamicListInfo = self._data.reward
  self._itemCountPerRow = 1
  self._dynamicListSize = math.floor((table.count(self._dynamicListInfo) - 1) / self._itemCountPerRow + 1)
end

function UIN13BuildRewardListItem:_SetDynamicList()
  self:_SetDynamicListData()
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "dynamicList")
    self._dynamicList:InitListView(self._dynamicListSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListSize, self._dynamicList)
  end
end

function UIN13BuildRewardListItem:_RefreshList(count, list)
  local contentPos = list.ScrollRect.content.localPosition
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  list.ScrollRect.content.localPosition = contentPos
end

function UIN13BuildRewardListItem:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN13BuildRewardItem", self._itemCountPerRow)
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

function UIN13BuildRewardListItem:_SetListItemData(listItem, index)
  local info = self._dynamicListInfo[index]
  local gray = self._state == 2 and 1 or 0
  listItem:SetData(index, info, self._tipsCallback, gray)
end
