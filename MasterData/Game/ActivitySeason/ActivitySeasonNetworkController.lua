local ActivitySeasonNetworkController = class("ActivitySeasonNetworkController", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivitySeasonNetworkController:ctor()
  self._pickRef = {}
end

function ActivitySeasonNetworkController:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickLevelReward, self, proto_csmsg.SC_ACTIVITY_Season_PickLevelReward, self.SC_ACTIVITY_Season_PickLevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickCirCleReward, self, proto_csmsg.SC_ACTIVITY_Season_PickCirCleReward, self.SC_ACTIVITY_Season_PickCirCleReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickAllLevelReward, self, proto_csmsg.SC_ACTIVITY_Season_PickAllLevelReward, self.SC_ACTIVITY_Season_PickAllLevelReward)
end

function ActivitySeasonNetworkController:CS_ACTIVITY_Season_PickLevelReward(actId, level, callback)
  self._pickRef.actId = actId
  self._pickRef.level = level
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickLevelReward, proto_csmsg.CS_ACTIVITY_Season_PickLevelReward, self._pickRef)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickLevelReward)
end

function ActivitySeasonNetworkController:SC_ACTIVITY_Season_PickLevelReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Season_PickLevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickLevelReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivitySeasonNetworkController:CS_ACTIVITY_Season_PickCirCleReward(actId, callback)
  self._pickRef.actId = actId
  self._pickRef.level = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickCirCleReward, proto_csmsg.CS_ACTIVITY_Season_PickCirCleReward, self._pickRef)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickCirCleReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickCirCleReward)
end

function ActivitySeasonNetworkController:SC_ACTIVITY_Season_PickCirCleReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Season_PickCirCleReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickCirCleReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivitySeasonNetworkController:CS_ACTIVITY_Season_PickAllLevelReward(actId, callback)
  self._pickRef.actId = actId
  self._pickRef.level = nil
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickAllLevelReward, proto_csmsg.CS_ACTIVITY_Season_PickAllLevelReward, self._pickRef)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Season_PickAllLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickAllLevelReward)
end

function ActivitySeasonNetworkController:SC_ACTIVITY_Season_PickAllLevelReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Season_PickAllLevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Season_PickAllLevelReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

return ActivitySeasonNetworkController
