_class("UISeasonMazeCollageContentBead", UISeasonMazeCollageContentBase)
UISeasonMazeCollageContentBead = UISeasonMazeCollageContentBead

function UISeasonMazeCollageContentBead:OnShow()
  self:InitWidget()
end

function UISeasonMazeCollageContentBead:InitWidget()
  self:InitCommonWidget()
end

function UISeasonMazeCollageContentBead:GetCollageType()
  return SeasonMazeCollageType.Bead
end

function UISeasonMazeCollageContentBead:SpawnListItem(scrollView, rowIndex)
  if rowIndex < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeCollageContentBeadItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local subItem = rowList[i]
    local itemIndex = rowIndex * self._itemCountPerRow + i
    if itemIndex > #self._dataList then
      subItem:GetGameObject():SetActive(false)
    else
      subItem:GetGameObject():SetActive(true)
      subItem:SetData(self._dataList[itemIndex], rowIndex, function(itemId, pos)
        self:OnItemClick(itemId, pos)
      end)
    end
  end
  return item
end
