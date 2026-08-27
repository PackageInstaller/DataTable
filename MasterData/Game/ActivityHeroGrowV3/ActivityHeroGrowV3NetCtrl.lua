local ActivityHeroGrowV3NetCtrl = class("ActivityHeroGrowV3NetCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityHeroGrowV3NetCtrl:ctor()
  self._dailyTaskFullReward = {}
  self._singleTokenReward = {}
  self._allTokeonReward = {}
  self._dailyTaskAllReward = {}
  self._challengeReward = {}
end

function ActivityHeroGrowV3NetCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_DailyTaskFullReward, self, proto_csmsg.SC_Activity_SectorHeroLite_DailyTaskFullReward, self.SC_Activity_SectorHeroLite_DailyTaskFullReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_SingleTokenReward, self, proto_csmsg.SC_Activity_SectorHeroLite_SingleTokenReward, self.SC_Activity_SectorHeroLite_SingleTokenReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_AllTokenReward, self, proto_csmsg.SC_Activity_SectorHeroLite_AllTokenReward, self.SC_Activity_SectorHeroLite_AllTokenReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_DailyTaskAllReward, self, proto_csmsg.SC_Activity_SectorHeroLite_DailyTaskAllReward, self.SC_Activity_SectorHeroLite_DailyTaskAllReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_HardDungeon_PickScoreReward, self, proto_csmsg.SC_Activity_HardDungeon_PickScoreReward, self.SC_Activity_HardDungeon_PickScoreReward)
end

function ActivityHeroGrowV3NetCtrl:CS_Activity_SectorHeroLite_DailyTaskFullReward(actId, day, callback)
  self._dailyTaskFullReward.actId = actId
  self._dailyTaskFullReward.day = day
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_DailyTaskFullReward, proto_csmsg.CS_Activity_SectorHeroLite_DailyTaskFullReward, self._dailyTaskFullReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_DailyTaskFullReward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_DailyTaskFullReward)
end

function ActivityHeroGrowV3NetCtrl:SC_Activity_SectorHeroLite_DailyTaskFullReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_SectorHeroLite_DailyTaskFullReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_DailyTaskFullReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowV3NetCtrl:CS_Activity_SectorHeroLite_SingleTokenReward(actId, tokenRewardLv, callback)
  self._singleTokenReward.actId = actId
  self._singleTokenReward.tokenRewardLv = tokenRewardLv
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_SingleTokenReward, proto_csmsg.CS_Activity_SectorHeroLite_SingleTokenReward, self._singleTokenReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_SingleTokenReward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_SingleTokenReward)
end

function ActivityHeroGrowV3NetCtrl:SC_Activity_SectorHeroLite_SingleTokenReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_SectorHeroLite_SingleTokenReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_SingleTokenReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowV3NetCtrl:CS_Activity_SectorHeroLite_AllTokenReward(actId, callback)
  self._allTokeonReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_AllTokenReward, proto_csmsg.CS_Activity_SectorHeroLite_AllTokenReward, self._allTokeonReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_AllTokenReward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_AllTokenReward)
end

function ActivityHeroGrowV3NetCtrl:SC_Activity_SectorHeroLite_AllTokenReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_SectorHeroLite_AllTokenReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_AllTokenReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowV3NetCtrl:CS_Activity_SectorHeroLite_DailyTaskAllReward(actId, callback)
  self._dailyTaskAllReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_DailyTaskAllReward, proto_csmsg.CS_Activity_SectorHeroLite_DailyTaskAllReward, self._dailyTaskAllReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_SectorHeroLite_DailyTaskAllReward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_DailyTaskAllReward)
end

function ActivityHeroGrowV3NetCtrl:SC_Activity_SectorHeroLite_DailyTaskAllReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_SectorHeroLite_DailyTaskAllReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_Activity_SectorHeroLite_DailyTaskAllReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowV3NetCtrl:CS_Activity_HardDungeon_PickScoreReward(actLongId, level, callback)
  self._challengeReward.actLongId = actLongId
  self._challengeReward.level = level
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_HardDungeon_PickScoreReward, proto_csmsg.CS_Activity_HardDungeon_PickScoreReward, self._challengeReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_HardDungeon_PickScoreReward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_HardDungeon_PickScoreReward)
end

function ActivityHeroGrowV3NetCtrl:SC_Activity_HardDungeon_PickScoreReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_HardDungeon_PickScoreReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_Activity_HardDungeon_PickScoreReward)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

return ActivityHeroGrowV3NetCtrl
