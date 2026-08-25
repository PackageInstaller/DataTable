local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local T_GridLayoutGroup = typeof(CS.UnityEngine.UI.GridLayoutGroup)
local ArtCollectionSubVideoView, Super = NewClass("ArtCollectionSubVideoView", BaseView)
ArtCollectionSubVideoView.uiResCls = UI_Collection_Item_PVResource

function ArtCollectionSubVideoView:ctor(subFeature)
  Super.ctor(self)
  self.subFeature = subFeature
end

function ArtCollectionSubVideoView:OnBuildView()
  Super.OnBuildView(self)
  self:UpdateScroll()
end

function ArtCollectionSubVideoView:UpdateScroll()
  if self.tableView == nil then
    local feature = CommonDefine.FeatureId.CollectionPicture
    local list = ArtCollectionController.Instance:GetDataSortListByFeature(feature, self.subFeature)
    self:CalcHeight(list)
    self.list = list
    self.showList = self:FixList(list)
    self.tableView = self:CreateTableview(self.ui.ScrollView, function()
      return #self.showList
    end, function(view, index)
      local cell = view:DequeueCell()
      cell = cell or view:AddChild(self.ui.UI_Collection_Item_PVGroup)
      local data = self.showList[index]
      self:AddViewComponentOnce(cell.gameObject, PVGroupItem, data)
      return cell
    end, function(view, index)
      return self.CacheSize[index].x, self.CacheSize[index].y
    end)
    self.tableView:ReloadData()
  else
    self.tableView:Refresh()
  end
end

function ArtCollectionSubVideoView:FixList(list)
  local cnt = self.colsNum
  local newList = {}
  for i = 1, #list, cnt do
    local data = {}
    for j = 1, cnt do
      local cfgId = list[i + j - 1]
      if cfgId then
        table.insert(data, cfgId)
      end
    end
    table.insert(newList, data)
  end
  return newList
end

function ArtCollectionSubVideoView:CalcHeight(list)
  self.CacheSize = {}
  local cellRT = self.ui.UI_Collection_Item_PVGroup:GetComponent(TYPEOF_RectTransform)
  local width = cellRT.sizeDelta.x
  local tempUI = UI_Collection_Item_PVGroupResource(self.ui.UI_Collection_Item_PVGroup)
  local gridCom = tempUI.Content:GetComponent(T_GridLayoutGroup)
  local colsNum = gridCom.constraintCount
  local itemHeight = gridCom.cellSize.y
  self.colsNum = colsNum
  for index, cfgId in ipairs(list) do
    local lineIndex = math.ceil(index / colsNum)
    local realH = itemHeight
    self.CacheSize[lineIndex] = {
      x = width,
      y = realH + 30
    }
  end
  self.gridCom = gridCom
end

return ArtCollectionSubVideoView
