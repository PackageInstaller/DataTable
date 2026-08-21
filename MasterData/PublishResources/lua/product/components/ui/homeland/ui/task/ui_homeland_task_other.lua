_class("UIHomelandTaskOther", UICustomWidget)
UIHomelandTaskOther = UIHomelandTaskOther

function UIHomelandTaskOther:Constructor()
  self._questModule = self:GetModule(QuestModule)
  self._scrollViewSize = Vector2(1423.9, 827.9)
  self._anchoredPosition = Vector2(115.4, 405)
  self._canGetTb = {}
end

function UIHomelandTaskOther:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandTaskOther:_GetComponents()
  self._bottom = self:GetGameObject("Bottom")
  self._doneValue = self:GetUIComponent("UILocalizationText", "DoneValue")
  self._progressValueRect = self:GetUIComponent("RectTransform", "ProgressValue")
  self._rewards = self:GetUIComponent("UISelectObjectPath", "Rewards")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._scrollViewRect = self:GetUIComponent("RectTransform", "ScrollView")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._topArea = self:GetGameObject("TopArea")
end

function UIHomelandTaskOther:SetData(taskType, quests)
  table.clear(self._canGetTb)
  self._taskType = taskType
  self._quests = quests
  self._bottom:SetActive(taskType == HomelandTaskType.Phase)
  self._contentRect.anchoredPosition = Vector2(0, 0)
  self._contentWidgets = self._content:SpawnObjects("UIHomelandTaskItem", #self._quests)
  for key, widget in pairs(self._contentWidgets) do
    local quest = quests[key]
    local questInfo = quest:QuestInfo()
    if questInfo.status == QuestStatus.QUEST_Completed then
      table.insert(self._canGetTb, questInfo)
    end
    widget:SetData(quest, function(id)
      self:_GetTaskReward(id)
    end)
  end
  if taskType == HomelandTaskType.Phase then
    self:_RefreshPhaseTaskRewardInfo()
  end
  if #self._canGetTb <= 0 then
    self._topArea:SetActive(false)
    self._anchoredPosition.y = 405
    if self._taskType == HomelandTaskType.Phase then
      self._scrollViewSize.y = 647.3
    else
      self._scrollViewSize.y = 827.9
    end
  else
    self._topArea:SetActive(true)
    self._anchoredPosition.y = 300
    if self._taskType == HomelandTaskType.Phase then
      self._scrollViewSize.y = 540
    else
      self._scrollViewSize.y = 685
    end
  end
  self._scrollViewRect.sizeDelta = self._scrollViewSize
  self._scrollViewRect.anchoredPosition = self._anchoredPosition
end

function UIHomelandTaskOther:_RefreshPhaseTaskRewardInfo()
  local phaseQuests = self._quests
  local completeCount = 0
  for _, quest in pairs(phaseQuests) do
    local questInfo = quest:QuestInfo()
    if questInfo.status >= QuestStatus.QUEST_Completed then
      completeCount = completeCount + 1
    end
  end
  self._doneValue:SetText(completeCount)
  local data = self._questModule:GetQuestByQuestType(QuestType.QT_Homeland_Stage_Num)
  self:_SetRewardItem(data, completeCount, #self._quests)
end

function UIHomelandTaskOther:_SetRewardItem(data, completeCount, totalCount)
  local count = #data
  if count <= 0 then
    return
  end
  self._progressValueRect.localScale = Vector3(completeCount / totalCount, 1, 1)
  self._rewards:SpawnObjects("UIHomelandTaskReward", count)
  local items = self._rewards:GetAllSpawnList()
  for i = 1, count do
    items[i]:SetData(data[i], totalCount, function(id)
      self:_GetTaskReward(id)
    end)
  end
end

function UIHomelandTaskOther:_GetTaskReward(id)
  self:Lock("UIHomelandTaskGetReward")
  self:StartTask(self._GetQuestAward, self, id)
  self.uiOwner.gotReward = true
end

function UIHomelandTaskOther:_GetQuestAward(TT, id)
  local res, msg = self._questModule:TakeQuestReward(TT, id)
  if res:GetSucc() then
    self:ShowDialog("UIHomeShowAwards", msg.rewards)
    self.uiOwner:RefreshAllTaskData()
    self.uiOwner:RefreshUIInfo(self._taskType)
  end
  self:UnLock("UIHomelandTaskGetReward")
end

function UIHomelandTaskOther:AllGetBtnOnClick()
  self:Lock("UIHomelandTaskGetReward")
  self:StartTask(self._CheckGetAllReward, self)
  self._topArea:SetActive(false)
  self._anchoredPosition.y = 405
  if self._taskType == HomelandTaskType.Phase then
    self._scrollViewSize.y = 647.3
  else
    self._scrollViewSize.y = 827.9
  end
  self._scrollViewRect.sizeDelta = self._scrollViewSize
  self._scrollViewRect.anchoredPosition = self._anchoredPosition
end

function UIHomelandTaskOther:_CheckGetAllReward(TT)
  local res, msg = self._questModule:TakeOneKeyReward(TT, self._taskType)
  if res:GetSucc() then
    local rewards = msg.rewards
    self:ShowDialog("UIHomeShowAwards", rewards)
    self.uiOwner:RefreshAllTaskData()
    self.uiOwner:RefreshUIInfo(self._taskType)
    table.clear(self._canGetTb)
    self:UnLock("UIHomelandTaskGetReward")
  end
end
