local ActivityCfgUtils = {}

function ActivityCfgUtils.GetCfg(activityTid)
  if not activityTid then
    return nil
  end
  return DT.Activity[activityTid]
end

function ActivityCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ActivityCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ActivityCfgUtils.GetActivityTidByActivityType(activityType)
  for activityTid, activityCfg in pairs(DT.Activity) do
    if activityCfg.ActivityType == activityType then
      return activityTid
    end
  end
  return nil
end

function ActivityCfgUtils.GetStageGroupList(activityTid)
  local activityConfig = ActivityCfgUtils.GetCfg(activityTid)
  if not activityConfig then
    return
  end
  local stageGroupTypeId = activityConfig.ActivityPara1[1]
  do return CopyDataUtils.GetStageGroupIdList end
  return CopyDataUtils.GetStageGroupIdList, stageGroupTypeId
end

function ActivityCfgUtils.GetSubPlotStageGroupList(activityTid)
  do return ActivityCfgUtils.GetCfgField, "ActivityPara3" end
  return ActivityCfgUtils.GetCfgField, "ActivityPara3", activityTid
end

function ActivityCfgUtils.GetBestExperienceTipsId(activityTid)
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  if not activityCfg then
    return
  end
  if not activityCfg.BestExperienceCondition or not activityCfg.BestExperienceTips then
    return
  end
  local needShowTips = false
  for _, stageId in pairs(activityCfg.BestExperienceCondition or {}) do
    local stageCfg = DT.Stage[stageId]
    local stageGroupId = stageCfg.BelongGroup
    local stageData = CopyDataUtils.GetAllTypeStageData(stageGroupId, stageId)
    if not stageData or not stageData.firstRewardDraw then
      needShowTips = true
      break
    end
  end
  return needShowTips and activityCfg.BestExperienceTips or nil
end

local activityTid2TicketInfoDict = {}

function ActivityCfgUtils.GetActivityDungeonTicketInfo(activityTid)
  if activityTid2TicketInfoDict then
    return activityTid2TicketInfoDict[activityTid]
  end
  activityTid2TicketInfoDict = ActivityCfgUtils.GetActivityTid2TicketInfoDict()
  return activityTid2TicketInfoDict[activityTid]
end

local CostTicketActivityTypeList = {
  ActivityDefine.ActivityType.SummerChapter1Activity
}

function ActivityCfgUtils.GetActivityTid2TicketInfoDict()
  if not table.next(activityTid2TicketInfoDict) then
    for activityTid, activityCfg in pairs(DT.Activity) do
      if not table.contains(CostTicketActivityTypeList, activityCfg.ActivityType) then
      else
        local cfgActivityPara4 = activityCfg.ActivityPara4
        local ticketInfo = {
          ticketItemTid = cfgActivityPara4[1],
          ticketMaxHoldNum = cfgActivityPara4[2],
          ticketShopTid = cfgActivityPara4[4]
        }
        if ticketInfo then
          activityTid2TicketInfoDict[activityTid] = ticketInfo
        end
      end
    end
  end
  return activityTid2TicketInfoDict
end

function ActivityCfgUtils.GetTicketInfoByTicketItemTid(targetTicketItemTid)
  if not table.next(activityTid2TicketInfoDict) then
    activityTid2TicketInfoDict = ActivityCfgUtils.GetActivityTid2TicketInfoDict()
  end
  for activityTid, ticketInfo in pairs(activityTid2TicketInfoDict) do
    if ticketInfo.ticketItemTid == targetTicketItemTid then
      return ticketInfo
    end
  end
  return 0
end

local summonTid2SkinTaskInfoDict = {}
local activityTid2SkinTaskInfoDict = {}

function ActivityCfgUtils.GetActivitySkinTaskInfo(targetActivityTid)
  if not table.next(activityTid2SkinTaskInfoDict) then
    for activityTid, activityCfg in pairs(DT.Activity) do
      if activityCfg.ActivitySystemType ~= ActivityDefine.ActivitySystemType.SkinTask then
      else
        local relatedTidList = string.split(activityCfg.ActivityPara2 or "", ",")
        for idx, tid in ipairs(relatedTidList) do
          tid = tonumber(tid)
          if DT.Activity[tid] then
            local relatedActivityTid = tid
            local targetTaskTid = activityCfg.ActivityPara1[idx]
            local skinTaskInfo = {skinTaskTid = targetTaskTid, skinActivityTid = activityTid}
            activityTid2SkinTaskInfoDict[relatedActivityTid] = skinTaskInfo
          elseif DT.Summon[tid] then
            local relatedSummonTid = tid
            local targetTaskTid = activityCfg.ActivityPara1[idx]
            local skinTaskInfo = {skinTaskTid = targetTaskTid, skinActivityTid = activityTid}
            summonTid2SkinTaskInfoDict[relatedSummonTid] = skinTaskInfo
          end
        end
      end
    end
  end
  return activityTid2SkinTaskInfoDict[targetActivityTid]
end

function ActivityCfgUtils.GetSummonSkinTaskInfo(targetSummonTid)
  return summonTid2SkinTaskInfoDict[targetSummonTid]
end

function ActivityCfgUtils.GetStageTaskMap(activityTid)
  local rst = {}
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  if not activityCfg then
    return rst
  end
  local finishTaskId = activityCfg.ActivityPara2
  local finishTaskCfg = TaskCfgUtils.GetCfg(finishTaskId)
  if not finishTaskCfg then
    return rst
  end
  local subBossTaskList = finishTaskCfg.CompleteCondPara
  for _, subBossTaskId in ipairs(subBossTaskList) do
    local taskCfg = TaskCfgUtils.GetCfg(subBossTaskId)
    if taskCfg and taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[2] then
      rst[taskCfg.CompleteCondPara[2]] = subBossTaskId
    end
  end
  return rst
end

function ActivityCfgUtils.GetSubBossStageGroupTidList(activityTid)
  local rst = {}
  local activityData = ActivityDataUtils.GetActivityData(activityTid)
  if not activityData then
    return rst
  end
  local isActivityFinish = ActivityManager.Instance:IsActivityFinishedByTid(activityTid)
  if isActivityFinish then
    return rst
  end
  local finishTaskId = tonumber(ActivityCfgUtils.GetCfgField("ActivityPara2", activityTid))
  local subBossTaskList = TaskCfgUtils.GetCfgField("CompleteCondPara", finishTaskId)
  for _, subBossTaskId in ipairs(subBossTaskList) do
    if TaskDataUtils.IsTaskDoneByTaskId(subBossTaskId) then
    else
      local bossTaskCfg = TaskCfgUtils.GetCfg(subBossTaskId) or {}
      local stageGroupTid = bossTaskCfg.CompleteCondPara and bossTaskCfg.CompleteCondPara[2]
      table.insert(rst, stageGroupTid)
    end
  end
  return rst
end

function ActivityCfgUtils.GetStageGroupType(activityTid)
  local activityCfg = ActivityCfgUtils.GetCfg(activityTid)
  if not activityCfg then
    return
  end
  return activityCfg.ActivityPara1 and activityCfg.ActivityPara1[1]
end

function ActivityCfgUtils.GetActivityTidByType(targetType, targetSystemType)
  for _, cfg in pairs(DT.Activity) do
    if cfg.ActivityType == targetType and cfg.ActivitySystemType == targetSystemType then
      return cfg.ID
    end
  end
  return nil
end

return ActivityCfgUtils
