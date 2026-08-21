_class("UIHomelandTask", UIController)
UIHomelandTask = UIHomelandTask

function UIHomelandTask:Constructor()
  self._questModule = self:GetModule(QuestModule)
  self._homelandModule = self:GetModule(HomelandModule)
  self._curTaskType = nil
  self._taskData = {}
  self._atlas = self:GetAsset("UIHomelandTask.spriteatlas", LoadType.SpriteAtlas)
  self.gotReward = false
  self._allGuideDone = true
end

function UIHomelandTask:OnShow(uiParams)
  self._callBack = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
end

function UIHomelandTask:_GetComponents()
  self._btn = {}
  self._btn[HomelandTaskType.Guide] = self:GetGameObject("GuideTaskBtn")
  self._btn[HomelandTaskType.Phase] = self:GetGameObject("PhaseTaskBtn")
  self._btn[HomelandTaskType.Home] = self:GetGameObject("HomeTaskBtn")
  self._btn[HomelandTaskType.Change] = self:GetGameObject("ChangeTaskBtn")
  self._btnImages = {}
  self._btnImages[HomelandTaskType.Guide] = self:GetUIComponent("Image", "GuideTaskBtn")
  self._btnImages[HomelandTaskType.Phase] = self:GetUIComponent("Image", "PhaseTaskBtn")
  self._btnImages[HomelandTaskType.Home] = self:GetUIComponent("Image", "HomeTaskBtn")
  self._btnImages[HomelandTaskType.Change] = self:GetUIComponent("Image", "ChangeTaskBtn")
  self._btnTexts = {}
  self._btnTexts[HomelandTaskType.Guide] = self:GetUIComponent("UILocalizationText", "GuideTaskBtnText")
  self._btnTexts[HomelandTaskType.Phase] = self:GetUIComponent("UILocalizationText", "PhaseTaskBtnText")
  self._btnTexts[HomelandTaskType.Home] = self:GetUIComponent("UILocalizationText", "HomeTaskBtnText")
  self._btnTexts[HomelandTaskType.Change] = self:GetUIComponent("UILocalizationText", "ChangeTaskBtnText")
  self._btnLocks = {}
  self._btnLocks[HomelandTaskType.Guide] = self:GetGameObject("GuideTaskLock")
  self._btnLocks[HomelandTaskType.Phase] = self:GetGameObject("PhaseTaskLock")
  self._btnLocks[HomelandTaskType.Home] = self:GetGameObject("HomeTaskLock")
  self._btnLocks[HomelandTaskType.Change] = self:GetGameObject("ChangeTaskLock")
  self._redPoints = {}
  self._redPoints[HomelandTaskType.Guide] = self:GetGameObject("GuideRedPoint")
  self._redPoints[HomelandTaskType.Phase] = self:GetGameObject("PhaseRedPoint")
  self._redPoints[HomelandTaskType.Home] = self:GetGameObject("HomeRedPoint")
  self._redPoints[HomelandTaskType.Change] = self:GetGameObject("ChangeRedPoint")
  self._guide = self:GetUIComponent("UISelectObjectPath", "Guide")
  self._guideObj = self:GetGameObject("Guide")
  self._other = self:GetUIComponent("UISelectObjectPath", "Other")
  self._otherObj = self:GetGameObject("Other")
end

function UIHomelandTask:_OnValue()
  self:RefreshAllTaskData()
  self._guideWidget = self._guide:SpawnObject("UIhomelandTaskGuide")
  self._otherWidget = self._other:SpawnObject("UIHomelandTaskOther")
  self:RefreshUIInfo(HomelandTaskType.Guide)
end

function UIHomelandTask:GuideTaskBtnOnClick(go)
  self:_SwitchTask(HomelandTaskType.Guide)
end

function UIHomelandTask:PhaseTaskBtnOnClick(go)
  if self._btnLocks[HomelandTaskType.Phase].activeSelf then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_task_phase_lock"))
    return
  end
  self:_SwitchTask(HomelandTaskType.Phase)
end

function UIHomelandTask:HomeTaskBtnOnClick(go)
  if self._btnLocks[HomelandTaskType.Home].activeSelf then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_task_home_lock"))
    return
  end
  self:_SwitchTask(HomelandTaskType.Home)
end

function UIHomelandTask:ChangeTaskBtnOnClick(go)
  if self._btnLocks[HomelandTaskType.Change].activeSelf then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_task_change_lock"))
    return
  end
  self:_SwitchTask(HomelandTaskType.Change)
end

function UIHomelandTask:_SwitchTask(taskType)
  if self._curTaskType == taskType then
    return
  end
  self:RefreshUIInfo(taskType)
end

function UIHomelandTask:RefreshUIInfo(taskType)
  if taskType == HomelandTaskType.Guide and self._allGuideDone then
    taskType = HomelandTaskType.Phase
    self._btn[HomelandTaskType.Guide]:SetActive(false)
  end
  self._curTaskType = taskType
  for _, _type in pairs(HomelandTaskType) do
    local sprite = "N17_task_btn02"
    local color = Color(0.4196078431372549, 0.4196078431372549, 0.4196078431372549)
    if self._curTaskType == _type then
      sprite = "N17_task_btn01"
      color = Color.white
    end
    self._btnImages[_type].sprite = self._atlas:GetSprite(sprite)
    self._btnTexts[_type].color = color
  end
  if self._curTaskType == HomelandTaskType.Guide then
    self._guideWidget:SetData(self._taskData[self._curTaskType])
  else
    self._otherWidget:SetData(self._curTaskType, self._taskData[self._curTaskType])
  end
  self._guideObj:SetActive(self._curTaskType == HomelandTaskType.Guide)
  self._otherObj:SetActive(self._curTaskType ~= HomelandTaskType.Guide)
  self:_RefreshTagUnLockState()
  self:_RefreshTagRedPointState()
end

function UIHomelandTask:BackBtnOnClick(go)
  self:CloseDialog()
  if self._callBack and self.gotReward then
    self._callBack()
  end
end

function UIHomelandTask:RefreshAllTaskData()
  self._taskData[HomelandTaskType.Guide] = self:_ClassifyGuideTaskData(self._questModule:GetQuestByQuestType(HomelandTaskType.Guide))
  local phases = self._questModule:GetQuestByQuestType(HomelandTaskType.Phase)
  local phaseTask = {}
  for _, task in ipairs(phases) do
    if task:QuestInfo().status ~= QuestStatus.QUEST_NotStart then
      phaseTask[#phaseTask + 1] = task
    end
  end
  self:_Sort(phaseTask)
  self._taskData[HomelandTaskType.Phase] = phaseTask
  local home = self._questModule:GetQuestByQuestType(HomelandTaskType.Home)
  local homeTask = {}
  for _, task in ipairs(home) do
    if task:QuestInfo().status ~= QuestStatus.QUEST_NotStart then
      homeTask[#homeTask + 1] = task
    end
  end
  self:_Sort(homeTask)
  self._taskData[HomelandTaskType.Home] = homeTask
  local change = self._questModule:GetQuestByQuestType(HomelandTaskType.Change)
  local changeTask = {}
  for _, task in ipairs(change) do
    if task:QuestInfo().status ~= QuestStatus.QUEST_NotStart then
      changeTask[#changeTask + 1] = task
    end
  end
  self._taskData[HomelandTaskType.Change] = changeTask
  self._taskData[QuestType.QT_Homeland_Stage_Num] = self._questModule:GetQuestByQuestType(QuestType.QT_Homeland_Stage_Num)
end

function UIHomelandTask:_ClassifyGuideTaskData(questList)
  self._allGuideDone = true
  local taskData = {}
  for _, quest in pairs(questList) do
    local cfg = Cfg.cfg_homeland_task[quest:ID()]
    if cfg then
      if not taskData[cfg.GroupID] then
        taskData[cfg.GroupID] = {}
      end
      table.insert(taskData[cfg.GroupID], quest)
    end
    if quest:QuestInfo().status ~= QuestStatus.QUEST_Taken then
      self._allGuideDone = false
    end
  end
  return taskData
end

function UIHomelandTask:_RefreshTagUnLockState()
  for _, taskType in pairs(HomelandTaskType) do
    self._btnLocks[taskType]:SetActive(not self:_IsUnLock(taskType))
  end
end

function UIHomelandTask:_RefreshTagRedPointState()
  for _, taskType in pairs(HomelandTaskType) do
    if self:_IsUnLock(taskType) then
      self._redPoints[taskType]:SetActive(self:_ShowRedPoint(taskType))
    else
      self._redPoints[taskType]:SetActive(false)
    end
  end
end

function UIHomelandTask:_IsUnLock(taskType)
  local functionType
  if taskType == HomelandTaskType.Guide then
    functionType = HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_GUIDE_UI
  elseif taskType == HomelandTaskType.Phase then
    functionType = HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_STAGE_UI
  elseif taskType == HomelandTaskType.Home or taskType == HomelandTaskType.Change then
    functionType = HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_COMMON_UI
  end
  if not functionType then
    Log.fatal("找不到任务类型：" .. tostring(taskType))
    return false
  else
    return self._homelandModule:CheckFunctionUnlock(functionType)
  end
end

function UIHomelandTask:_ShowRedPoint(taskType)
  local data = self._taskData[taskType]
  if not data then
    return false
  end
  if taskType == HomelandTaskType.Guide then
    for _, quests in pairs(data) do
      if quests then
        for _, quest in pairs(quests) do
          if quest:QuestInfo().status == QuestStatus.QUEST_Completed then
            return true
          end
        end
      end
    end
    return false
  else
    for _, quest in pairs(data) do
      if quest:QuestInfo().status == QuestStatus.QUEST_Completed then
        return true
      end
    end
    if taskType == HomelandTaskType.Phase then
      local stageData = self._taskData[QuestType.QT_Homeland_Stage_Num]
      if not stageData then
        return false
      end
      for _, quest in pairs(stageData) do
        if quest:QuestInfo().status == QuestStatus.QUEST_Completed then
          return true
        end
      end
    end
  end
  return false
end

function UIHomelandTask:_Sort(questlist)
  if questlist then
    local function sortFunc(a, b)
      local astatus = a:QuestInfo().status
      
      local bstatus = b:QuestInfo().status
      if astatus == bstatus then
        local cfga = Cfg.cfg_quest[a:ID()]
        local cfgb = Cfg.cfg_quest[b:ID()]
        if cfga and cfga.SortID and cfgb and cfgb.SortID then
          return cfga.SortID < cfgb.SortID
        end
      else
        if astatus == QuestStatus.QUEST_Taken then
          astatus = 0
        end
        if bstatus == QuestStatus.QUEST_Taken then
          bstatus = 0
        end
        return astatus > bstatus
      end
    end
    
    table.sort(questlist, sortFunc)
  end
end
