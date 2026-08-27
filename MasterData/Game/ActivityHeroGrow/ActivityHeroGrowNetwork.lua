local ActivityHeroGrowNetwork = class("ActivityHeroGrowNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityHeroGrowNetwork:ctor()
  self._dailyTaskFullReward = {}
  self._singleTokenReward = {}
  self._allTokeonReward = {}
  self._dailyTaskAllReward = {}
end

function ActivityHeroGrowNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_DailyTaskFullReward, self, proto_csmsg.SC_ACTIVITYSectorHero_DailyTaskFullReward, self.SC_ACTIVITYSectorHero_DailyTaskFullReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_SingleTokenReward, self, proto_csmsg.SC_ACTIVITYSectorHero_SingleTokenReward, self.SC_ACTIVITYSectorHero_SingleTokenReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_AllTokenReward, self, proto_csmsg.SC_ACTIVITYSectorHero_AllTokenReward, self.SC_ACTIVITYSectorHero_AllTokenReward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_DailyTaskAllReward, self, proto_csmsg.SC_ACTIVITYSectorHero_DailyTaskAllReward, self.SC_ACTIVITYSectorHero_DailyTaskAllReward)
end

function ActivityHeroGrowNetwork:CS_ACTIVITYSectorHero_DailyTaskFullReward(actId, day, callback)
  self._dailyTaskFullReward.actId = actId
  self._dailyTaskFullReward.day = day
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_DailyTaskFullReward, proto_csmsg.CS_ACTIVITYSectorHero_DailyTaskFullReward, self._dailyTaskFullReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_DailyTaskFullReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_DailyTaskFullReward)
end

function ActivityHeroGrowNetwork:SC_ACTIVITYSectorHero_DailyTaskFullReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSectorHero_DailyTaskFullReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_DailyTaskFullReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowNetwork:CS_ACTIVITYSectorHero_SingleTokenReward(actId, tokenRewardLv, callback)
  self._singleTokenReward.actId = actId
  self._singleTokenReward.tokenRewardLv = tokenRewardLv
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_SingleTokenReward, proto_csmsg.CS_ACTIVITYSectorHero_SingleTokenReward, self._singleTokenReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_SingleTokenReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_SingleTokenReward)
end

function ActivityHeroGrowNetwork:SC_ACTIVITYSectorHero_SingleTokenReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSectorHero_SingleTokenReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_SingleTokenReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowNetwork:CS_ACTIVITYSectorHero_AllTokenReward(actId, callback)
  self._allTokeonReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_AllTokenReward, proto_csmsg.CS_ACTIVITYSectorHero_AllTokenReward, self._allTokeonReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_AllTokenReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_AllTokenReward)
end

function ActivityHeroGrowNetwork:SC_ACTIVITYSectorHero_AllTokenReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSectorHero_AllTokenReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_AllTokenReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityHeroGrowNetwork:CS_ACTIVITYSectorHero_DailyTaskAllReward(actId, callback)
  self._dailyTaskAllReward.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_DailyTaskAllReward, proto_csmsg.CS_ACTIVITYSectorHero_DailyTaskAllReward, self._dailyTaskAllReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITYSectorHero_DailyTaskAllReward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_DailyTaskAllReward)
end

function ActivityHeroGrowNetwork:SC_ACTIVITYSectorHero_DailyTaskAllReward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITYSectorHero_DailyTaskAllReward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSectorHero_DailyTaskAllReward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

return ActivityHeroGrowNetwork
