local TaskCfgUtils = {}

function TaskCfgUtils.GetCfg(taskTid)
  if not taskTid then
    return nil
  end
  return DT.Task[taskTid]
end

function TaskCfgUtils.GetCfgField(field, cfgTid)
  local cfg = TaskCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function TaskCfgUtils.GetTaskCompleteAward(taskTid)
  do return TaskDataUtils.GetTaskCompleteAward end
  return TaskDataUtils.GetTaskCompleteAward, taskTid
end

local taskType2TaskTidsDict = {}

function TaskCfgUtils.GetTaskTidListByTaskType(taskType)
  if not taskType then
    return {}
  end
  if taskType2TaskTidsDict[taskType] then
    return taskType2TaskTidsDict[taskType]
  end
  for _, cfg in pairs(DT.Task) do
    if cfg.TaskType then
      if not taskType2TaskTidsDict[cfg.TaskType] then
        taskType2TaskTidsDict[cfg.TaskType] = {}
      end
      table.insert(taskType2TaskTidsDict[cfg.TaskType], cfg.ID)
    end
  end
  return taskType2TaskTidsDict[taskType]
end

function TaskCfgUtils.GetTaskCompleteAwardInfoList(taskTid)
  local rst = {}
  local cfgCompleteAward = TaskCfgUtils.GetCfgField("CompleteAward", taskTid)
  for i = 1, #cfgCompleteAward, 2 do
    local tid = cfgCompleteAward[i]
    local num = cfgCompleteAward[i + 1]
    table.insert(rst, {tid = tid, num = num})
  end
  return rst
end

return TaskCfgUtils
