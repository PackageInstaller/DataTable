local ActivityDataUtils = {}

function ActivityDataUtils.ResetAll()
  DataCenter.activityData.activityDatas = {}
end

function ActivityDataUtils.OpenActivityMainPanel(targetActivityTid, params, isTrialInto)
  UIManager.Instance:Reopen(Urls.ActivityMainPanel, {
    targetActivityTid = targetActivityTid,
    params = params,
    isTrialInto = isTrialInto
  })
end

function ActivityDataUtils.ReqActivityData()
  ProtoManager.Instance:ReqServer("GameRequest", "GetActivityData", function(data)
    for tid, activityData in pairs(data) do
      Logger.Info("server activity data =>", tid, table.tostring(activityData.base))
    end
    ActivityDataUtils.UpdateActivityData(data)
    PopupQueManager.Instance:OnActivityChange()
  end)
end

function ActivityDataUtils.OnDayRefresh()
  local activityDatas = DataCenter.activityData.activityDatas
  if not activityDatas then
    return
  end
  for tid, acData in pairs(activityDatas) do
    local acCfg = DT.Activity[tid] or {}
    if acCfg.ActivityType == ActivityDefine.ActivityType.SevenDayLogin and acCfg.ActivitySystemType == ActivityDefine.ActivitySystemType.LoginByMonthActivity and acData.loginDaily then
      acData.loginDaily = acData.loginDaily + 1
      if acData.prize then
        acData.prize[acData.loginDaily] = CommonDefine.CommonState.GainPrize
      end
    end
  end
end

function ActivityDataUtils.ReqOnGainAllPrize(activityTid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainAllPrize", function()
    if callback then
      callback()
    end
  end, function()
  end, activityTid)
end

function ActivityDataUtils.CheckNeedReqActivityData()
  local isNeedReq = false
  if isNeedReq then
    ActivityDataUtils.ReqActivityData()
  end
end

function ActivityDataUtils.GetActivityData(tid)
  return DataCenter.activityData.activityDatas[tid]
end

function ActivityDataUtils.GetActivityDefine(tid)
  local config = ActivityDataUtils.GetConfig(tid)
  if not config then
    return nil
  end
  local activityType = config.ActivityType
  local activityDefine = ActivityDefine.ActivityCompClsInfo[activityType]
  return activityDefine
end

function ActivityDataUtils.GetActivityCompInfoByTid(tid)
  if not tid then
    return nil
  end
  local activityClsInfo = ActivityDefine.GetActivityCompInfo(tid)
  local config = ActivityDataUtils.GetConfig(tid)
  if not activityClsInfo or not config then
    return activityClsInfo
  end
  if activityClsInfo[config.ActivitySystemType] then
    return activityClsInfo[config.ActivitySystemType]
  end
  return activityClsInfo
end

function ActivityDataUtils.UpdateActivityData(datas)
  local updateRedMap = {}
  for tid, activityData in pairs(datas) do
    ActivityDataUtils.MergeActivityData(tid, activityData)
    updateRedMap[tid] = activityData
  end
  ActivityRedUtils.UpdateActivityRed(updateRedMap)
end

function ActivityDataUtils.MergeActivityData(tid, newActData)
  if newActData.taskList then
    for taskId, taskData in pairs(newActData.taskList) do
      TaskDataUtils.UpdateTask(taskData)
    end
  end
  local activityCfg = ActivityDataUtils.GetConfig(tid)
  if activityCfg and activityCfg.ActivityType == ActivityDefine.ActivityType.PVPReverseRoundActivity then
    ActivityDataUtils.FilterReverseRoundTask(newActData)
  end
  local preActData = DataCenter.activityData.activityDatas[tid] or {}
  ActivityDataUtils.MergeTaskList(preActData, newActData)
  for k, v in pairs(newActData.base) do
    assert(not newActData[k], string.format("activityData 和 base数据中存在重复的key: %s, %s", k, table.tostring(newActData)))
    newActData[k] = v
  end
  newActData.activityTid = tid
  newActData.base.activityTid = tid
  newActData.startTime = newActData.startTime or 0
  newActData.endTime = newActData.endTime or 0
  newActData.finishTime = newActData.finishTime or 0
  DataCenter.activityData.activityDatas[tid] = newActData
end

function ActivityDataUtils.MergeTaskList(preActData, newActData)
  local preTaskList = preActData.taskList or {}
  for taskId, taskData in pairs(table.clone(newActData.taskList or {})) do
    local preTaskData = preTaskList[taskId]
    if preTaskData then
      table.clear(preTaskData)
      for k, v in pairs(taskData) do
        preTaskData[k] = v
      end
      newActData.taskList[taskId] = preTaskData
    end
  end
end

function ActivityDataUtils.IsUnlockActivity()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Activity, 0)
  return unlock
end

function ActivityDataUtils.FilterReverseRoundTask(activityData)
  local taskList = activityData.taskList or {}
  local deleteList = {}
  for taskId, taskData in pairs(taskList) do
    local taskCfg = TaskDataUtils.GetConfig(taskId) or {}
    local targetTid = taskCfg.UnlockCondPara and taskCfg.UnlockCondPara[1] or 0
    local awakerCfg = DT.AwakerConfig[targetTid]
    if awakerCfg then
      if not AwakerDataUtils.HasOwnedAwaker(targetTid) then
        table.insert(deleteList, taskId)
      end
    elseif DT.Item[targetTid] and ItemDataUtils.GetItemNum(targetTid) <= 0 then
      table.insert(deleteList, taskId)
    end
  end
  for _, taskId in ipairs(deleteList) do
    taskList[taskId] = nil
  end
end

function ActivityDataUtils.GetPreOrderCanGetTaskList(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  if not config or not activityData then
    return {}
  end
  local taskList = config.ActivityPara1 or {}
  local taskTimeList = string.split(config.ActivityPara2 or "", ",")
  local taskDataList = {}
  for idx, taskTid in ipairs(taskList) do
    local isCanGet = TaskDataUtils.IsTaskCanReward(taskTid)
    local taskTime = tonumber(taskTimeList[idx]) or 0
    if isCanGet and taskTime <= TimeUtils.GetServerTime() then
      table.insert(taskDataList, taskTid)
    end
  end
  local bookingTaskList = config.ActivityPara5 or {}
  for i = 2, #bookingTaskList do
    local taskTid = bookingTaskList[i]
    local isCanGet = TaskDataUtils.IsTaskCanReward(taskTid)
    if isCanGet then
      table.insert(taskDataList, taskTid)
    end
  end
  return taskDataList
end

function ActivityDataUtils.CheckActivityDataCondition(activityData)
  local activityBaseData = activityData.base
  if not activityData or not activityBaseData then
    return false
  end
  local activityTid = activityBaseData.tid
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return false
  end
  if config.ActivitySystemType == ActivityDefine.ActivitySystemType.BattleTeachingActivity and ActivityDataUtils.CheckActivityTaskAllDone(activityTid) then
    return false
  end
  if not config.ActivityLevelCondition and not config.ActivityStageCondition then
    return true
  end
  local reachLevel = true
  if config.ActivityLevelCondition then
    reachLevel = PlayerDataUtils.GetLevel() >= config.ActivityLevelCondition
    activityData.reachLevel = reachLevel
  end
  local reachStage = true
  if config.ActivityStageCondition then
    local stageData = MainCopyDataUtils.GetStageData(config.ActivityStageCondition)
    reachStage = stageData and stageData.firstRewardDraw
    activityData.reachStage = reachStage
  end
  local open = reachLevel and reachStage
  return open
end

local NeedRefreshDRoleActivityTids = {
  DT.GetConstant("DiamondRechargeActivity")
}

function ActivityDataUtils.ReqGainAward(activityTid, prizeTid, extraParams, callback, isIgnoreCheckEnergy)
  if not activityTid or not prizeTid then
    return
  end
  if not isIgnoreCheckEnergy and TaskDataUtils.GetConfig(prizeTid) and GetEnergyCheckUtils.TaskConfigCheckEnergyOver(TaskDataUtils.GetConfig(prizeTid)) then
    GetEnergyCheckUtils.TipsShow(function()
      ActivityDataUtils.ReqGainAward(activityTid, prizeTid, extraParams, callback, true)
    end)
    return
  end
  local pickItems = extraParams and extraParams.pickItems or {}
  ProtoManager.Instance:ReqServer("GameRequest", "GainActivityPrize", function(data)
    local taskData = TaskDataUtils.GetTaskData(prizeTid)
    if taskData then
      local oldState = taskData.state
      TaskDataUtils.OnTaskStateChanged(prizeTid, oldState, cd.TaskCommonState.Finish)
      taskData.state = cd.TaskCommonState.Finish
    end
    if callback then
      callback(data)
    end
    if table.contains(NeedRefreshDRoleActivityTids, activityTid) then
      PlayerDataUtils.ReqOnRoleOpen()
    end
    EventMgr.Instance.OnActivityTaskComplete:Dispatch(activityTid)
  end, function(data)
  end, activityTid, prizeTid, pickItems)
end

function ActivityDataUtils.ReqGainAwardList(activityTid, taskTidList, callback, isIgnoreCheckEnergy)
  if not (activityTid and taskTidList) or not table.next(taskTidList) then
    return
  end
  if not isIgnoreCheckEnergy then
    for _, taskTid in ipairs(taskTidList) do
      if GetEnergyCheckUtils.TaskConfigCheckEnergyOver(TaskDataUtils.GetConfig(taskTid)) then
        GetEnergyCheckUtils.TipsShow(function()
          ActivityDataUtils.ReqGainAwardList(activityTid, taskTid, callback, true)
        end)
        return
      end
    end
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnMultiGainPrize", function(data)
    for _, taskTid in ipairs(taskTidList) do
      local taskData = TaskDataUtils.GetTaskData(taskTid)
      if taskData then
        local oldState = taskData.state
        TaskDataUtils.OnTaskStateChanged(taskTid, oldState, cd.TaskCommonState.Finish)
        taskData.state = cd.TaskCommonState.Finish
      end
    end
    if callback then
      callback(data)
    end
    if table.contains(NeedRefreshDRoleActivityTids, activityTid) then
      PlayerDataUtils.ReqOnRoleOpen()
    end
    EventMgr.Instance.OnActivityTaskComplete:Dispatch(activityTid)
  end, function(data)
  end, activityTid, taskTidList)
end

function ActivityDataUtils.CheckCondition(activityData)
  local activityTid = activityData.tid
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return false
  end
  if not config.ActivityLevelCondition and not config.ActivityStageCondition then
    return true
  end
  local reachLevel = true
  if config.ActivityLevelCondition then
    reachLevel = PlayerDataUtils.GetLevel() >= config.ActivityLevelCondition
    activityData.reachLevel = reachLevel
  end
  local reachStage = true
  if config.ActivityStageCondition then
    local stageData = MainCopyDataUtils.GetStageData(config.ActivityStageCondition)
    reachStage = stageData and stageData.firstRewardDraw
    activityData.reachStage = reachStage
  end
  local open = reachLevel and reachStage
  return open
end

function ActivityDataUtils.IsActivityOpen(activityTid)
  local activityCfg = ActivityDataUtils.GetConfig(activityTid)
  if not activityCfg then
    return false
  end
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  if activityData and ActivityDataUtils.ShouldHideTwoAndAHalfAnniversaryRaidNeverJoined(activityData) then
    return false
  end
  local endTime = activityData and activityData.base.endTime or math.maxinteger
  if 0 ~= endTime and endTime < TimeUtils.GetServerTime() then
    return false
  end
  local hideTs = activityData and activityData.hideTs
  if hideTs and 0 ~= hideTs and hideTs < TimeUtils.GetServerTime() then
    return false
  end
  local activityState = activityData and activityData.base and activityData.base.state
  if activityState == ActivityDefine.ActivityState.Running or activityState == ActivityDefine.ActivityState.Ready then
    return true
  end
  if activityState == ActivityDefine.ActivityState.NotOpen or activityState == ActivityDefine.ActivityState.Finish then
    return false
  end
  if activityCfg.ActivitySystemType == ActivityDefine.ActivitySystemType.ReturnEventGroup then
    return false
  end
  local isConditionOk = ActivityDataUtils.CheckCondition({tid = activityTid})
  local openTime = activityCfg.ActivityStartTime or math.maxinteger
  local isInOpenTime = openTime and openTime <= TimeUtils.GetServerTime()
  local closeTime = activityCfg.ActivityEndTime or 0
  local isInCloseTime = closeTime and closeTime >= TimeUtils.GetServerTime()
  return isConditionOk and isInOpenTime and not isInCloseTime
end

function ActivityDataUtils.GetConfig(activityTid)
  if not activityTid then
    Logger.Error("找不到活动配置:", activityTid, debug.traceback())
    return
  end
  return DT.Activity[activityTid]
end

function ActivityDataUtils.GetConfigByField(field, activityTid)
  local cfg = ActivityDataUtils.GetConfig(activityTid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function ActivityDataUtils.GetType(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  return config and config.ActivityType
end

function ActivityDataUtils.ShouldHideTwoAndAHalfAnniversaryRaidNeverJoined(activityData)
  if not activityData then
    return false
  end
  local activityTid = not activityData.activityTid and activityData.base and activityData.base.tid
  if not activityTid then
    return false
  end
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config or config.ActivityType ~= ActivityDefine.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity then
    return false
  end
  local isHide = false
  local cfgDeadline = config.ActivityEndTime or 0
  local now = TimeUtils.GetServerTime()
  if cfgDeadline >= now then
    return isHide
  else
    local joinKey = "ActivityClientJoinTs_" .. activityTid
    local stats = activityData.statistics
    local joinTs = stats and stats[joinKey] or 0
    local isJoined = 0 ~= joinTs and cfgDeadline > joinTs
    if not isJoined then
      isHide = true
    else
      local serverEndTime = activityData.endTime or 0
      if serverEndTime > 0 and now > serverEndTime then
        isHide = true
      end
    end
  end
  return isHide
end

function ActivityDataUtils.GetActivityFeatureByType(activityType)
  local info = ActivityDefine.ActivityCompClsInfo[activityType]
  return info and info.avgFeatureId
end

function ActivityDataUtils.LoopActivityParams(activityTid, loopFunc)
  local activityCfg = DT.Activity[activityTid] or {}
  local para2List = string.split(activityCfg.ActivityPara2 or "", ",")
  for i, v in ipairs(para2List) do
    para2List[i] = tonumber(v)
  end
  local ParaList = {
    activityCfg.ActivityPara1 or {},
    para2List,
    activityCfg.ActivityPara3 or {},
    activityCfg.ActivityPara4 or {},
    activityCfg.ActivityPara5 or {}
  }
  for _, paras in ipairs(ParaList) do
    for _, id in ipairs(paras or {}) do
      if loopFunc(id) then
        return
      end
    end
  end
end

function ActivityDataUtils.GetShopList(activityId)
  local shopList = {}
  ActivityDataUtils.LoopActivityParams(activityId, function(id)
    if DT.ShopType[id] then
      table.insert(shopList, id)
    end
  end)
  return shopList
end

function ActivityDataUtils.GetLotteryList(activityId)
  local lotteryList = {}
  ActivityDataUtils.LoopActivityParams(activityId, function(id)
    if DT.Lottery[id] then
      table.insert(lotteryList, id)
    end
  end)
  return lotteryList
end

function ActivityDataUtils.GetTaskList(activityId)
  local taskList = {}
  ActivityDataUtils.LoopActivityParams(activityId, function(id)
    if DT.Task[id] then
      table.insert(taskList, id)
    end
  end)
  return taskList
end

function ActivityDataUtils.CheckActivityTaskAllDone(activityTid)
  local taskTidList = ActivityDataUtils.GetTaskList(activityTid)
  for _, taskTid in ipairs(taskTidList) do
    local taskData = TaskDataUtils.GetTaskData(taskTid)
    if taskData.state ~= CommonDefine.TaskState.Done then
      return false
    end
  end
  return true
end

function ActivityDataUtils.GetTaskDataListFormActivityData(activityData)
  local taskListActivityData = activityData
  local taskList = {}
  if taskListActivityData and taskListActivityData.taskList then
    for _, taskData in pairs(taskListActivityData.taskList) do
      if taskData then
        table.insert(taskList, taskData)
      end
    end
  end
  return taskList
end

function ActivityDataUtils.GetAtitivtyTidByType(activityType)
  if not activityType or type(activityType) ~= "string" then
    return nil
  end
  for _, cfg in pairs(DT.Activity) do
    if cfg.ActivityType == activityType then
      return cfg.ID
    end
  end
  return nil
end

function ActivityDataUtils.GetSystemType(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  return config and config.ActivitySystemType
end

function ActivityDataUtils.IsReturnActivity(activityTid)
  local activitySystemType = ActivityDataUtils.GetSystemType(activityTid)
  return activitySystemType == ActivityDefine.ActivitySystemType.ReturnEvent
end

ActivityDataUtils.ActivityMarkTitle = {
  [ActivityDefine.ActivitySystemType.ReturnEvent] = LT.Text("ActivityMarkReturn"),
  [ActivityDefine.ActivitySystemType.HalfAnniversaryCelebrationActivity] = LT.Text("ActivityMarkHalfAYear"),
  [ActivityDefine.ActivitySystemType.YearAndAHalfCelebrationActivity] = LT.Text("ActivityMarkOneAndAHalfYears"),
  [ActivityDefine.ActivitySystemType.SecondAnniversaryCelebrationActivity] = LT.Text("ActivityMarkTwoYears"),
  [ActivityDefine.ActivitySystemType.MouchetteCrossoverActivity] = LT.Text("ActivityMarkMouchetteCrossover")
}

function ActivityDataUtils.GetActivityMarkTitle(activityTid)
  local activitySystemType = ActivityDataUtils.GetSystemType(activityTid)
  return ActivityDataUtils.ActivityMarkTitle[activitySystemType]
end

function ActivityDataUtils.GetActivityName(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  do return LT.Text end
  return LT.Text, config.ActivityName
end

function ActivityDataUtils.GetUnlockConditionDesc(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  do return LT.Text end
  return LT.Text, config.UnlockConditionExplanation
end

function ActivityDataUtils.GetActivityPlot(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  do return LT.Text end
  return LT.Text, config.ActivityPlot
end

function ActivityDataUtils.GetTabImage(activityTid)
  local activityCfg = ActivityDataUtils.GetConfig(activityTid)
  if not activityCfg then
    return
  end
  local tagPic = activityCfg.TagPicture
  if tagPic and string.contains(tagPic, ";") then
    local imgPathList = string.split(tagPic, ";")
    if PlayerDataUtils.IsMale() then
      return imgPathList[1]
    end
    return imgPathList[2]
  end
  return activityCfg.TagPicture
end

function ActivityDataUtils.GetBgImage(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  local pic = config.ActivityPicture
  if pic and string.contains(pic, ";") then
    local picList = string.split(pic, ";")
    if PlayerDataUtils.IsMale() then
      return picList[1]
    end
    return picList[2]
  end
  return config.ActivityPicture
end

function ActivityDataUtils.GetVXPrfab(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  local vxPrefab = config.VXPrefab
  if vxPrefab then
    return vxPrefab
  end
  return ""
end

function ActivityDataUtils.GetTimeType(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  return config.ActivityTimeType
end

function ActivityDataUtils.GetTimeParam(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  return config.ActivityTimePara
end

function ActivityDataUtils.GetLeftTime(activityData)
  if not activityData then
    return 0
  end
  local timeType = ActivityDataUtils.GetTimeType(activityData.activityTid)
  if not timeType then
    return 0
  end
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    return 0
  end
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  if not activityData.endTime or activityData.endTime <= 0 then
    return
  end
  local endTime = TimeUtils.GetFixedTimestamp(activityData.endTime)
  if not endTime or 0 == endTime then
    return
  end
  local leftTime = endTime - now
  return leftTime
end

function ActivityDataUtils.GetRuleTitle(activityTid)
  do return LT.Text end
  return LT.Text, "ActivityDescriptionTitle"
end

function ActivityDataUtils.GetRuleContent(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config or not config.ActivityTips then
    return
  end
  if ActivityDataUtils.ActivityId2GetRuleFuncMap[activityTid] and ActivityDataUtils.ActivityId2GetRuleFuncMap[activityTid].GetContentFunc then
    do return ActivityDataUtils.ActivityId2GetRuleFuncMap[activityTid].GetContentFunc end
    return ActivityDataUtils.ActivityId2GetRuleFuncMap[activityTid].GetContentFunc, config.ActivityTips
  end
  do return LT.Text end
  return LT.Text, config.ActivityTips
end

function ActivityDataUtils.GetPrizeStateText(state)
  if not state then
    return
  end
  local stateTextTable = {
    [CommonDefine.CommonState.GainPrize] = "ActivityRewardNotReceived",
    [CommonDefine.CommonState.Finish] = "ActivityRewardReceived"
  }
  return stateTextTable[state]
end

function ActivityDataUtils.GetSevenLoginAwards(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return
  end
  return config.ActivityPara1
end

function ActivityDataUtils.GetDoubleOutputTotalCount(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return 0
  end
  return config.ActivityPara2 or 0
end

function ActivityDataUtils.GetDoubleOutputBonus(activityTid)
  local isUnlimited = ActivityDataUtils.CheckDoubleOutputTotalCountUnlimited(activityTid)
  return isUnlimited and 50 or 100
end

function ActivityDataUtils.GetDoubleOutputProgressShowText(stageGroupId)
  local activityData = ActivityManager.Instance:GetMultiDropActivity(stageGroupId)
  if not activityData then
    return ""
  end
  local activityTid = activityData.activityTid
  local isUnlimited = ActivityDataUtils.CheckDoubleOutputTotalCountUnlimited(activityTid)
  local bonusNum = ActivityDataUtils.GetDoubleOutputBonus(activityTid)
  local head = LT.Textf("DoubleOutputActivityTimesHead", bonusNum)
  if isUnlimited then
    return head .. " " .. LT.Text("ActivityExtraDropTimes")
  end
  local doubleOutputData = activityData
  local leftCount = doubleOutputData.count or 0
  local totalCount = ActivityDataUtils.GetDoubleOutputTotalCount(activityTid)
  if 0 == leftCount then
    do return LT.Text end
    return LT.Text, "DoubleOutputActivityTimesRunOut", nil, nil, nil, nil
  end
  return head .. " " .. LT.Textf("DoubleOutputActivityRemainTimes", leftCount, totalCount)
end

function ActivityDataUtils.CheckDoubleOutputTotalCountUnlimited(activityTid)
  local totalCount = ActivityDataUtils.GetDoubleOutputTotalCount(activityTid)
  local limited = 99
  return totalCount > limited
end

function ActivityDataUtils.IsActivityAlwaysShow(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config then
    return false
  end
  return config.ActivityDisplay == ActivityDefine.ActivityDisplayType.AlwaysShow
end

function ActivityDataUtils.GetSpecialTaskListActivityAwardTaskTid(activityTid)
  if not activityTid then
    return
  end
  local config = ActivityDataUtils.GetConfig(activityTid)
  return config and config.ActivityPara3 and config.ActivityPara3[1]
end

function ActivityDataUtils.GetProduceTid(activityTid)
  local produceTid
  ActivityDataUtils.LoopActivityParams(activityTid, function(id)
    if DT.Produce[id] then
      produceTid = id
      return true
    end
  end)
  return produceTid
end

function ActivityDataUtils.CheckFinish_SevenDayLoginActivity(activityData)
  if not activityData then
    return false
  end
  local awardList = ActivityDataUtils.GetSevenLoginAwards(activityData.activityTid)
  if not awardList or not activityData.prize then
    return false
  end
  local awardIndex = 1
  local prizeStateDatas = activityData.prize
  local FinishState = CommonDefine.TaskCommonState.Finish
  local hasFinish = true
  for i = 1, #awardList, 2 do
    local tid, num = awardList[i], awardList[i + 1]
    if tid and num then
      local prizeState = prizeStateDatas[awardIndex]
      if not prizeState or prizeState ~= FinishState then
        hasFinish = false
        break
      end
      awardIndex = awardIndex + 1
    end
  end
  return hasFinish
end

function ActivityDataUtils.CheckFinish_TaskListActivity(activityData)
  if not activityData then
    return false
  end
  local taskList = activityData.taskList
  if not taskList then
    return false
  end
  local hasFinish = true
  local FinishState = CommonDefine.TaskCommonState.Finish
  for _, taskData in pairs(taskList) do
    if not taskData or taskData.state ~= FinishState then
      hasFinish = false
      break
    end
  end
  return hasFinish
end

function ActivityDataUtils.CheckFinishCount_TaskListActivity(activityData)
  if not activityData then
    return 0, 0
  end
  local taskList = activityData.taskList
  if not taskList then
    return 0, 0
  end
  local finishCount = 0
  local totalCount = 0
  local FinishState = CommonDefine.TaskCommonState.Finish
  local tmpList = {}
  for _, taskData in pairs(taskList) do
    if DT.Task[taskData.tid].BelongTaskGroup then
      if taskData and taskData.state == FinishState then
        finishCount = finishCount + 1
      end
      totalCount = totalCount + 1
      table.insert(tmpList, {
        tid = taskData.tid,
        state = taskData.state,
        desc = DT.Task[taskData.tid].Desc
      })
    end
  end
  return finishCount, totalCount
end

function ActivityDataUtils.CheckFinish_AwakerTrialActivity(activityData)
  if not activityData then
    return false
  end
  local stageAwardStateMap = activityData.stageList
  if not stageAwardStateMap then
    return false
  end
  local activityConfig = ActivityDataUtils.GetConfig(activityData.activityTid)
  local stageList = activityConfig and activityConfig.ActivityPara1
  if not stageList then
    return false
  end
  local hasFinish = true
  local FinishState = CommonDefine.TaskCommonState.Finish
  for _, stageTid in ipairs(stageList) do
    local stageConfig = CopyDataUtils.GetStageConfig(stageTid)
    if stageConfig and stageConfig.TrialActivityRewards and #stageConfig.TrialActivityRewards > 0 then
      local state = stageAwardStateMap[stageTid]
      if not state or state ~= FinishState then
        hasFinish = false
        break
      end
    end
  end
  return hasFinish
end

function ActivityDataUtils.CheckFinish_SubplotActivity(activityData)
  if not activityData then
    return false
  end
  local activityConfig = ActivityDataUtils.GetConfig(activityData.activityTid)
  if not (activityConfig and activityConfig.ActivityPara2) or not activityConfig.ActivityPara3 then
    return false
  end
  local taskStateMap = activityData.taskList
  if not taskStateMap then
    return false
  end
  local hasFinish = true
  local FinishState = CommonDefine.TaskCommonState.Finish
  local specificTaskTid = activityConfig.ActivityPara2
  local specificTaskData = specificTaskTid and taskStateMap[specificTaskTid]
  if not (specificTaskData and specificTaskData.state) or specificTaskData.state ~= FinishState then
    hasFinish = false
  end
  if hasFinish then
    local taskTidList = activityConfig.ActivityPara3
    if #taskTidList <= 0 then
      hasFinish = false
    else
      for _, taskTid in ipairs(taskTidList) do
        local taskData = taskStateMap[taskTid]
        if not taskData or taskData.state ~= FinishState then
          hasFinish = false
          break
        end
      end
    end
  end
  return hasFinish
end

function ActivityDataUtils.CheckFinish_DoubleExperienceActivity(activityData)
  if not activityData then
    return false
  end
  local dayExp = PlayerDataUtils.GetRoleData().dayExp or 0
  local dayLimit = PlayerDataUtils.GetRoleDayExpLimit()
  return dayExp >= dayLimit
end

function ActivityDataUtils.CheckFinish_SignReceiveAwakeActivity(activityData)
  if not activityData then
    return false
  end
  local activityConfig = ActivityDataUtils.GetConfig(activityData.activityTid)
  if not activityConfig then
    return true
  end
  return activityConfig.ActivityPara2 - table.length(activityData.selectedReward) <= 0
end

function ActivityDataUtils.CheckActivityFinishState(activityTid)
  local activityType = ActivityDataUtils.GetType(activityTid)
  if not activityType then
    return false
  end
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  if not activityData then
    return false
  end
  local ActivityType = ActivityDefine.ActivityType
  local funcMap = {
    [ActivityType.SevenDayLogin] = ActivityDataUtils.CheckFinish_SevenDayLoginActivity,
    [ActivityType.TaskList] = ActivityDataUtils.CheckFinish_TaskListActivity,
    [ActivityType.AwakerTrial] = ActivityDataUtils.CheckFinish_AwakerTrialActivity,
    [ActivityType.SubPlot] = ActivityDataUtils.CheckFinish_SubplotActivity,
    [ActivityType.DoubleExp] = ActivityDataUtils.CheckFinish_DoubleExperienceActivity,
    [ActivityType.SpecialTaskList] = ActivityDataUtils.CheckFinish_TaskListActivity,
    [ActivityType.SignReceiveAnyWeaponActivity] = ActivityDataUtils.CheckFinish_SignReceiveAwakeActivity,
    [ActivityType.SignReceiveAwake] = ActivityDataUtils.CheckFinish_SignReceiveAwakeActivity,
    [ActivityType.FiveDaySign] = ActivityDataUtils.CheckFinish_SevenDayLoginActivity,
    [ActivityType.SignReceiveWeapon] = ActivityDataUtils.CheckFinish_TaskListActivity,
    [ActivityType.TwoAndAHalfAnniversaryRechargeActiviity] = ActivityDataUtils.CheckFinish_TaskListActivity
  }
  local checkFunc = funcMap[activityType]
  local result = checkFunc and checkFunc(activityData)
  return result
end

local CanBuildTaskGroupTypes = {
  ActivityDefine.ActivityType.ShopActivity
}
local CanBuildTaskGroupSystemTypes = {
  ActivityDefine.ActivitySystemType.ReturnEvent
}
ActivityDataUtils.ActivityTid2TaskGroupData = {}

function ActivityDataUtils.GetTaskGroupDatasByCfg(activityTid)
  local cfg = ActivityDataUtils.GetConfig(activityTid)
  if not cfg then
    return nil
  end
  if not table.contains(CanBuildTaskGroupTypes, cfg.ActivityType) or not table.contains(CanBuildTaskGroupSystemTypes, cfg.ActivitySystemType) then
    return nil
  end
  if ActivityDataUtils.ActivityTid2TaskGroupData[activityTid] then
    return ActivityDataUtils.ActivityTid2TaskGroupData[activityTid]
  end
  local rst = {}
  local taskGroupOpenDays = cfg.ActivityPara1
  local activityStartTs = ActivityManager.Instance:GetActivityDataByField("startTime", activityTid) or 0
  local iterIdx = 1
  for openDay, taskGroupTid, _, idx in table.iteraDouble(taskGroupOpenDays) do
    local openTs = activityStartTs
    if 0 ~= openDay then
      local taskStartTs = activityStartTs + math.max(openDay - 1, 0) * CommonDefine.OneDaySecond
      openTs = TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp(nil, taskStartTs)
    end
    local taskGroupData = ActivityDataUtils.CreateActivityTaskGroupData(taskGroupTid, openTs, {})
    rst[iterIdx] = taskGroupData
    iterIdx = iterIdx + 1
  end
  ActivityDataUtils.ActivityTid2TaskGroupData[activityTid] = rst
  return rst
end

function ActivityDataUtils.CreateActivityTaskGroupData(tid, openTs, taskDataMap)
  return {
    tid = tid or 0,
    openTs = openTs or 0,
    taskDataMap = taskDataMap or {}
  }
end

function ActivityDataUtils.IsActivityTaskGroupOpen(taskGroupTid, activityTid)
  local isOpen = false
  local now = TimeUtils.GetServerTime()
  local taskGroupDatas = ActivityDataUtils.GetTaskGroupDatasByCfg(activityTid)
  for _, taskGroupData in pairs(taskGroupDatas) do
    if taskGroupData.tid == taskGroupTid and now >= taskGroupData.openTs then
      isOpen = true
      break
    end
  end
  return isOpen
end

function ActivityDataUtils.IsActivityClosed(activityTid)
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  if not activityData or not activityData.base then
    local activityCfg = ActivityDataUtils.GetConfig(activityTid)
    if activityCfg and activityCfg.ActivityTimeType == ActivityDefine.ActivityTimeType.FixedTime then
      return activityCfg.ActivityEndTime < TimeUtils.GetServerTime()
    end
    return false
  end
  return activityData.base.state == ActivityDefine.ActivityState.Finish
end

function ActivityDataUtils.GetActivityOpenTime(activityTid)
  local activityCfg = ActivityDataUtils.GetConfig(activityTid)
  if not activityCfg then
    return 0
  end
  return activityCfg.ActivityStartTime
end

function ActivityDataUtils.GetActivityTaskDataListByCompleteCond(activityData, targetCompleteCond)
  local rst = {}
  for tid, _ in pairs(activityData.taskList or {}) do
    if TaskCfgUtils.GetCfgField("CompleteCond", tid) == targetCompleteCond then
      local taskData = TaskDataUtils.GetTaskData(tid)
      table.insert(rst, taskData)
    end
  end
  return rst
end

function ActivityDataUtils.IsHaveLimitTimeReward(activityId)
  local activityCfg = ActivityDataUtils.GetConfig(activityId)
  if not activityCfg then
    return
  end
  local taskIdlist = table.clone(activityCfg.ActivityPara1)
  for _, taskId in ipairs(taskIdlist) do
    local taskData = TaskDataUtils.GetTaskData(taskId) or {}
    if taskData.state == cd.TaskState.UnDone or taskData.state == cd.TaskState.Doing then
      return
    end
    if taskData.state == cd.TaskState.Receive then
      return true
    end
  end
end

function ActivityDataUtils.GetShowingPermanentActivityTidList()
  local rst = {}
  local permanentActivityTidList = DT.GetOriginalConstant("PermanentActivity")
  for _, activityTid in ipairs(permanentActivityTidList) do
    if ActivityManager.Instance:IsActivityOpenedByTid(activityTid) then
    else
      table.insert(rst, activityTid)
    end
  end
  return rst
end

function ActivityDataUtils.GetTaskTidList(activityTid)
  local rst = {}
  local activityData = ActivityManager.Instance:GetActivityData(activityTid)
  if not activityData then
    return rst
  end
  local taskList = activityData.taskList
  for tid, _ in pairs(taskList) do
    table.insert(rst, tid)
  end
  return rst
end

function ActivityDataUtils.GetGamePassportTaskList(activityTid)
  local actCfg = ActivityDataUtils.GetConfig(activityTid)
  local normalTasks = actCfg.ActivityPara1
  local para2 = string.split(actCfg.ActivityPara2, ",")
  local paidTasks = {}
  for k, v in ipairs(para2 or {}) do
    paidTasks[k] = tonumber(v)
  end
  local taskList = {}
  for i = 1, #normalTasks do
    taskList[i] = {
      normalTasks[i],
      paidTasks[i]
    }
  end
  return taskList
end

function ActivityDataUtils.CheckPassportPassportTaskListEnergyIsOverMax(activityTid, isBoughtPlus)
  local taskList = ActivityDataUtils.GetGamePassportTaskList(activityTid)
  if not taskList then
    return false
  end
  local energyItemId = DT.GetConstant("EnergyItemTid")
  local itemCount = 0
  for _, taskInfo in ipairs(taskList) do
    local normalTask = taskInfo[1]
    local paidTask = taskInfo[2]
    itemCount = itemCount + ActivityDataUtils._GetTaskEnergyCount(normalTask, false, energyItemId, isBoughtPlus)
    itemCount = itemCount + ActivityDataUtils._GetTaskEnergyCount(paidTask, true, energyItemId, isBoughtPlus)
  end
  do return GetEnergyCheckUtils.EnergyIsOverMax end
  return GetEnergyCheckUtils.EnergyIsOverMax, itemCount, ipairs(taskList)
end

function ActivityDataUtils._GetTaskEnergyCount(taskId, isPlus, energyItemId, isBoughtPlus)
  if isPlus and not isBoughtPlus then
    return 0
  end
  if not TaskDataUtils.IsTaskCanReward(taskId) then
    return 0
  end
  local taskCfg = TaskDataUtils.GetTaskConfigByTid(taskId)
  if not taskCfg then
    return 0
  end
  local reward = taskCfg.CompleteAward or {}
  if isPlus then
    reward = taskCfg.ExtraAward or {}
  end
  local count = 0
  for index = 1, #reward, 2 do
    local itemId, itemCount = reward[index], reward[index + 1]
    if itemId == energyItemId then
      count = count + itemCount
    end
  end
  return count
end

function ActivityDataUtils.GetDiamondRechargeRuleTitle()
  do return LT.Text end
  return LT.Text, "PlayerExpRuleTitle"
end

local DiamondRechargeActivityTid = DT.GetConstant("DiamondRechargeActivity")

function ActivityDataUtils.GetDiamondRechargeRuleContent(content)
  local oriExp = PlayerDataUtils.GetDRoleByField("originExp") or 0
  local bonusExp = PlayerDataUtils.GetDRoleByField("bonusExp") or 0
  local expBonus = PlayerDataUtils.GetExpBonusPercent()
  do return LT.Textf, content, oriExp, bonusExp end
  return LT.Textf, content, oriExp, bonusExp, expBonus
end

ActivityDataUtils.ActivityId2GetRuleFuncMap = {
  [DiamondRechargeActivityTid] = {
    GetContentFunc = ActivityDataUtils.GetDiamondRechargeRuleContent,
    GetTitleFunc = ActivityDataUtils.GetDiamondRechargeRuleTitle
  }
}

function ActivityDataUtils.IsMainPanelBannerActivityTimeOpen(activityData)
  if not activityData then
    return false
  end
  local activityCfg = ActivityDataUtils.GetConfig(activityData.activityTid)
  if activityCfg and activityCfg.ActivityType == ActivityDefine.ActivityType.TwoAndAHalfAnniversaryRAIDActiviity then
    local now = TimeUtils.GetServerTime()
    local hideTs = activityData.base and activityData.base.hideTs or activityData.hideTs or 0
    if hideTs > 0 and now > hideTs then
      return false
    end
    local startTime = activityData.startTime or activityCfg.ActivityStartTime or 0
    if now < startTime then
      return false
    end
    local endTime = activityData.endTime or 0
    return endTime <= 0 or now < endTime
  end
  do return ActivityManager.Instance.IsActivityBannerOpenedAboutTimeType, ActivityManager.Instance end
  return ActivityManager.Instance.IsActivityBannerOpenedAboutTimeType, ActivityManager.Instance, activityData, 0, endTime <= 0 or now < endTime
end

function ActivityDataUtils.GetMainPanelBannerActivityTidList()
  local rst = {}
  local activityDataList = ActivityManager.Instance:GetDisplayActivityList()
  for _, activityData in pairs(activityDataList) do
    if activityData.hasFinish then
    else
      local activityTid = activityData.activityTid
      local activityCfg = ActivityDataUtils.GetConfig(activityTid) or {}
      local activityDisplay = activityCfg.ActivityDisplay or 1
      if not activityCfg.BannerPic or 0 == activityDisplay then
      elseif not ActivityDataUtils.IsMainPanelBannerActivityTimeOpen(activityData) then
      else
        table.insert(rst, activityTid)
      end
    end
  end
  table.sort(rst, function(a, b)
    local aCfg = DT.Activity[a]
    local bCfg = DT.Activity[b]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  return rst
end

return ActivityDataUtils
