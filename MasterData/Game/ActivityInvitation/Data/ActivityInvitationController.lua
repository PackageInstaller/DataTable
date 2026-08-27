local ActivityInvitationController = class("ActivityInvitationController", ControllerBase)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityInvitationData = require("Game.ActivityInvitation.Data.ActivityInvitationData")

function ActivityInvitationController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_invitation)
  ConfigData:LoadDynCfg(eDynConfigData.activity_invitation_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_invitation_task_group)
  self.__SetInvitationRegister = BindCallback(self, self.SetInvitationRegister)
  MsgCenter:AddListener(eMsgEventId.InvitationCodeRegister, self.__SetInvitationRegister)
  self.__TaskUpdateCallback = BindCallback(self, self.__InvitationTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskUpdateCallback)
  self.__TaskDeleteCallback = BindCallback(self, self.__InvitationTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__TaskDeleteCallback)
  self._dataDic = {}
end

function ActivityInvitationController:AddInvitation(msg)
  local frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = frameCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Invitation, msg.actId)
  if frameData == nil or not frameData:IsActivityOpen() then
    return
  end
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = ActivityInvitationData.New()
  self._dataDic[msg.actId] = data
  data:InitInvitationData(msg)
end

function ActivityInvitationController:UpdateInvitation(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdataInvitationData(msg)
  MsgCenter:Broadcast(eMsgEventId.ActivityInvitation, msg.actId)
end

function ActivityInvitationController:OnInvitationTaskChange(taskId)
  for _, data in pairs(self._dataDic) do
    data:OnInvitationTaskChange(taskId)
  end
end

function ActivityInvitationController:__InvitationTaskUpdate(taskData)
  self:OnInvitationTaskChange(taskData.id)
end

function ActivityInvitationController:__InvitationTaskDelete(taskId)
  self:OnInvitationTaskChange(taskId)
end

function ActivityInvitationController:SetInvitationRegister(frameId)
  for k, v in pairs(self._dataDic) do
    if v:GetActFrameId() == frameId then
      v:SetInvitationRegister()
      break
    end
  end
end

function ActivityInvitationController:RemoveInvitation(actId)
  self._dataDic[actId] = nil
end

function ActivityInvitationController:IsHaveInvitation()
  return table.count(self._dataDic) > 0
end

function ActivityInvitationController:GetInvitationDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityInvitationController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_invitation)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_invitation_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_invitation_task_group)
  MsgCenter:RemoveListener(eMsgEventId.InvitationCodeRegister, self.__SetInvitationRegister)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__TaskDeleteCallback)
end

return ActivityInvitationController
