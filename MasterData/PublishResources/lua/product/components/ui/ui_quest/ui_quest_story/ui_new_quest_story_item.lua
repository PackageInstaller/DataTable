_class("UINewQuestStoryItem", UICustomWidget)
UINewQuestStoryItem = UINewQuestStoryItem

function UINewQuestStoryItem:OnShow(uiParams)
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UINewQuestStoryItem")
  self._canvasGroup.blocksRaycasts = false
  self._uINewQuestStoryItemObj = self:GetGameObject("UINewQuestStoryItem")
  self._uINewQuestStoryItemObj:SetActive(true)
  local mMission = self:GetModule(MissionModule)
  self.discoveryData = mMission:GetDiscoveryData()
  self.chapters = self.discoveryData:GetChapters()
  self:_GetComponents()
end

function UINewQuestStoryItem:SetData()
  self._uINewQuestStoryItemObj:SetActive(true)
  self._canvasGroup.blocksRaycasts = true
  self._newCenterCanvasGroup.alpha = 1
  self:_OnValue()
end

function UINewQuestStoryItem:OnHide()
  self._uINewQuestStoryItemObj:SetActive(false)
end

function UINewQuestStoryItem:_GetComponents()
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._chapterCountTxt = self:GetUIComponent("UILocalizationText", "ChapterCountTxt")
  self._chapterCountTipsTxt = self:GetUIComponent("UILocalizationText", "ChapterCountTipsTxt")
  self._chapterNameTxt = self:GetUIComponent("UILocalizedTMP", "ChapterNameTxt")
  self._chapterStoryTipsTxt = self:GetUIComponent("UILocalizationText", "ChapterStoryTipsTxt")
  self._leftAnchorButtonObj = self:GetGameObject("LeftAnchorButton")
  self._rightAnchorButtonObj = self:GetGameObject("RightAnchorButton")
  self._newCenterCanvasGroup = self:GetUIComponent("CanvasGroup", "NewCenter")
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] questModule is nil !")
    return
  end
  self._currentChapterIndex = 1
  self._itemCountPerRow = 1
  self._curQuestIndex = 1
  self._list = self:GetUIComponent("UIDynamicScrollView", "taskList")
  self:RefrenshChapterData()
  self.curChapter = self.chapters[self._currentChapterIndex]
  self.questList = self._questModule:GetChapterQuests(self._currentChapterIndex)
  self.taskCount = #self.questList
  if self.taskCount < 14 then
  end
  self.items = {}
  self._list:InitListView(self.taskCount, function(scrollView, index)
    return self:_InitStoryTaskList(scrollView, index)
  end)
  self:StartTask(self.RefrenshListAndPlay, self)
  self:RefreshPanalBaseData()
end

function UINewQuestStoryItem:RefreshPanalBaseData()
  local chapter_cfg = Cfg.cfg_chapter({})
  if chapter_cfg == nil then
    Log.fatal("[quest] error --> cfg_chapter is nil !")
    return
  end
  if self._currentChapterIndex == nil then
    self._currentChapterIndex = 1
  end
  self._cfg_chapter = chapter_cfg[self._currentChapterIndex]
  if self._cfg_chapter == nil then
    Log.fatal("[quest] error --> cfg_chapter is nil ! index--> " .. self._currentChapterIndex)
    return
  end
  if self.curChapter == nil then
    return
  end
  self._cg:LoadImage(self._cfg_chapter.BigBackground)
  self._chapterCountTxt:SetText("" .. self.curChapter.index_name_en)
  self._chapterCountTipsTxt:SetText(self.curChapter.index_name)
  self._chapterNameTxt:SetText(self.curChapter.name)
  local str = StringTable.Get(self.questList[self._curQuestIndex]:QuestInfo().QuestDesc)
  self._chapterStoryTipsTxt:SetText(str)
  if self._currentChapterIndex == 1 then
    self._leftAnchorButtonObj:SetActive(false)
  else
    self._leftAnchorButtonObj:SetActive(true)
  end
  if self:_CheckRightBtnActive() then
    self._rightAnchorButtonObj:SetActive(true)
  else
    self._rightAnchorButtonObj:SetActive(false)
  end
end

function UINewQuestStoryItem:_CheckRightBtnActive()
  if self._currentChapterIndex == table.count(self.chapters) then
    return false
  end
  local questList = self._questModule:GetChapterQuests(self._currentChapterIndex)
  if questList then
    for i = 1, #questList do
      local questInfo = questList[i]:QuestInfo()
      if questInfo.status ~= QuestStatus.QUEST_Taken then
        return false
      end
    end
    return true
  end
end

function UINewQuestStoryItem:RefrenshList()
  local currentChapterIndex = self._currentChapterIndex
  local quest_index = self._questModule:GetLocalChapterQuestIndex()
  if currentChapterIndex == nil and quest_index == nil then
    return
  end
  self.curChapter = self.chapters[self._currentChapterIndex]
  self.questList = self._questModule:GetChapterQuests(self._currentChapterIndex)
  self.taskCount = #self.questList
  self._list:SetListItemCount(self.taskCount, true)
  self._list:MovePanelToItemIndex(0, 0)
  for index = 1, #self.items do
    local item = self.items[index]
    if index <= #self.questList then
      item:SetData(index, self.questList[index], nil, function(matid, pos)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
      end)
    else
    end
  end
  self._list:RefreshAllShownItem()
  self:RefreshPanalBaseData()
  self:StartTask(self.RefrenshListAndPlay, self)
end

function UINewQuestStoryItem:RefrenshListAndPlay(TT)
  self:Lock("UINewQuestStoryItem:RefrenshListAndPlay")
  local questCount = #self.questList
  if 6 < questCount then
    questCount = 6
  end
  for i = 1, questCount do
    local quest = self.questList[i]:QuestInfo()
    for j = 1, #self.items do
      local item = self.items[j]
      if item._data ~= nil and quest.quest_id == item._data.quest_id then
        do
          local yieldTime = (i - 1) * 65
          item:InitAnim()
          GameGlobal.Timer():AddEvent(yieldTime, function()
            item:PlayAnim()
          end)
        end
      end
    end
  end
  local lastYieldTime = (questCount - 1) * 65
  GameGlobal.Timer():AddEvent(lastYieldTime, function()
    self:UnLock("UINewQuestStoryItem:RefrenshListAndPlay")
    for j = 1, #self.items do
      local item = self.items[j]
      item:ResetAlph()
    end
  end)
end

function UINewQuestStoryItem:RefrenshChapterData()
  self._currentChapterIndex = self:_CalcuCurMainQuestChapterID()
  if not self._currentChapterIndex then
    self._currentChapterIndex = table.count(self.chapters)
  end
  local chapter_index = self._questModule:GetLocalChapterQuestIndex()
  if chapter_index == nil then
  end
end

function UINewQuestStoryItem:_CalcuCurMainQuestChapterID()
  local max = table.count(self.chapters)
  for i = 1, max do
    self.questList = self._questModule:GetChapterQuests(i)
    if self.questList then
      for j = 1, #self.questList do
        local info = self.questList[j]:QuestInfo()
        if info.status ~= QuestStatus.QUEST_Taken then
          return i
        end
      end
    end
  end
  return max
end

function UINewQuestStoryItem:_InitStoryTaskList(scrollView, index)
  if index < 0 then
    return nil
  end
  if index > #self.questList then
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UINewQuestStoryListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  self.rowList = rowList
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > #self.questList then
    end
    self:_ShowTaskItem(heartItem, itemIndex)
    self.items[itemIndex] = heartItem
  end
  return item
end

function UINewQuestStoryItem:_ShowTaskItem(heartItem, index)
  if index == 1 then
    if not self.guideItems then
      self.guideItems = {}
    end
    self.guideItems[1] = heartItem
  elseif index == 2 then
    if not self.guideItems then
      self.guideItems = {}
    end
    self.guideItems[2] = heartItem
  end
  if self.questList[index] == nil then
    heartItem:GetGameObject():SetActive(false)
    heartItem:GetGameObject().transform.parent.gameObject:SetActive(false)
    heartItem:InitAnim()
    return
  end
  if heartItem ~= nil then
    heartItem:GetGameObject().transform.parent.gameObject:SetActive(true)
    heartItem:GetGameObject():SetActive(true)
    heartItem:SetData(index, self.questList[index], nil, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
    end)
  end
end

function UINewQuestStoryItem:OnClose()
  self._uINewQuestStoryItemObj:SetActive(false)
  self._canvasGroup.blocksRaycasts = false
end

function UINewQuestStoryItem:_OnValue()
  self:RefrenshList()
end

function UINewQuestStoryItem:LeftAnchorButtonOnClick()
  if self._currentChapterIndex > 1 then
    self._currentChapterIndex = self._currentChapterIndex - 1
  end
  self:RefrenshClick()
end

function UINewQuestStoryItem:RightAnchorButtonOnClick()
  local maxCount = table.count(self.chapters)
  if self.questList then
    for i = 1, #self.questList do
      local questInfo = self.questList[i]:QuestInfo()
      if questInfo.status ~= QuestStatus.QUEST_Completed and questInfo.status ~= QuestStatus.QUEST_Taken then
        return
      end
    end
  end
  if maxCount > self._currentChapterIndex then
    self._currentChapterIndex = self._currentChapterIndex + 1
  end
  self:RefrenshClick()
end

function UINewQuestStoryItem:RefrenshClick()
  if self._currentChapterIndex == nil then
    return
  end
  self.curChapter = self.chapters[self._currentChapterIndex]
  self.questList = self._questModule:GetChapterQuests(self._currentChapterIndex)
  self.taskCount = #self.questList
  self._list:SetListItemCount(self.taskCount, true)
  self._list:MovePanelToItemIndex(0, 0)
  for index = 1, #self.items do
    local item = self.items[index]
    if index <= #self.questList then
      item:SetData(index, self.questList[index])
    else
    end
  end
  self._list:RefreshAllShownItem()
  self:RefreshPanalBaseData()
  self:StartTask(self.RefrenshListAndPlay, self)
end

function UINewQuestStoryItem:GetGuideFirstItemBtn(isGetBtn)
  if self.guideItems then
    local item = self.guideItems[1]
    if item then
      if isGetBtn then
        return item:GetRewardBtnObj()
      else
        return item:GetGotoBtnObj()
      end
    end
  end
end

function UINewQuestStoryItem:GetGuideFirstGoToBtn()
  for k, subitem in pairs(self.items) do
    if subitem:CheckQuestId(10102) and subitem:IsCanGogo() then
      return subitem:GetGotoBtnObj()
    end
  end
end
