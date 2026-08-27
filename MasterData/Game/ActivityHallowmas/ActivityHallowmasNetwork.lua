local ActivityHallowmasNetwork = class("ActivityHallowmasNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityHallowmasNetwork:ctor()
  self._taskRef = {}
  self._expReaward = {}
  self._expAllReward = {}
  self._expBuy = {}
  self._cycleReward = {}
  self._allChieveCommit = {}
end

function ActivityHallowmasNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_RefreshSingleQuest, self, proto_csmsg.SC_ACTIVITY_Halloween2022_RefreshSingleQuest, self.SC_ACTIVITY_Halloween2022_RefreshSingleQuest)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickLevelReward, self, proto_csmsg.SC_ACTIVITY_Halloween2022_PickLevelReward, self.SC_ACTIVITY_Halloween2022_PickLevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickAllLevelReward, self, proto_csmsg.SC_ACTIVITY_Halloween2022_PickAllLevelReward, self.SC_ACTIVITY_Halloween2022_PickAllLevelReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_BuyScore, self, proto_csmsg.SC_ACTIVITY_Halloween2022_BuyScore, self.SC_ACTIVITY_Halloween2022_BuyScore)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickCycleReward, self, proto_csmsg.SC_ACTIVITY_Halloween2022_PickCycleReward, self.SC_ACTIVITY_Halloween2022_PickCycleReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_CommitAllAchievement, self, proto_csmsg.SC_ACTIVITY_Halloween2022_CommitAllAchievement, self.SC_ACTIVITY_Halloween2022_CommitAllAchievement)
end

function ActivityHallowmasNetwork:CS_ACTIVITY_Halloween2022_RefreshSingleQuest(actId, taskId, callback)
  self._taskRef.actId = actId
  self._taskRef.questId = taskId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_RefreshSingleQuest, proto_csmsg.CS_ACTIVITY_Halloween2022_RefreshSingleQuest, self._taskRef)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_RefreshSingleQuest, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_RefreshSingleQuest)
end

function ActivityHallowmasNetwork:SC_ACTIVITY_Halloween2022_RefreshSingleQuest(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Halloween2022_RefreshSingleQuest error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_RefreshSingleQuest)
    return
  end
end

function ActivityHallowmasNetwork:CS_ACTIVITY_Halloween2022_PickLevelReward(actId, level, callback)
  self._expReaward.actId = actId
  self._expReaward.level = level
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_PickLevelReward, proto_csmsg.CS_ACTIVITY_Halloween2022_PickLevelReward, self._expReaward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_PickLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickLevelReward)
end

function ActivityHallowmasNetwork:SC_ACTIVITY_Halloween2022_PickLevelReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Halloween2022_PickLevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickLevelReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivityHallowmasNetwork:CS_ACTIVITY_Halloween2022_PickAllLevelReward(actId, callback)
  self._expAllReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_PickAllLevelReward, proto_csmsg.CS_ACTIVITY_Halloween2022_PickAllLevelReward, self._expAllReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_PickAllLevelReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickAllLevelReward)
end

function ActivityHallowmasNetwork:SC_ACTIVITY_Halloween2022_PickAllLevelReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Halloween2022_PickAllLevelReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickAllLevelReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivityHallowmasNetwork:CS_ACTIVITY_Halloween2022_BuyScore(actId, count, callback)
  self._expBuy.actId = actId
  self._expBuy.buyCnt = count
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_BuyScore, proto_csmsg.CS_ACTIVITY_Halloween2022_BuyScore, self._expBuy)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_BuyScore, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_BuyScore)
end

function ActivityHallowmasNetwork:SC_ACTIVITY_Halloween2022_BuyScore(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Halloween2022_BuyScore error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_BuyScore)
    return
  end
end

function ActivityHallowmasNetwork:CS_ACTIVITY_Halloween2022_PickCycleReward(actId, callback)
  self._cycleReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_PickCycleReward, proto_csmsg.CS_ACTIVITY_Halloween2022_PickCycleReward, self._cycleReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_PickCycleReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickCycleReward)
end

function ActivityHallowmasNetwork:SC_ACTIVITY_Halloween2022_PickCycleReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Halloween2022_PickCycleReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_PickCycleReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivityHallowmasNetwork:CS_ACTIVITY_Halloween2022_CommitAllAchievement(actId, callback)
  self._allChieveCommit.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_CommitAllAchievement, proto_csmsg.CS_ACTIVITY_Halloween2022_CommitAllAchievement, self._allChieveCommit)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Halloween2022_CommitAllAchievement, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_CommitAllAchievement)
end

function ActivityHallowmasNetwork:SC_ACTIVITY_Halloween2022_CommitAllAchievement(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Halloween2022_CommitAllAchievement error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Halloween2022_CommitAllAchievement)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

return ActivityHallowmasNetwork
