local ActivityKeyExertionController = class("ActivityKeyExertionController", ControllerBase)
local base = ControllerBase
local ActivityKeyExertionData = require("Game.ActivityKeyExertion.ActivityKeyExertionData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActivityKeyExertionController:OnInit()
  self._dataDic = {}
  ConfigData:LoadDynCfg(eDynConfigData.activity_keyExertion_main)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivityKeyExertion)
end

function ActivityKeyExertionController:InitKeyExertion(actFrameData)
  if self._dataDic[actFrameData:GetActId()] ~= nil then
    return
  end
  local data = ActivityKeyExertionData.New()
  self._dataDic[actFrameData:GetActId()] = data
  data:InitKeyExertionData(actFrameData:GetActId())
  data:SetBigRewardPickedCount(actFrameData.bigReward)
end

function ActivityKeyExertionController:OpenKeyExertion(actId, callback)
  local data = self._dataDic[actId]
  if data ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityKeyExertion, function(window)
      if window == nil then
        return
      end
      window:InitKeyExertionMain(data)
      if callback ~= nil then
        callback(window)
      end
    end)
  end
end

function ActivityKeyExertionController:GetKeyExertionData(id)
  return self._dataDic[id]
end

function ActivityKeyExertionController:GetTheLatestKeyExertionData()
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

function ActivityKeyExertionController:ReqKeyExertionOpenPackage(actId, callback)
  self._net:CS_ACTIVITY_KeyExertion_PickAllReward(actId, callback)
end

function ActivityKeyExertionController:ReqKeyExertionCommitTask(actId, taskId, callback)
  local data = self._dataDic[actId]
  if data == nil or not data:IsActivityRunning() then
    return
  end
  local dataTaskDic = data:GetKeyExertionTaskIdDic()
  if dataTaskDic == nil or dataTaskDic[taskId] == nil then
    return
  end
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, callback)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Commit(data.actInfo.id, taskId, function()
    dataTaskDic[taskId] = nil
    data:RefreshKeyExertionRedTask()
    local rewards, nums = taskData:GetTaskCfgRewards()
    local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
    data:RefreshKeyExertionRedTask()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityKeyExertionController:__TaskProcessUpdate(taskData)
  if not taskData:CheckComplete() then
    return
  end
  for _, data in pairs(self._dataDic) do
    local taskIdDic = data:GetKeyExertionTaskIdDic()
    if taskIdDic ~= nil and taskIdDic[taskData.id] ~= nil then
      data:RefreshKeyExertionRedTask()
    end
  end
end

function ActivityKeyExertionController:UpdateAllKeyExertionData(msg)
  for _, msgData in pairs(msg) do
    local diffData = self._dataDic[msgData.actId]
    if diffData ~= nil then
      diffData:SetBigRewardPickedCount(msgData.bigReward)
    end
  end
  local uiKeyExertionMain = UIManager:GetWindow(UIWindowTypeID.ActivityKeyExertion)
  if uiKeyExertionMain ~= nil then
    uiKeyExertionMain:RefreshKeyExertionRewards()
    uiKeyExertionMain:UpdateLogicPreviewNode()
  end
end

function ActivityKeyExertionController:__ItemUpdate(itemDic)
  for _, data in pairs(self._dataDic) do
    if itemDic[data:GetKeyExertionTokenId()] ~= nil then
      data:RefreshKeyExertionRedPackage()
      MsgCenter:Broadcast(eMsgEventId.ActivityKeyExertionTokenNumChange, data:GetKeyExertionTokenId())
    end
  end
end

function ActivityKeyExertionController:RemoveKeyExertion(id)
  self._dataDic[id] = nil
end

function ActivityKeyExertionController:IsHaveKeyExertion()
  return table.count(self._dataDic) > 0
end

function ActivityKeyExertionController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_keyExertion_main)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

return ActivityKeyExertionController
