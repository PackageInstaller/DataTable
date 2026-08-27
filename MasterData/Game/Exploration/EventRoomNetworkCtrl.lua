local EventRoomNetworkCtrl = class("EventRoomNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function EventRoomNetworkCtrl:ctor()
  self.__selectMsg = {}
  self._assistTab = {}
  self._assistExTab = {}
  self._algUpgradeBackTab = {}
  self._event_refresh = {}
  self._event_exit = {}
end

function EventRoomNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Select, self, proto_csmsg.SC_EXPLORATION_EVENT_Select, self.SC_EXPLORATION_EVENT_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Focus, self, proto_csmsg.SC_EXPLORATION_EVENT_Focus, self.SC_EXPLORATION_EVENT_Focus)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_RandomConfirm, self, proto_csmsg.SC_EXPLORATION_EVENT_RandomConfirm, self.SC_EXPLORATION_EVENT_RandomConfirm)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgrade, self, proto_csmsg.SC_EXPLORATION_EVENT_AlgUpgrade, self.SC_EXPLORATION_EVENT_AlgUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_SpecifyExit, self, proto_csmsg.SC_EXPLORATION_EVENT_SpecifyExit, self.SC_EXPLORATION_EVENT_SpecifyExit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Assist, self, proto_csmsg.SC_EXPLORATION_EVENT_Assist, self.SC_EXPLORATION_EVENT_Assist)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgradeBack, self, proto_csmsg.SC_EXPLORATION_EVENT_AlgUpgradeBack, self.SC_EXPLORATION_EVENT_AlgUpgradeBack)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AssistEX, self, proto_csmsg.SC_EXPLORATION_EVENT_AssistEX, self.SC_EXPLORATION_EVENT_AssistEX)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReFresh, self, proto_csmsg.SC_EXPLORATION_EVENT_ReFresh, self.SC_EXPLORATION_EVENT_ReFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Exit, self, proto_csmsg.SC_EXPLORATION_EVENT_Exit, self.SC_EXPLORATION_EVENT_Exit)
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_Select(position, index)
  self.__selectMsg.position = position
  self.__selectMsg.idx = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Select, proto_csmsg.CS_EXPLORATION_EVENT_Select, self.__selectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Select)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_Select(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Select)
    local errorLog
    if msg.ret == proto_csmsg_ErrorCode.EXPLORATION_EVENT_CONSUME_NOT_ENOUGH then
      errorLog = ConfigData:GetTipContent(TipContent.eventRoom_ItemInfficient)
    else
      errorLog = "SC_EXPLORATION_EVENT_Select error:" .. tostring(msg.ret)
    end
    self:ShowSCErrorMsg(errorLog)
    return
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  local choiceCtrl = ExplorationManager.epCtrl:GetLastSelectChoiceCtrl()
  if choiceCtrl ~= nil then
    choiceCtrl:OnChoiceItemSelectSuccess(msg)
  end
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_Focus(position)
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Focus, proto_csmsg.CS_EXPLORATION_EVENT_Focus, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Focus, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Focus)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_Focus(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Focus)
    local err = "SC_EXPLORATION_EVENT_Focus error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.eventCtrl:OnRejudegeOver(msg.value)
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_RandomConfirm(position)
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_RandomConfirm, proto_csmsg.CS_EXPLORATION_EVENT_RandomConfirm, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_RandomConfirm, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_RandomConfirm)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_RandomConfirm(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_RandomConfirm)
    local err = "SC_EXPLORATION_EVENT_RandomConfirm error,code:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  if ExplorationManager.epCtrl == nil then
    return
  end
  ExplorationManager.epCtrl.eventCtrl:OnCollectRewardSuccess()
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_AlgUpgrade(position, chipId, callback)
  self.__selectMsg = {}
  self.__selectMsg.position = position
  self.__selectMsg.algId = chipId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgrade, proto_csmsg.CS_EXPLORATION_EVENT_AlgUpgrade, self.__selectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgrade)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_AlgUpgrade(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgrade)
    local err = "EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_AlgUpgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_SpecifyExit(position, callback)
  self.__selectMsg = {}
  self.__selectMsg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_SpecifyExit, proto_csmsg.CS_EXPLORATION_EVENT_SpecifyExit, self.__selectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_SpecifyExit, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_SpecifyExit)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_SpecifyExit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_SpecifyExit)
    local err = "EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_SpecifyExit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_AlgUpgradeBack(position, callback)
  self._algUpgradeBackTab.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgradeBack, proto_csmsg.CS_EXPLORATION_EVENT_AlgUpgradeBack, self._algUpgradeBackTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgradeBack, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AlgUpgradeBack)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_AlgUpgradeBack(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AlgUpgradeBack)
    local err = "SC_EXPLORATION_EVENT_AlgUpgradeBack error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_Assist(roomPos, quitHeroUidList, enterIdList, callback)
  self._assistTab.position = roomPos
  self._assistTab.quit = quitHeroUidList
  self._assistTab.enter = enterIdList
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist, proto_csmsg.CS_EXPLORATION_EVENT_Assist, self._assistTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Assist)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_Assist(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist)
    local err = "SC_EXPLORATION_EVENT_Assist error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Assist, msg)
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_AssistEX(roomPos, quitHeroUidDic, enterIdDic, callback)
  self._assistExTab.position = roomPos
  self._assistExTab.quit = quitHeroUidDic
  self._assistExTab.enter = enterIdDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AssistEX, proto_csmsg.CS_EXPLORATION_EVENT_AssistEX, self._assistExTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AssistEX, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_AssistEX)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_AssistEX(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AssistEX)
    local err = "SC_EXPLORATION_EVENT_AssistEX error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_AssistEX, msg)
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_ReFresh(position, callback)
  self._event_refresh.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReFresh, proto_csmsg.CS_EXPLORATION_EVENT_ReFresh, self._event_refresh)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReFresh, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReFresh)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_ReFresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_EVENT_ReFresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReFresh)
  end
end

function EventRoomNetworkCtrl:CS_EXPLORATION_EVENT_Exit(position, callback)
  self._event_exit.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Exit, proto_csmsg.CS_EXPLORATION_EVENT_Exit, self._event_exit)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Exit, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_Exit)
end

function EventRoomNetworkCtrl:SC_EXPLORATION_EVENT_Exit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_EVENT_Exit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_Exit)
  end
end

function EventRoomNetworkCtrl:Reset()
end

return EventRoomNetworkCtrl
