local ActivityTaskController = class("ActivityTaskController", ControllerBase)
local base = ControllerBase
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function ActivityTaskController:OnInit()
  self._idDic = {}
  self._taskIdMapping = {}
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__TaskCompletedCallback = BindCallback(self, self.__TaskCompleted)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskCompletedCallback)
end

function ActivityTaskController:AddActivityTaskList(activityQuests)
  for i, activityQuest in ipairs(activityQuests) do
    self:AddActivityTask(activityQuest)
  end
end

function ActivityTaskController:AddActivityTask(activityQuest)
  if self._idDic[activityQuest.actId] ~= nil then
    return
  end
  local id = activityQuest.actId
  self._idDic[id] = activityQuest
  local taskIds = {}
  table.insertto(taskIds, activityQuest.onceQuests)
  table.insertto(taskIds, activityQuest.refreshQuests.ids)
  local reddotCount = 0
  for i, taskId in ipairs(taskIds) do
    if self._taskIdMapping[taskId] == nil then
      self._taskIdMapping[taskId] = {}
    end
    self._taskIdMapping[taskId][id] = true
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData ~= nil and taskData:CheckComplete() then
      reddotCount = reddotCount + 1
    end
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Task, id)
  if actData ~= nil then
    local reddot = actData:GetActivityReddotNode()
    if reddot ~= nil then
      reddot:SetRedDotCount(reddotCount)
    end
  end
  if 0 < (activityQuest.startTm or 0) then
    activivityCtrl:TryResetActivityFinishTimeByType(ActivityFrameEnum.eActivityType.Task, id, activityQuest.startTm)
  end
end

function ActivityTaskController:UpadteTaskActivity(activityQuest)
  if self._idDic[activityQuest.actId] == nil then
    return
  end
  local data = self._idDic[activityQuest.actId]
  data.onceQuests = activityQuest.onceQuests
  data.refreshQuests = activityQuest.refreshQuests
end

function ActivityTaskController:RemoveActivityTask(id)
  if self._idDic[id] == nil then
    return
  end
  self._idDic[id] = nil
  for i, idDic in pairs(self._taskIdMapping) do
    idDic[id] = nil
  end
end

function ActivityTaskController:__TaskUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  local taskId = taskData.stcData.id
  local idDic = self._taskIdMapping[taskId]
  if idDic == nil then
    return
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  for id, _ in pairs(idDic) do
    local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Task, id)
    if actData ~= nil then
      local reddot = actData:GetActivityReddotNode()
      if reddot ~= nil then
        local count = reddot:GetRedDotCount()
        count = count + 1
        reddot:SetRedDotCount(count)
      end
    end
  end
end

function ActivityTaskController:__TaskCompleted(taskStcData)
  local taskId = taskStcData.id
  local idDic = self._taskIdMapping[taskId]
  if idDic == nil then
    return
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  for id, _ in pairs(idDic) do
    local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Task, id)
    if actData ~= nil then
      local reddot = actData:GetActivityReddotNode()
      if reddot ~= nil then
        local count = reddot:GetRedDotCount()
        count = count - 1
        reddot:SetRedDotCount(count)
      end
    end
  end
end

function ActivityTaskController:HasActivityTask()
  return table.count(self._idDic) > 0
end

function ActivityTaskController:SendCommitActivityTask(actId, taskData, callback)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameId = actCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.Task, actId)
  if 0 < (actFrameId or 0) then
    activityFrameNet:CS_Activity_Quest_Commit(actFrameId, taskData.id, function()
      self:__TaskCompleted(taskData.stcData)
      callback()
    end)
  end
end

function ActivityTaskController:GetAcitvityTaskData(id)
  return self._idDic[id]
end

function ActivityTaskController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskCompletedCallback)
end

return ActivityTaskController
