_class("UITowerPassAward", UIController)
UITowerPassAward = UITowerPassAward

function UITowerPassAward:Constructor()
  self._widgets = {}
  self._questModule = self:GetModule(QuestModule)
end

function UITowerPassAward:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UITowerPassAward:OnShow(uiParams)
  self._allQuests = uiParams[1]
  self._topIndex = uiParams[2] or 0
  self:_GetComponents()
  self:_OnValue()
end

function UITowerPassAward:_GetComponents()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
end

function UITowerPassAward:_OnValue()
  self:_InitDynamicScrollView()
  self._scrollView:MovePanelToItemIndex(self._topIndex, 0)
end

function UITowerPassAward:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._allQuests, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UITowerPassAward:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("UITowerPassAwardItems")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UITowerPassAwardItems", 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  index = index + 1
  self._widgets[index] = itemWidgets[1]
  if self._widgets[index] then
    self._widgets[index]:SetData(self._allQuests[index], index, function(id, pos)
      self:ShowTips(id, pos)
    end)
  end
  return item
end

function UITowerPassAward:BackgroundOnClick(go)
  self:CloseDialog()
end

function UITowerPassAward:ShowTips(id, pos)
  self._tips:SetData(id, pos)
end
