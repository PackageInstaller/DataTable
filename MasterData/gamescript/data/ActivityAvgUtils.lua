local ActivityAvgUtils = {}
local ActAvgMap = {}

function ActivityAvgUtils.ResetAll()
end

function ActivityAvgUtils.PlayActAvg(activityTid)
  ActivityAvgUtils.PlayActAvgFromConstantCfg(activityTid)
  ActivityAvgUtils.PlayActAvgFromStageGroupCfg(activityTid)
end

function ActivityAvgUtils.PlayActAvgFromConstantCfg(activityTid)
  local actAvgList = ActivityAvgUtils.GetActAvgSortList(activityTid)
  print("play act avg", activityTid, table.tostring(actAvgList))
  if not actAvgList then
    return
  end
  for _, actAvg in ipairs(actAvgList) do
    local avgId = actAvg.avgId
    local taskId = actAvg.taskId
    if not taskId or TaskDataUtils.IsTaskDoneByTaskId(taskId) then
      ActivityAvgUtils.PlayActivityAvg(avgId)
    end
  end
end

function ActivityAvgUtils.PlayActAvgFromStageGroupCfg(activityTid)
  local stageGroupTidList = ActivityCfgUtils.GetSubPlotStageGroupList(activityTid)
  for _, stageGroupTid in ipairs(stageGroupTidList or {}) do
    local activityTid2AvgDict = StageGroupCfgUtils.GetActivityTid2AvgDict(stageGroupTid)
    if not activityTid2AvgDict then
    elseif activityTid2AvgDict[activityTid] then
      local avgTid = activityTid2AvgDict[activityTid]
      ActivityAvgUtils.PlayActivityAvg(avgTid)
      break
    end
  end
end

function ActivityAvgUtils.PlayActivityAvg(avgTid)
  AvgStoryManager.Instance:WaitStoryFinish(nil, function()
    AvgStoryManager.Instance:PlayStoryOnce(avgTid)
  end)
end

function ActivityAvgUtils.GetActAvgList(activityTid)
  if not table.next(ActAvgMap) then
    for key, cfg in pairs(DT.Constant) do
      local data = cfg.Data
      if data and "table" == type(data) and "PlayActAvg" == data[1] then
        local avgList = ActAvgMap[data[3]] or {}
        local avgData = {
          avgId = data[2],
          taskId = data[4],
          key = key
        }
        table.insert(avgList, avgData)
        ActAvgMap[data[3]] = avgList
      end
    end
  end
  return ActAvgMap[activityTid]
end

function ActivityAvgUtils.GetActAvgSortList(activityTid)
  local actAvgList = ActivityAvgUtils.GetActAvgList(activityTid)
  if not actAvgList then
    return
  end
  table.sort(actAvgList, function(a, b)
    return a.key < b.key
  end)
  return actAvgList
end

return ActivityAvgUtils
