_class("UIQuestStoryItem", UICustomWidget)
UIQuestStoryItem = UIQuestStoryItem

function UIQuestStoryItem:OnShow(uiParams)
  self._transition = self:GetUIComponent("ATransitionComponent", "UIQuestStoryItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestStoryItem")
  self._canvasGroup.blocksRaycasts = false
  self._tweenAnim = self:GetUIComponent("Animation", "rect")
  self._detailIsOpen = false
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] questModule is nil !")
    return
  end
  self._itemCountPerRow = 1
  self._isFirst = true
  self.items = {}
  local mMission = self:GetModule(MissionModule)
  self.discoveryData = mMission:GetDiscoveryData()
  self.chapters = self.discoveryData:GetChapters()
end

function UIQuestStoryItem:SetDetailReference(pool, poolGo, poolGrid)
  self._detailPool = pool
  self._detailPoolGo = poolGo
  self._detailPoolGrid = poolGrid
end

function UIQuestStoryItem:SetData(taskType, cellSizeX, cellSizeY)
  self._transition:PlayEnterAnimation(true)
  self._canvasGroup.blocksRaycasts = true
  self._isOpen = true
  self:_GetComponents()
  self._taskType = taskType
  if cellSizeX then
    self._cellSize = Vector2(cellSizeX, cellSizeY)
  end
  self._currentChapterIndex = 1
  self._currentChapterIndex = self._questModule:GetMainQuestChapterID()
  if not self._currentChapterIndex then
    self._currentChapterIndex = table.count(self.chapters) + 1
  end
  local chapter_index = self._questModule:GetLocalChapterQuestIndex()
  if chapter_index > self._currentChapterIndex then
    self._currentChapterIndex = chapter_index
  end
  self:_OnValue()
  self._detailPoolGo:SetActive(true)
end

function UIQuestStoryItem:_GetChapterList()
  if not self.chapters then
    Log.fatal("[quest] self.chapters is nil !")
    return
  end
  self._chapterList = {}
  for _, chapter in pairs(self.chapters) do
    if chapter then
      table.insert(self._chapterList, chapter.id)
    end
  end
end

function UIQuestStoryItem:RefrenshList()
  self.items = {}
  self._currentChapterIndex = self._questModule:GetMainQuestChapterID()
  if not self._currentChapterIndex then
    self._currentChapterIndex = table.count(self.chapters) + 1
  end
  self:_GetChapterList()
  self._list:SetListItemCount(table.count(self.chapters))
  self._list:MovePanelToItemIndex(0, 0)
  self:_ChangeScrollViewContentPosition()
end

function UIQuestStoryItem:OnHide()
  self._detailIsOpen = false
end

function UIQuestStoryItem:_GetComponents()
  self._list = self:GetUIComponent("UIDynamicScrollView", "taskList")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._rectGo = self:GetGameObject("rect")
end

function UIQuestStoryItem:OnClose()
  self._isOpen = false
  self._transition:PlayLeaveAnimation(true)
  self._canvasGroup.blocksRaycasts = false
end

function UIQuestStoryItem:_OnValue()
  self:_GetChapterList()
  if self._isFirst == true then
    self._isFirst = false
    self._list:InitListView(table.count(self.chapters), function(scrollView, index)
      return self:_InitStoryTaskList(scrollView, index)
    end)
    self:_ChangeScrollViewContentPosition()
  else
    self:RefrenshList()
  end
  if self._cellSize then
    self._detailPoolGrid.cellSize = self._cellSize
  end
end

function UIQuestStoryItem:_InitStoryTaskList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIQuestStoryListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowChapterItem(heartItem, itemIndex)
    self.items[itemIndex] = heartItem
  end
  return item
end

function UIQuestStoryItem:_ShowChapterItem(heartItem, index)
  if heartItem ~= nil then
    heartItem:GetGameObject():SetActive(true)
    heartItem:SetData(index, self._currentChapterIndex, function(idx, status)
      self:_StoryTaskItemClick(idx, status)
    end)
  end
end

function UIQuestStoryItem:_StoryTaskItemClick(index, status)
  if status > QuestStatus.QUEST_NotStart then
    self:_OpenDetail(index)
  else
    ToastManager.ShowToast(StringTable.Get("str_quest_base_story_click_lock_chapter"))
  end
end

function UIQuestStoryItem:_ChangeScrollViewContentPosition()
  if self._currentChapterIndex >= table.count(self.chapters) then
    self._list:MovePanelToItemIndex(self._currentChapterIndex, 0)
    return
  end
  if table.count(self.chapters) > 2 and self._currentChapterIndex > 2 then
    local moveIdx = self._currentChapterIndex
    self._content.anchoredPosition = Vector2((moveIdx - 3) * -780 - 500, 0)
  end
end

function UIQuestStoryItem:_OpenDetail(index)
  self._detailIsOpen = true
  local chapter = self._chapterList[index]
  if self._detailPanel == nil then
    self._detailPanel = self._detailPool:SpawnObject("UIQuestStoryDetailItem")
  end
  self._detailPanel:SetData(chapter, self._currentChapterIndex, function(idx)
    self:_FinishTween(idx)
  end, function()
    self:RefrenshList()
  end, function()
    self:OnDetailClose()
  end)
end

function UIQuestStoryItem:_FinishTween(idx)
  self:Lock("UIQusetStoryChapterFinishTween")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StoryQuestLock, idx + 1)
  GameGlobal.Timer():AddEvent(167, function()
    local unLockIdx = idx + 1
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnNewStoryQuestUnLock, unLockIdx)
    GameGlobal.Timer():AddEvent(1000, function()
      self:RefrenshList()
    end)
  end)
  self._tweenAnim:Play("uieff_Quest_Story_Back")
  GameGlobal.Timer():AddEvent(1300, function()
    self:UnLock("UIQusetStoryChapterFinishTween")
  end)
end

function UIQuestStoryItem:CloseDetail()
  if self._detailIsOpen and self._detailPanel then
    self._detailPanel:AnimatedHide()
  end
  self._detailIsOpen = false
end

function UIQuestStoryItem:OnDetailClose()
  self._detailIsOpen = false
end

function UIQuestStoryItem:CheckDetailOpen()
  return self._detailIsOpen
end

function UIQuestStoryItem:GetQuestStoryListItem(index)
  if self.items[index] then
    return self.items[index]:GetGameObject("bg")
  else
    return nil
  end
end

function UIQuestStoryItem:GetQuestStoryScroll()
  return self:GetUIComponent("ScrollRect", "taskList")
end

function UIQuestStoryItem:GetQuestStoryDetailItemGet()
  if self._detailPanel then
    return self._detailPanel:GetGameObject("taskGet")
  else
    return nil
  end
end

function UIQuestStoryItem:GetQuestStoryDetailItemGoto()
  if self._detailPanel then
    return self._detailPanel:GetGameObject("taskStateImgGoto")
  else
    return nil
  end
end
