_class("UIQuestAchievementFinishList", UIController)
UIQuestAchievementFinishList = UIQuestAchievementFinishList

function UIQuestAchievementFinishList:OnShow(uiParams)
  self:_GetComponents()
  self._itemCountPerRow = 1
  self._list = uiParams[1]
  self._hideCallback = uiParams[2]
  self._questModule = GameGlobal.GetModule(QuestModule)
  self:_OnValue()
end

function UIQuestAchievementFinishList:OnHide()
  if self._hideCallback then
    self._hideCallback()
  end
end

function UIQuestAchievementFinishList:_GetComponents()
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self._detailScrollView = self:GetUIComponent("UIDynamicScrollView", "taskDetailList")
end

function UIQuestAchievementFinishList:AwardClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

function UIQuestAchievementFinishList:InitScrollView()
  local count = #self._list
  self._detailScrollView:InitListView(count, function(scrollView, index)
    return self:OnInitScrollView(scrollView, index)
  end)
end

function UIQuestAchievementFinishList:OnInitScrollView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIQuestAchievementLatelyAchieveItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowAchieveItem(heartItem, itemIndex)
  end
  return item
end

function UIQuestAchievementFinishList:_ShowAchieveItem(heartItem, itemIndex)
  local data = self._list[itemIndex]
  heartItem:GetGameObject():SetActive(true)
  if data ~= nil then
    heartItem:SetData(itemIndex, data, function()
    end, function(matid, pos)
      self:AwardClick(matid, pos)
    end, true)
  end
end

function UIQuestAchievementFinishList:CloseBtnOnClick()
  self:CloseDialog()
end

function UIQuestAchievementFinishList:_OnValue()
  self:InitScrollView()
end

function UIQuestAchievementFinishList:BgOnClick()
  self:CloseDialog()
end
