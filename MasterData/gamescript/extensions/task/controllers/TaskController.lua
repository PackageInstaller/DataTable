local TaskController = NewClass("TaskController", BaseController)
local TaskState = CommonDefine.TaskState

function TaskController:OnInit()
end

function TaskController:OnReset()
end

function TaskController:OpenTaskAppointRstTipsView()
  local viewData = TaskModel.Instance:GetPopTipRewards()
  if viewData then
    UIManager.Instance:Reopen(Urls.TaskAppointRstTipsView, viewData)
    TaskModel.Instance:SetPopTipRewards(nil)
  end
end

function TaskController:ReqOnTaskOpen(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TaskRequest", "OnTaskOpen", function(data)
    for taskServerIndex, taskData in pairs(data) do
      print("========== 请求任务数据成功 ==========", taskServerIndex, table.tostring(taskData))
    end
    TaskDataUtils.InitTaskData(data)
    RedPointDataUtils.UpdateFreeTrialRed()
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求任务数据失败 ==========\n", table.tostring(data))
  end)
end

function TaskController:ReqOnBatchGainPrize(modType, taskTidList, callback)
  print("========== TaskController.ReqOnBatchGainPrize ==========", modType, table.tostring(taskTidList))
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TaskRequest", "OnBatchGainPrize", function(data)
    Logger.Info("========== 请求批量领取任务奖励成功 ==========\n", table.tostring(data))
    if data.itemPrize and data.itemPrize.syncData then
      ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle_CHN"), "", data.itemPrize.syncData)
    end
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求批量领取任务奖励失败 ==========\n", table.tostring(data))
  end, modType, taskTidList)
end

function TaskController:ReqOnTaskAwakerDelegate(newTaskData, uid, awakerList)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TaskRequest", "OnTaskAwakerDelegate", function(data)
    if data.appointCount then
      TaskDataUtils.SetCompleteCount(data.appointCount)
    end
    if data.appointMaxCount then
      TaskDataUtils.SetMaxCompleteCount(data.appointMaxCount)
    end
    if data then
      newTaskData.state = TaskState.Doing
      newTaskData.awakerList = awakerList
      newTaskData.ts = TimeUtils.GetServerTime()
      TaskDataUtils.UpdateTask(newTaskData)
      TaskDataUtils.DispatchUpdateEvent(CommonDefine.TaskServerIndex.Appoint)
    end
    if not TaskDataUtils.EnableDispatch() then
      RedPointDataUtils.RemoveDailyDispatchRed()
    end
    UIManager.Instance:CloseByUrl(Urls.TaskAppointBuildTips)
  end, nil, uid, awakerList)
end

function TaskController:ReqOnTaskRecallAwaker(newTaskData, uid)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TaskRequest", "OnTaskRecallAwaker", function(data)
    if data then
      newTaskData.state = TaskState.UnDone
      newTaskData.awakerList = {}
      TaskDataUtils.UpdateTask(newTaskData)
      if data.appointCount then
        TaskDataUtils.SetCompleteCount(data.appointCount)
      end
      if data.appointMaxCount then
        TaskDataUtils.SetMaxCompleteCount(data.appointMaxCount)
      end
      TaskDataUtils.DispatchUpdateEvent(CommonDefine.TaskServerIndex.Appoint)
    end
  end, nil, uid)
end

function TaskController:ReqOnTaskGainPrize(uid, extraParams, callBack, banRewardTips)
  local pickItems = extraParams and extraParams.pickItems or {}
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TaskRequest", "OnTaskGainPrize", function(data)
    Logger.Info("========== 完成任务成功 ==========\n", table.tostring(data))
    local taskData = TaskDataUtils.GetTaskData(uid)
    taskData.state = cd.TaskState.Done
    if TaskDataUtils.GetTaskType(taskData.tid) == CommonDefine.TaskType.TaskType_Appoint_Dispatch then
      TaskDataUtils.SetIsSpecialAppoint(data.isSpecial and 1 or 0)
    end
    if data.appointCount then
      TaskDataUtils.SetCompleteCount(data.appointCount)
    end
    if data.appointMaxCount then
      TaskDataUtils.SetMaxCompleteCount(data.appointMaxCount)
    end
    TaskDataUtils.UpdateTask(taskData)
    if callBack then
      callBack(data)
    end
    if not banRewardTips then
      TaskDataUtils.ShowTaskCompleteReward(data, uid)
    end
  end, function(data)
    Logger.Info("========== 完成任务失败 ==========\n", table.tostring(data))
  end, uid, pickItems)
end

function TaskController:ReqOnTaskGainAllPrize(taskSvrIdx, callback)
  ProtoManager.Instance:ReqServer("TaskRequest", "OnTaskGainAllPrize", function(data)
    Logger.Info("========== 一键领取任务奖励成功 ==========\n", table.tostring(data or {}))
    TaskDataUtils.ShowTaskCompleteReward(data)
    self:_MarkTaskDone(data.taskUids)
    TaskDataUtils.DispatchUpdateEvent(taskSvrIdx)
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 一键领取任务奖励失败 ==========\n", table.tostring(data or {}))
  end, taskSvrIdx)
end

function TaskController:ReqOnTaskAwakerDelegateBatch(tbl, callback)
  local sendTbl = {}
  for taskUid, awakerList in pairs(tbl) do
    for idx, awakerTid in pairs(awakerList) do
      if 0 == awakerTid then
        awakerList[idx] = nil
      end
    end
    if awakerList and table.next(awakerList) then
      sendTbl[taskUid] = awakerList
    end
  end
  ProtoManager.Instance:ReqServer("TaskRequest", "OnTaskAwakerDelegateBatch", function(data)
    Logger.Info("========== 一键派遣任务成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
    RedPointDataUtils.RemoveDailyDispatchRed()
  end, function(data)
    Logger.Info("========== 一键派遣任务失败 ==========\n", table.tostring(data or {}))
  end, sendTbl)
end

function TaskController:_MarkTaskDone(taskUids)
  for _, uid in ipairs(taskUids) do
    local taskData = TaskDataUtils.GetTaskData(uid)
    if taskData then
      taskData.state = cd.TaskState.Done
      if taskData.awakerList then
        taskData.awakerList = {}
      end
    end
  end
end

return TaskController
