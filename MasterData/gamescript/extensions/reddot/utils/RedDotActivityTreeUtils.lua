local ActivityType = ActivityDefine.ActivityType
local RedDotActivityTreeUtils = {}

function RedDotActivityTreeUtils.ShouldUseActivityPara3AsSubplotStageGroupList(activityCfg)
  if not activityCfg or not activityCfg.ActivityPara3 then
    return false
  end
  local para3 = activityCfg.ActivityPara3
  if type(para3) ~= "table" or not table.next(para3) then
    return false
  end
  local sysType = activityCfg.ActivitySystemType
  if sysType == ActivityDefine.ActivitySystemType.ReturnEventGroup or sysType == ActivityDefine.ActivitySystemType.BattlePassActivity then
    return false
  end
  for _, stageGroupTid in ipairs(para3) do
    if not CopyDataUtils.IsValidSubplotStageGroupForRedDot(stageGroupTid) then
      return false
    end
  end
  return true
end

function RedDotActivityTreeUtils.GetAcitivityRedDotTree(args)
  local rstTree
  local activityTid = args.activityTid
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  local activityType = activityCfg.ActivityType
  local redDotTreeFunc = RedDotActivityTreeUtils.ActivityType2RedDotTreeFuncMap[activityType]
  if redDotTreeFunc then
    rstTree = redDotTreeFunc(args)
  else
    rstTree = RedDotSequenceFlow(nil, "通用活动红点")
  end
  local activityClsInfo = ActivityDefine.ActivityCompClsInfo[activityType]
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  local isOpen = ActivityDataUtils.CheckActivityDataCondition(activityData)
  rstTree:AddChild(RedDotActivityRedValidCheckWork(activityTid))
  rstTree:AddChild(RedDotActivitySkinCanGetRewardWork(activityTid))
  rstTree:AddChild(RedDotResonanceUpgradeWork(activityClsInfo and activityClsInfo.resonanceGroup, activityTid))
  if isOpen then
    rstTree:AddChild(RedDotActivityTreeUtils.GetTaskListRedDotTree({activityTid = activityTid}))
    rstTree:AddChild(RedDotTreeUtils.GetActivityStageGroupEntryRedDotTree({activityTid = activityTid}))
    if RedDotActivityTreeUtils.ShouldUseActivityPara3AsSubplotStageGroupList(activityCfg) then
      rstTree:AddChild(RedDotTreeUtils.GetActivitySubplotEntryRedDotTree({
        stageGroupTidList = activityCfg.ActivityPara3,
        activityTid = activityTid
      }))
    end
    rstTree:AddChild(RedDotActivityDonationBoxWork(activityTid))
    rstTree:AddChild(RedDotActivityShopWork(activityTid))
    rstTree:AddChild(RedDotActivityLotteryWork(activityTid))
  end
  return rstTree
end

function RedDotActivityTreeUtils.GetSevenDayLoginRedDotTree(args)
  local activityTid = args.activityTid
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  if activityCfg.ActivitySystemType == ActivityDefine.ActivitySystemType.LoginByMonthActivity then
    local rst = RedDotSequenceFlow(nil, "月签到活动红点")
    rst:AddChild(RedDotLoginByMonthCanGetRewardWork(activityTid))
    return rst
  end
  local rst = RedDotSequenceFlow(nil, "七日签到活动红点")
  rst:AddChild(RedDotTasksCanGetRewardWork({
    activityCfg.ActivityPara3
  }))
  return rst
end

function RedDotActivityTreeUtils.GetDeepSeaInvasionDefensiveRedDotTree(args)
  local activityTid = args.activityTid
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  local rst = RedDotSequenceFlow(nil, "深海入侵防御战活动红点")
  rst:AddChild(RedDotTasksCanGetRewardWork({
    activityCfg.ActivityPara4
  }))
  return rst
end

function RedDotActivityTreeUtils.GetSecondAnniversarySignRedDotTree(args)
  local activityTid = args.activityTid
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  local activityData = ActivityManager.Instance:GetActivityDataByType(ActivityType.SecondAnniversarySign)
  if not activityData then
    return nil
  end
  local rst = RedDotSequenceFlow(nil, "二周年庆典活动红点")
  local targetTaskTidList = {}
  for tid, _ in pairs(activityData.taskList) do
    if TaskCfgUtils.GetCfgField("CompleteCond", tid) ~= TaskDefine.CompleteCond.TaskLoginDays then
    elseif not TaskCfgUtils.GetCfgField("BelongTaskGroup", tid) then
    else
      table.insert(targetTaskTidList, tid)
    end
  end
  table.insert(targetTaskTidList, activityCfg.ActivityPara2)
  rst:AddChild(RedDotTasksCanGetRewardWork(targetTaskTidList))
  return rst
end

function RedDotActivityTreeUtils.GetShopActivityRedDotTree(args)
  local activityTid = args.activityTid
  local taskGroupTidList = {}
  local taskGroupDatas = ActivityDataUtils.GetTaskGroupDatasByCfg(activityTid)
  for _, taskGroupData in pairs(taskGroupDatas) do
    local taskGroupTid = taskGroupData.tid
    table.insert(taskGroupTidList, taskGroupTid)
  end
  local rst = RedDotSequenceFlow(nil, "商店活动红点")
  rst:AddChild(RedDotActivityTaskGroupFirstOpenWork(taskGroupTidList, activityTid))
  return rst
end

function RedDotActivityTreeUtils.GetPreOrderRedDotTree(args)
  local activityTid = args.activityTid
  local rst = RedDotSequenceFlow(nil, "预约活动红点")
  rst:AddChild(RedDotActivityPreOrderWork(activityTid))
  return rst
end

function RedDotActivityTreeUtils.GetWorldBossRedDotTree(args)
  local activityTid = args.activityTid
  local rst = RedDotSequenceFlow(nil, "世界Boss活动红点")
  local stageGroupTidList = ActivityCfgUtils.GetSubBossStageGroupTidList(activityTid)
  rst:AddChild(RedDotStageGroupSvrWork(stageGroupTidList))
  return rst
end

function RedDotActivityTreeUtils.GetWorldBossEntryRedDotTree(args)
  local rst = RedDotSequenceFlow(nil, "世界Boss活动入口红点")
  local cfgActivityPara1 = ActivityCfgUtils.GetCfgField("ActivityPara1", args.activityTid)
  rst:AddChild(RedDotTreeUtils.GetActivitySubplotEntryRedDotTree({
    stageGroupTidList = cfgActivityPara1,
    activityTid = args.activityTid
  }))
  rst:AddChild(RedDotActivityTreeUtils.GetWorldBossRedDotTree(args))
  rst:AddChild(RedDotActivityTreeUtils.GetTwoAnniversaryWorldBossEntryRedDotTree(args))
  return rst
end

function RedDotActivityTreeUtils.GetTwoAnniversaryWorldBossEntryRedDotTree(args)
  local rst = RedDotSequenceFlow(RedDotDefine.DynamicRedDotID.ActivityWorldBossEntry, "二周年世界Boss活动入口红点")
  local activityTid = args.activityTid
  if ActivityManager.Instance:IsActivityFinishedByTid(activityTid) then
    return rst
  end
  local stageGroupTidList = ActivityCfgUtils.GetCfgField("ActivityPara1", activityTid)
  rst:AddChild(RedDotStageGroupDisplayWork(stageGroupTidList))
  return rst
end

function RedDotActivityTreeUtils.GetGoldenWeekRedDotTree(args)
  local activityTid = args.activityTid
  local taskTidList = ActivityDataUtils.GetTaskTidList(activityTid)
  local rst = RedDotSequenceFlow(nil, "五一活动红点")
  rst:AddChild(RedDotTasksCanGetRewardWork(taskTidList))
  return rst
end

function RedDotActivityTreeUtils.GetSummerChapter1RedDotTree(args)
  local activityTid = args.activityTid
  local taskTidList = ActivityDataUtils.GetTaskTidList(activityTid)
  local rst = RedDotSequenceFlow(nil, "夏日活动第一章红点")
  rst:AddChild(RedDotTasksCanGetRewardWork(taskTidList))
  return rst
end

function RedDotActivityTreeUtils.GetRailWayActivityRedDotTree(args)
  local activityTid = args.activityTid
  local taskTidList = ActivityDataUtils.GetTaskTidList(activityTid)
  local rst = RedDotSequenceFlow(nil, "铁路活动红点")
  rst:AddChild(RedDotTasksCanGetRewardWork(taskTidList))
  local railWayEntryRedTree = RedDotTreeUtils.GetRailWayEntryRedDotTree()
  rst:AddChild(railWayEntryRedTree)
  return rst
end

function RedDotActivityTreeUtils.GetTaskListRedDotTree(args)
  local activityTid = args.activityTid
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  local activityType = activityCfg.ActivityType
  local activitySubType = activityCfg.ActivitySystemType
  local taskTidList = {}
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  if table.contains({
    ActivityType.PreOrder,
    ActivityType.NewPreOrder
  }, activityType) then
    return nil
  end
  if table.contains({
    "BattlePassActivity",
    "ReturnEventGroup"
  }, activitySubType) then
    taskTidList = table.clone(activityCfg.ActivityPara1)
    local extraTaskTidList = {}
    if activityData.isUnlockExtraTask then
      local extraTaskList = string.split(activityCfg.ActivityPara2, ",")
      for _, taskId in ipairs(extraTaskList) do
        local tid = tonumber(taskId)
        table.insert(taskTidList, tid)
        table.insert(extraTaskTidList, tid)
      end
    end
    local rst = RedDotSequenceFlow(nil, "任务组活动红点")
    rst:AddChild(RedDotTasksCanGetRewardWork(taskTidList))
    if #extraTaskTidList > 0 then
      rst:AddChild(RedDotTasksCanGetExtraRewardWork(extraTaskTidList))
    end
    return rst
  elseif activityType == ActivityType.ShopActivity then
    local taskGroupTid2OpenTsMap = {}
    local taskDataList = ActivityDataUtils.GetTaskDataListFormActivityData(activityData)
    local taskGroupDatas = ActivityDataUtils.GetTaskGroupDatasByCfg(activityTid)
    for _, taskGroupData in pairs(taskGroupDatas) do
      local taskGroupTid = taskGroupData.tid
      taskGroupTid2OpenTsMap[taskGroupTid] = taskGroupData.openTs
    end
    local now = TimeUtils.GetServerTime()
    for _, taskItemData in pairs(taskDataList) do
      local taskGroupTid = TaskDataUtils.GetConfigByField("BelongTaskGroup", taskItemData.tid)
      local openTs = taskGroupTid2OpenTsMap[taskGroupTid]
      if now < openTs then
      else
        table.insert(taskTidList, taskItemData.tid)
      end
    end
  else
    for _, taskData in pairs(activityData.taskList or {}) do
      table.insert(taskTidList, taskData.tid)
    end
  end
  local rst = RedDotSequenceFlow(nil, "任务组活动红点")
  rst:AddChild(RedDotTasksCanGetRewardWork(taskTidList))
  return rst
end

function RedDotActivityTreeUtils.GetAwakerTrialRedDotTree(args)
  local rst = RedDotSequenceFlow(nil, "唤醒体试玩活动红点")
  rst:AddChild(RedDotTreeUtils.GetRedDotActivityStageListCanGetRewardWork(args))
  return rst
end

RedDotActivityTreeUtils.ActivityType2RedDotTreeFuncMap = {
  [ActivityType.SevenDayLogin] = RedDotActivityTreeUtils.GetSevenDayLoginRedDotTree,
  [ActivityType.DeepSeaInvasionDefensive] = RedDotActivityTreeUtils.GetDeepSeaInvasionDefensiveRedDotTree,
  [ActivityType.SecondAnniversarySign] = RedDotActivityTreeUtils.GetSecondAnniversarySignRedDotTree,
  [ActivityType.ShopActivity] = RedDotActivityTreeUtils.GetShopActivityRedDotTree,
  [ActivityType.PreOrder] = RedDotActivityTreeUtils.GetPreOrderRedDotTree,
  [ActivityType.NewPreOrder] = RedDotActivityTreeUtils.GetPreOrderRedDotTree,
  [ActivityType.WorldBoss] = RedDotActivityTreeUtils.GetWorldBossRedDotTree,
  [ActivityType.DeepSeaInvasionDefensive] = RedDotActivityTreeUtils.GetWorldBossRedDotTree,
  [ActivityType.TwoAnniversaryWorldBossActivity] = RedDotActivityTreeUtils.GetWorldBossEntryRedDotTree,
  [ActivityType.GoldenWeekActivity] = RedDotActivityTreeUtils.GetGoldenWeekRedDotTree,
  [ActivityType.SummerChapter1Activity] = RedDotActivityTreeUtils.GetSummerChapter1RedDotTree,
  [ActivityType.RailWayActivity] = RedDotActivityTreeUtils.GetRailWayActivityRedDotTree,
  [ActivityType.AwakerTrial] = RedDotActivityTreeUtils.GetAwakerTrialRedDotTree
}
return RedDotActivityTreeUtils
