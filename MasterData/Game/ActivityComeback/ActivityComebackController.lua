local ActivityComebackController = class("ActivityComebackController", ControllerBase)
local base = ControllerBase
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityComebackData = require("Game.ActivityComeback.ActivityComebackData")
local ActivityComebackNewSystemData = require("Game.ActivityComeback.ActivityComebackNewSystemData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActivityComebackController:OnInit()
  self._dataDic = {}
  self._newSysDataDic = {}
  self._taskIdMapping = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_return_newSystem)
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__TaskCompletedCallback = BindCallback(self, self.__TaskCompleted)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskCompletedCallback)
end

function ActivityComebackController:AddComebackList(comebackMsgs)
  for i, comebackMsg in ipairs(comebackMsgs) do
    self:AddComebackActivity(comebackMsg)
  end
end

function ActivityComebackController:AddComebackActivity(comebackMsg)
  if self._dataDic[comebackMsg.actId] ~= nil then
    self._dataDic[comebackMsg.actId]:InitActivityComeback(comebackMsg)
  else
    local data = ActivityComebackData.New()
    data:SetActFrameDataByType(ActivityFrameEnum.eActivityType.Comeback, comebackMsg.actId)
    data:InitActivityComeback(comebackMsg)
    self._dataDic[comebackMsg.actId] = data
  end
end

function ActivityComebackController:RemoveComebackActivity(comebackId)
  self._dataDic[comebackId] = nil
end

function ActivityComebackController:HasActivityComeback()
  return table.count(self._dataDic) > 0
end

function ActivityComebackController:GetComebackData(id)
  return self._dataDic[id]
end

function ActivityComebackController:GetTheLatestComebackData()
  local res
  for k, v in pairs(self._dataDic) do
    if res == nil then
      res = v
    elseif v:GetActivityBornTime() > res:GetActivityBornTime() then
      res = v
    end
  end
  return res
end

function ActivityComebackController:AddComebackNewSystemList(newSysMsgs)
  for i, newSysMsg in ipairs(newSysMsgs) do
    self:AddComebackNewSystem(newSysMsg)
  end
end

function ActivityComebackController:AddComebackNewSystem(newSysMsg)
  if self._newSysDataDic[newSysMsg.actId] ~= nil then
    self._newSysDataDic[newSysMsg.actId]:InitActivityComebackNewSystem(newSysMsg)
  else
    local data = ActivityComebackNewSystemData.New()
    data:SetActFrameDataByType(ActivityFrameEnum.eActivityType.ComebackNewSystem, newSysMsg.actId)
    data:InitActivityComebackNewSystem(newSysMsg)
    self._newSysDataDic[newSysMsg.actId] = data
  end
  local modules = newSysMsg.modules
  local reddotCount = 0
  for _, module in ipairs(modules) do
    local questIds = module.questIds
    for _, taskId in ipairs(questIds) do
      if self._taskIdMapping[taskId] == nil then
        self._taskIdMapping[taskId] = {}
      end
      self._taskIdMapping[taskId][newSysMsg.actId] = true
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        reddotCount = reddotCount + 1
      end
    end
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.ComebackNewSystem, newSysMsg.actId)
  if actData ~= nil then
    local reddot = actData:GetActivityReddotNode()
    if reddot ~= nil then
      reddot:SetRedDotCount(reddotCount)
    end
  end
end

function ActivityComebackController:RemoveComebackNewSystem(newSysId)
  self._newSysDataDic[newSysId] = nil
end

function ActivityComebackController:HasComebackNewSystem()
  return table.count(self._newSysDataDic) > 0
end

function ActivityComebackController:GetComebackNewSystemData(id)
  return self._newSysDataDic[id]
end

function ActivityComebackController:SendComebackNewSystemCommitTask(actId, taskData, callback)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameId = actCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.ComebackNewSystem, actId)
  if 0 < (actFrameId or 0) then
    activityFrameNet:CS_Activity_Quest_Commit(actFrameId, taskData.id, function()
      callback()
    end)
  end
end

function ActivityComebackController:__TaskUpdate(taskData)
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
    local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.ComebackNewSystem, id)
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

function ActivityComebackController:__TaskCompleted(taskStcData)
  local taskId = taskStcData.id
  local idDic = self._taskIdMapping[taskId]
  if idDic == nil then
    return
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  for id, _ in pairs(idDic) do
    local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.ComebackNewSystem, id)
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

function ActivityComebackController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_return_newSystem)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskCompletedCallback)
end

return ActivityComebackController
