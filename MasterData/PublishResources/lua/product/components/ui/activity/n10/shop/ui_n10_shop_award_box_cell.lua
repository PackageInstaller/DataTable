_class("UIN10ShopAwardBoxCell", UICustomWidget)
UIN10ShopAwardBoxCell = UIN10ShopAwardBoxCell

function UIN10ShopAwardBoxCell:Constructor()
  self.listInited = false
  self.rowCellItemNum = 3
  self.rowCellCount = 0
end

function UIN10ShopAwardBoxCell:OnShow(uiParams)
  self:_GetComponents()
end

function UIN10ShopAwardBoxCell:_GetComponents()
  self.awardList = self:GetUIComponent("UIDynamicScrollView", "AwardList")
end

function UIN10ShopAwardBoxCell:InitData(data, itemInfoCallBack, playJackpotAnim)
  self._data = data
  self._itemInfoCallback = itemInfoCallBack
  self._playJackpotAnim = playJackpotAnim
  self:_InitAwardListUi()
end

function UIN10ShopAwardBoxCell:_InitAwardListUi()
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

function UIN10ShopAwardBoxCell:_OnGetAwardRowCell(scrollview, index)
  local item = scrollview:NewListViewItem("RowCell")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIN10ShopAwardRowCell", 1)
  end
  local rowList = cellPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local rowIndex = index + 1
    if rowIndex > self.rowCellCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      local delayTime = 0
      if self._playJackpotAnim then
        delayTime = rowIndex
      end
      itemWidget:InitData(self._data.itemGroup[rowIndex], self._itemInfoCallback, delayTime)
    end
  end
  return item
end
