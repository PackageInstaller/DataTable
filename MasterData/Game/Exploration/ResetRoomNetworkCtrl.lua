local ResetRoomNetworkCtrl = class("ResetRoomNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ResetRoomNetworkCtrl:ctor()
  self.__sendPosition = {}
  self.__sendReproduction = {}
  self.__sendFusion = {}
  self.__sendReconstitution = {}
end

function ResetRoomNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reproduction, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Reproduction, self.SC_EXPLORATION_RECONSTITUTION_Reproduction)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Fusion, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Fusion, self.SC_EXPLORATION_RECONSTITUTION_Fusion)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reconstitution, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Reconstitution, self.SC_EXPLORATION_RECONSTITUTION_Reconstitution)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Quit, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Quit, self.SC_EXPLORATION_RECONSTITUTION_Quit)
end

function ResetRoomNetworkCtrl:CS_EXPLORATION_RECONSTITUTION_Reproduction(position, algData, heroId)
  self.__sendReproduction.position = position
  self.__sendReproduction.alg = {}
  self.__sendReproduction.alg.algId = algData.dataId
  self.__sendReproduction.alg.ch = algData:GetHeroID() or 0
  self.__sendReproduction.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reproduction, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Reproduction, self.__sendReproduction)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reproduction, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reproduction)
end

function ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Reproduction(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Reproduction error" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.resetRoomCtrl:OnSendMsgSuccess()
end

function ResetRoomNetworkCtrl:CS_EXPLORATION_RECONSTITUTION_Fusion(position, algItemList)
  if #algItemList < 0 then
    return
  end
  self.__sendFusion.position = position
  self.__sendFusion.alg = {}
  for _, v in ipairs(algItemList) do
    local tab = {}
    tab.algId = v.dataId
    tab.ch = v.chipData:GetHeroID() or 0
    table.insert(self.__sendFusion.alg, tab)
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Fusion, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Fusion, self.__sendFusion)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Fusion, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Fusion)
end

function ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Fusion(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Fusion)
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Fusion error" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.resetRoomCtrl:OnSendMsgSuccess(msg.alg)
end

function ResetRoomNetworkCtrl:CS_EXPLORATION_RECONSTITUTION_Reconstitution(position, algData)
  self.__sendReconstitution.position = position
  self.__sendReconstitution.alg = {}
  self.__sendReconstitution.alg.algId = algData.dataId
  self.__sendReconstitution.alg.ch = algData:GetHeroID() or 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reconstitution, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Reconstitution, self.__sendReconstitution)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reconstitution, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reconstitution)
end

function ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Reconstitution(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reconstitution)
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Reconstitution error" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.resetRoomCtrl:OnSendMsgSuccess(msg.alg)
end

function ResetRoomNetworkCtrl:CS_EXPLORATION_RECONSTITUTION_Quit(position)
  self.__sendPosition.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Quit, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Quit, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Quit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Quit)
end

function ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Quit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Quit)
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Quit error" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.resetRoomCtrl:CloseResetRoom()
end

function ResetRoomNetworkCtrl:Reset()
end

return ResetRoomNetworkCtrl
