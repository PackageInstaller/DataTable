local FlappyBirdNetWorkCtrl = class("FlappyBirdNetWorkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function FlappyBirdNetWorkCtrl:ctor()
  self.__sendMsg = {}
end

function FlappyBirdNetWorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FlappyBird_Settle, self, proto_csmsg.SC_FlappyBird_Settle, self.SC_FlappyBird_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FlappyBird_ProgressDetail, self, proto_csmsg.SC_FlappyBird_ProgressDetail, self.SC_FlappyBird_ProgressDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_FlappyBird_SelfRankDetail, self, proto_csmsg.SC_FlappyBird_SelfRankDetail, self.SC_FlappyBird_SelfRankDetail)
end

function FlappyBirdNetWorkCtrl:CS_FlappyBird_Settle(actGroupId, birdId, score, frameNum, checkParam, action)
  self.__sendMsg = {}
  self.__sendMsg.actLongId = actGroupId
  self.__sendMsg.birdId = birdId
  self.__sendMsg.score = score
  self.__sendMsg.currentFrame = frameNum
  self.__sendMsg.checkParam = checkParam
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_Settle, proto_csmsg.CS_FlappyBird_Settle, self.__sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_Settle, action, proto_csmsg_MSG_ID.MSG_SC_FlappyBird_Settle)
end

function FlappyBirdNetWorkCtrl:SC_FlappyBird_Settle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_Settle)
    local err = "FlappyBirdNetWorkCtrl:SC_FlappyBird_Settle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_Settle, msg)
end

function FlappyBirdNetWorkCtrl:CS_FlappyBird_ProgressDetail(actLongId, birdId, action)
  self.__sendMsg = {}
  self.__sendMsg.actLongId = actLongId
  self.__sendMsg.birdId = birdId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_ProgressDetail, proto_csmsg.CS_FlappyBird_ProgressDetail, self.__sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_ProgressDetail, action, proto_csmsg_MSG_ID.MSG_SC_FlappyBird_ProgressDetail)
end

function FlappyBirdNetWorkCtrl:SC_FlappyBird_ProgressDetail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_ProgressDetail)
    local err = "FlappyBirdNetWorkCtrl:SC_FlappyBird_ProgressDetail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_ProgressDetail, msg)
end

function FlappyBirdNetWorkCtrl:CS_FlappyBird_SelfRankDetail(actLongId, birdId, action)
  self.__sendMsg = {}
  self.__sendMsg.actLongId = actLongId
  self.__sendMsg.birdId = birdId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_SelfRankDetail, proto_csmsg.CS_FlappyBird_SelfRankDetail, self.__sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_SelfRankDetail, action, proto_csmsg_MSG_ID.MSG_SC_FlappyBird_SelfRankDetail)
end

function FlappyBirdNetWorkCtrl:SC_FlappyBird_SelfRankDetail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_SelfRankDetail)
    local err = "FlappyBirdNetWorkCtrl:SC_FlappyBird_SelfRankDetail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_FlappyBird_SelfRankDetail, msg)
end

return FlappyBirdNetWorkCtrl
