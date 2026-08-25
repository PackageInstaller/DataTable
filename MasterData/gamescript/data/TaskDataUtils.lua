local TaskData = DataCenter.taskData
local TaskState = CommonDefine.TaskState
local TaskDataUtils = {}

function TaskDataUtils.ResetAll()
  TaskData.taskTid2DataDict = {}
  TaskData.taskSvrIdx2TidsDict = {}
  TaskData.appointRefreshCount = 0
  TaskData.sendTeamNum = 0
  TaskData.maxTeamNum = 0
  TaskData.curShowTaskType = nil
  TaskData.completeDelegateNum = 0
  TaskData.maxCompleteDelegateNum = 0
  TaskData.isSpecialAppoint = 1
  TaskData.dailyTaskTid = nil
  TaskData.constKeyTaskMap = {}
end

function TaskDataUtils.GetTaskTid2DataDict()
  return TaskData.taskTid2DataDict or {}
end

function TaskDataUtils.GetTaskData(tid, withoutAdd)
  local data = TaskData.taskTid2DataDict[tid]
  if not data and not withoutAdd then
    data = TaskDataUtils._AddTask(tid)
  end
  return data
end

function TaskDataUtils.SetTaskData(tid, taskData)
  TaskData.taskTid2DataDict[tid] = taskData
end

function TaskDataUtils.ClearTaskTid2DataDict()
  TaskData.taskTid2DataDict = {}
end

function TaskDataUtils.GetTaskTidListBySvrIdx(svrIdx)
  return TaskData.taskSvrIdx2TidsDict[svrIdx] or {}
end

function TaskDataUtils.AddTaskSvrIdx2TidsDict(svrIdx, taskTid)
  if not TaskData.taskSvrIdx2TidsDict[svrIdx] then
    TaskData.taskSvrIdx2TidsDict[svrIdx] = {}
  end
  if table.contains(TaskData.taskSvrIdx2TidsDict[svrIdx], taskTid) then
    return
  end
  table.insert(TaskData.taskSvrIdx2TidsDict[svrIdx], taskTid)
end

function TaskDataUtils.DelTaskSvrIdx2TidsDict(svrIdx, taskTid)
  if not TaskData.taskSvrIdx2TidsDict[svrIdx] then
    return
  end
  for idx, seekTid in pairs(TaskData.taskSvrIdx2TidsDict[svrIdx]) do
    if seekTid == taskTid then
      table.remove(TaskData.taskSvrIdx2TidsDict[svrIdx], idx)
      break
    end
  end
end

function TaskDataUtils.ClearTaskSvrIdx2TidsDict(svrIdx)
  TaskData.taskSvrIdx2TidsDict = {}
end

function TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx)
  if not serverIdx then
    return {}
  end
  local rst = {}
  local taskTidList = TaskDataUtils.GetTaskTidListBySvrIdx(serverIdx)
  if not taskTidList or 0 == #taskTidList then
    return {}
  end
  for _, taskTid in pairs(taskTidList) do
    local taskData = TaskDataUtils.GetTaskData(taskTid)
    table.insert(rst, taskData)
  end
  return rst
end

function TaskDataUtils.OpenTaskMainPanel(callBack)
  UIManager.Instance:Reopen(Urls.TaskMainPanel)
  if callBack then
    callBack()
  end
end

function TaskDataUtils.OpenDailyTaskView()
  UIManager.Instance:Reopen(Urls.DailyTaskView)
end

function TaskDataUtils.OpenDispatchPanel()
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.SendPanel)
  RedPointDataUtils.RemoveDailyDispatchRed()
end

function TaskDataUtils.OpenRecallTips(confirmFunc, awakerList)
  UIManager.Instance:Reopen(Urls.TaskRecallTips, confirmFunc, awakerList)
end

function TaskDataUtils.OpenAppointBuildTips(tblData)
  UIManager.Instance:Reopen(Urls.TaskAppointBuildTips, tblData)
end

function TaskDataUtils.TryShowStageGroupUnlockItemOverLimitTip(uid)
  local taskData = TaskDataUtils.GetTaskData(uid, true)
  local taskTid = taskData and taskData.tid
  local taskCfg = taskTid and DT.Task[taskTid]
  if not taskCfg or not taskCfg.CompleteAward then
    return false
  end
  local stageGroupUnlockItemTid = DT.GetConstant("KeysItemIndex")
  local willObtainNum = 0
  for i = 1, #taskCfg.CompleteAward, 2 do
    local tid = taskCfg.CompleteAward[i]
    local num = taskCfg.CompleteAward[i + 1] or 0
    if tid and tid == stageGroupUnlockItemTid then
      willObtainNum = willObtainNum + num
    end
  end
  if willObtainNum <= 0 then
    return false
  end
  if not ItemDataUtils.CheckStageGroupUnlockedItemOverLimit(willObtainNum) then
    return false
  end
  local tipTid = 20140
  if UIPopTipsDataUtils.ShallTipRemind(tipTid) then
    return false
  end
  local params = {
    tid = stageGroupUnlockItemTid,
    taskUid = uid,
    tipTid = tipTid
  }
  UIManager.Instance:Reopen(Urls.DailyTaskOverItemTipPanel, params)
  return true
end

function TaskDataUtils.TryShowStageGroupUnlockItemOverLimitTipByAward(completeAward, onConfirm)
  if not completeAward or 0 == #completeAward or not onConfirm then
    return false
  end
  local stageGroupUnlockItemTid = DT.GetConstant("KeysItemIndex")
  local willObtainNum = 0
  for i = 1, #completeAward, 2 do
    local tid = completeAward[i]
    local num = completeAward[i + 1] or 0
    if tid and tid == stageGroupUnlockItemTid then
      willObtainNum = willObtainNum + num
    end
  end
  if willObtainNum <= 0 then
    return false
  end
  if not ItemDataUtils.CheckStageGroupUnlockedItemOverLimit(willObtainNum) then
    return false
  end
  local tipTid = 20140
  if UIPopTipsDataUtils.ShallTipRemind(tipTid) then
    return false
  end
  local params = {
    tid = stageGroupUnlockItemTid,
    taskUid = 0,
    tipTid = tipTid,
    onConfirmFunc = onConfirm
  }
  UIManager.Instance:Reopen(Urls.DailyTaskOverItemTipPanel, params)
  return true
end

function TaskDataUtils.TaskComplete(uid, callBack, banRewardTips, ignoreOverLimitTip)
  local function call()
    TaskDataUtils._TaskComplete(uid, callBack, banRewardTips)
  end
  
  if not ignoreOverLimitTip and TaskDataUtils.TryShowStageGroupUnlockItemOverLimitTip(uid) then
    return
  end
  local taskData = TaskDataUtils.GetTaskData(uid)
  local taskCfg = DT.Task[taskData.tid]
  if GetEnergyCheckUtils.TaskConfigCheckEnergyOver(taskCfg) then
    GetEnergyCheckUtils.TipsShow(call)
  else
    call()
  end
end

function TaskDataUtils._TaskComplete(uid, callBack, banRewardTips)
  local function ToReqGainTaskAward(extraParams, onRequestCallback)
    print("[chest] ToReqGainTaskAward extraParams=", table.tostring(extraParams))
    
    TaskController.Instance:ReqOnTaskGainPrize(uid, extraParams, callBack, banRewardTips)
    if onRequestCallback then
      onRequestCallback()
    end
  end
  
  ToReqGainTaskAward()
end

function TaskDataUtils.ShowTaskCompleteReward(svrData, taskUid)
  local itemPrize = svrData.itemPrize
  local items = {}
  for _, itemData in pairs(itemPrize.syncData or {}) do
    table.insert(items, itemData)
  end
  local isTaskTypeDaily = false
  for _, uid in ipairs(svrData.taskUids or {taskUid}) do
    local taskCfg = TaskDataUtils.GetConfig(uid)
    if taskCfg and taskCfg.TaskType == cd.TaskType.TaskType_DailyTask then
      isTaskTypeDaily = true
    end
  end
  for itemTid, itemNum in pairs(itemPrize.extra or {}) do
    table.insert(items, {
      tid = itemTid,
      changedNum = itemNum,
      extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue,
      extraDesc = isTaskTypeDaily and LT.Text("BpRewardSourceName") or LT.Text("AppointTaskRewardAddTag")
    })
  end
  ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle_CHN"), "", items)
end

function TaskDataUtils.GetConfig(tid)
  if not tid then
    return
  end
  return DT.Task[tid]
end

function TaskDataUtils.GetConfigByField(field, tid)
  if not field or not tid then
    return nil
  end
  local cfg = TaskDataUtils.GetConfig(tid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function TaskDataUtils.Reset()
  TaskDataUtils.ClearTaskTid2DataDict()
  TaskDataUtils.ClearTaskSvrIdx2TidsDict()
end

function TaskDataUtils.GetNeededShopItem(taskId)
  local cfg = TaskDataUtils.GetTaskConfigByTid(taskId)
  if not cfg then
    return
  end
  local boughtConds = {
    cd.TaskExtraCond.BoughtShopItem,
    cd.TaskExtraCond.BoughtShopItemEvent
  }
  if table.contains(boughtConds, cfg.ExtraCondType) and cfg.ExtraCondPara then
    return cfg.ExtraCondPara[2]
  end
  if table.contains(boughtConds, cfg.CompleteCond) and cfg.CompleteCondPara then
    return cfg.CompleteCondPara[2]
  end
end

function TaskDataUtils.GetTaskPrice(taskId)
  local neededShopItem = TaskDataUtils.GetNeededShopItem(taskId)
  do return ShopDataUtils.GetShopItemPrice end
  return ShopDataUtils.GetShopItemPrice, neededShopItem
end

function TaskDataUtils.IsTaskDoneByTaskId(taskId)
  local taskData = TaskDataUtils.GetTaskData(taskId)
  if not taskData then
    return false
  end
  return taskData.state == CommonDefine.TaskState.Done or taskData.state == CommonDefine.TaskState.Receive
end

function TaskDataUtils.IsCanGetRward(taskIdOrList)
  if not taskIdOrList then
    return false
  end
  if type(taskIdOrList) == "number" or type(taskIdOrList) == "string" then
    do return TaskDataUtils.IsTaskCanReward, tonumber(taskIdOrList) end
    return TaskDataUtils.IsTaskCanReward, tonumber(taskIdOrList)
  end
  local isCanGet = false
  for _, taskId in ipairs(taskIdOrList) do
    if TaskDataUtils.IsTaskCanReward(taskId) then
      isCanGet = true
    end
  end
  return isCanGet
end

function TaskDataUtils.IsTaskCanReward(taskId)
  local taskData = TaskDataUtils.GetTaskData(taskId)
  taskData = taskData or TaskDataUtils._AddTask(taskId)
  return taskData.state == CommonDefine.TaskState.Receive
end

function TaskDataUtils.IsTaskNotComplete(taskId)
  local taskData = TaskDataUtils.GetTaskData(taskId)
  taskData = taskData or TaskDataUtils._AddTask(taskId)
  local state = taskData.state
  if state == TaskState.UnDone or state == TaskState.Doing then
    return true
  end
end

function TaskDataUtils._AddTask(taskId)
  local taskData = {
    uid = taskId,
    tid = taskId,
    state = CommonDefine.TaskState.UnDone,
    count = 0
  }
  TaskDataUtils.AddTask(taskData)
  return taskData
end

function TaskDataUtils.TaskFinshAndGetedAward(taskId)
  local taskData = TaskDataUtils.GetTaskData(taskId)
  if not taskData then
    return false
  end
  return taskData.state == CommonDefine.TaskState.Done
end

function TaskDataUtils.CheckTaskListIsAllDone(list)
  if list then
    for _, taskId in ipairs(list) do
      if not TaskDataUtils.IsTaskDoneByTaskId(taskId) then
        return false
      end
    end
    return true
  else
    return false
  end
end

function TaskDataUtils.InitTaskData(serverData)
  TaskDataUtils.Reset()
  TaskDataUtils.InitByConfigData()
  TaskDataUtils.InitByServerData(serverData)
end

function TaskDataUtils.InitByConfigData()
  local TaskPlayerLevel = CommonDefine.TaskType.TaskType_PlayerLevel
  local TaskDailyTask = cd.TaskType.TaskType_DailyTask
  local AbandonedTask = DT.GetOriginalConstant("AbandonedTask") or {}
  for tid, taskCfg in pairs(DT.Task) do
    if table.contains(AbandonedTask, tid) then
    else
      if taskCfg.TaskType == TaskPlayerLevel then
        local taskData = {
          uid = taskCfg.ID,
          tid = taskCfg.ID,
          state = CommonDefine.TaskState.Doing
        }
        TaskDataUtils.AddTaskSvrIdx2TidsDict(CommonDefine.TaskServerIndex.PlayerLevel, taskCfg.ID)
        TaskDataUtils.SetTaskData(taskCfg.ID, taskData)
      end
      if taskCfg.TaskType == TaskDailyTask then
        TaskData.dailyTaskTid = tid
      end
    end
  end
end

function TaskDataUtils.InitByServerData(serverData)
  if serverData.Appoint then
    TaskData.appointRefreshCount = serverData.Appoint.refreshCount or 0
    TaskDataUtils.SetIsSpecialAppoint(serverData.Appoint.isSpecial and 1 or 0)
    TaskData.completeDelegateNum = serverData.Appoint.appointCount or 0
    TaskData.maxCompleteDelegateNum = serverData.Appoint.appointMaxCount or 0
  end
  for key, taskListInfo in pairs(serverData) do
    if taskListInfo.tasks then
      if "PlayerLevel" == key then
        for _, taskInfo in pairs(taskListInfo.tasks) do
          TaskDataUtils.UpdateTask(taskInfo)
        end
      else
        for _, taskInfo in pairs(taskListInfo.tasks) do
          TaskDataUtils.AddTask(taskInfo)
        end
      end
    end
  end
end

function TaskDataUtils.AppointTaskRedFunc()
  do return RedPointDataUtils.IsShowTaskRedPoint end
  return RedPointDataUtils.IsShowTaskRedPoint, CommonDefine.TaskServerIndex.Appoint
end

function TaskDataUtils.AchievementTaskRedFunc()
  do return RedPointDataUtils.IsShowTaskRedPoint end
  return RedPointDataUtils.IsShowTaskRedPoint, CommonDefine.TaskServerIndex.Achivement
end

function TaskDataUtils.AddTask(taskInfo)
  taskInfo = TaskProtoCodec.TaskDataToKeyValue(taskInfo)
  local uid = taskInfo.uid or taskInfo.tid
  local tid = taskInfo.tid
  if 0 == uid then
    uid = tid
  end
  local taskCfg = TaskDataUtils.GetConfig(tid)
  if not taskCfg then
    return
  end
  local taskData = TaskDataUtils.GetTaskData(tid, true)
  if taskData then
    TaskDataUtils.UpdateTask(taskInfo)
    return
  end
  local type2index = CommonDefine.TaskType2ServerIndex
  local serverIndex = type2index[taskCfg.TaskType] or DT.GetConstant(taskCfg.TaskType) or cd.DefaultTaskIndex
  if serverIndex == CommonDefine.TaskServerIndex.Appoint and not taskInfo.awakerList then
    taskInfo.awakerList = {}
  end
  TaskDataUtils.SetTaskData(tid, taskInfo)
  EventMgr.Instance.TaskInfoAdded:Dispatch(taskInfo)
  if serverIndex then
    TaskDataUtils.AddTaskSvrIdx2TidsDict(serverIndex, tid)
  end
  TaskDataUtils.CalSendTeamNum()
  TaskDataUtils.DispatchUpdateEvent(serverIndex)
  TaskDataUtils._TryUpload2SteamArchieve(uid)
end

local UpdateIndexList = {}

function TaskDataUtils.DispatchUpdateEvent(serverIndex)
  serverIndex = serverIndex or -1
  UpdateIndexList[serverIndex] = true
  if TaskDataUtils._dispatchUpdateEventTimer then
    return
  end
  TaskDataUtils._dispatchUpdateEventTimer = TimerManager.Instance:CreateTimer(0.2, 0, nil, function()
    TaskDataUtils._dispatchUpdateEventTimer = nil
    for idx, _ in pairs(UpdateIndexList) do
      if -1 ~= idx then
        EventMgr.Instance.TaskViewUpdate:Dispatch(idx)
      else
        EventMgr.Instance.TaskViewUpdate:Dispatch()
      end
    end
    table.clear(UpdateIndexList)
  end)
end

function TaskDataUtils.UpdateTask(updateInfo)
  updateInfo = TaskProtoCodec.TaskDataToKeyValue(updateInfo)
  local taskTid = updateInfo.tid
  local taskInfo = TaskDataUtils.GetTaskData(taskTid, true)
  TaskDataUtils.OnTaskStateChanged(taskTid, taskInfo and taskInfo.state, updateInfo.state)
  if not taskInfo then
    TaskDataUtils.AddTask(updateInfo)
  else
    for key, value in pairs(updateInfo) do
      taskInfo[key] = value
    end
    EventMgr.Instance.TaskInfoUpdated:Dispatch(taskInfo)
    TaskHomeAchievementModel.Instance:_RefreshAchievementTaskMap(taskInfo)
    if updateInfo.tid then
      local tid = updateInfo.tid
      local type2index = CommonDefine.TaskType2ServerIndex
      local taskCfg = TaskDataUtils.GetConfig(tid)
      local serverIndex = type2index[taskCfg.TaskType]
      TaskDataUtils.CalSendTeamNum()
      TaskDataUtils.DispatchUpdateEvent(serverIndex)
    end
  end
  TaskDataUtils._TryUpload2SteamArchieve(taskTid)
end

function TaskDataUtils._TryUpload2SteamArchieve(taskUid)
  local taskData = TaskDataUtils.GetTaskData(taskUid, true)
  if taskData and TaskDataUtils.IsTaskDoneByTaskId(taskData.tid) then
    local taskCfg = DT.Task[taskData.tid]
    local steamAchievAPI = taskCfg and taskCfg.SteamAchievAPI or nil
    SteamArchievesMgr.Instance:OnGameArchieveCompepete(steamAchievAPI)
  end
end

function TaskDataUtils.OnTaskStateChanged(taskTid, oldState, newState)
  if not (taskTid and oldState) or not newState then
    return
  end
  if oldState == newState then
    return
  end
  if newState == CommonDefine.TaskState.Receive then
    ActivityKarenUtils.OnKarenTaskToReceive(taskTid)
  elseif newState == CommonDefine.TaskState.Done then
    ActivityKarenUtils.OnKarenTaskToDone(taskTid)
  end
  TaskDataUtils._TryUpload2SteamArchieve(taskTid)
end

function TaskDataUtils.LoadAchievementTaskPopUpTips(updateInfo)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Task, CommonDefine.TaskServerIndex.Achivement)
  if not unlocked then
    return
  end
  local tid = updateInfo.tid
  local taskCfg = TaskDataUtils.GetConfig(tid)
  if taskCfg then
    if taskCfg.TaskType == CommonDefine.TaskType.TaskType_Achivement and updateInfo.state == CommonDefine.TaskState.Receive then
      UIManager.Instance:InsertUIQueue(CommonDefine.SceneType.Town, true, Urls.PopAchievementTips, tid)
    end
  else
    Logger.Warn("LoadAchievementTaskPopUpTips: not find task=%s config", tid)
  end
end

function TaskDataUtils.DeleteTask(taskUid)
  local taskInfo = TaskDataUtils.GetTaskData(taskUid, true)
  if not taskInfo then
    return
  end
  local tid = taskInfo.tid
  TaskDataUtils.SetTaskData(tid, nil)
  local type2index = CommonDefine.TaskType2ServerIndex
  local taskCfg = TaskDataUtils.GetConfig(tid)
  local serverIndex = type2index[taskCfg.TaskType]
  TaskDataUtils.DelTaskSvrIdx2TidsDict(serverIndex, tid)
  TaskDataUtils.CalSendTeamNum()
  TaskDataUtils.DispatchUpdateEvent(serverIndex)
end

function TaskDataUtils.CalSendTeamNum()
  local appointIndex = 1
  local taskTidList = TaskDataUtils.GetTaskTidListBySvrIdx(appointIndex)
  local num = 0
  for _, tid in ipairs(taskTidList) do
    local taskData = TaskDataUtils.GetTaskData(tid)
    local taskCfg = TaskDataUtils.GetConfig(tid)
    if taskCfg.TaskType == CommonDefine.TaskType.TaskType_Appoint_Dispatch and (taskData.state == TaskState.Doing or taskData.state == TaskState.Receive) then
      num = num + 1
    end
  end
  TaskData.sendTeamNum = num
end

function TaskDataUtils.CreateCondInfo(count, need, reverse)
  local condInfo = {isOk = false, conditionStr = ""}
  if reverse then
    condInfo.isOk = count <= need
  else
    condInfo.isOk = need <= count
  end
  condInfo.conditionStr = string.format("%s/%s", count, need)
  return condInfo
end

function TaskDataUtils.CheckTasksContainState(serverIdx, state)
  local taskGroup = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx)
  for _, taskData in pairs(taskGroup) do
    if taskData.state == state then
      return true
    end
  end
  return false
end

function TaskDataUtils.CheckTasksAllInState(serverIdx, state)
  local taskGroup = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx)
  for _, taskData in pairs(taskGroup) do
    if taskData.state ~= state then
      return false
    end
  end
  return true
end

function TaskDataUtils.RemoveJumpLockTasks(list)
  local rst = list or {}
  for i = #rst, 1, -1 do
    local taskCfg = TaskDataUtils.GetConfig(rst[i].tid)
    if taskCfg.UnlockCondType and taskCfg.UnlockCondType == "SpecificFeatureUnlock" then
      local featureCfg = DT.FeatureUnlock[taskCfg.UnlockCondPara[1]]
      local key = featureCfg.Key or PlayerDataUtils.GetFeatureMainTypeKey()
      local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureCfg.Feature, key)
      if not isUnlock then
        table.remove(rst, i)
      end
    end
  end
  return rst
end

function TaskDataUtils.SortTasksData(list)
  if not list or 0 == #list then
    return {}
  end
  local rst = table.deepclone(list)
  table.sort(rst, function(a, b)
    local aCfg = TaskDataUtils.GetConfig(a.tid)
    local bCfg = TaskDataUtils.GetConfig(b.tid)
    local sortWeight = {
      [TaskState.Receive] = 1,
      [TaskState.Doing] = 2,
      [TaskState.Done] = 3,
      [TaskState.UnDone] = 4
    }
    if a.state == b.state then
      return aCfg.BaseSortID < bCfg.BaseSortID
    else
      return sortWeight[a.state] < sortWeight[b.state]
    end
  end)
  return rst
end

function TaskDataUtils.HasExtraAward(taskTid)
  local config = TaskDataUtils.GetConfig(taskTid)
  if not config then
    return false
  end
  return config and config.ExtraAward ~= nil
end

function TaskDataUtils.GetExtraAwardTagText()
  do return LT.Text end
  return LT.Text, "AppointTaskRewardAddTag"
end

function TaskDataUtils.IsReachDispatchExtraAwardCond(taskTid, awakerTids)
  local extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(taskTid, awakerTids)
  return extraAwardInfo and extraAwardInfo.reach or false
end

function TaskDataUtils.GetDispatchAwardList(taskCfg, awakerList)
  local tempList = {}
  local awardList = {}
  local itemCountMap = {}
  for key, count in table.iteraDouble(taskCfg.CompleteAward or {}) do
    table.insert(tempList, key)
    itemCountMap[key] = count
  end
  for _, itemId in pairs(tempList) do
    table.insert(awardList, {
      itemTid = itemId,
      count = itemCountMap[itemId]
    })
  end
  local extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(taskCfg.ID, awakerList)
  if extraAwardInfo then
    table.insert(awardList, {
      itemTid = extraAwardInfo.tid,
      count = extraAwardInfo.num,
      reach = extraAwardInfo.reach,
      isExtra = true
    })
  end
  return awardList
end

function TaskDataUtils.GetDispatchExtraAward(taskTid, awakerTids)
  local taskConfig = TaskDataUtils.GetConfig(taskTid)
  if not taskConfig then
    return
  end
  local award
  local TEAT = CommonDefine.TaskExtraAwardType
  if taskConfig.ExtraCondType == TEAT.AppointTotalLevel then
    award = TaskDataUtils.GetExtraAwardByAwakerTotalLevel(taskTid, awakerTids)
  end
  return award
end

function TaskDataUtils.GetExtraAwardByAwakerTotalLevel(taskTid, awakerTids)
  local taskConfig = TaskDataUtils.GetConfig(taskTid)
  if not taskConfig then
    return
  end
  local dispatchAwakerLevel = 0
  if awakerTids then
    for _, awakerTid in ipairs(awakerTids) do
      if awakerTid and AwakerDataUtils.HasOwnedAwaker(awakerTid) then
        local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
        dispatchAwakerLevel = dispatchAwakerLevel + awakerData.level
      end
    end
  end
  local extraAwardIndex = 1
  local _reach = false
  for idx, levelCond in ipairs(taskConfig.ExtraCondPara) do
    if levelCond > dispatchAwakerLevel then
      break
    end
    extraAwardIndex = idx
    _reach = true
  end
  extraAwardIndex = extraAwardIndex + 1
  local _tid = taskConfig.ExtraAward[1]
  local _num = taskConfig.ExtraAward[extraAwardIndex]
  return {
    tid = _tid,
    num = _num,
    reach = _reach
  }
end

function TaskDataUtils.GetDispatchTaskTypeNormalIcon(taskTid)
  local config = TaskDataUtils.GetConfig(taskTid)
  return config and config.AchieveIcon[1]
end

function TaskDataUtils.GetDispatchTaskTypeGreyIcon(taskTid)
  local config = TaskDataUtils.GetConfig(taskTid)
  return config and config.AchieveIcon[2]
end

function TaskDataUtils.GetLockedTips(taskUid)
  local taskData = TaskDataUtils.GetTaskData(taskUid)
  if not taskData or not taskData.lock then
    return
  end
  local taskConfig = TaskDataUtils.GetConfig(taskData.tid)
  if not (taskConfig and taskConfig.UnlockCondType) or not taskConfig.UnlockCondPara then
    return
  end
  local TUCT = CommonDefine.TaskUnlockCondType
  local tips
  if taskConfig.UnlockCondType == TUCT.PlayerLevel then
    local levelLimit = taskConfig.UnlockCondPara[1]
    tips = LT.Textf(taskConfig.UnlockCondDesc, levelLimit)
  elseif taskConfig.UnlockCondType == TUCT.StageFirstClear then
    local stageTid = taskConfig.UnlockCondPara[1]
    tips = LT.Textf(taskConfig.UnlockCondDesc, CopyDataUtils.GetStageNameNumber(stageTid))
  end
  return tips
end

function TaskDataUtils.GetCurDispatchNum()
  local dispatchTaskTidList = TaskDataUtils.GetTaskTidListBySvrIdx(CommonDefine.TaskServerIndex.Appoint)
  local curNum = 0
  if not dispatchTaskTidList then
    return curNum
  end
  for _, tid in ipairs(dispatchTaskTidList) do
    local taskData = TaskDataUtils.GetTaskData(tid)
    if taskData and (taskData.state == TaskState.Doing or taskData.state == TaskState.Receive) then
      curNum = curNum + 1
    end
  end
  return curNum
end

function TaskDataUtils.GetMaxDispatchNum()
  local playerLevel = DataCenter.playerData.DRole.level
  local accountLevelConfig = PlayerDataUtils.GetAccountLevelConfig(playerLevel)
  if not accountLevelConfig or not accountLevelConfig.DailyAppointNum then
    Logger.Error("account level config error:", playerLevel, accountLevelConfig and accountLevelConfig.DailyAppointNum)
    return 0
  end
  return accountLevelConfig.DailyAppointNum
end

function TaskDataUtils.EnableDispatch()
  local dispatchTaskTidList = TaskDataUtils.GetTaskTidListBySvrIdx(CommonDefine.TaskServerIndex.Appoint)
  if not dispatchTaskTidList or 0 == #dispatchTaskTidList then
    return false
  end
  local isAllDoing = TaskDataUtils.CheckTasksAllInState(CommonDefine.TaskServerIndex.Appoint, CommonDefine.TaskState.Doing)
  if isAllDoing then
    return false
  end
  local maxDispatchNum = TaskDataUtils.GetMaxDispatchNum()
  local curDispatchNum = TaskDataUtils.GetCurDispatchNum()
  return maxDispatchNum - curDispatchNum > 0
end

function TaskDataUtils.SetAppointRefreshCount(num)
  TaskData.appointRefreshCount = num
end

function TaskDataUtils.SetIsSpecialAppoint(val)
  TaskData.isSpecialAppoint = val
end

function TaskDataUtils.SetCompleteCount(val)
  TaskData.completeDelegateNum = val
end

function TaskDataUtils.SetMaxCompleteCount(val)
  TaskData.maxCompleteDelegateNum = val
end

function TaskDataUtils.GetConditionInfo(condType, condParam, awakerList)
  local condInfo
  if "AppointTotalLevel" == condType then
    local need = condParam[1]
    local totalLevel = TaskDataUtils.GetTotalLevel(awakerList)
    condInfo = TaskDataUtils.CreateCondInfo(totalLevel, need)
  elseif "AppointTotalCombat" == condType then
    local need = condParam[1]
    local totalFight = TaskDataUtils.GetTotalFight(awakerList)
    condInfo = TaskDataUtils.CreateCondInfo(totalFight, need)
  elseif "AppointAwakerNum" == condType then
    local need = condParam[1]
    
    local function checkFunc(awakerData)
      return awakerData and awakerData.fighting
    end
    
    local count = TaskDataUtils.GetAwakerCount(awakerList, checkFunc)
    condInfo = TaskDataUtils.CreateCondInfo(count, need, true)
  elseif "AppointAwakerLevelNum" == condType then
    local need = condParam[1]
    local level = condParam[2]
    
    local function checkFunc(awakerData)
      return awakerData and awakerData.level >= level
    end
    
    local count = TaskDataUtils.GetAwakerCount(awakerList, checkFunc)
    condInfo = TaskDataUtils.CreateCondInfo(count, need)
  elseif "AppointAwakerSchoolNum" == condType then
    local need = condParam[1]
    local schoolId = condParam[2]
    
    local function checkFunc(awakerData)
      local awakerCfg = DT.AwakerConfig[awakerData.tid]
      return awakerCfg.School == schoolId
    end
    
    local count = TaskDataUtils.GetAwakerCount(awakerList, checkFunc)
    condInfo = TaskDataUtils.CreateCondInfo(count, need)
  elseif "SpecificAwakerLevel" == condType then
    local need = condParam[1]
    local awakerId = condParam[2]
    local count = AwakerDataUtils.GetAwakerData(awakerId).level
    condInfo = TaskDataUtils.CreateCondInfo(count, need)
  elseif "AwakerStarNum" == condType then
    local need = condParam[1]
    local star = condParam[2]
    
    local function checkFunc(awakerData)
      return awakerData and awakerData.star >= star
    end
    
    local count = TaskDataUtils.GetAwakerCount(awakerList, checkFunc)
    condInfo = TaskDataUtils.CreateCondInfo(count, need)
  elseif "AwakerSchoolCombatNum" == condType then
    local need = condParam[1]
    local fight = condParam[2]
    local schoolIdList = table.concat(condParam, ",", 3)
    
    local function checkFunc(awakerData)
      local awakerCfg = DT.AwakerConfig[awakerData.tid]
      if table.contains(awakerCfg.School, schoolIdList) then
        return awakerData.fighting >= fight
      end
    end
    
    local count = TaskDataUtils.GetAwakerCount(awakerList, checkFunc)
    condInfo = TaskDataUtils.CreateCondInfo(count, need)
  elseif "AwakerSkillLevelNum" == condType then
    local need = condParam[1]
    local strengthLevel = condParam[2]
    
    local function checkFunc(skillData)
      return skillData.upNum >= strengthLevel
    end
    
    local count = TaskDataUtils.GetSkillCount(awakerList, checkFunc)
    condInfo = TaskDataUtils.CreateCondInfo(count, need)
  end
  return condInfo
end

function TaskDataUtils.GetAppointedAwakerGroup()
  local rst = {}
  local appointTaskList = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Appoint)
  for _, delegateTask in pairs(appointTaskList) do
    if delegateTask.awakerList and #delegateTask.awakerList > 0 then
      for _, awakerId in pairs(delegateTask.awakerList) do
        table.insert(rst, awakerId)
      end
    end
  end
  return rst
end

function TaskDataUtils.AwakerInTask(awakerId)
  local changeAwakerId = AwakerDataUtils.GetChangerForm(awakerId)
  local appointTaskList = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Appoint)
  local TaskUnDone = cd.TaskState.UnDone
  for _, delegateTask in pairs(appointTaskList) do
    if delegateTask.state ~= TaskUnDone and delegateTask.awakerList and #delegateTask.awakerList > 0 then
      for _, _awakerId in pairs(delegateTask.awakerList) do
        if 0 ~= _awakerId and (_awakerId == awakerId or _awakerId == changeAwakerId) then
          return true
        end
      end
    end
  end
end

function TaskDataUtils.GetTaskIsActive(numUid)
  local taskData = TaskDataUtils.GetTaskData(numUid)
  return taskData.endTs and taskData.endTs > TimeUtils.GetServerTime()
end

function TaskDataUtils.GetTaskLeftTime(taskData)
  local taskCfg = TaskDataUtils.GetConfig(taskData.tid)
  local needTime = (taskCfg.NeedTime or 0) * 60
  local curTime = TimeUtils.GetServerTime()
  local startTime = taskData.ts
  if 0 == needTime or not startTime then
    return 0
  end
  local passedTime = curTime - startTime
  local leftTime = math.max(0, needTime - passedTime)
  return leftTime
end

function TaskDataUtils.GetTaskJumpTo(numTid)
  local taskCfg = TaskDataUtils.GetConfig(numTid)
  if not taskCfg then
    Logger.Error("Error! Task Config don't have numTid ", numTid)
    return nil
  end
  return taskCfg.JumpTo and taskCfg.JumpTo[1] or nil
end

function TaskDataUtils.GetTotalFight(awakerList)
  if not awakerList then
    return 0
  end
  local totalFighting = 0
  for _, tid in pairs(awakerList) do
    if 0 ~= tid then
      local awakerData = AwakerDataUtils.GetAwakerData(tid)
      if awakerData and awakerData.fighting then
        totalFighting = totalFighting + awakerData.fighting
      end
    end
  end
  return totalFighting
end

function TaskDataUtils.GetTotalLevel(awakerList)
  if not awakerList then
    return 0
  end
  local totalLevel = 0
  for _, tid in pairs(awakerList) do
    if 0 ~= tid then
      local awakerData = AwakerDataUtils.GetAwakerData(tid)
      if awakerData and awakerData.level then
        totalLevel = totalLevel + awakerData.level
      end
    end
  end
  return totalLevel
end

function TaskDataUtils.GetAwakerCount(awakerList, checkFunc)
  if nil == checkFunc or not awakerList then
    return 0
  end
  local count = 0
  for _, tid in pairs(awakerList) do
    if 0 ~= tid then
      local awakerData = AwakerDataUtils.GetAwakerData(tid)
      if checkFunc(awakerData) then
        count = count + 1
      end
    end
  end
  return count
end

function TaskDataUtils.GetSkillCount(awakerList, checkFunc)
  if nil == checkFunc or not awakerList then
    return 0
  end
  local count = 0
  for _, tid in pairs(awakerList) do
    if 0 ~= tid then
      for index = 1, 6 do
        local skillData = AwakerDataUtils.GetSkillDataBySlot(tid, index)
        if checkFunc(skillData) then
          count = count + 1
        end
      end
    end
  end
  return count
end

function TaskDataUtils.GetTaskCompleteAward(numTid)
  local rst = {}
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(numTid)
  if not taskCfg.CompleteAward then
    return rst
  end
  for key, val in table.iteraDouble(taskCfg.CompleteAward) do
    table.insert(rst, {tid = key, num = val})
  end
  return rst
end

function TaskDataUtils.GetTaskDesc(numTid)
  if not TaskDataUtils.GetConfig(numTid) then
    Logger.Error("Error! Task Config, numTid ", numTid)
    return ""
  end
  return TaskDataUtils.GetConfig(numTid).Desc
end

function TaskDataUtils.GetTaskProgressDesc(taskTid, targetFormat)
  if not TaskDataUtils.GetConfig(taskTid) then
    Logger.Error("Error! Task Config, taskTid ", taskTid)
    return ""
  end
  local taskData = TaskDataUtils.GetTaskData(taskTid)
  local taskCfg = TaskDataUtils.GetConfig(taskTid)
  local count = taskData.count or 0
  local totalCount = TaskDataUtils.GetTaskProgressLimit(taskTid)
  do return string.format, targetFormat or "%s<color=#959595>(%s/%s)</color>", LT.Text(taskCfg.Desc), count end
  return string.format, targetFormat or "%s<color=#959595>(%s/%s)</color>", LT.Text(taskCfg.Desc), count, totalCount
end

function TaskDataUtils.GetTaskType(numTid)
  if not TaskDataUtils.GetConfig(numTid) then
    Logger.Error("Error! Task Config, numTid ", numTid)
    return ""
  end
  return TaskDataUtils.GetConfig(numTid).TaskType
end

function TaskDataUtils.ReportToApus(taskTid)
  local taskCfg = TaskDataUtils.GetConfig(taskTid)
  if not taskCfg then
    Logger.ReportApusErrorS("Task Error No Config, taskTid " .. taskTid)
  end
  taskCfg = taskCfg or {}
  local taskData = TaskDataUtils.GetTaskData(taskTid)
  if not taskData then
    Logger.ReportApusErrorS("Task Error No TaskData, taskTid " .. taskTid)
    return
  end
  Logger.ReportApusInfo("TaskInfo", string.format(" tid:%s, state:%s, count:%s, complete:%s completeCount:%s", taskTid, taskData.state, taskData.count, taskCfg.CompleteCond, taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1]))
end

function TaskDataUtils.GetTaskListByType(taskType, isExcludeParent)
  local taskServerId
  if type(taskType) == "number" then
    taskServerId = taskType
  else
    taskServerId = DT.GetConstant(taskType)
    assert(taskServerId, string.format("TaskType：%s 没有在常量表配置常量id", taskType))
  end
  local taskTidList = TaskDataUtils.GetTaskTidListBySvrIdx(taskServerId)
  local taskList = {}
  for _, tid in pairs(taskTidList) do
    local taskData = TaskDataUtils.GetTaskData(tid)
    table.insert(taskList, taskData)
  end
  if not isExcludeParent then
    return taskList
  end
  local rst = {}
  for _, taskData in pairs(taskList) do
    local taskCfg = TaskDataUtils.GetConfig(taskData.tid)
    if taskCfg and taskCfg.TaskType == taskType then
      table.insert(rst, taskData)
    end
  end
  return rst
end

function TaskDataUtils.GetTaskListParentTask(parentTaskTid)
  local taskList = {}
  for _, task in pairs(TaskDataUtils.GetTaskTid2DataDict()) do
    local taskCfg = DT.Task[task.tid]
    if taskCfg.BelongTaskGroup == parentTaskTid then
      table.insert(taskList, task)
    end
  end
  return taskList
end

function TaskDataUtils.GetConstKeyTaskMap(constKey)
  if TaskData.constKeyTaskMap[constKey] then
    return TaskData.constKeyTaskMap[constKey]
  end
  local taskList = DT.GetOriginalConstant(constKey)
  local parentTaskMap = table.reverseKV(taskList or {})
  local allTaskMap = {}
  for taskTid, taskCfg in pairs(DT.Task) do
    if taskCfg.BelongTaskGroup and parentTaskMap[taskCfg.BelongTaskGroup] then
      local taskData = TaskDataUtils.GetTaskData(taskTid)
      if taskData then
        allTaskMap[taskTid] = taskData
      end
    end
  end
  TaskData.constKeyTaskMap[constKey] = allTaskMap
  return allTaskMap
end

function TaskDataUtils.GetTaskConfigByUid(numUid)
  local tid = TaskDataUtils.GetTaskData(numUid).tid
  do return TaskDataUtils.GetTaskConfigByTid end
  return TaskDataUtils.GetTaskConfigByTid, tid
end

function TaskDataUtils.GetTaskConfigByTid(numTid)
  if not TaskDataUtils.GetConfig(numTid) then
    Logger.Error("Error! Task Config, tid ", numTid)
    return nil
  end
  do return TaskDataUtils.GetConfig end
  return TaskDataUtils.GetConfig, numTid, numTid
end

function TaskDataUtils.GetCompleteDelegateNum()
  return TaskData.completeDelegateNum
end

function TaskDataUtils.GetSendTeamNum()
  return TaskData.sendTeamNum
end

function TaskDataUtils.GetIsSpecialAppoint()
  return TaskData.isSpecialAppoint
end

function TaskDataUtils.GetUnDispatchedTaskList()
  local list = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Appoint)
  if not list then
    return {}
  end
  local maxDispatchNum = TaskDataUtils.GetMaxDispatchNum()
  local curDispatchNum = TaskDataUtils.GetCurDispatchNum()
  local remainCanDispatch = math.max(0, maxDispatchNum - curDispatchNum)
  if remainCanDispatch <= 0 then
    return {}
  end
  local ret = {}
  for _, taskData in ipairs(list) do
    if taskData and taskData.state == TaskState.UnDone then
      table.insert(ret, taskData)
      if remainCanDispatch <= #ret then
        break
      end
    end
  end
  return ret
end

function TaskDataUtils.GetMinLevelRequirementOfUnDispatchedTasks()
  local unDispatched = TaskDataUtils.GetUnDispatchedTaskList()
  if not unDispatched or 0 == #unDispatched then
    return nil
  end
  local minNeed
  for _, taskData in ipairs(unDispatched) do
    local cfg = TaskDataUtils.GetConfig(taskData.tid)
    if cfg and cfg.CompleteCond == CommonDefine.TaskCond.AppointTotalLevel and cfg.CompleteCondPara and cfg.CompleteCondPara[1] then
      local need = cfg.CompleteCondPara[1]
      if nil == minNeed or minNeed > need then
        minNeed = need
      end
    end
  end
  return minNeed
end

function TaskDataUtils.GetTop4LevelSumOfUnDispatchedAwakers()
  local appointedTids = TaskDataUtils.GetAppointedAwakerGroup()
  local appointedSet = {}
  for _, tid in ipairs(appointedTids) do
    if tid and 0 ~= tid then
      appointedSet[tid] = true
    end
  end
  local owned = AwakerDataUtils.GetOwnedAwakerList()
  local levels = {}
  for _, awakerData in ipairs(owned) do
    if awakerData and awakerData.tid and not appointedSet[awakerData.tid] and (awakerData.level or 0) > 0 then
      table.insert(levels, awakerData.level or 0)
    end
  end
  table.sort(levels, function(a, b)
    return b < a
  end)
  local sum = 0
  for i = 1, math.min(4, #levels) do
    sum = sum + levels[i]
  end
  return sum
end

function TaskDataUtils.HasCanDispatchTaskRed()
  local unDispatched = TaskDataUtils.GetUnDispatchedTaskList()
  if not unDispatched or 0 == #unDispatched then
    return false
  end
  local minNeed = TaskDataUtils.GetMinLevelRequirementOfUnDispatchedTasks()
  if nil == minNeed then
    return false
  end
  local top4Sum = TaskDataUtils.GetTop4LevelSumOfUnDispatchedAwakers()
  return minNeed <= top4Sum
end

function TaskDataUtils.GetAppointMaxNum()
  return TaskData.maxCompleteDelegateNum
end

function TaskDataUtils.GetTaskProgressLimit(taskTid)
  local rst = ""
  local taskConfig = TaskDataUtils.GetConfig(taskTid)
  if taskConfig.ProgressLimit then
    rst = taskConfig.ProgressLimit
  elseif taskConfig.CompleteCondPara and taskConfig.CompleteCondPara[1] then
    rst = taskConfig.CompleteCondPara[1]
  end
  return rst
end

function TaskDataUtils.GetStageTaskShowType(taskTid)
  local cfg = DT.Task[taskTid]
  if cfg and cfg.TaskType == CommonDefine.TaskType.LevelAchievements then
    return cfg.ExtraCondPara and cfg.ExtraCondPara[1]
  end
  return nil
end

function TaskDataUtils.GetStageTaskProgressShowText(taskTid, progress, limit)
  local rst = ""
  local showType = TaskDataUtils.GetStageTaskShowType(taskTid)
  if showType == CommonDefine.StageTaskShowType.Common then
    rst = string.format("(%s/%s)", progress, limit)
  elseif showType == CommonDefine.StageTaskShowType.Percent then
    rst = string.format("(%s%%)", LT.Textf("Shop_Confirm_Buy_Str_Now_Money", progress))
  end
  return rst
end

function TaskDataUtils.GetStageTaskCompareType(taskTid)
  local cfg = DT.Task[taskTid]
  local taskCond = cfg and cfg.CompleteCond
  if not taskCond then
    return nil
  end
  if taskCond:sub(-3) == "Low" then
    return CommonDefine.CompareType.Less
  elseif taskCond:sub(-4) == "High" then
    return CommonDefine.CompareType.Greater
  end
  return nil
end

function TaskDataUtils.MergeDailyChallengeTaskCfg(taskTids)
  local taskCond2CfgsMap = {}
  for i, taskId in pairs(taskTids) do
    local cfg = DT.Task[taskId]
    if not taskCond2CfgsMap[cfg.CompleteCond] then
      taskCond2CfgsMap[cfg.CompleteCond] = {}
    end
    table.insert(taskCond2CfgsMap[cfg.CompleteCond], cfg)
  end
  local finalCfgs = {}
  for _, cfgs in pairs(taskCond2CfgsMap) do
    table.sort(cfgs, function(a, b)
      return a.BaseSortID < b.BaseSortID
    end)
    table.insert(finalCfgs, cfgs[1])
  end
  return finalCfgs
end

function TaskDataUtils.GetTimeReplaceLanguageKey(newLangKey, isSeasonSwitched)
  local config = DT.GetOriginalConstant("LanguageReplaceTime")
  if not config then
    return newLangKey
  end
  for _, keyGroup in ipairs(config) do
    if keyGroup and #keyGroup >= 3 and keyGroup[1] == newLangKey then
      if isSeasonSwitched then
        return keyGroup[3]
      end
      local curTime = TimeUtils.GetServerTime()
      if curTime < keyGroup[2] then
        return keyGroup[3]
      end
    end
  end
  return newLangKey
end

function TaskDataUtils.ShowDailyChallengeRulePanel(stageGroupId)
  local id = stageGroupId
  local cfgData = DT.StageGroup[id]
  local list = cfgData.IntegralTerm
  local str = ""
  if list then
    local showTaskCfgs = TaskDataUtils.MergeDailyChallengeTaskCfg(list)
    for i, taskCfg in ipairs(showTaskCfgs) do
      local taskTitle = LT.Text(taskCfg.Name)
      local taskDesc = LT.Text(taskCfg.Desc)
      local index = string.find(taskTitle, "<") - 1
      index = index > 0 and index or 0
      taskTitle = string.sub(taskTitle, 0, index)
      str = str .. LT.Textf("DailyChallengeInstructionsExample", i, taskTitle, taskDesc)
      if i < #list then
        str = str .. "\n"
      end
    end
  end
  local title = LT.Text("RulesOfPlay")
  local dayLimit = PlayerDataUtils.GetRoleDayExpLimit()
  local ruleTextKey = TaskDataUtils.GetTimeReplaceLanguageKey("DailyChallengeInstructionsV2")
  local detail = LT.Textf(ruleTextKey, PlayerDataUtils.GetRoleData().dayExp or 0, str, dayLimit)
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, detail)
end

function TaskDataUtils.IsTaskTypeHaveReceiveState(taskType)
  local taskList = TaskDataUtils.GetTaskListByType(taskType, true)
  for _, taskData in ipairs(taskList or {}) do
    if taskData.state == cd.TaskState.Receive then
      return true
    end
  end
end

return TaskDataUtils
