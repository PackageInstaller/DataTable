_class("UISeasonCgCollectionController", UIController)
UISeasonCgCollectionController = UISeasonCgCollectionController

function UISeasonCgCollectionController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonCgCollectionController:OnShow(uiParams)
  self.closeCb = uiParams[1]
  self._itemCountPerRow = 3
  self._bookModule = GameGlobal.GetModule(BookModule)
  self:InitWidget()
  self:OnValue()
end

function UISeasonCgCollectionController:InitWidget()
  local topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtns = topBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
    if self.closeCb then
      self.closeCb()
    end
  end, nil, nil, true)
  self.txtCollectionCount = self:GetUIComponent("UILocalizationText", "txtCollectionCount")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._scrollRt = self:GetUIComponent("RectTransform", "ScrollView")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
end

function UISeasonCgCollectionController:OnValue()
  self._cfgs = UISeasonExploreHelper.GetSeasonCgCfgs()
  local count = #self._cfgs
  if 0 < count then
    self:Sort()
    self.txtCollectionCount:SetText(count)
    self._collectionCount = count
    self._listShowItemCount = math.ceil(self._collectionCount / self._itemCountPerRow)
    self:_InitSrollView()
  end
end

function UISeasonCgCollectionController:Sort()
  table.sort(self._cfgs, function(a, b)
    local k, isUnLockA = self._bookModule:GetSeasonStory(a)
    local a1 = 0
    if isUnLockA then
      a1 = 1
    end
    local m, isUnLockB = self._bookModule:GetSeasonStory(b)
    local b1 = 0
    if isUnLockB then
      b1 = 1
    end
    if a1 ~= b1 then
      return a1 > b1
    end
    return a.ID < b.ID
  end)
end

function UISeasonCgCollectionController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitCellList(scrollView, index)
  end)
  self._inited = true
end

function UISeasonCgCollectionController:InitCellList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonCgCollectionCell", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local cellItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._collectionCount then
      cellItem:GetGameObject():SetActive(false)
    else
      self:ShowCellItem(cellItem, itemIndex)
    end
  end
  return item
end

function UISeasonCgCollectionController:ShowCellItem(cellItem, index)
  cellItem:GetGameObject():SetActive(true)
  local cfg = self._cfgs[index]
  if cfg ~= nil then
    cellItem:SetData(cfg, index, function(idx, isUnlock)
      self:OnClickCell(idx, isUnlock)
    end)
  end
end

function UISeasonCgCollectionController:OnClickCell(index, isUnlock)
  if isUnlock then
    local cfg = self._cfgs[index]
    self:ShowDialog("UISeasonCgDetailController", cfg)
  end
end
