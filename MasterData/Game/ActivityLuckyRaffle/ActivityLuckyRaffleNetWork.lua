local ActivityLuckyRaffleNetWork = class("ActivityLuckyRaffleNetWork", NetworkCtrlBase)
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityLuckyRaffleNetWork:ctor()
  self._voteTable = {}
end

function ActivityLuckyRaffleNetWork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_LuckyRaffle_Vote, self, proto_csmsg.SC_ACTIVITY_LuckyRaffle_Vote, self.SC_ACTIVITY_LuckyRaffle_Vote)
end

function ActivityLuckyRaffleNetWork:CS_ACTIVITY_LuckyRaffle_Vote(actId, poolId, successAction)
  self._voteTable.actId = actId
  self._voteTable.poolId = poolId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_LuckyRaffle_Vote, proto_csmsg.CS_ACTIVITY_LuckyRaffle_Vote, self._voteTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_LuckyRaffle_Vote, successAction, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_LuckyRaffle_Vote)
end

function ActivityLuckyRaffleNetWork:SC_ACTIVITY_LuckyRaffle_Vote(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_LuckyRaffle_Vote error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_LuckyRaffle_Vote)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_LuckyRaffle_Vote, msg.actData)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_LuckyRaffle_Vote, msg.rewards)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return ActivityLuckyRaffleNetWork
