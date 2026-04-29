_class("UIHomelandStoryTaskController", UIController)
UIHomelandStoryTaskController = UIHomelandStoryTaskController

function UIHomelandStoryTaskController:Constructor()
  self._localData = UIHomelandStoryTaskLocalData:New()
end

function UIHomelandStoryTaskController:LoadDataOnEnter(TT, res, uiParams)
  self._uiHomelandModule = GameGlobal.GetModule(HomelandModule):GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  self._taskManager = self._homelandClient:GetHomelandTaskManager()
  self._taskHelper = self._taskManager:GetHomelandTaskManagerHelper()
  self._storyTaskManager = self._taskManager:GetHomelandStoryTaskManager()
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._storyTaskInfos = self._homelandModule.m_homeland_info.story_task_info
end

function UIHomelandStoryTaskController:OnShow(uiParams)
  self._taskGroupCfg = Cfg.cfg_homeland_task_group({})
  self._storyTaskCfg = Cfg.cfg_homeland_story_task({})
  self._firstShow = true
  self:_GetComponents()
  self:Refresh()
  self:AttachEvent(GameEventType.HandleStoryTaskUpdate, self.StoryTaskUpdate)
  self:AttachEvent(GameEventType.UIHomelandStoryTaskBtnSelect, self.OnSelectBtn)
  self:AttachEvent(GameEventType.UIHomelandStoryTaskGroupSelect, self.OnSelectGroupItem)
  self:SetLocalDataNew()
end

function UIHomelandStoryTaskController:OnHide()
  self:DetachEvent(GameEventType.HandleStoryTaskUpdate, self.StoryTaskUpdate)
  self:DetachEvent(GameEventType.UIHomelandStoryTaskBtnSelect, self.OnSelectBtn)
  self:DetachEvent(GameEventType.UIHomelandStoryTaskGroupSelect, self.OnSelectGroupItem)
  if self._aniCoro then
    self:UnLock("UIHomelandStoryTaskController:ShowItemCoro")
    GameGlobal.TaskManager():KillTask(self._aniCoro)
    self._aniCoro = nil
  end
end

function UIHomelandStoryTaskController:_GetComponents()
  self._atlas = self:GetAsset("UIHomelandStoryTask.spriteatlas", LoadType.SpriteAtlas)
  self._tabs = self:GetUIComponent("UISelectObjectPath", "tabs")
  self._processText = self:GetUIComponent("UILocalizationText", "processText")
  self._txtActionPoint = self:GetUIComponent("UILocalizationText", "txtActionPoint")
  self._iconActionPointImg = self:GetUIComponent("RawImageLoader", "iconActionPoint")
  self._right = self:GetGameObject("right")
  self._rightAnimation = self:GetUIComponent("Animation", "right")
  self._awardspar = self:GetGameObject("awardspar")
  self._sv = self:GetUIComponent("ScrollRect", "sv")
  self._awards = self:GetUIComponent("UISelectObjectPath", "awards")
  self._groups = self:GetUIComponent("UISelectObjectPath", "groups")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._rewardTextgo = self:GetGameObject("rewardText")
  self._rewardText = self:GetUIComponent("UILocalizationText", "rewardText")
  self._finishstate = self:GetUIComponent("Image", "finishstate")
  self._groupInfo = {}
  self._groupInfo.groupname = self:GetUIComponent("UILocalizationText", "groupName")
  self._groupInfo.tasktitle = self:GetUIComponent("UILocalizationText", "groupTaskTitle")
  self._groupInfo.taskcontent = self:GetUIComponent("UILocalizationText", "groupTaskInfo")
  self._groupInfo.taskbg = self:GetUIComponent("UILocalizationText", "groupTaskBg")
  self._groupInfo.content = self:GetUIComponent("RectTransform", "content")
  self._groupInfo.img = self:GetUIComponent("RawImageLoader", "contentImg")
  self._groupInfo.groupTaskFinished = self:GetUIComponent("UILocalizationText", "groupTaskFinished")
  self._groupInfo.unlock = self:GetUIComponent("RectTransform", "unlock")
  self._groupInfo.unlockIntroaward = self:GetUIComponent("UISelectObjectPath", "unlockIntroaward")
  self._finisedGo = self:GetGameObject("finished")
  self._traceBtn = self:GetGameObject("traceBtn")
  self._rightlock = self:GetGameObject("rightlock")
  self._traceText = self:GetUIComponent("UILocalizationText", "btnTraceText")
  self._lockInfo = {}
  self._lockInfo.title = self:GetUIComponent("UILocalizationText", "locktitleText")
  self._lockInfo.content = self:GetUIComponent("UILocalizationText", "lockcontentText")
  self._lockInfo.condition = self:GetUIComponent("UILocalizationText", "conditionText")
  self._lockInfo.actionpoint = self:GetUIComponent("UILocalizationText", "actionpointText")
  self._lockInfo.bg = self:GetUIComponent("Image", "lockbgImg")
  self._rightintro = self:GetGameObject("rightintro")
  self._rightintroInfo = {}
  self._rightintroInfo.title = self:GetUIComponent("UILocalizationText", "introtitleText")
  self._rightintroInfo.content = self:GetUIComponent("UILocalizationText", "introcontentText")
  self._rightintroInfo.condition = self:GetUIComponent("UILocalizationText", "introconditionText")
  self._rightintroInfo.actionpoint = self:GetUIComponent("UILocalizationText", "locktitleText")
  self._introawardsv = self:GetUIComponent("UISelectObjectPath", "introawardsv")
  self._unlockTextPoint = self:GetUIComponent("UILocalizationText", "unlockTextPoint")
  self._tipTextGo = self:GetGameObject("tipText")
end

function UIHomelandStoryTaskController:InitActiveTask()
  if not self._storyTaskInfos then
    self._isTrace = false
    self._selectTaskId = 0
    return
  end
  self._isTrace = self._storyTaskInfos.cfg_id ~= 0
  if self._isTrace then
    self._selectTaskId = self._storyTaskInfos.cfg_id
  elseif self._activeStoryTasks[1] then
    self._selectTaskId = self._activeStoryTasks[1].ID
  end
  if self._selectTaskId then
    self._selectTaskCfg = self._storyTaskCfg[self._selectTaskId]
    self._selectTaskGroupId = self:GetRunningGroup()
  end
end

function UIHomelandStoryTaskController:GetRunningGroup()
  local groupId = self._selectTaskCfg.StoryTaskGroupTb[1]
  if self._selectTaskId then
    for i = 1, #self._selectTaskCfg.StoryTaskGroupTb do
      local group = self._selectTaskCfg.StoryTaskGroupTb[i]
      if not self._storyTaskManager:CheckStoryTaskGroupFinished(self._selectTaskId, group) and self:CheckTaskGroupInTime(group) then
        groupId = self._selectTaskCfg.StoryTaskGroupTb[i]
        return groupId
      end
    end
    for i = #self._selectTaskCfg.StoryTaskGroupTb, 1, -1 do
      local group = self._selectTaskCfg.StoryTaskGroupTb[i]
      if self._storyTaskManager:CheckStoryTaskGroupFinished(self._selectTaskId, group) and self:CheckTaskGroupInTime(group) then
        groupId = group
        break
      end
    end
    return groupId
  end
  return groupId
end

function UIHomelandStoryTaskController:CheckTaskGroupInTime(taskGroupId)
  return self._taskHelper:CheckTaskGroupInTime(taskGroupId)
end

function UIHomelandStoryTaskController:SetActiveTask(taskId)
  self._selectTaskId = taskId
  self._selectTaskCfg = self._storyTaskCfg[self._selectTaskId]
  self._selectTaskGroupId = self:GetRunningGroup()
end

function UIHomelandStoryTaskController:Refresh()
  self:GetSelectStoryTaskData()
  self:InitActiveTask()
  self:RefreshSelectBtns()
  self:RefreshUnLockInfo()
  self:ShowInfo()
  self:RefreshTaskGroups()
  self:ShowActionPointInfo()
end

function UIHomelandStoryTaskController:GetSelectStoryTaskData()
  self._activeStoryTasks = {}
  if not self._storyTaskInfos then
    return self._activeStoryTasks
  end
  for key, value in pairs(self._storyTaskCfg) do
    local begintime = self._storyTaskCfg[key].UnlockTime
    if self:CheckOpen(begintime) then
      table.insert(self._activeStoryTasks, value)
    end
  end
  return self._activeStoryTasks
end

function UIHomelandStoryTaskController:CheckOpen(beginTime)
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if curTime >= beginTime then
    return true
  end
  return false
end

function UIHomelandStoryTaskController:RefreshSelectBtns()
  local data = self._activeStoryTasks
  self._tabs:SpawnObjects("UIHomelandStoryTaskBtn", #data)
  self._selectBnts = self._tabs:GetAllSpawnList()
  for i = 1, #self._selectBnts do
    self._selectBnts[i]:SetData(data[i], self, self._selectTaskId)
  end
end

function UIHomelandStoryTaskController:RefreshTaskGroups()
  local data = self._storyTaskCfg[self._selectTaskId]
  if not data then
    return
  end
  self._groups:SpawnObjects("UIHomelandStoryTaskGroupItem", #data.StoryTaskGroupTb)
  self._taskGroups = self._groups:GetAllSpawnList()
  for i = 1, #data.StoryTaskGroupTb do
    if data.StoryTaskGroupTb[i] then
      self._taskGroups[i]:Show()
      local lastGroup = data.StoryTaskGroupTb[i - 1]
      self._taskGroups[i]:Flush(i, data.StoryTaskGroupTb[i], self, self._selectTaskId, lastGroup, self._selectTaskGroupId, self._taskGroupCfg)
    else
      self._taskGroups[i]:Hide()
    end
  end
  self:ShowTaskGroupInfo()
  self:RefreshAward()
  if self._firstShow then
    self._firstShow = false
    self._aniCoro = self:StartTask(self.ShowItemCoro, self)
  end
end

function UIHomelandStoryTaskController:RefreshUnLockInfo()
  if not self._selectTaskCfg then
    self._rightlock:SetActive(false)
    self._rightintro:SetActive(false)
    self._right:SetActive(false)
    return
  end
  local data = self._storyTaskCfg[self._selectTaskId]
  self._rightintroInfo.content:SetText(StringTable.Get(data.GroupsListContent))
  if data.LockTaskId ~= nil then
    self._rightintroInfo.condition:SetText(string.format(StringTable.Get("str_homeland_storytask_condition", data.LockTaskId)))
  else
    self._rightintroInfo.condition:SetText("")
  end
  local isInTime = self:CheckIsFree(data.UnCostTimeStart, data.UnCostTimeEnd)
  self._tipTextGo:SetActive(isInTime)
  local cost = isInTime and 0 or data.CostItemNum
  self._unlockTextPoint:SetText(cost)
  do
    local cur, max = self:GetActionPointInfo()
    local color
    if cost <= cur then
      color = Color(1.0, 1.0, 1.0)
    else
      color = Color(0.984313725490196, 0.3411764705882353, 0.2549019607843137)
    end
    self._unlockTextPoint.color = color
  end
  local isUnlock = self:CheckTaskUnLock(self._selectTaskId)
  self._rightlock:SetActive(false)
  self._rightintro:SetActive(not isUnlock)
  self._right:SetActive(isUnlock)
  self._awardspar:SetActive(isUnlock)
  self._rightintro:SetActive(not isUnlock)
end

function UIHomelandStoryTaskController:CheckIsFree(beginTime, endTime)
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = loginModule:GetTimeStampByTimeStr(endTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if curTime >= beginTime and curTime < endTime then
    return true
  end
  return false
end

function UIHomelandStoryTaskController:ShowItemCoro(TT)
  self:Lock("UIHomelandStoryTaskController:ShowItemCoro")
  local items = self._groups:GetAllSpawnList()
  YIELD(TT, 90)
  for i = 1, #items do
    YIELD(TT, 20)
    items[i]:ShowAnim()
  end
  self:UnLock("UIHomelandStoryTaskController:ShowItemCoro")
end

function UIHomelandStoryTaskController:ShowTaskGroupInfo()
  local curTaskGroupInfo = self._taskGroupCfg[self._selectTaskGroupId]
  if not curTaskGroupInfo then
    return
  end
  local finished = self:CheckTaskGroupFinish(self._selectTaskId, self._selectTaskGroupId)
  local unlocked = self:CheckTaskGroupUnlock(self._selectTaskId, self._selectTaskGroupId)
  self._groupInfo.content.gameObject:SetActive(unlocked)
  self._groupInfo.img.gameObject:SetActive(unlocked)
  self._groupInfo.unlock.gameObject:SetActive(not unlocked)
  if not unlocked then
    local rewards = self._taskGroupCfg[self._selectTaskGroupId].Reward
    local introawards = self._groupInfo.unlockIntroaward:SpawnObjects("UIHomelandTaskGuideRewardItem", #rewards)
    for i = 1, #introawards do
      if rewards[i] then
        introawards[i]:Show()
        local rew = {}
        rew.assetid = rewards[i][1]
        rew.count = rewards[i][2]
        introawards[i]:SetData(rew, finished)
        introawards[i]:ClearTextCount()
      else
        introawards[i]:Hide()
      end
    end
  elseif finished then
    self._rightAnimation:Play()
    self._groupInfo.groupname:SetText(StringTable.Get(curTaskGroupInfo.GroupTitle))
    self._groupInfo.tasktitle:SetText("")
    self._groupInfo.taskcontent:SetText("")
    self._groupInfo.taskbg:SetText("")
    self._groupInfo.groupTaskFinished:SetText(StringTable.Get(curTaskGroupInfo.GroupContent))
  else
    local task = self:CheckTaskItemRunning(self._selectTaskId, self._selectTaskGroupId)
    local info = {}
    if task then
      local title, content, bg = task:GetTaskInfo()
      local finishInfo = task:GetConditionInfo()
      local finishType = finishInfo.FinishType
      if finishType == FinishConditionEnum.Item or finishType == FinishConditionEnum.PetSearch or finishType == FinishConditionEnum.PetNeed then
        local itemId, itemCount = finishInfo.NeedItems[1], finishInfo.NeedItems[2]
        local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(itemId)
        local colorContent
        if itemCount <= haveCount then
          colorContent = string.format("<color=#fbc305>%s</color>", haveCount)
          content = StringTable.Get(content, colorContent, itemCount)
        else
          colorContent = string.format("<color=#fbc305>%s</color>", haveCount)
          content = StringTable.Get(content, colorContent, itemCount)
        end
      else
        content = StringTable.Get(content)
      end
      info.title = StringTable.Get(title)
      info.content = content
      info.bg = StringTable.Get(bg)
      self._groupInfo.groupTaskFinished:SetText("")
    else
      info.title = ""
      info.content = ""
      info.bg = ""
      self._groupInfo.groupTaskFinished:SetText(StringTable.Get(curTaskGroupInfo.GroupContent))
    end
    self._rightAnimation:Play()
    self._groupInfo.groupname:SetText(StringTable.Get(curTaskGroupInfo.GroupTitle))
    self._groupInfo.tasktitle:SetText(info.title)
    self._groupInfo.taskcontent:SetText(info.content)
    self._groupInfo.taskbg:SetText(info.bg)
  end
  self._finisedGo:SetActive(finished)
  self._traceBtn:SetActive(not finished)
  self._groupInfo.img:LoadImage(curTaskGroupInfo.GroupIcon)
end

function UIHomelandStoryTaskController:RefreshAward()
  local finished = self:CheckTaskGroupFinish(self._selectTaskId, self._selectTaskGroupId)
  local rewards = self._taskGroupCfg[self._selectTaskGroupId].Reward
  self._rewardTextgo:SetActive(true)
  local str = finished and "str_homeland_storytask_finished_reward" or "str_homeland_storytask_finish_reward"
  self._rewardText:SetText(StringTable.Get(str))
  local sp = finished and "n19_chuanshanjia_finish04" or "n19_chuanshanjia_finish03"
  self._finishstate.sprite = self._atlas:GetSprite(sp)
  self._awards:SpawnObjects("UIHomelandTaskGuideRewardItem", #rewards)
  self._awardItems = self._awards:GetAllSpawnList()
  for i = 1, #self._awardItems do
    if rewards[i] then
      self._awardItems[i]:Show()
      local rew = {}
      rew.assetid = rewards[i][1]
      rew.count = rewards[i][2]
      self._awardItems[i]:SetData(rew, finished)
    else
      self._awardItems[i]:Hide()
    end
  end
  local data = self._storyTaskCfg[self._selectTaskId]
  rewards = data.Reward
  self._introawardsv:SpawnObjects("UIHomelandTaskGuideRewardItem", #rewards)
  self._introawards = self._introawardsv:GetAllSpawnList()
  for i = 1, #self._introawards do
    if rewards[i] then
      self._introawards[i]:Show()
      local rew = {}
      rew.assetid = rewards[i][1]
      rew.count = rewards[i][2]
      self._introawards[i]:SetData(rew, finished)
      self._introawards[i]:ClearTextCount()
    else
      self._introawards[i]:Hide()
    end
  end
end

function UIHomelandStoryTaskController:ShowInfo()
  if not self._selectTaskCfg then
    return
  end
  local finishCount = self:GetFinishedStoryTask()
  self._processText:SetText(StringTable.Get("str_homeland_storytask_finished", finishCount, #self._activeStoryTasks))
  self._titleText:SetText(StringTable.Get(self._selectTaskCfg.GroupsListTitle))
  local traceStr = {
    "str_homeland_storytask_stoptrace",
    "str_homeland_storytask_trace"
  }
  local id = self._isTrace and self._selectTaskId == self._storyTaskInfos.cfg_id and 1 or 2
  self._traceText:SetText(StringTable.Get(traceStr[id]))
end

function UIHomelandStoryTaskController:ShowActionPointInfo()
  local cur, max = self:GetActionPointInfo()
  self._txtActionPoint:SetText(cur .. "/" .. max)
  if not self._storyTaskInfos then
    return
  end
  local endtime = self._storyTaskInfos.refresh_time
  self:_SetRemainingTime("_actionPointPool", nil, endtime)
end

function UIHomelandStoryTaskController:GetFinishedStoryTask()
  return self._storyTaskManager:GetFinishedStoryTaskCount()
end

function UIHomelandStoryTaskController:GetStoryTaskCfgData(id)
  return self._storyTaskCfg[id]
end

function UIHomelandStoryTaskController:GetTaskGroupCfgData(id)
  return self._taskGroupCfg[id]
end

function UIHomelandStoryTaskController:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandStoryTaskController:BtnUnlockOnClick(go)
  if self._selectTaskCfg == nil then
    return
  end
  local cur, max = self:GetActionPointInfo()
  local isInTime = self:CheckIsFree(self._selectTaskCfg.UnCostTimeStart, self._selectTaskCfg.UnCostTimeEnd)
  local cost = isInTime and 0 or self._selectTaskCfg.CostItemNum
  if cur < cost then
    ToastManager.ShowToast(StringTable.Get("str_homeland_storytask_action_point_not_enough"))
    return
  end
  Log.info("UIHomelandStoryTaskController:BtnUnlockOnClick() id = ", self._selectTaskId)
  self:StartTask(function(TT)
    GameGlobal.UIStateManager():Lock("UIHomelandStoryTaskController:BtnUnlockOnClick")
    local res = self._homelandModule:HomelandStoryTaskUnlockReq(TT, self._selectTaskId)
    if res:GetSucc() then
      Log.info("UIHomelandStoryTaskController:BtnUnlockOnClick() Success, id = ", self._selectTaskId)
      local taskName = StringTable.Get(self._selectTaskCfg.GroupsListTitle)
      ToastManager.ShowToast(StringTable.Get("str_homeland_storytask_unlock_success", taskName))
      YIELD(TT, 1500)
      self:ShowInfo()
      self:RefreshTaskGroups()
      self:RefreshUnLockInfo()
      self:RefreshSelectBtns()
      self:ShowActionPointInfo()
    else
      Log.fatal("UIHomelandStoryTaskController:BtnUnlockOnClick() error, id = ", self._selectTaskId)
    end
    GameGlobal.UIStateManager():UnLock("UIHomelandStoryTaskController:BtnUnlockOnClick")
  end, self)
end

function UIHomelandStoryTaskController:TraceBtnOnClick(go)
  Log.info("UIHomelandStoryTaskController:TraceBtnOnClick() id = ", self._selectTaskId, " isTrace = ", tostring(self._isTrace))
  self:StartTask(function(TT)
    GameGlobal.UIStateManager():Lock("UIHomelandStoryTaskController:TraceBtnOnClick")
    local res = self._homelandModule:HomelandStoryTaskAutoOperateReq(TT, self._selectTaskId)
    if res:GetSucc() then
      Log.info("UIHomelandStoryTaskController:TraceBtnOnClick() Success, id = ", self._selectTaskId)
      self._isTrace = self._storyTaskInfos.cfg_id ~= 0
      if self._storyTaskInfos.cfg_id > 0 then
        self._storyTaskManager:StartRun(self._storyTaskInfos.cfg_id)
      else
        self._storyTaskManager:StopRun()
      end
      self:ShowInfo()
      self:RefreshTaskGroups()
      self:RefreshSelectBtns()
      if self._isTrace then
        self:_PrintStoryTask()
        self:CloseDialog()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.StoryTaskTraceSuccess)
      end
    else
      Log.fatal("UIHomelandStoryTaskController:TraceBtnOnClick() error, id = ", self._selectTaskId)
    end
    GameGlobal.UIStateManager():UnLock("UIHomelandStoryTaskController:TraceBtnOnClick")
  end, self)
end

function UIHomelandStoryTaskController:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandStoryTaskController:BtnWhiteCloseOnClick(go)
  self:CloseDialog()
end

function UIHomelandStoryTaskController:ActionPointBtnOnClick(go)
  self:ShowDialog("UIHomelandStoryTaskActionPointDetail")
end

function UIHomelandStoryTaskController:OnSelectBtn(taskId)
  self:RefreshSelectBtnsOnSelect(taskId)
end

function UIHomelandStoryTaskController:OnSelectGroupItem(taskId)
  self:RefreshSelectGroupOnSelect(taskId)
end

function UIHomelandStoryTaskController:StoryTaskUpdate(msg)
  self._storyTaskInfos = msg
  self:RefreshSelectBtns()
  self:SetActiveTask(self._selectTaskId)
  self:ShowInfo()
  self:RefreshTaskGroups()
  self:ShowActionPointInfo()
end

function UIHomelandStoryTaskController:CheckTaskUnLock(id)
  if not self._storyTaskInfos then
    return false
  end
  if not self._storyTaskInfos.id_list then
    return false
  end
  for i, v in pairs(self._storyTaskInfos.id_list) do
    if id == v then
      return true
    end
  end
  return false
end

function UIHomelandStoryTaskController:GetActionPointInfo()
  local item_id = Cfg.cfg_homeland_global.StoryTaskRefreshItemId.IntValue
  local maxCount = Cfg.cfg_homeland_global.StoryTaskMaxRefreshCount.IntValue
  local im = GameGlobal.GetModule(ItemModule)
  local itemCount = im:GetItemCount(item_id)
  return itemCount, maxCount
end

function UIHomelandStoryTaskController:GetStoryTaskGroupInfo(taskGroupId)
  return self._storyTaskManager:GetStoryGroupInfo(taskGroupId)
end

function UIHomelandStoryTaskController:SetNewPoint(taskId)
  if self._localData.HasPrefsStoryTask(taskId) then
    return
  end
  self._localData.SetPrefsStoryTask(taskId)
end

function UIHomelandStoryTaskController:CheckNewPoint(taskId)
  return self._localData.HasPrefsStoryTask(taskId)
end

function UIHomelandStoryTaskController:CheckIsTrace(taskId)
  if not self._storyTaskInfos then
    return false
  end
  return self._storyTaskInfos.cfg_id == taskId
end

function UIHomelandStoryTaskController:GetTeaceingStoryTask()
  return self._storyTaskInfos.cfg_id
end

function UIHomelandStoryTaskController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
  if endTime <= 0 then
    obj:_SetTimeText("Max")
  end
end

function UIHomelandStoryTaskController:CheckTaskGroupUnlock(taskId, groupId)
  local data = self._storyTaskCfg[self._selectTaskId]
  if not data then
    return true
  end
  local preGroup
  for i = 1, #data.StoryTaskGroupTb do
    if data.StoryTaskGroupTb[i] == groupId then
      preGroup = data.StoryTaskGroupTb[i - 1]
      break
    end
  end
  if preGroup == nil then
    return true
  end
  return self:CheckTaskGroupFinish(taskId, preGroup)
end

function UIHomelandStoryTaskController:CheckTaskGroupFinish(taskId, groupId)
  if self._storyTaskManager then
    return self._storyTaskManager:CheckStoryTaskGroupFinished(taskId, groupId)
  end
end

function UIHomelandStoryTaskController:CheckTaskItemRunning(taskId, groupId)
  if self._storyTaskManager then
    return self._storyTaskManager:GetRunningTask(taskId, groupId)
  end
end

function UIHomelandStoryTaskController:CheckStoryTaskFinish(taskId)
  if not self:CheckTaskUnLock(taskId) then
    return false
  end
  local taskinfo = self._storyTaskCfg[taskId]
  local groups = taskinfo.StoryTaskGroupTb
  for i = 1, #groups do
    if not self:CheckTaskGroupFinish(taskId, groups[i]) then
      return false
    end
  end
  return true
end

function UIHomelandStoryTaskController:RefreshSelectBtnsOnSelect(taskId)
  self:SetActiveTask(taskId)
  self:RefreshUnLockInfo()
  self:ShowInfo()
  self:RefreshTaskGroups()
  self:RefreshSelectBtns()
end

function UIHomelandStoryTaskController:RefreshSelectGroupOnSelect(groupId)
  self._selectTaskGroupId = groupId
  self:RefreshTaskGroups()
end

function UIHomelandStoryTaskController:SetLocalDataNew()
  self._localData:SetNewStoryTask()
  self._localData.SetPrefsStoryTaskGroupNew(0)
end

function UIHomelandStoryTaskController:_PrintStoryTask()
  Log.debug("PrintStoryTask() homelandStoryTask: ")
  Log.debug("PrintStoryTask() cfg_id = ", self._storyTaskInfos.cfg_id)
  Log.debug("PrintStoryTask() id_list = ")
  for i, v in pairs(self._storyTaskInfos.id_list) do
    Log.debug("PrintStoryTask() id_list[", i, "] = ", v)
  end
end
