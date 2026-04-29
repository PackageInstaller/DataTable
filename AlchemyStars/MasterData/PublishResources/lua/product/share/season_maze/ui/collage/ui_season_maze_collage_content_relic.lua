_class("UISeasonMazeCollageContentRelic", UISeasonMazeCollageContentBase)
UISeasonMazeCollageContentRelic = UISeasonMazeCollageContentRelic

function UISeasonMazeCollageContentRelic:OnShow()
  self:InitWidget()
end

function UISeasonMazeCollageContentRelic:InitWidget()
  self:InitCommonWidget()
end

function UISeasonMazeCollageContentRelic:GetCollageType()
  return SeasonMazeCollageType.Relic
end

function UISeasonMazeCollageContentRelic:SpawnListItem(scrollView, rowIndex)
  if rowIndex < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeCollageContentRelicItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local subItem = rowList[i]
    local itemIndex = rowIndex * self._itemCountPerRow + i
    if itemIndex > #self._dataList then
      subItem:GetGameObject():SetActive(false)
    else
      subItem:GetGameObject():SetActive(true)
      local d = self._dataList[itemIndex]
      subItem:SetData(d, rowIndex, function(itemID, pos)
        self:OnItemClick(itemID, pos)
      end)
    end
  end
  return item
end
