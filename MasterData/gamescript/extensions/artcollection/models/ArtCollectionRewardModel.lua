local ArtCollectionRewardModel = NewClass("ArtCollectionRewardModel", BaseModel)

local function cfg(index)
  return DT.Task[index]
end

local TaskState = CommonDefine.TaskState

function ArtCollectionRewardModel:OnInit()
  self:OnReset()
end

function ArtCollectionRewardModel:OnReset()
  self.taskDatas = nil
  self:GetTaskCfg()
end

function ArtCollectionRewardModel:GetTaskCfg()
  if self.taskCfgIds then
    return self.taskCfgIds
  end
  self.taskCfgIds = {}
  for taskId, taskCfg in pairs(DT.Task) do
    local rewardType = taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[2]
    if taskCfg.CompleteCond == ArtCollectionDefine.CompleteCond and rewardType and table.contains(ArtCollectionDefine.RewardType, rewardType) then
      if not self.taskCfgIds[rewardType] then
        self.taskCfgIds[rewardType] = {}
      end
      table.insert(self.taskCfgIds[rewardType], taskId)
    end
  end
  return self.taskCfgIds
end

function ArtCollectionRewardModel:UpdateTaskData()
  local allAchievementTask = TaskDataUtils.GetTaskDataListBySvrIdx(ArtCollectionDefine.TaskServerIndex)
  if not self.taskDatas then
    self.taskDatas = {}
  end
  for _, taskData in pairs(allAchievementTask) do
    local taskCfg = DT.Task[taskData.uid]
    local rewardType = taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[2]
    if taskCfg.CompleteCond == ArtCollectionDefine.CompleteCond and rewardType and table.contains(ArtCollectionDefine.RewardType, rewardType) then
      self.taskDatas[taskData.uid] = taskData
    end
  end
  self:Notify(NotifyId.CollectionRewardGet)
end

function ArtCollectionRewardModel:GetTaskData()
  if not self.taskDatas or self.taskDatas == {} then
    self:UpdateTaskData()
  end
  return self.taskDatas
end

function ArtCollectionRewardModel:GetTaskState(taskId)
  if self.taskDatas and self.taskDatas[taskId] then
    return self.taskDatas[taskId].state
  else
    return TaskState.UnDone
  end
end

function ArtCollectionRewardModel:SetTaskState(taskId, state)
  if self.taskDatas[taskId] then
    self.taskDatas[taskId].state = state
  end
end

function ArtCollectionRewardModel:GetProgressRewardDatas(rewardType)
  local ids = self.taskCfgIds[rewardType]
  if not rewardType or not ids then
    return
  end
  local progressRewardDatas = {}
  for i = 1, #ids do
    local rewCfg = cfg(ids[i])
    local star = rewCfg.CompleteCondPara[1] or 0
    local rewardArrCfg = rewCfg.CompleteAward
    local rewardArr = {}
    for idx = 1, #rewardArrCfg, 2 do
      local tid = rewardArrCfg[idx]
      local num = rewardArrCfg[idx + 1]
      if tid and num then
        table.insert(rewardArr, {tid = tid, num = num})
      end
    end
    local state = self:GetTaskState(ids[i])
    local isAttach = state == TaskState.Receive or state == TaskState.Done
    local isGet = state == TaskState.Done
    
    local function _ReqGetRewardFunc()
      TaskDataUtils.TaskComplete(ids[i], function()
        self:SetTaskState(ids[i], TaskState.Done)
        self:Notify(NotifyId.CollectionRewardGet)
      end)
    end
    
    local rewardData = {
      awardIndex = i,
      star = star,
      needStar = star,
      awardTitle = LT.Text("Collection_Reward_Desc"),
      rewards = rewardArr,
      hideStar = true,
      isAttach = isAttach,
      isGet = isGet,
      gainRewardFunc = _ReqGetRewardFunc
    }
    table.insert(progressRewardDatas, rewardData)
  end
  return progressRewardDatas
end

return ArtCollectionRewardModel
