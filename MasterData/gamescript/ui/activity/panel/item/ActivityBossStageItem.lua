local ActivityBossStageItem, Super = System.NewComponent("ActivityBossStageItem", ActivityStageGroupItem)

function ActivityBossStageItem:ctor(uiNode, uiResCfg, stageNum, groupTid, activityTid, stageGroupDefine, openStageGroupFunc, taskId)
  Super.ctor(self, uiNode, uiResCfg, stageNum, groupTid, activityTid, stageGroupDefine, openStageGroupFunc)
  self.groupTid = groupTid
  self.taskId = taskId
end

function ActivityBossStageItem:OnBind(binder)
  self.binder = binder
  Super.OnBind(self, binder)
  binder:BindToRaw(function(binder, _, _)
    self:SetIsKilled()
  end, function()
    do return self.GetProgress end
    return self.GetProgress, self
  end)
end

function ActivityBossStageItem:SetIsKilled()
  local curCount, totalCount = self:GetProgress()
  self.binder:SetText(self.ui.Text_CurProgress, curCount)
  self.binder:SetText(self.ui.Text_TotalProgress, "/" .. totalCount)
  local isKilled = self:IsFinished()
  local isInOpenTime = self:GetIsInOpenTime()
  self.binder:SetActive(self.ui.Group_Progress, not isKilled and isInOpenTime)
  if self.ui.Text_Promote then
    self.binder:SetActive(self.ui.Text_Promote, not isKilled and isInOpenTime)
  end
  self.binder:SetActive(self.ui.Image_Killed, isKilled)
  if isKilled then
    local timeRed = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.NewStageGroupUnlock, {
      self.stageGroupId
    })
    if timeRed then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.NewStageGroupUnlock, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
    end
  end
end

function ActivityBossStageItem:CheckIsCanClick()
  if self:IsFinished() then
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(self.groupTid)
    if stageGroupCfg and stageGroupCfg.Type == CommonDefine.StageGroupType.OceanBoss then
      Alert.ShowStr(LT.Text("DeepSeaInvasionDefensiveActiviityTips14"))
      return false
    end
    Alert.ShowStr(LT.Text("AlertBossKilled"))
    return false
  end
  return true
end

function ActivityBossStageItem:GetProgress()
  local curCount, totalCount = 0, 0
  if self.taskId then
    local taskCfg = TaskDataUtils.GetTaskConfigByTid(self.taskId)
    if taskCfg and taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1] then
      totalCount = taskCfg.CompleteCondPara[1]
    end
    local taskData = TaskDataUtils.GetTaskData(self.taskId)
    if taskData then
      curCount = taskData.count
    end
  end
  return totalCount - curCount, totalCount
end

function ActivityBossStageItem:IsFinished()
  do return TaskDataUtils.IsTaskDoneByTaskId end
  return TaskDataUtils.IsTaskDoneByTaskId, self.taskId
end

function ActivityBossStageItem:SetProgress()
end

function ActivityBossStageItem:GetIsInOpenTime()
  local isInOpenTime = true
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(self.groupTid)
  if stageGroupCfg and stageGroupCfg.StageDisplayDate then
    isInOpenTime = TimeUtils.GetServerTime() >= stageGroupCfg.StageDisplayDate
  end
  return isInOpenTime
end

return ActivityBossStageItem
