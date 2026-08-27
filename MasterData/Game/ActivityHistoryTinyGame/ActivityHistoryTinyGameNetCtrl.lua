local ActivityHistoryTinyGameNetCtrl = class("ActivityHistoryTinyGameNetCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityHistoryTinyGameNetCtrl:ctor()
  self._refreshSingleTable = {}
  self._refreshAllTable = {}
  self._rewardTable = {}
end

function ActivityHistoryTinyGameNetCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_RefreshQuestSingle, self, proto_csmsg.SC_ACTIVITY_TinyGame_RefreshQuestSingle, self.SC_ACTIVITY_TinyGame_RefreshQuestSingle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_RefreshQuestAll, self, proto_csmsg.SC_ACTIVITY_TinyGame_RefreshQuestAll, self.SC_ACTIVITY_TinyGame_RefreshQuestAll)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_GetActiveReward, self, proto_csmsg.SC_ACTIVITY_TinyGame_GetActiveReward, self.SC_ACTIVITY_TinyGame_GetActiveReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_ActiveDiff, self, proto_csmsg.SC_ACTIVITY_TinyGame_ActiveDiff, self.SC_ACTIVITY_TinyGame_ActiveDiff)
end

function ActivityHistoryTinyGameNetCtrl:CS_ACTIVITY_TinyGame_RefreshQuestSingle(actId, taskId, callback)
  self._refreshSingleTable.actId = actId
  self._refreshSingleTable.toReplaceTaskId = taskId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestSingle, proto_csmsg.CS_ACTIVITY_TinyGame_RefreshQuestSingle, self._refreshSingleTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestSingle, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_RefreshQuestSingle)
end

function ActivityHistoryTinyGameNetCtrl:SC_ACTIVITY_TinyGame_RefreshQuestSingle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_TinyGame_RefreshQuestSingle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestSingle)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestSingle, msg)
end

function ActivityHistoryTinyGameNetCtrl:CS_ACTIVITY_TinyGame_RefreshQuestAll(actId, callback)
  self._refreshAllTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestAll, proto_csmsg.CS_ACTIVITY_TinyGame_RefreshQuestAll, self._refreshAllTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestAll, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_RefreshQuestAll)
end

function ActivityHistoryTinyGameNetCtrl:SC_ACTIVITY_TinyGame_RefreshQuestAll(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_TinyGame_RefreshQuestAll error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestAll)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_RefreshQuestAll, msg)
end

function ActivityHistoryTinyGameNetCtrl:CS_ACTIVITY_TinyGame_GetActiveReward(actId, all, active, callback)
  self._rewardTable.actId = actId
  self._rewardTable.all = all
  self._rewardTable.active = active
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_GetActiveReward, proto_csmsg.CS_ACTIVITY_TinyGame_GetActiveReward, self._rewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_GetActiveReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TinyGame_GetActiveReward)
end

function ActivityHistoryTinyGameNetCtrl:SC_ACTIVITY_TinyGame_GetActiveReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_TinyGame_GetActiveReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_GetActiveReward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TinyGame_GetActiveReward, msg)
end

function ActivityHistoryTinyGameNetCtrl:SC_ACTIVITY_TinyGame_ActiveDiff(msg)
  local tinyCtrl = ControllerManager:GetController(ControllerTypeId.HistoryTinyGameActivity)
  if tinyCtrl == nil then
    return
  end
  local data = tinyCtrl:GetOneHTGData()
  if data == nil then
    return
  end
  data:UpdateHTGActive(msg.active)
  MsgCenter:Broadcast(eMsgEventId.ActivityTinyGameActive)
end

return ActivityHistoryTinyGameNetCtrl
