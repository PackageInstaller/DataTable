local TaskModel = NewClass("TaskModel", BaseModel)
local TaskPage = CommonDefine.TaskPage
local TaskServerIndex = CommonDefine.TaskServerIndex
local PageToServerIndex = {
  [TaskPage.Career] = TaskServerIndex.Career,
  [TaskPage.PlayerLevel] = TaskServerIndex.PlayerLevel,
  [TaskPage.School] = TaskServerIndex.School,
  [TaskPage.Achievement] = TaskServerIndex.Achivement
}
local PageToFeature = {
  [TaskPage.Tutorial] = {
    cd.FeatureId.Tutorial
  },
  [TaskPage.AwakerTrial] = {
    cd.FeatureId.ResidentTrial
  },
  [TaskPage.BattleTeaching] = {
    cd.FeatureId.BattleTeaching
  }
}
local PageResources = {}

function TaskModel:OnInit()
  self.curTaskViewPaged = TaskPage.Career
  self.serverIndex = TaskServerIndex.Career
  self.taskPopTipRewards = nil
  self.needCalcReward = true
end

function TaskModel:OnReset()
  self.curTaskViewPaged = TaskPage.Career
  self.needCalcReward = true
  self.taskPopTipRewards = nil
end

function TaskModel:GetPageServerIndex(page)
  return PageToServerIndex[page]
end

function TaskModel:GetServerIndexPage(svrIdx)
  for page, idx in pairs(PageToServerIndex) do
    if idx == svrIdx then
      return page
    end
  end
  return nil
end

function TaskModel:SetCurTaskPage(page)
  if not self:IsPageUnlocked(page) then
    page = self:GetUnlockedTaskPage()
  end
  if self.curTaskViewPaged ~= page then
    self.curTaskViewPaged = page
    self:LocalNotify(NotifyId.OnTaskMainViewPageChanged, page)
  end
end

function TaskModel:GetCurTaskPage()
  return self.curTaskViewPaged
end

function TaskModel:IsPageUnlocked(page)
  local serverIdx = self:GetPageServerIndex(page)
  local _, unlocked
  local feature = PageToFeature[page] or {
    CommonDefine.FeatureId.Task,
    serverIdx
  }
  if serverIdx then
    _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Task, serverIdx)
  elseif feature then
    _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature[1], feature[2])
  end
  return unlocked or false
end

function TaskModel:GetUnlockedTaskPage()
  local pageList = {
    TaskPage.Career,
    TaskPage.PlayerLevel,
    TaskPage.School,
    TaskPage.Achievement,
    TaskPage.Tutorial,
    TaskPage.AwakerTrial
  }
  for _, page in ipairs(pageList) do
    if self:IsPageUnlocked(page) then
      return page
    end
  end
  return TaskPage.Career
end

function TaskModel:SetCurServerIndex(serverIndex)
  self.serverIndex = serverIndex
  if TaskParentChildModel.Instance:IsParentChildTask(serverIndex) then
    TaskParentChildModel.Instance:SetTaskServerIndex(serverIndex)
  end
end

function TaskModel:GetCurServerIndex()
  return self.serverIndex
end

function TaskModel:IsHaveReward(serverIndex)
  local taskList = TaskDataUtils.GetTaskDataListBySvrIdx(serverIndex)
  for _, taskData in pairs(taskList) do
    if taskData.state == cd.TaskState.Receive then
      return true
    end
  end
end

function TaskModel:SetPopTipRewards(data)
  self.taskPopTipRewards = data
end

function TaskModel:GetPopTipRewards()
  return self.taskPopTipRewards
end

function TaskModel:SetNeedCalcReward(value)
  self.needCalcReward = value
end

function TaskModel:IsNeedCalcReward()
  return self.needCalcReward
end

function TaskModel:SortTaskList(taskItemList)
  if not taskItemList or 0 == #taskItemList then
    return taskItemList
  end
  local tempChildList = taskItemList
  local sortWeight = {
    [CommonDefine.TaskState.Receive] = 1,
    [CommonDefine.TaskState.Doing] = 2,
    [CommonDefine.TaskState.Done] = 3,
    [CommonDefine.TaskState.UnDone] = 4
  }
  table.sort(tempChildList, function(a, b)
    local aCfg = DT.Task[a.tid]
    local bCfg = DT.Task[b.tid]
    if a.isHide then
      return false
    elseif b.isHide then
      return true
    end
    if a.state == b.state then
      return aCfg.BaseSortID < bCfg.BaseSortID
    else
      return sortWeight[a.state] < sortWeight[b.state]
    end
  end)
  return tempChildList
end

function TaskModel:GetTaskPageResUrl(page)
  if PageResources[page] then
    return PageResources[page]
  end
  local uiRes
  if page == TaskPage.Career then
    uiRes = UI_Task_Popup_CareerResource()
  elseif page == TaskPage.PlayerLevel then
    uiRes = UI_Task_Popup_ChallengeResource()
  elseif page == TaskPage.School then
    uiRes = UI_Task_Popup_CareerResource()
  elseif page == TaskPage.Achievement then
    uiRes = UI_Task_Popup_Challenge2Resource()
  end
  if uiRes then
    PageResources[page] = uiRes.assetPath
  end
  return PageResources[page]
end

function TaskModel:GetNotReceiveTaskRewardInfoList(parentTaskTidList, targetTaskType)
  local rst = {}
  for _, parentTaskTid in pairs(parentTaskTidList) do
    local childTaskTidList = TaskCfgUtils.GetTaskTidListByTaskType(targetTaskType)
    for _, childTaskTid in pairs(childTaskTidList) do
      local belongGroup = TaskCfgUtils.GetCfgField("BelongTaskGroup", childTaskTid)
      if belongGroup ~= parentTaskTid then
      else
        local taskData = TaskDataUtils.GetTaskData(childTaskTid)
        if taskData.state == CommonDefine.TaskState.Done then
        else
          local completeAwardInfoList = TaskCfgUtils.GetTaskCompleteAwardInfoList(childTaskTid)
          table.aconcat(rst, completeAwardInfoList)
        end
      end
    end
  end
  return rst
end

return TaskModel
