local TaskState = CommonDefine.TaskState
local ActivityAchievementPanel, Super = System.NewClass("ActivityAchievementPanel", UIBasePanel)
ActivityAchievementPanel.uiResCls = UI_Events_Panel_RewardResource

function ActivityAchievementPanel:ctor(activityData, parentTaskList, allTaskMap, extraParams)
  Super.ctor(self)
  self.taskListMap = {}
  self.activityData = activityData
  self.activityTid = activityData and activityData.activityTid
  self.parentTaskMap = self:SplitParentTaskList(parentTaskList)
  self.allTaskList = allTaskMap
  Logger.Debug("[ac] taskList=%s", table.tostring(self.allTaskList))
  self.subList = {}
  self.extraParams = extraParams or {}
  self.selectedTaskId = Vue.ref(self.extraParams.selectedTaskId or self.parentTaskMap[1])
  if not self.activityData then
    self.uiResCls = "UI/UI_Events/UI_Events_Prefab/UI_Events_Panel_3Star_Reward.prefab"
  end
end

function ActivityAchievementPanel:OnBind(binder)
  self.binder = binder
  self:SetLeftTime()
  self:SplitTaskList2ParentIndex()
  self:BindTabView()
  self:BindAchievementView()
  self:BindOneKeyVisible()
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_OneKey, System.fn(self, self.OnBtnOneKey))
  binder:SetText(self.ui.Text_Title, self.extraParams.title or LT.Text("StageRewardsTitle"))
end

function ActivityAchievementPanel:BindOneKeyVisible()
  self.binder:SetActive(self.ui.Btn_OneKey, true)
  self.binder:BindToVisible(self.ui.Btn_OneKey, function()
    do return self.IsHaveRewards end
    return self.IsHaveRewards, self
  end)
end

function ActivityAchievementPanel:SetLeftTime()
  if self.activityData then
    local activityComp = self.binder:BindComponent(ActivityBaseComp(self.ui, self.activityData))
    activityComp:_BindActivityTimer()
  end
end

function ActivityAchievementPanel:SplitParentTaskList(parentTaskList)
  if type(parentTaskList) == "string" then
    local list = string.split(parentTaskList, ",")
    for index, str in ipairs(list) do
      local parentTaskId = tonumber(str)
      list[index] = parentTaskId
      self.taskListMap[parentTaskId] = {}
    end
    return list
  else
    for _, parentTaskId in ipairs(parentTaskList) do
      self.taskListMap[parentTaskId] = {}
    end
  end
  return parentTaskList
end

function ActivityAchievementPanel:SplitTaskList2ParentIndex()
  for taskId, taskData in pairs(self.allTaskList) do
    local taskCfg = DT.Task[taskId]
    local belongTask = taskCfg.BelongTaskGroup
    if belongTask then
      self.taskListMap[belongTask] = self.taskListMap[belongTask] or {}
      table.insert(self.taskListMap[belongTask], taskData)
    end
  end
  self:SortTaskList()
end

function ActivityAchievementPanel:SortTaskList()
  for _, taskList in pairs(self.taskListMap) do
    table.sort(taskList, function(a, b)
      if a.state ~= b.state then
        if a.state == TaskState.Done or b.state == TaskState.Done then
          return b.state == TaskState.Done
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
end

function ActivityAchievementPanel:IsHaveRewards()
  return #self:GetRewardTaskList() > 0
end

function ActivityAchievementPanel:GetRewardTaskList()
  local taskList = {}
  for _, taskData in pairs(self.allTaskList) do
    if taskData.state == TaskState.Receive then
      local taskCfg = DT.Task[taskData.tid]
      if taskCfg and taskCfg.CompleteAward then
        table.insert(taskList, taskData.tid)
      end
    end
  end
  return taskList
end

function ActivityAchievementPanel:OnBtnOneKey()
  local taskList = self:GetRewardTaskList()
  if 0 == #taskList then
    return
  end
  if self.activityTid then
    ActivityDataUtils.ReqGainAwardList(self.activityTid, taskList)
  else
    local taskTypeAndListMap = self:GetTaskTypeAndTaskList(taskList)
    local commonTaskServerIndex = DT.GetConstant("TaskType_Common")
    for taskType, subTaskList in pairs(taskTypeAndListMap) do
      local taskTypeServerIndex = DT.GetConstant(taskType)
      if not taskTypeServerIndex then
        Logger.Error("OnBtnOneKey taskTypeServerIndex is nil", taskType, table.tostring(subTaskList))
      end
      TaskController.Instance:ReqOnBatchGainPrize(taskTypeServerIndex or commonTaskServerIndex, subTaskList)
    end
  end
end

function ActivityAchievementPanel:GetTaskTypeAndTaskList(taskList)
  local taskTypeAndListMap = {}
  for _, taskId in ipairs(taskList) do
    local taskCfg = DT.Task[taskId]
    local taskType = taskCfg.TaskType
    if not taskTypeAndListMap[taskType] then
      taskTypeAndListMap[taskType] = {}
    end
    table.insert(taskTypeAndListMap[taskType], taskId)
  end
  return taskTypeAndListMap
end

function ActivityAchievementPanel:BindTabView()
  self.binder:BindToCircularListView(self.ui.ScrollView_TabCon, function()
    return self.parentTaskMap
  end, function(cBinder, gameObj, index)
    local parentTaskId = self.parentTaskMap[index]
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
    cBinder:BindComponent(NewRedCom(ui.Group_RedDot)):BindTaskList(self.taskListMap[parentTaskId])
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

function ActivityAchievementPanel:GetTaskRedPoint(taskId)
  local taskList = self.taskListMap[taskId] or {}
  for _, taskData in ipairs(taskList or {}) do
    if taskData.state == TaskState.Receive then
      return true
    end
  end
end

function ActivityAchievementPanel:GetParentTaskProgress(parentTaskId)
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

function ActivityAchievementPanel:SetTabItem(tabUI, tabData)
end

function ActivityAchievementPanel:BindAchievementView()
  local AwardSizeDelta = self.ui.ScrollView_Award.transform.sizeDelta
  self.binder:BindToCircularListView(self.ui.ScrollView_TaskCon, function()
    return self.taskListMap[self.selectedTaskId.value] or {}
  end, function(childBinder, GameObject, index)
    local taskList = self.taskListMap[self.selectedTaskId.value] or {}
    local taskData = taskList[index]
    local ui = UI_Event_Reward_ItemResource(GameObject)
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
    local itemCount = #rewardList
    local itemWidth = 122 * itemCount
    local sizeDelta = ui.ScrollView_Award.transform.sizeDelta
    if itemWidth < AwardSizeDelta.x then
      sizeDelta.x = itemWidth
    else
      sizeDelta.x = AwardSizeDelta.x
    end
    ui.ScrollView_Award.transform.sizeDelta = sizeDelta
    childBinder:BindToCircularListView(ui.ScrollView_Award, function()
      return rewardList
    end, function(ccBinder, gameObject, awardIndex)
      local itemData = rewardList[awardIndex]
      ccBinder:BindComponent(CommonIconItemType2(gameObject, itemData))
    end)
  end)
end

function ActivityAchievementPanel:BindAchievementDesc(binder, uiTextDesc, taskData, taskCfg)
  binder:BindToRaw(function(childBinder, count)
    local stageId = taskCfg.CompleteCondPara[1] or 0
    local stageCfg = DT.Stage[stageId]
    if not stageCfg then
      local maxCount = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      local desc = string.format("%s<color=#A3A6AB>(%s/%s)</color>", LT.Text(taskCfg.Desc), count, maxCount)
      childBinder:SetText(uiTextDesc, desc)
      return
    end
    local stageData = MainCopyDataUtils.GetStageData(stageId)
    if not stageData then
      local stageName = "@1@2"
      local taskDesc = LT.Textf(taskCfg.Desc, stageName)
      local maxCount = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      local desc = string.format("%s<color=#A3A6AB>(%s/%s)</color>", taskDesc, count, maxCount)
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
          local desc = string.format("%s<color=#A3A6AB>(%s/%s)</color> %s", taskDesc, count, maxCount, timeDesc)
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
      local desc = string.format("%s<color=#A3A6AB>(%s/%s)</color>", taskDesc, count, maxCount)
      childBinder:SetText(uiTextDesc, desc)
    end
  end, function()
    return taskData.count
  end)
end

function ActivityAchievementPanel:FindTaskData(tid)
  for _, taskList in pairs(self.taskListMap) do
    for i, v in ipairs(taskList) do
      if v.tid == tid then
        return v
      end
    end
  end
  return nil
end

function ActivityAchievementPanel:FixTaskData()
  if not self.activityData then
    return
  end
  for _, taskData in pairs(self.activityData.taskList) do
    local tempData = self:FindTaskData(taskData.tid)
    if tempData then
      tempData.count = taskData.count
      tempData.state = taskData.state
    end
  end
end

function ActivityAchievementPanel:ReqTaskReward(taskData)
  if not taskData then
    print("-------------------ReqTaskReward taskData is nil")
    return
  end
  local taskListActivityData = self.activityData
  if taskListActivityData then
    local taskListActivityBaseData = taskListActivityData.base or {}
    if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
      print("-------------------ReqTaskReward taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running")
      return
    end
  end
  if taskData.state ~= CommonDefine.TaskCommonState.CanFinish then
    print("-------------------ReqTaskReward taskData.state ~= CommonDefine.TaskCommonState.CanFinish")
    return
  end
  if self._reqServerIng then
    print("-------------------ReqTaskReward self._reqServerIng")
    return
  end
  self._reqServerIng = true
  
  local function ToReqGainAward(extraParams)
    if not self.activityTid then
      TaskDataUtils.TaskComplete(taskData.tid, function()
        self:OnTaskCompleteCallback(taskData)
      end)
      print("-------------------ReqTaskReward TaskDataUtils.TaskComplete", taskData.tid)
      return
    end
    extraParams = extraParams or {}
    ActivityDataUtils.ReqGainAward(self.activityTid, taskData.tid, extraParams, function(result)
      if result then
        taskListActivityData.taskList[taskData.tid].state = CommonDefine.TaskCommonState.Finish
        self:OnTaskCompleteCallback(taskData)
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

function ActivityAchievementPanel:OnTaskCompleteCallback(taskData)
  FrameWaiter.OnNextFrame(function()
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    self:FixTaskData()
    self:SortTaskList()
    self._reqServerIng = false
  end, 2)
end

function ActivityAchievementPanel:SetAchievementItem(achieveUI, achieveData)
end

return ActivityAchievementPanel
