local TinyGameNetworkCtrl = class("TinyGameNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function TinyGameNetworkCtrl:ctor()
  self._getRewardTable = {}
end

function TinyGameNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityGame_2048_Settle, self, proto_csmsg.SC_ActivityGame_2048_Settle, self.SC_ActivityGame_2048_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityGame_2048_SelfRankDetail, self, proto_csmsg.SC_ActivityGame_2048_SelfRankDetail, self.SC_ActivityGame_2048_SelfRankDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TinyGame_Reward, self, proto_csmsg.SC_TinyGame_Reward, self.SC_TinyGame_Reward)
end

function TinyGameNetworkCtrl:CS_ActivityGame_2048_Settle(actId, gameId, score, action)
  local sendMsg = {}
  sendMsg.actLongId = actId
  sendMsg.gameId = gameId
  sendMsg.score = score
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_Settle, proto_csmsg.CS_ActivityGame_2048_Settle, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_Settle, action, proto_csmsg_MSG_ID.MSG_SC_ActivityGame_2048_Settle)
end

function TinyGameNetworkCtrl:SC_ActivityGame_2048_Settle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_Settle)
    local err = "TinyGameNetworkCtrl:SC_ActivityGame_2048_Settle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function TinyGameNetworkCtrl:CS_ActivityGame_2048_SelfRankDetail(actId, gameId, action)
  local sendMsg = {}
  sendMsg.actLongId = actId
  sendMsg.gameId = gameId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_SelfRankDetail, proto_csmsg.CS_ActivityGame_2048_SelfRankDetail, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_SelfRankDetail, action, proto_csmsg_MSG_ID.MSG_SC_ActivityGame_2048_SelfRankDetail)
end

function TinyGameNetworkCtrl:SC_ActivityGame_2048_SelfRankDetail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_SelfRankDetail)
    local err = "TinyGameNetworkCtrl:SC_ActivityGame_2048_SelfRankDetail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ActivityGame_2048_SelfRankDetail, msg)
end

function TinyGameNetworkCtrl:CS_TinyGame_Reward(actLongId, level, gameCat, callback)
  self._getRewardTable.actLongId = actLongId
  self._getRewardTable.level = level
  self._getRewardTable.gameCat = gameCat
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Reward, proto_csmsg.CS_TinyGame_Reward, self._getRewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_TinyGame_Reward)
end

function TinyGameNetworkCtrl:SC_TinyGame_Reward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_TinyGame_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Reward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Reward, msg)
  UIUtil.ShowCommonReward(msg.rewards)
end

function TinyGameNetworkCtrl:Reset()
end

return TinyGameNetworkCtrl
