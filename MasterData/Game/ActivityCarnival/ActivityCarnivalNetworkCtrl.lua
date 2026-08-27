local ActivityCarnivalNetworkCtrl = class("ActivityCarnivalNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityCarnivalNetworkCtrl:ctor()
  self._singleTaskRefTable = {}
  self._singleRewardTable = {}
  self._allRewardTable = {}
  self._timePassTable = {}
  self._cycleReward = {}
end

function ActivityCarnivalNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_RefreshQuestSingle, self, proto_csmsg.SC_ACTIVITY_Carnival_RefreshQuestSingle, self.SC_ACTIVITY_Carnival_RefreshQuestSingle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_PickLevelReward, self, proto_csmsg.SC_ACTIVITY_Carnival_PickLevelReward, self.SC_ACTIVITY_Carnival_PickLevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_PickAllLevelReward, self, proto_csmsg.SC_ACTIVITY_Carnival_PickAllLevelReward, self.SC_ACTIVITY_Carnival_PickAllLevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_RefreshPeriod, self, proto_csmsg.SC_ACTIVITY_Carnival_RefreshPeriod, self.SC_ACTIVITY_Carnival_RefreshPeriod)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_PickCirCleReward, self, proto_csmsg.SC_ACTIVITY_Carnival_PickCirCleReward, self.SC_ACTIVITY_Carnival_PickCirCleReward)
end

function ActivityCarnivalNetworkCtrl:CS_ACTIVITY_Carnival_RefreshQuestSingle(actId, questId, callback)
  self._singleTaskRefTable.actId = actId
  self._singleTaskRefTable.questId = questId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshQuestSingle, proto_csmsg.CS_ACTIVITY_Carnival_RefreshQuestSingle, self._singleTaskRefTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshQuestSingle, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_RefreshQuestSingle)
end

function ActivityCarnivalNetworkCtrl:SC_ACTIVITY_Carnival_RefreshQuestSingle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Carnival_RefreshQuestSingle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshQuestSingle)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshQuestSingle, msg)
end

function ActivityCarnivalNetworkCtrl:CS_ACTIVITY_Carnival_PickLevelReward(actId, level, callback)
  self._singleRewardTable.actId = actId
  self._singleRewardTable.level = level
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickLevelReward, proto_csmsg.CS_ACTIVITY_Carnival_PickLevelReward, self._singleRewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_PickLevelReward)
end

function ActivityCarnivalNetworkCtrl:SC_ACTIVITY_Carnival_PickLevelReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Carnival_PickLevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickLevelReward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickLevelReward, msg)
end

function ActivityCarnivalNetworkCtrl:CS_ACTIVITY_Carnival_PickAllLevelReward(actId, callback)
  self._allRewardTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickAllLevelReward, proto_csmsg.CS_ACTIVITY_Carnival_PickAllLevelReward, self._allRewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickAllLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_PickAllLevelReward)
end

function ActivityCarnivalNetworkCtrl:SC_ACTIVITY_Carnival_PickAllLevelReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Carnival_PickAllLevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickAllLevelReward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickAllLevelReward, msg)
end

function ActivityCarnivalNetworkCtrl:CS_ACTIVITY_Carnival_RefreshPeriod(actId, callback)
  self._timePassTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshPeriod, proto_csmsg.CS_ACTIVITY_Carnival_RefreshPeriod, self._timePassTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshPeriod, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_RefreshPeriod)
end

function ActivityCarnivalNetworkCtrl:SC_ACTIVITY_Carnival_RefreshPeriod(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Carnival_RefreshPeriod error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_RefreshPeriod)
  end
end

function ActivityCarnivalNetworkCtrl:CS_ACTIVITY_Carnival_PickCirCleReward(actId, callback)
  self._cycleReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickCirCleReward, proto_csmsg.CS_ACTIVITY_Carnival_PickCirCleReward, self._cycleReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickCirCleReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival_PickCirCleReward)
end

function ActivityCarnivalNetworkCtrl:SC_ACTIVITY_Carnival_PickCirCleReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Carnival_PickCirCleReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickCirCleReward)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival_PickCirCleReward, msg)
end

return ActivityCarnivalNetworkCtrl
