local ActivityRaidUtils = {}
local WORLD_BOSS_STAGE_PASS_COND = "WorldBossStagePassTime"
local RAID_WORLD_TARGET_CONSTANT_KEY = "TwoAndAHalfAnniversaryRAIDActiviityWorldTarget"
ActivityRaidUtils.worldBossKillCountMapByActivityTid = {}

function ActivityRaidUtils.GetWorldTaskGroupTid()
  local worldTargetConfig = DT.GetOriginalConstant(RAID_WORLD_TARGET_CONSTANT_KEY)
  return worldTargetConfig and worldTargetConfig[1]
end

function ActivityRaidUtils.AppendWorldMilestoneRow(taskTid, rows)
  local taskCfg = taskTid and DT.Task[taskTid]
  if not taskCfg or taskCfg.CompleteCond ~= WORLD_BOSS_STAGE_PASS_COND then
    return
  end
  local threshold = taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1] or taskCfg.ProgressLimit
  if not threshold or threshold <= 0 then
    return
  end
  table.insert(rows, {
    taskTid = taskTid,
    threshold = threshold,
    _sort = taskCfg.BaseSortID or 0
  })
end

function ActivityRaidUtils.SortWorldMilestoneRows(rows)
  table.sort(rows, function(a, b)
    local sortA = a._sort or 0
    local sortB = b._sort or 0
    if sortA == sortB then
      return (a.taskTid or 0) < (b.taskTid or 0)
    end
    return sortA < sortB
  end)
  for _, row in ipairs(rows) do
    row._sort = nil
  end
end

function ActivityRaidUtils.CollectWorldMilestoneRowsForParent(parentTid)
  if not parentTid then
    return {}
  end
  local rows = {}
  for taskTid, taskCfg in pairs(DT.Task) do
    if taskCfg.BelongTaskGroup == parentTid and taskCfg.CompleteCond == WORLD_BOSS_STAGE_PASS_COND then
      ActivityRaidUtils.AppendWorldMilestoneRow(taskTid, rows)
    end
  end
  ActivityRaidUtils.SortWorldMilestoneRows(rows)
  return rows
end

function ActivityRaidUtils.ResolveWorldMilestoneRows(activityConfig)
  if not activityConfig then
    return {}
  end
  local worldTaskGroupTid = ActivityRaidUtils.GetWorldTaskGroupTid()
  local rows = ActivityRaidUtils.CollectWorldMilestoneRowsForParent(worldTaskGroupTid)
  if #rows > 0 then
    return rows
  end
  Logger.Warn("ActivityRaidUtils.ResolveWorldMilestoneRows failed, activityId=%s taskGroupTid=%s", activityConfig.ID, worldTaskGroupTid)
  return {}
end

function ActivityRaidUtils.GetWorldMilestoneProgressCount(row)
  if not row or not row.taskTid then
    return 0
  end
  local taskData = TaskDataUtils.GetTaskData(row.taskTid)
  local count = taskData and taskData.count or 0
  if row.threshold and TaskDataUtils.IsTaskDoneByTaskId(row.taskTid) and count < row.threshold then
    count = row.threshold
  end
  return count
end

function ActivityRaidUtils.GetWorldProgressCountByRows(rows)
  local totalCount = 0
  for _, row in ipairs(rows or {}) do
    totalCount = math.max(totalCount, ActivityRaidUtils.GetWorldMilestoneProgressCount(row))
  end
  return totalCount
end

function ActivityRaidUtils.ResolveWorldProgressCount(activityConfig)
  do return ActivityRaidUtils.GetWorldProgressCountByRows, ActivityRaidUtils.ResolveWorldMilestoneRows(activityConfig) end
  return ActivityRaidUtils.GetWorldProgressCountByRows, ActivityRaidUtils.ResolveWorldMilestoneRows(activityConfig)
end

function ActivityRaidUtils.GetStageGroupKillTotal(activityTid, activityConfig)
  if not activityTid then
    return nil
  end
  local countMap = ActivityRaidUtils.worldBossKillCountMapByActivityTid[activityTid]
  if not countMap then
    return nil
  end
  local stageGroupList = activityConfig and activityConfig.ActivityPara1 or {}
  local total = 0
  for _, stageGroupId in ipairs(stageGroupList) do
    total = total + (countMap[stageGroupId] or 0)
  end
  return total
end

function ActivityRaidUtils.ResolveWorldKillDisplayCount(activityTid, activityConfig)
  local stageTotal = ActivityRaidUtils.GetStageGroupKillTotal(activityTid, activityConfig)
  if nil ~= stageTotal then
    return stageTotal
  end
  do return ActivityRaidUtils.ResolveWorldProgressCount end
  return ActivityRaidUtils.ResolveWorldProgressCount, activityConfig
end

function ActivityRaidUtils.GetWorldProgressCap(rows)
  local cap = 0
  for _, row in ipairs(rows or {}) do
    if row.threshold and cap < row.threshold then
      cap = row.threshold
    end
  end
  return cap
end

function ActivityRaidUtils.GetWorldMilestoneFillAmount(totalCount, rows)
  rows = rows or {}
  local milestoneCount = #rows
  if 0 == milestoneCount then
    return 0
  end
  totalCount = totalCount or 0
  local prevThreshold = 0
  for idx, row in ipairs(rows) do
    local threshold = row.threshold or 0
    if totalCount < threshold then
      local range = threshold - prevThreshold
      local percentInRange = range > 0 and (totalCount - prevThreshold) / range or 0
      percentInRange = math.max(0, math.min(1, percentInRange))
      return (idx - 1 + percentInRange) / milestoneCount
    end
    prevThreshold = threshold
  end
  return 1
end

function ActivityRaidUtils.GetWorldProgressRawKey(activityTid, activityConfig)
  local rows = ActivityRaidUtils.ResolveWorldMilestoneRows(activityConfig)
  local totalCount = ActivityRaidUtils.ResolveWorldKillDisplayCount(activityTid, activityConfig)
  local parts = {
    tostring(totalCount)
  }
  local countMap = activityTid and ActivityRaidUtils.worldBossKillCountMapByActivityTid[activityTid]
  if countMap then
    local stageGroupList = activityConfig and activityConfig.ActivityPara1 or {}
    for _, stageGroupId in ipairs(stageGroupList) do
      table.insert(parts, tostring(countMap[stageGroupId] or 0))
    end
  end
  for _, row in ipairs(rows or {}) do
    if row.taskTid then
      table.insert(parts, TaskDataUtils.IsTaskDoneByTaskId(row.taskTid) and "1" or "0")
    else
      table.insert(parts, "0")
    end
  end
  do return table.concat, parts end
  return table.concat, parts, "_", ipairs(rows or {})
end

function ActivityRaidUtils.FormatWorldCount(count)
  local numberCount = tonumber(count) or 0
  if numberCount >= 100000 then
    return tostring(numberCount // 1000) .. "K"
  end
  do return tostring, bc.NumberToK(numberCount) end
  return tostring, bc.NumberToK(numberCount)
end

function ActivityRaidUtils.GetWorldTargetEndDays(activityConfig)
  local timePara = activityConfig and activityConfig.ActivityTimePara
  return timePara and timePara[1] or 0
end

function ActivityRaidUtils.GetActivityTimeText(activityData, activityConfig)
  local endTime = activityData and activityData.endTime
  if endTime and endTime > 0 then
    local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
    local endTimeCountdown = endTime - now
    if endTimeCountdown >= 0 then
      do return TimeUtils.ActivityCountDownFormat end
      return TimeUtils.ActivityCountDownFormat, endTimeCountdown
    end
    do return LT.Text end
    return LT.Text, "ActivityTimeExpired"
  end
  do return LT.Textf, "TwoAndAHalfAnniversaryRAIDActiviityEndTime", ActivityRaidUtils.GetWorldTargetEndDays(activityConfig) end
  return LT.Textf, "TwoAndAHalfAnniversaryRAIDActiviityEndTime", ActivityRaidUtils.GetWorldTargetEndDays(activityConfig)
end

function ActivityRaidUtils.ReadWorldBossKillCountFromTable(source, stageGroupId)
  if not source or not stageGroupId then
    return nil
  end
  local directCount = source[stageGroupId] or source[tostring(stageGroupId)]
  if type(directCount) == "number" then
    return directCount
  end
  for _, key in ipairs({
    "tid2WorldBossGroup2Num",
    "tid2WorldBossGroupNum",
    "group2Num",
    "stageGroup2Num",
    "stageGroupId2Num",
    "countMap",
    "data"
  }) do
    local count = ActivityRaidUtils.ReadWorldBossKillCountFromTable(source[key], stageGroupId)
    if nil ~= count then
      return count
    end
  end
  return nil
end

function ActivityRaidUtils.CollectWorldBossKillSyncEntries(data, defaultActivityTid)
  local entries = {}
  if not data or type(data) ~= "table" then
    return entries
  end
  if "table" == type(data.group2Num) then
    local activityTid = data.activityTid or defaultActivityTid
    if activityTid then
      table.insert(entries, {
        activityTid = activityTid,
        group2Num = data.group2Num
      })
    end
    return entries
  end
  if defaultActivityTid then
    local entry = data[defaultActivityTid] or data[tostring(defaultActivityTid)]
    if type(entry) == "table" and "table" == type(entry.group2Num) then
      table.insert(entries, {
        activityTid = entry.activityTid or defaultActivityTid,
        group2Num = entry.group2Num
      })
      return entries
    end
  end
  for key, entry in pairs(data) do
    if type(entry) == "table" and "table" == type(entry.group2Num) then
      local activityTid = entry.activityTid or tonumber(key) or key
      table.insert(entries, {
        activityTid = activityTid,
        group2Num = entry.group2Num
      })
    end
  end
  if 0 == #entries and defaultActivityTid then
    local hasCountValue = false
    for _, value in pairs(data) do
      if type(value) == "number" then
        hasCountValue = true
        break
      end
    end
    if hasCountValue then
      table.insert(entries, {activityTid = defaultActivityTid, group2Num = data})
    end
  end
  return entries
end

function ActivityRaidUtils._EnsureWorldBossKillCountMap(activityTid, stageGroupList)
  local countMap = ActivityRaidUtils.worldBossKillCountMapByActivityTid[activityTid]
  if countMap then
    return countMap
  end
  countMap = {}
  for _, stageGroupId in ipairs(stageGroupList or {}) do
    countMap[stageGroupId] = 0
  end
  ActivityRaidUtils.worldBossKillCountMapByActivityTid[activityTid] = countMap
  return countMap
end

function ActivityRaidUtils.UpdateWorldBossKillCountMap(activityTid, data)
  if not activityTid then
    return
  end
  local entries = ActivityRaidUtils.CollectWorldBossKillSyncEntries(data, activityTid)
  local patchData = data
  if #entries > 0 then
    for _, entry in ipairs(entries) do
      if entry.activityTid == activityTid or entry.activityTid == tonumber(activityTid) then
        patchData = entry
        break
      end
    end
    if patchData == data and entries[1] then
      patchData = entries[1]
    end
  end
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  local stageGroupList = activityConfig and activityConfig.ActivityPara1 or {}
  local countMap = ActivityRaidUtils._EnsureWorldBossKillCountMap(activityTid, stageGroupList)
  local group2Num = patchData and patchData.group2Num
  if type(group2Num) == "table" then
    for key, count in pairs(group2Num) do
      if type(count) == "number" then
        local stageGroupId = tonumber(key) or key
        countMap[stageGroupId] = count
      end
    end
  end
  for _, stageGroupId in ipairs(stageGroupList) do
    local count = ActivityRaidUtils.ReadWorldBossKillCountFromTable(patchData, stageGroupId)
    if nil ~= count then
      countMap[stageGroupId] = count
    end
  end
end

function ActivityRaidUtils.ReqWorldBossKillCount(activityTid, callback)
  if not activityTid then
    if callback then
      callback(nil)
    end
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "GetActivityWorldBossKillCount", function(data)
    ActivityRaidUtils.UpdateWorldBossKillCountMap(activityTid, data)
    if callback then
      callback(data)
    end
  end, nil, activityTid)
end

function ActivityRaidUtils.GetWorldBossKillCount(activityTid, stageGroupId)
  local countMap = activityTid and ActivityRaidUtils.worldBossKillCountMapByActivityTid[activityTid]
  return countMap and stageGroupId and countMap[stageGroupId] or 0
end

return ActivityRaidUtils
