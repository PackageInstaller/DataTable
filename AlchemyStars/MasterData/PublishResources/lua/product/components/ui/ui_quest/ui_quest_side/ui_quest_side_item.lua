_class("UIQuestSideItem", UICustomWidget)
UIQuestSideItem = UIQuestSideItem

function UIQuestSideItem:OnShow(uiParams)
  self._transition = self:GetUIComponent("ATransitionComponent", "UIQuestSideItem")
  self._anim = self:GetUIComponent("Animation", "UIQuestSideItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestSideItem")
  self._canvasGroup.blocksRaycasts = false
  self._itemCountPerRow = 1
  self._items = {}
  self:AttachEvents()
end

function UIQuestSideItem:AnimatedListIntro()
end

function UIQuestSideItem:OnClose()
  self._isOpen = false
  self._anim:Stop()
  self._canvasGroup.alpha = 0
  self._canvasGroup.blocksRaycasts = false
end

function UIQuestSideItem:SetData(type)
  if self._listInitAnimateTask then
    GameGlobal.TaskManager():KillTask(self._listInitAnimateTask)
  end
  self._canvasGroup.alpha = 1
  self._transition:PlayEnterAnimation(true)
  self._canvasGroup.blocksRaycasts = true
  self._isIntro = not self._isOpen
  self._isOpen = true
  self:_GetComponents()
  self._type = type
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  self._taskList = self:_GetQuestList()
  self._taskCount = table.count(self._taskList)
  self:_OnValue(true)
  self._listInitAnimateTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 500)
    self._isIntro = false
  end)
end

function UIQuestSideItem:_GetQuestList()
  local taskList = self._questModule:GetQuestByQuestType(self._type)
  local taskListT = {}
  for i = 1, #taskList do
    local quest = taskList[i]:QuestInfo()
    if quest.status ~= QuestStatus.QUEST_NotStart and quest.status ~= QuestStatus.QUEST_Taken then
      table.insert(taskListT, taskList[i])
    end
  end
  return taskListT
end

function UIQuestSideItem:OnHide()
  self:RemoveEvents()
end

function UIQuestSideItem:RefrenshList(force)
  self._items = {}
  self._taskList = self:_GetQuestList()
  self._taskCount = table.count(self._taskList)
  local contentPos = self._list.ScrollRect.content.localPosition
  self._list.ScrollRect:StopMovement()
  if self._taskCount <= 0 then
    self._noTaskGo:SetActive(true)
    self._taskRootGo:SetActive(false)
  else
    self._noTaskGo:SetActive(false)
    self._taskRootGo:SetActive(true)
    self._list:SetListItemCount(self._taskCount)
    self._list:MovePanelToItemIndex(0, 0)
    if not force then
      self._list.ScrollRect.content.localPosition = contentPos
    else
      self._list.ScrollRect.content.localPosition = Vector2(0, 0)
    end
  end
end

function UIQuestSideItem:_GetComponents()
  self._list = self:GetUIComponent("UIDynamicScrollView", "taskList")
  self._scrollrect = self:GetUIComponent("ScrollRect", "taskList")
  self._noTaskGo = self:GetGameObject("noTaskGo")
  self._taskRootGo = self:GetGameObject("taskRootGo")
end

function UIQuestSideItem:_OnValue(force)
  self._list:InitListView(0, function(scrollView, index)
    return self:_InitSideTaskList(scrollView, index)
  end)
  self._playAnim = true
  if 0 >= self._taskCount then
    self._noTaskGo:SetActive(true)
    self._taskRootGo:SetActive(false)
  else
    self:RefrenshList(force)
    self._noTaskGo:SetActive(false)
    self._taskRootGo:SetActive(true)
  end
  self._playAnim = false
end

function UIQuestSideItem:_InitSideTaskList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIQuestSideListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowSideItem(heartItem, itemIndex)
  end
  return item
end

function UIQuestSideItem:_ShowSideItem(heartItem, idx)
  local config = self._taskList[idx]
  heartItem:GetGameObject():SetActive(true)
  if config ~= nil then
    heartItem:SetData(idx, config, function(questInfo)
      self:_SideTaskItemClick(questInfo.quest_id)
    end, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
    end, self._playAnim)
  end
  table.insert(self._items, heartItem)
end

function UIQuestSideItem:_SideTaskItemClick(id)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIQuestGet")
  self:StartTask(self.On_SideTaskItemClick, self, id)
end

function UIQuestSideItem:On_SideTaskItemClick(TT, id)
  local res, msg = self._questModule:TakeQuestReward(TT, id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Branch)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Branch)
      end)
    end
  end
end

function UIQuestSideItem:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestSideItem:RemoveEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestSideItem:OnUIGetItemCloseInQuest(type)
  if self._isOpen and type == QuestType.QT_Branch then
    self:RefrenshList()
  end
end

function UIQuestSideItem:OnUIPetObtainCloseInQuest(type)
  if self._isOpen and type == QuestType.QT_Branch then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Branch)
    end)
  end
end
