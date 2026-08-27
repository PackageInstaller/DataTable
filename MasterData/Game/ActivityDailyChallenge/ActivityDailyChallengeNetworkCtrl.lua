local ActivityDailyChallengeNetworkCtrl = class("ActivityDailyChallengeNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityDailyChallengeNetworkCtrl:ctor()
  self._refreshItemTable = {}
  self._receivePointTable = {}
  self._unlockDungeonTable = {}
end

function ActivityDailyChallengeNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DailyChallenge_RefreshUnlockItem, self, proto_csmsg.SC_ACTIVITY_DailyChallenge_RefreshUnlockItem, self.SC_ACTIVITY_DailyChallenge_RefreshUnlockItem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DailyChallenge_GetPointReward, self, proto_csmsg.SC_ACTIVITY_DailyChallenge_GetPointReward, self.SC_ACTIVITY_DailyChallenge_GetPointReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DailyChallenge_UnlockDungeon, self, proto_csmsg.SC_ACTIVITY_DailyChallenge_UnlockDungeon, self.SC_ACTIVITY_DailyChallenge_UnlockDungeon)
end

function ActivityDailyChallengeNetworkCtrl:CS_ACTIVITY_DailyChallenge_RefreshUnlockItem(actId, callback)
  self._refreshItemTable.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_RefreshUnlockItem, proto_csmsg.CS_ACTIVITY_DailyChallenge_RefreshUnlockItem, self._refreshItemTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_RefreshUnlockItem, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DailyChallenge_RefreshUnlockItem)
end

function ActivityDailyChallengeNetworkCtrl:SC_ACTIVITY_DailyChallenge_RefreshUnlockItem(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_DailyChallenge_RefreshUnlockItem error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_RefreshUnlockItem)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_RefreshUnlockItem, msg)
end

function ActivityDailyChallengeNetworkCtrl:CS_ACTIVITY_DailyChallenge_GetPointReward(actId, score, getAll, callback)
  self._receivePointTable.actId = actId
  self._receivePointTable.score = score
  self._receivePointTable.getAll = getAll or false
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_GetPointReward, proto_csmsg.CS_ACTIVITY_DailyChallenge_GetPointReward, self._receivePointTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_GetPointReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DailyChallenge_GetPointReward)
end

function ActivityDailyChallengeNetworkCtrl:SC_ACTIVITY_DailyChallenge_GetPointReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_DailyChallenge_GetPointReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_GetPointReward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_GetPointReward, msg)
end

function ActivityDailyChallengeNetworkCtrl:CS_ACTIVITY_DailyChallenge_UnlockDungeon(actId, dungeonId, callback)
  self._unlockDungeonTable.actId = actId
  self._unlockDungeonTable.dungeonId = dungeonId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_UnlockDungeon, proto_csmsg.CS_ACTIVITY_DailyChallenge_UnlockDungeon, self._unlockDungeonTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_UnlockDungeon, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DailyChallenge_UnlockDungeon)
end

function ActivityDailyChallengeNetworkCtrl:SC_ACTIVITY_DailyChallenge_UnlockDungeon(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_DailyChallenge_UnlockDungeon error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_UnlockDungeon)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DailyChallenge_UnlockDungeon, msg)
end

return ActivityDailyChallengeNetworkCtrl
