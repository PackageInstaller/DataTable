local TaskState = CommonDefine.TaskState
local Vector2 = CS.UnityEngine.Vector2
local ActivityPVPReRoundAchieve, Super = System.NewClass("ActivityPVPReRoundAchieve", UIBasePanel)
ActivityPVPReRoundAchieve.uiResCls = UI_Events_Panel_PVPReRound_AchieveResource

function ActivityPVPReRoundAchieve:ctor(activityData, parentTaskList)
  Super.ctor(self)
  self.taskListMap = {}
  self.activityData = activityData
  self.activityTid = self.activityData.activityTid
  self.parentTaskList = self:SplitParentTaskList(parentTaskList)
  self.allTaskList = {}
  self.subList = {}
  self.selectedTaskId = Vue.ref(self.parentTaskList[1])
end

function ActivityPVPReRoundAchieve:OnBind(binder)
  self.binder = binder
  self:BindTaskList()
  self:SetLeftTime()
  self:BindTabView()
  self:BindAchievementView()
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:SetText(self.ui.Text_Title, LT.Text("StageRewardsTitle"))
  self:BindOneKeyGet(self.binder)
end

function ActivityPVPReRoundAchieve:BindOneKeyGet(binder)
  binder:SetActive(self.ui.Button_OneKeyGet, true)
  binder:BindZ1Button(self.ui.Button_OneKeyGet, function()
    local canReceiveTaskList = self:GetCanReceiveTaskList()
    if #canReceiveTaskList > 0 then
      ActivityDataUtils.ReqGainAwardList(self.activityTid, canReceiveTaskList)
    else
      Alert.ShowStr(LT.Text("ReRoundNoReward"))
    end
  end, function()
    if self:IsCanOneKeyGet() then
      return CommonDefine.Z1ButtonState.High
    else
      return CommonDefine.Z1ButtonState.Unclickable
    end
  end, function()
    do return LT.Text end
    return LT.Text, "DispatchReceiveAll"
  end)
end

function ActivityPVPReRoundAchieve:GetParentTaskMap()
  local parentTaskMap = {}
  for _, taskId in ipairs(self.parentTaskList) do
    parentTaskMap[taskId] = true
  end
  return parentTaskMap
end

function ActivityPVPReRoundAchieve:GetCanReceiveTaskList()
  local canReceiveTaskList = {}
  local parentTaskId = self.selectedTaskId.value
  if not parentTaskId then
    return canReceiveTaskList
  end
  local parentTaskMap = self:GetParentTaskMap()
  for taskId, taskData in pairs(self.allTaskList) do
    if taskData.state == CommonDefine.TaskState.Receive then
      local taskCfg = DT.Task[taskId] or {}
      local belongTask = taskCfg.BelongTaskGroup
      if belongTask and parentTaskMap[belongTask] then
        table.insert(canReceiveTaskList, taskId)
      end
    end
  end
  return canReceiveTaskList
end

function ActivityPVPReRoundAchieve:IsCanOneKeyGet()
  local parentTaskMap = self:GetParentTaskMap()
  for taskId, taskData in pairs(self.allTaskList) do
    if taskData.state == CommonDefine.TaskState.Receive then
      local taskCfg = DT.Task[taskId] or {}
      local belongTask = taskCfg.BelongTaskGroup
      if not belongTask or not parentTaskMap[belongTask] then
      else
        local isStageFirstClear = true
        if taskCfg.UnlockCondType == CommonDefine.TaskUnlockCondType.StageFirstClear then
          local stageId = taskCfg.UnlockCondPara[1]
          if not MainCopyDataUtils.IsStageDataFirstFinish(stageId) then
            isStageFirstClear = false
          end
        end
        if isStageFirstClear then
          return true
        end
      end
    end
  end
end

function ActivityPVPReRoundAchieve:BindTaskList()
  self.binder:BindToRaw(function()
    self:TriggerRefresh()
  end, function()
    do return ActivityDataUtils.GetActivityData end
    return ActivityDataUtils.GetActivityData, self.activityTid
  end)
end

function ActivityPVPReRoundAchieve:SetLeftTime()
  if self.activityData then
    local activityComp = self.binder:BindComponent(ActivityBaseComp(self.ui, self.activityData))
    activityComp:_BindActivityTimer()
  end
end

function ActivityPVPReRoundAchieve:SplitParentTaskList(parentTaskList)
  if type(parentTaskList) == "string" then
    local list = string.split(parentTaskList, ",")
    for index, str in ipairs(list) do
      local parentTaskId = tonumber(str)
      list[index] = parentTaskId
      self.taskListMap[parentTaskId] = {}
    end
    return list
  end
  return parentTaskList
end

function ActivityPVPReRoundAchieve:SplitTaskList2ParentIndex()
  self.taskListMap = {}
  for taskId, taskData in pairs(self.allTaskList) do
    local taskCfg = DT.Task[taskId]
    local belongTask = taskCfg.BelongTaskGroup
    assert(belongTask, string.format("任务:%s - %s 没有配置父任务", taskId, taskCfg.CnID))
    if belongTask then
      self.taskListMap[belongTask] = self.taskListMap[belongTask] or {}
      table.insert(self.taskListMap[belongTask], taskData)
    end
  end
  self:_DealTaskMap()
end

function ActivityPVPReRoundAchieve:_DealTaskMap()
  for parentTask, taskList in pairs(self.taskListMap) do
    self:RemoveJumpToTask(taskList)
  end
end

function ActivityPVPReRoundAchieve:RemoveJumpToTask(taskList)
  for i = #taskList, 1, -1 do
    local taskData = taskList[i]
    local taskCfg = DT.Task[taskData.tid]
    if taskCfg.AchieveDisplayCondition ~= "TRUE" then
      table.remove(taskList, i)
    end
  end
  for i, taskData in ipairs(taskList) do
    local nextTaskData = self:GetNextShowTask(taskData.tid)
    if nextTaskData then
      taskList[i] = nextTaskData
    end
  end
  table.sort(taskList, function(a, b)
    if a.state ~= b.state then
      if a.state == TaskState.Done or b.state == TaskState.Done then
        return b.state == TaskState.Done
      end
      if a.state == TaskState.Receive or b.state == TaskState.Receive then
        return a.state == TaskState.Receive
      end
      return a.state > b.state
    end
    if a.finishTime ~= b.finishTime then
      return a.finishTime < b.finishTime
    end
    local cfgA = DT.Task[a.tid]
    local cfgB = DT.Task[b.tid]
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
end

function ActivityPVPReRoundAchieve:GetNextShowTask(taskId)
  local curTaskData = self.allTaskList[taskId]
  if curTaskData.state ~= TaskState.Done then
    return
  end
  for _, taskData in pairs(self.allTaskList) do
    local taskCfg = DT.Task[taskData.tid]
    if taskCfg.AchieveDisplayCondition == taskId then
      if taskData.state == TaskState.Done then
        local nextTaskData = self:GetNextShowTask(taskData.tid)
        if nextTaskData then
          return nextTaskData
        end
        return taskData
      else
        return taskData
      end
    end
  end
  return nil
end

function ActivityPVPReRoundAchieve:BindTabView()
  self.binder:BindToCircularListView(self.ui.ScrollView_TabCon, function()
    return self.parentTaskList
  end, function(cBinder, gameObj, index)
    local parentTaskId = self.parentTaskList[index]
    local ui = UI_Event_Reward_TabResource(gameObj)
    local taskCfg = DT.Task[parentTaskId]
    cBinder:SetText(ui.Text_Title, LT.Text(taskCfg.Desc))
    cBinder:BindToText(ui.Text_Progress, function()
      local completeCount, totalCount = self:GetParentTaskProgress(parentTaskId)
      do return string.format, "%s/%s", completeCount end
      return string.format, "%s/%s", completeCount, totalCount
    end)
    cBinder:BindZ1Button(ui.uiNode, function()
      self.selectedTaskId.value = parentTaskId
      cBinder:CircularScrollTo(self.ui.ScrollView_TaskCon, 1)
    end, nil, nil, System.bind(self.GetTaskRedPoint, self, parentTaskId))
    cBinder:BindToVisible(ui.Group_High, function()
      return self.selectedTaskId.value == parentTaskId
    end)
    cBinder:BindToRaw(function(ccBinder)
      ccBinder:BindComponent(NewRedCom(ui.Group_RedDot)):BindTaskList(self.taskListMap[parentTaskId])
    end, function()
      do return ActivityDataUtils.GetActivityData end
      return ActivityDataUtils.GetActivityData, self.activityTid
    end)
    cBinder:BindToTextColor(ui.Text_Title, function()
      if self.selectedTaskId.value == parentTaskId then
        return CommonDefine.ColorType.Light
      end
      return CommonDefine.ColorType.Dark
    end)
    cBinder:BindToTextColor(ui.Text_Progress, function()
      if self.selectedTaskId.value == parentTaskId then
        return CommonDefine.ColorType.Light
      end
      return CommonDefine.ColorType.Dark
    end)
  end)
end

function ActivityPVPReRoundAchieve:GetTaskRedPoint(taskId)
  local taskList = self.taskListMap[taskId] or {}
  for _, taskData in ipairs(taskList or {}) do
    if taskData.state == TaskState.Receive then
      return true
    end
  end
end

function ActivityPVPReRoundAchieve:GetParentTaskProgress(parentTaskId)
  local completeCount, totalCount = 0, 0
  local taskList = self.taskListMap[parentTaskId] or {}
  totalCount = #taskList
  for _, taskData in ipairs(taskList) do
    local state = taskData.state
    if state == TaskState.Done then
      completeCount = completeCount + 1
    end
  end
  return completeCount, totalCount
end

function ActivityPVPReRoundAchieve:SetTabItem(tabUI, tabData)
end

function ActivityPVPReRoundAchieve:BindAchievementView()
  self.binder:BindToCircularListView(self.ui.ScrollView_TaskCon, function()
    return self.taskListMap[self.selectedTaskId.value] or {}
  end, function(childBinder, GameObject, index)
    local taskList = self.taskListMap[self.selectedTaskId.value] or {}
    local taskData = taskList[index]
    local ui = UI_Event_Item_PVPReRound_AchieveResource(GameObject)
    local taskId = taskData.tid
    local taskCfg = DT.Task[taskId]
    childBinder:BindToVisible(ui.Btn_Receive, function()
      return taskData.state == TaskState.Receive
    end)
    childBinder:BindZ1Button(ui.Btn_Receive, function()
      self:ReqTaskReward(taskData)
    end)
    childBinder:BindToVisible(ui.Group_Got, function()
      return taskData.state == TaskState.Done
    end)
    childBinder:BindToVisible(ui.Group_NotReceive, function()
      return taskData.state < TaskState.Receive
    end)
    self:BindAchievementDesc(childBinder, ui.Text_Desc, taskData, taskCfg)
    if not taskCfg.CompleteAward or 0 == #taskCfg.CompleteAward then
      return
    end
    local rewardList = {}
    for i = 1, #taskCfg.CompleteAward, 2 do
      table.insert(rewardList, {
        itemTid = taskCfg.CompleteAward[i],
        itemCount = taskCfg.CompleteAward[i + 1]
      })
    end
    if #rewardList > 0 then
      childBinder:BindComponent(CommonIconItemType2(ui.UI_Common_Item, rewardList[1]))
    end
    local targetTid = taskCfg.UnlockCondPara and taskCfg.UnlockCondPara[1]
    local icon = self:GetIcon(targetTid)
    local descTf = ui.Text_Desc.transform
    if icon then
      childBinder:SetActive(ui.Icon_Role, true)
      childBinder:SetActive(ui.Image_IconBg, true)
      childBinder:SetImage(ui.Icon_Role, icon)
      descTf.anchoredPosition = Vector2(-210, 0)
      descTf.sizeDelta = Vector2(509, 163)
    else
      childBinder:SetActive(ui.Icon_Role, false)
      childBinder:SetActive(ui.Image_IconBg, false)
      descTf.anchoredPosition = Vector2(-277, 0)
      descTf.sizeDelta = Vector2(664, 163)
    end
  end)
end

function ActivityPVPReRoundAchieve:GetIcon(tid)
  local awakerCfg = DT.AwakerConfig[tid]
  if awakerCfg then
    return awakerCfg.Item_LittleIcon
  end
  local itemCfg = DT.Item[tid]
  if itemCfg then
    return itemCfg.Icon
  end
  return nil
end

function ActivityPVPReRoundAchieve:BindAchievementDesc(binder, uiTextDesc, taskData, taskCfg)
  binder:BindToRaw(function(childBinder, count)
    local stageId = taskCfg.CompleteCondPara[1] or 0
    local stageCfg = DT.Stage[stageId]
    if not stageCfg then
      local maxCount = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      local desc = string.format("%s(%s/%s)", LT.Text(taskCfg.Desc), count, maxCount)
      childBinder:SetText(uiTextDesc, desc)
      return
    end
    local stageData = MainCopyDataUtils.GetStageData(stageId)
    if not stageData then
      local stageName = "@1@2"
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      local desc = string.format("%s(%s/%s)", taskDesc, count, maxCount)
      childBinder:SetText(uiTextDesc, desc)
      return
    end
    local openTime = stageData.openTime or 0
    local timeToStageOpen = openTime - TimeUtils.GetServerTime()
    Logger.Debug("[ac] desc =%s", taskCfg.Desc)
    if timeToStageOpen > 0 then
      local stageName = "@1@2"
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      
      local function setDesc(countdown)
        if self.ui then
          local d, h = TimeUtils.SecToDayHour(countdown)
          local timeDesc = LT.Textf("SubplotActivityRewardTimeTips", d, h)
          local desc = string.format("%s(%s/%s) %s", taskDesc, count, maxCount, timeDesc)
          childBinder:SetText(uiTextDesc, desc)
        end
      end
      
      setDesc(timeToStageOpen)
      childBinder:BindTimer(0.033, -1, function()
        timeToStageOpen = math.max(timeToStageOpen - 0.033, 0)
        setDesc(timeToStageOpen)
      end)
    else
      local stageName = LT.Text(stageCfg.Name)
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      local desc = string.format("%s(%s/%s)", taskDesc, count, maxCount)
      childBinder:SetText(uiTextDesc, desc)
    end
  end, function()
    return taskData.count
  end)
end

function ActivityPVPReRoundAchieve:FindTaskData(tid)
  for _, taskList in pairs(self.taskListMap) do
    for i, v in ipairs(taskList) do
      if v.tid == tid then
        return v
      end
    end
  end
  return nil
end

function ActivityPVPReRoundAchieve:FixTaskData()
  for _, taskData in pairs(self.activityData.taskList) do
    local tempData = self:FindTaskData(taskData.tid)
    if tempData then
      tempData.count = taskData.count
      tempData.state = taskData.state
    end
  end
end

function ActivityPVPReRoundAchieve:ReqTaskReward(taskData)
  if not taskData then
    return
  end
  local taskListActivityData = self.activityData
  local taskListActivityBaseData = taskListActivityData and taskListActivityData.base or {}
  if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if taskData.state ~= CommonDefine.TaskCommonState.CanFinish then
    return
  end
  if self._reqServerIng then
    return
  end
  self._reqServerIng = true
  
  local function ToReqGainAward(extraParams, onRequestCallback)
    extraParams = extraParams or {}
    ActivityDataUtils.ReqGainAward(self.activityTid, taskData.tid, extraParams, function(result)
      if result then
        taskListActivityData.taskList[taskData.tid].state = CommonDefine.TaskCommonState.Finish
        FrameWaiter.OnNextFrame(function()
          self:FixTaskData()
          if onRequestCallback then
            onRequestCallback()
          end
          self:TriggerRefresh()
          self._reqServerIng = false
        end, 2)
      end
    end, true)
  end
  
  local taskConfig = DT.Task[taskData.tid]
  
  local function GainPrize()
    if taskConfig and taskConfig.CompleteAward then
      ToReqGainAward()
    end
  end
  
  if GetEnergyCheckUtils.TaskConfigCheckEnergyOver(taskConfig) then
    GetEnergyCheckUtils.TipsShow(GainPrize)
  else
    GainPrize()
  end
end

function ActivityPVPReRoundAchieve:TriggerRefresh()
  local activityData = ActivityDataUtils.GetActivityData(self.activityTid)
  self.allTaskList = activityData and activityData.taskList or {}
  self:SplitTaskList2ParentIndex()
  local parentTaskId = self.selectedTaskId.value
  self.selectedTaskId.value = 0
  self.selectedTaskId.value = parentTaskId
end

function ActivityPVPReRoundAchieve:SetAchievementItem(achieveUI, achieveData)
end

return ActivityPVPReRoundAchieve
