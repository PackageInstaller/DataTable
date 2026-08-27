local ActivityLimitTaskData = class("ActivityLimitTaskData")

function ActivityLimitTaskData:InitActLimitTaskData(activityFrameData)
  self._actFrameData = activityFrameData
  local actTaskLimitCfg = ConfigData.activity_task_limit[activityFrameData.id]
  if actTaskLimitCfg == nil then
    error("Cant get activity_task_limit cfg, id = " .. tostring(activityFrameData.id))
    return
  end
  self.actTaskLimitCfg = actTaskLimitCfg
end

function ActivityLimitTaskData:GetActLimitTaskFrameData()
  return self._actFrameData
end

function ActivityLimitTaskData:IsActLimitTask(taskType)
  return self.actTaskLimitCfg.taskTypeDic[taskType] ~= nil
end

function ActivityLimitTaskData:IsActLimitTaskShowNew(taskData)
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local show = userData:GetActLimitNewTaskReddot(self._actFrameData.id, taskData.id)
  local nopick = not taskData:IsPickedTaskReward()
  return show and nopick
end

function ActivityLimitTaskData:GetActLimitTaskDataList()
  local list = {}
  for taskType, _ in pairs(self.actTaskLimitCfg.taskTypeDic) do
    local taskDic = PlayerDataCenter.allTaskData:GetTaskDataDicByType(taskType)
    for taskId, taskData in pairs(taskDic) do
      if taskData.stcData.isShow then
        table.insert(list, taskData)
      end
    end
  end
  return list
end

function ActivityLimitTaskData:GetActLimitNotPickedTaskDataDic()
  local dic = {}
  for taskType, _ in pairs(self.actTaskLimitCfg.taskTypeDic) do
    local taskDic = PlayerDataCenter.allTaskData:GetTaskDataDicByType(taskType)
    for taskId, taskData in pairs(taskDic) do
      if taskData.stcData.isShow and not taskData:IsPickedTaskReward() then
        dic[taskId] = taskData
      end
    end
  end
  return dic
end

return ActivityLimitTaskData
