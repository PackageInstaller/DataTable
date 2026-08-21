_class("UISeasonMazeBeadAutoSyn", UIController)
UISeasonMazeBeadAutoSyn = UISeasonMazeBeadAutoSyn

function UISeasonMazeBeadAutoSyn:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeBeadAutoSyn:OnShow(uiParams)
  self._controller = uiParams[1]
  self._data = uiParams[2] or {}
  self._allChoice = true
  self:InitWidget()
  self:_OnValue()
end

function UISeasonMazeBeadAutoSyn:InitWidget()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISeasonMazeBeadTips")
  self._mark = self:GetUIComponent("Image", "AllChoiceBtnMark")
  self._commonItemTips = self:GetUIComponent("UISelectObjectPath", "CommonItemTips")
  self._commonTips = self._commonItemTips:SpawnObject("UISelectInfo")
end

function UISeasonMazeBeadAutoSyn:AllChoiceBtnOnClick(go)
  self._allChoice = not self._allChoice
  for _, value in pairs(self._data) do
    value.choice = self._allChoice
  end
  self._mark.enabled = self._allChoice
  self._scrollView:RefreshAllShownItem()
  self._controller:OnChoiceChange(self._data)
end

function UISeasonMazeBeadAutoSyn:OnItemChoiceChage()
  local allChoice = true
  for _, value in pairs(self._data) do
    allChoice = allChoice and value.choice
  end
  self._allChoice = allChoice
  self._mark.enabled = self._allChoice
  self._controller:OnChoiceChange(self._data)
end

function UISeasonMazeBeadAutoSyn:OkBtnOnClick(go)
  self._controller:SynthesisBead(function()
    self:CloseDialog()
  end)
end

function UISeasonMazeBeadAutoSyn:_OnValue()
  self._controller:OnChoiceChange(self._data)
  self:_InitDynamicScrollView()
end

function UISeasonMazeBeadAutoSyn:_InitDynamicScrollView()
  self._scrollView:InitListView(table.count(self._data), function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UISeasonMazeBeadAutoSyn:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("UISeasonMazeBeadAutoSynItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UISeasonMazeBeadAutoSynItem", 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  local itemWidget = itemWidgets[1]
  if itemWidget then
    local data = self:_GetBeadData(index + 1)
    itemWidget:SetData(index + 1, data, function(uid, id, position)
      self._tips:SetData(uid, id, position)
    end, function()
      self:OnItemChoiceChage()
    end, function(widget, beadData1, beadData2)
      self._controller:SynthesisPreView(widget, beadData1, beadData2, SeasonMazeBeadItemType.SynthesisList, function(uid, id, position)
        self._tips:SetData(uid, id, position)
      end, self._commonTips)
    end)
  end
  return item
end

function UISeasonMazeBeadAutoSyn:_GetBeadData(index)
  return self._data[index]
end

function UISeasonMazeBeadAutoSyn:InSlot(uid)
  return self._controller:InSlot(uid)
end

function UISeasonMazeBeadAutoSyn:IsLock(data, itemType)
  return false
end

function UISeasonMazeBeadAutoSyn:IsMark(data, itemType)
  return false
end

function UISeasonMazeBeadAutoSyn:CloseBtnOnClick(go)
  self._controller:ClearSynthesisSlot()
  self._controller:RefreshAllShownItem()
  self:CloseDialog()
end
