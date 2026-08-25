local PopupTaskAppointRstTipsComp = System.NewClass("PopupTaskAppointRstTipsComp", PopupBaseComp)

function PopupTaskAppointRstTipsComp:ctor()
end

function PopupTaskAppointRstTipsComp:OnBind(binder)
  self.binder = binder
end

function PopupTaskAppointRstTipsComp:Clear()
end

function PopupTaskAppointRstTipsComp:CheckPopup()
  if UIManager.Instance:GetWindow(Urls.ShowRewardPanel) then
    return
  end
  local rewards = TaskModel.Instance:GetPopTipRewards()
  if not rewards then
    return
  end
  if not self:_IsAllTaskDone(rewards) then
    return
  end
  if TaskModel.Instance:IsNeedCalcReward() then
    local svrData = self:_BuildRewardData(rewards)
    TaskDataUtils.ShowTaskCompleteReward(svrData)
    TaskModel.Instance:SetNeedCalcReward(false)
    return
  end
  TaskController.Instance:OpenTaskAppointRstTipsView()
end

function PopupTaskAppointRstTipsComp:_IsAllTaskDone(rewards)
  for tid, rstData in pairs(rewards) do
    local taskData = TaskDataUtils.GetTaskData(rstData.taskData.uid)
    if taskData and taskData.state ~= CommonDefine.TaskState.Done and taskData.state ~= CommonDefine.TaskState.UnDone then
      return false
    end
  end
  return true
end

function PopupTaskAppointRstTipsComp:_BuildRewardData(rewards)
  local syncData = {}
  local taskUids = {}
  local extra = {}
  for tid, rstData in pairs(rewards) do
    table.insert(taskUids, rstData.taskData.uid)
    local awardList = rstData.awardList
    if not awardList then
      do
        local taskCfg = TaskDataUtils.GetConfig(rstData.taskTid)
        if taskCfg then
          awardList = TaskDataUtils.GetDispatchAwardList(taskCfg)
        end
      end
    end
    for _, awardData in ipairs(awardList or {}) do
      if awardData.extraDescFunc then
        extra[awardData.tid] = awardData.changedNum
      else
        table.insert(syncData, {
          changedNum = awardData.changedNum,
          uid = awardData.tid,
          tid = awardData.tid,
          reason = cd.ItemReason.AppointTask
        })
      end
    end
  end
  return {
    itemPrize = {syncData = syncData, extra = extra},
    taskUids = taskUids
  }
end

return PopupTaskAppointRstTipsComp
