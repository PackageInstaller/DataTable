_class("UISakuraDrawShopAwardBoxCell", UICustomWidget)
UISakuraDrawShopAwardBoxCell = UISakuraDrawShopAwardBoxCell

function UISakuraDrawShopAwardBoxCell:Constructor()
  self.listInited = false
  self.rowCellItemNum = 3
  self.rowCellCount = 0
end

function UISakuraDrawShopAwardBoxCell:OnShow(uiParams)
  self:InitWidget()
end

function UISakuraDrawShopAwardBoxCell:InitWidget()
  self.awardList = self:GetUIComponent("UIDynamicScrollView", "AwardList")
end

function UISakuraDrawShopAwardBoxCell:_InitAwardListUi()
  self.rowCellCount = #self._data.itemGroup
  if self.listInited then
    self.awardList:SetListItemCount(self.rowCellCount)
    self.awardList:RefreshAllShownItem()
    self.awardList:MovePanelToItemIndex(0, 0)
    self.awardList:FinishSnapImmediately()
    return
  else
    self.listInited = true
  end
  self.awardList:InitListView(self.rowCellCount, function(scrollview, index)
    return self:_OnGetAwardRowCell(scrollview, index)
  end)
end

function UISakuraDrawShopAwardBoxCell:_OnGetAwardRowCell(scrollview, index)
  local item = scrollview:NewListViewItem("RowCell")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UISakuraDrawShopAwardRowCell", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local rowIndex = index + 1
    if rowIndex > self.rowCellCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      itemWidget:InitData(self._data.itemGroup[rowIndex], self._itemInfoCallback)
    end
  end
  return item
end

function UISakuraDrawShopAwardBoxCell:SetData()
end

function UISakuraDrawShopAwardBoxCell:InitData(data, itemInfoCallBack)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self:_InitAwardListUi()
end
