_class("UILuckLandBuildings", UIController)
UILuckLandBuildings = UILuckLandBuildings

function UILuckLandBuildings:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandBuildings:OnShow(uiParams)
  self._perRowCount = 2
  self._levelBuildDatas = LuckLandData:GetInstance():CurBuildingDatas()
  self:_InitWidget()
  self:_OnValue()
end

function UILuckLandBuildings:OnHide()
  if self._task then
    GameGlobal.TaskManager():KillTask(self._task)
    self._task = nil
  end
end

function UILuckLandBuildings:_InitWidget()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandBuildings:_OnValue()
  self:_InitDynamicScrollView()
end

function UILuckLandBuildings:_InitDynamicScrollView()
  self._scrollView:InitListView(math.ceil(self._levelBuildDatas:TotalCount() / self._perRowCount), function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
  self:Lock("UILuckLandBuildings")
  self._task = self:StartTask(function(TT)
    self:_DynamicListPlayAnimation(TT)
    YIELD(TT, 300)
    self:UnLock("UILuckLandBuildings")
  end, self)
end

function UILuckLandBuildings:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("UILuckLandBuildingItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UILuckLandBuildingItem", self._perRowCount)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  for i = 1, self._perRowCount do
    local itemWidget = itemWidgets[i]
    if itemWidget then
      itemWidget:SetData(self._levelBuildDatas:GetBuildDataByIndex(index * self._perRowCount + i))
    end
  end
  return item
end

function UILuckLandBuildings:_RefreshScrollView()
  self._scrollView:SetListItemCount(4)
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UILuckLandBuildings:CancleBtnOnClick(go)
  self:Lock("UILuckLandBuildings")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UILuckLandBuildings_out")
    YIELD(TT, 333)
    self:UnLock("UILuckLandBuildings")
    self:CloseDialog()
  end, self)
end

function UILuckLandBuildings:HelpBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UILuckLandBuildings")
end

function UILuckLandBuildings:_DynamicListPlayAnimation(TT)
  local showTabIds = self._scrollView:GetVisibleItemIDsInScrollView()
  local items = {}
  for index = 0, showTabIds.Count - 1 do
    local id = math.floor(showTabIds[index])
    local item = self._scrollView:GetShownItemByItemIndex(id)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    if rowList then
      for i = 1, #rowList do
        item.gameObject:SetActive(false)
        local data = {}
        data.index = index
        data.gameObject = item.gameObject
        data.widget = rowList[i]
        table.insert(items, data)
      end
    end
  end
  for i = 1, #items do
    local data = items[i]
    YIELD(TT, data.index * 50)
    data.gameObject:SetActive(true)
    data.widget:PlayAnimation()
  end
end
