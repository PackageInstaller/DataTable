local WarChessNetworkCtrl = class("WarChessNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function WarChessNetworkCtrl:ctor()
  self.singleStartMsg = {}
  self.freshFmtMsg = {
    identify = {},
    formInfo = {},
    fromFormationIdx = nil
  }
  self.teamMoveMsg = {
    identify = {},
    wcPos = {}
  }
  self.teamInteractMsg = {
    identify = {},
    wcPos = nil,
    entityCat = nil,
    interactionId = nil
  }
  self.turnOverMsg = {wid = nil}
  self._battleSelectAlg = {
    identify = {}
  }
  self.storeBuyChipMsg = {
    identify = nil,
    idx = nil,
    tid = nil
  }
  self.storeBuyBuffMsg = {identify = nil, idx = nil}
  self.storeRefreshMsg = {identify = nil}
  self.storeExchangeMsg = {identify = nil, costItemId = nil}
  self.storeSaleMsg = {
    identify = nil,
    algId = nil,
    tid = nil
  }
  self.treasureSelectMsg = {
    identify = nil,
    index = nil,
    tid = nil
  }
  self.storeQuitMsg = {identify = nil}
  self.rewardBrief = {warChessConfigId = nil}
  self.resetMsg = {wid = nil, backRound = nil}
  self.exChangeMsg = {
    identify = {},
    identifyEnd = {}
  }
  self.rescueMsg = {
    identify = nil,
    heroes = nil,
    fromFormationIdx = nil,
    powerNum = nil
  }
  self.backBeforeBattle = {identify = nil}
  self.updateHpData = {identify = nil, monster = nil}
  self._Choice_ProtocolTab = {}
  self.getMonsterPower = {}
end

function WarChessNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_SingleStart, self, proto_csmsg.SC_WarChess_SingleStart, self.SC_WarChess_SingleStart)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_FreshFormation, self, proto_csmsg.SC_WarChess_FreshFormation, self.SC_WarChess_FreshFormation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Deploy, self, proto_csmsg.SC_WarChess_Deploy, self.SC_WarChess_Deploy)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_GameStart, self, proto_csmsg.SC_WarChess_GameStart, self.SC_WarChess_GameStart)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_MoveTo, self, proto_csmsg.SC_WarChess_MoveTo, self.SC_WarChess_MoveTo)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Interact, self, proto_csmsg.SC_WarChess_Interact, self.SC_WarChess_Interact)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_Settle, self, proto_csmsg.SC_WarChess_BattleSystem_Settle, self.SC_WarChess_BattleSystem_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_Quit, self, proto_csmsg.SC_WarChess_BattleSystem_Quit, self.SC_WarChess_BattleSystem_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_SelectAlg, self, proto_csmsg.SC_WarChess_BattleSystem_SelectAlg, self.SC_WarChess_BattleSystem_SelectAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_DropAlg, self, proto_csmsg.SC_WarChess_BattleSystem_DropAlg, self.SC_WarChess_BattleSystem_DropAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_RefreshAlg, self, proto_csmsg.SC_WarChess_BattleSystem_RefreshAlg, self.SC_WarChess_BattleSystem_RefreshAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BroadCastOver, self, proto_csmsg.SC_WarChess_BroadCastOver, self.SC_WarChess_BroadCastOver)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_RoundStartSingle, self, proto_csmsg.SC_WarChess_RoundStartSingle, self.SC_WarChess_RoundStartSingle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_SelectAlg, self, proto_csmsg.SC_WarChess_StoreSystem_SelectAlg, self.SC_WarChess_StoreSystem_SelectAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_Quit, self, proto_csmsg.SC_WarChess_StoreSystem_Quit, self.SC_WarChess_StoreSystem_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_Sale, self, proto_csmsg.SC_WarChess_StoreSystem_Sale, self.SC_WarChess_StoreSystem_SaleAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_Refresh, self, proto_csmsg.SC_WarChess_StoreSystem_Refresh, self.SC_WarChess_StoreSystem_Refresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_ExchangeItem, self, proto_csmsg.SC_WarChess_StoreSystem_ExchangeItem, self.SC_WarChess_StoreSystem_ExchangeItem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_SelectBuff, self, proto_csmsg.SC_WarChess_StoreSystem_SelectBuff, self.SC_WarChess_StoreSystem_SelectBuff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BoxSystem_SelectAlg, self, proto_csmsg.SC_WarChess_BoxSystem_SelectAlg, self.SC_WarChess_BoxSystem_SelectAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BoxSystem_DropAlg, self, proto_csmsg.SC_WarChess_BoxSystem_DropAlg, self.SC_WarChess_BoxSystem_DropAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BoxSystem_RefreshAlg, self, proto_csmsg.SC_WarChess_BoxSystem_RefreshAlg, self.SC_WarChess_BoxSystem_RefreshAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_EventSystem_Select, self, proto_csmsg.SC_WarChess_EventSystem_Select, self.SC_WarChess_EventSystem_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_AlgDiscardSystem_Select, self, proto_csmsg.SC_WarChess_AlgDiscardSystem_Select, self.SC_WarChess_AlgDiscardSystem_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_AlgDiscardSystem_Quit, self, proto_csmsg.SC_WarChess_AlgDiscardSystem_Quit, self.SC_WarChess_AlgDiscardSystem_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_AlgDiscardSystem_PurchaseAlgLimit, self, proto_csmsg.SC_WarChess_AlgDiscardSystem_PurchaseAlgLimit, self.SC_WarChess_AlgDiscardSystem_PurchaseAlgLimit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_RayCastSystem_Start, self, proto_csmsg.SC_WarChess_RayCastSystem_Start, self.SC_WarChess_RayCastSystem_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_RayCastSystem_Quit, self, proto_csmsg.SC_WarChess_RayCastSystem_Quit, self.SC_WarChess_RayCastSystem_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_SelectTeamForAlgSystem_Select, self, proto_csmsg.SC_WarChess_SelectTeamForAlgSystem_Select, self.SC_WarChess_SelectTeamForAlgSystem_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_SelectTeamForAlgSystem_Quit, self, proto_csmsg.SC_WarChess_SelectTeamForAlgSystem_Quit, self.SC_WarChess_SelectTeamForAlgSystem_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_JumpSystemData_Start, self, proto_csmsg.SC_WarChess_JumpSystemData_Start, self.SC_WarChess_JumpSystemData_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_JumpSystemData_Quit, self, proto_csmsg.SC_WarChess_JumpSystemData_Quit, self.SC_WarChess_JumpSystemData_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_JumpSystemData_Move, self, proto_csmsg.SC_WarChess_JumpSystemData_Move, self.SC_WarChess_JumpSystemData_Move)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_StartSystem, self, proto_csmsg.SC_WarChess_StartSystem, self.SC_WarChess_StartSystem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_OverSystem, self, proto_csmsg.SC_WarChess_OverSystem, self.SC_WarChess_OverSystem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_SwitchingSystem, self, proto_csmsg.SC_WarChess_SwitchingSystem, self.SC_WarChess_SwitchingSystem)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BroadCastSync, self, proto_csmsg.SC_WarChess_BroadCastSync, self.SC_WarChess_BroadCastSync)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Quit, self, proto_csmsg.SC_WarChess_Quit, self.SC_WarChess_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Settle, self, proto_csmsg.SC_WarChess_Settle, self.SC_WarChess_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Brief_Detail, self, proto_csmsg.SC_WarChess_Brief_Detail, self.SC_WarChess_Brief_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Detail, self, proto_csmsg.SC_WarChess_Detail, self.SC_WarChess_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_UniqueRewardBrief, self, proto_csmsg.SC_WarChess_UniqueRewardBrief, self.SC_WarChess_UniqueRewardBrief)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_ResetTheRound, self, proto_csmsg.SC_WarChess_ResetTheRound, self.SC_WarChess_ResetTheRound)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_EnterWarChessLobby, self, proto_csmsg.SC_WarChess_EnterWarChessLobby, self.SC_WarChess_EnterWarChessLobby)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_WarChessExchangePos, self, proto_csmsg.SC_WarChess_WarChessExchangePos, self.SC_WarChess_WarChessExchangePos)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteract, self, proto_csmsg.SC_WarChess_GlobalInteract, self.SC_WarChess_GlobalInteract)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_GetSeasonBackup, self, proto_csmsg.SC_WarChess_GetSeasonBackup, self.SC_WarChess_GetSeasonBackup)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_SetSeasonBackup, self, proto_csmsg.SC_WarChess_SetSeasonBackup, self.SC_WarChess_SetSeasonBackup)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_SeasonBackupChoice, self, proto_csmsg.SC_WarChess_SeasonBackupChoice, self.SC_WarChess_SeasonBackupChoice)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Event_FreshFormation, self, proto_csmsg.SC_WarChess_Event_FreshFormation, self.SC_WarChess_Event_FreshFormation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Event_StrategySelect, self, proto_csmsg.SC_WarChess_Event_StrategySelect, self.SC_WarChess_Event_StrategySelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteractTrigger, self, proto_csmsg.SC_WarChess_GlobalInteractTrigger, self.SC_WarChess_GlobalInteractTrigger)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_AvgOver, self, proto_csmsg.SC_WarChess_AvgOver, self.SC_WarChess_AvgOver)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChessSeasonRecord, self, proto_csmsg.SC_WarChessSeasonRecord, self.SC_WarChessSeasonRecord)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_OverReward_SelectAlg, self, proto_csmsg.SC_WarChess_OverReward_SelectAlg, self.SC_WarChess_OverReward_SelectAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_OverReward_DropAlg, self, proto_csmsg.SC_WarChess_OverReward_DropAlg, self.SC_WarChess_OverReward_DropAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_OverReward_RefreshAlg, self, proto_csmsg.SC_WarChess_OverReward_RefreshAlg, self.SC_WarChess_OverReward_RefreshAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_Choice_Protocol, self, proto_csmsg.SC_WarChess_Choice_Protocol, self.SC_WarChess_Choice_Protocol)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_MonsterPower, self, proto_csmsg.SC_WarChess_MonsterPower, self.SC_WarChess_MonsterPower)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_BackBeforeBattle, self, proto_csmsg.SC_WarChess_BattleSystem_BackBeforeBattle, self.SC_WarChess_BattleSystem_BackBeforeBattle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_UpdateData, self, proto_csmsg.SC_WarChess_BattleSystem_UpdateData, self.SC_WarChess_BattleSystem_UpdateData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_EventInBattle, self, proto_csmsg.SC_WarChess_EventInBattle, self.SC_WarChess_EventInBattle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_ChoiceEvent, self, proto_csmsg.SC_WarChess_BattleSystem_ChoiceEvent, self.SC_WarChess_BattleSystem_ChoiceEvent)
end

function WarChessNetworkCtrl:CS_WarChess_SingleStart(stageId, challengeMode, challengeQuests, warChessType, callback)
  self.singleStartMsg.warChessId = stageId
  self.singleStartMsg.challengeMode = challengeMode
  self.singleStartMsg.challengeQuests = challengeQuests
  self.singleStartMsg.warChessType = warChessType
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_SingleStart, proto_csmsg.CS_WarChess_SingleStart, self.singleStartMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SingleStart, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_SingleStart)
end

function WarChessNetworkCtrl:SC_WarChess_SingleStart(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_SingleStart error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SingleStart)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_SingleStart, msg.warChess)
end

function WarChessNetworkCtrl:CS_WarChess_FreshFormation(wid, tid, formationId, fromFormationIdx, power, officeAssist, fairyUid, callback)
  self.freshFmtMsg.identify.wid = wid
  self.freshFmtMsg.identify.tid = tid
  self.freshFmtMsg.formInfo.formationId = formationId
  self.freshFmtMsg.formInfo.fairyUid = fairyUid
  self.freshFmtMsg.fromFormationIdx = fromFormationIdx
  self.freshFmtMsg.powerNum = power
  self.freshFmtMsg.assist = officeAssist
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_FreshFormation, proto_csmsg.CS_WarChess_FreshFormation, self.freshFmtMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_FreshFormation, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_FreshFormation)
end

function WarChessNetworkCtrl:SC_WarChess_FreshFormation(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_FreshFormation error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_FreshFormation)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_Deploy(wid, tid, wcPos, entityCat, interactionId, callback)
  self.teamInteractMsg.identify.wid = wid
  self.teamInteractMsg.identify.tid = tid
  self.teamInteractMsg.wcPos = wcPos
  self.teamInteractMsg.entityCat = entityCat
  self.teamInteractMsg.interactionId = interactionId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Deploy, proto_csmsg.CS_WarChess_Deploy, self.teamInteractMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Deploy, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Deploy)
end

function WarChessNetworkCtrl:SC_WarChess_Deploy(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_Deploy error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Deploy, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Deploy, true)
end

function WarChessNetworkCtrl:CS_WarChess_GameStart(msg, callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_GameStart, proto_csmsg.CS_WarChess_GameStart, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_GameStart, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_GameStart)
end

function WarChessNetworkCtrl:SC_WarChess_GameStart(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_GameStart error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_GameStart, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_GameStart, true)
end

function WarChessNetworkCtrl:CS_WarChess_MoveTo(wid, tid, gridData, callback)
  self.teamMoveMsg.identify.wid = wid
  self.teamMoveMsg.identify.tid = tid
  self.teamMoveMsg.wcPos.gid = gridData:GetWCGridBFId()
  self.teamMoveMsg.wcPos.pos = WarChessHelper.Pos2Coordination(gridData:GetGridLogicPos())
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_MoveTo, proto_csmsg.CS_WarChess_MoveTo, self.teamMoveMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_MoveTo, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_MoveTo)
end

function WarChessNetworkCtrl:SC_WarChess_MoveTo(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_MoveTo error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_MoveTo, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_MoveTo, true)
end

function WarChessNetworkCtrl:CS_WarChess_Interact(wid, tid, wcPos, entityCat, interactionId, callback, battleInteract)
  self.teamInteractMsg.identify.wid = wid
  self.teamInteractMsg.identify.tid = tid
  self.teamInteractMsg.wcPos = wcPos
  self.teamInteractMsg.entityCat = entityCat
  self.teamInteractMsg.interactionId = interactionId
  self.teamInteractMsg.battleInteract = battleInteract
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Interact, proto_csmsg.CS_WarChess_Interact, self.teamInteractMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Interact, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Interact)
end

function WarChessNetworkCtrl:SC_WarChess_Interact(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_Interact error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Interact, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Interact, true)
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_Settle(sendMsg, callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Settle, proto_csmsg.CS_WarChess_BattleSystem_Settle, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Settle, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_Settle)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_Settle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BattleSystem_Settle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Settle, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Settle, true)
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_Quit(identify, callback)
  local msg = {identify = identify}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Quit, proto_csmsg.CS_WarChess_BattleSystem_Quit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BattleSystem_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Quit, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_Quit, true)
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_SelectAlg(wid, tid, idx, stid, callback)
  self._battleSelectAlg.identify.wid = wid
  self._battleSelectAlg.identify.tid = tid
  self._battleSelectAlg.idx = idx
  self._battleSelectAlg.tid = stid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_SelectAlg, proto_csmsg.CS_WarChess_BattleSystem_SelectAlg, self._battleSelectAlg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_SelectAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_SelectAlg)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_SelectAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BattleSystem_SelectAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_SelectAlg)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_DropAlg(wid, tid, callback)
  self._battleSelectAlg.identify.wid = wid
  self._battleSelectAlg.identify.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_DropAlg, proto_csmsg.CS_WarChess_BattleSystem_DropAlg, self._battleSelectAlg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_DropAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_DropAlg)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_DropAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BattleSystem_DropAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_DropAlg)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_RefreshAlg(wid, tid, callback)
  self._battleSelectAlg.identify.wid = wid
  self._battleSelectAlg.identify.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_RefreshAlg, proto_csmsg.CS_WarChess_BattleSystem_RefreshAlg, self._battleSelectAlg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_RefreshAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_RefreshAlg)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_RefreshAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BattleSystem_RefreshAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_RefreshAlg)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_RefreshAlg, msg)
end

function WarChessNetworkCtrl:CS_WarChess_StoreSystem_SelectAlg(identify, idx, tid, callback)
  self.storeBuyChipMsg.identify = identify
  self.storeBuyChipMsg.idx = idx
  self.storeBuyChipMsg.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_SelectAlg, proto_csmsg.CS_WarChess_StoreSystem_SelectAlg, self.storeBuyChipMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_SelectAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_SelectAlg)
end

function WarChessNetworkCtrl:SC_WarChess_StoreSystem_SelectAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_StoreSystem_SelectAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_StoreSystem_SaleAlg(identify, chipID, tid, callback)
  self.storeSaleMsg.identify = identify
  self.storeSaleMsg.algId = chipID
  self.storeSaleMsg.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Sale, proto_csmsg.CS_WarChess_StoreSystem_Sale, self.storeSaleMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Sale, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_Sale)
end

function WarChessNetworkCtrl:SC_WarChess_StoreSystem_SaleAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_StoreSystem_Sale error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_StoreSystem_Refresh(identify, callback)
  self.storeRefreshMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Refresh, proto_csmsg.CS_WarChess_StoreSystem_Refresh, self.storeRefreshMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Refresh, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_Refresh)
end

function WarChessNetworkCtrl:SC_WarChess_StoreSystem_Refresh(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_StoreSystem_Refresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Refresh, nil)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Refresh, msg.storeSystemData)
end

function WarChessNetworkCtrl:CS_WarChess_StoreSystem_ExchangeItem(identify, itemId, callback)
  self.storeExchangeMsg.identify = identify
  self.storeExchangeMsg.costItemId = itemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_ExchangeItem, proto_csmsg.CS_WarChess_StoreSystem_ExchangeItem, self.storeExchangeMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_ExchangeItem, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_ExchangeItem)
end

function WarChessNetworkCtrl:SC_WarChess_StoreSystem_ExchangeItem(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_StoreSystem_ExchangeItem error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_ExchangeItem, nil)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_ExchangeItem, msg.costItemid)
end

function WarChessNetworkCtrl:CS_WarChess_StoreSystem_SelectBuff(identify, idx, callback)
  self.storeBuyBuffMsg.identify = identify
  self.storeBuyBuffMsg.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_SelectBuff, proto_csmsg.CS_WarChess_StoreSystem_SelectBuff, self.storeBuyBuffMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_SelectBuff, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_SelectBuff)
end

function WarChessNetworkCtrl:SC_WarChess_StoreSystem_SelectBuff(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_StoreSystem_SelectBuff error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_SelectBuff)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_StoreSystem_Quit(identify, callback)
  self.storeQuitMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Quit, proto_csmsg.CS_WarChess_StoreSystem_Quit, self.storeQuitMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_StoreSystem_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_StoreSystem_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_StoreSystem_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_StoreSystem_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_BoxSystem_SelectAlg(identify, index, tid, callback)
  self.treasureSelectMsg.identify = identify
  self.treasureSelectMsg.index = index
  self.treasureSelectMsg.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_SelectAlg, proto_csmsg.CS_WarChess_BoxSystem_SelectAlg, self.treasureSelectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_SelectAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BoxSystem_SelectAlg)
end

function WarChessNetworkCtrl:SC_WarChess_BoxSystem_SelectAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BoxSystem_SelectAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_BoxSystem_RefreshAlg(identify, callback)
  self.treasureSelectMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_RefreshAlg, proto_csmsg.CS_WarChess_BoxSystem_RefreshAlg, self.treasureSelectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_RefreshAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BoxSystem_RefreshAlg)
end

function WarChessNetworkCtrl:SC_WarChess_BoxSystem_RefreshAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BoxSystem_RefreshAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_RefreshAlg, msg)
end

function WarChessNetworkCtrl:CS_WarChess_BoxSystem_DropAlg(identify, callback)
  self.treasureSelectMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_DropAlg, proto_csmsg.CS_WarChess_BoxSystem_DropAlg, self.treasureSelectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_DropAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BoxSystem_DropAlg)
end

function WarChessNetworkCtrl:SC_WarChess_BoxSystem_DropAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BoxSystem_DropAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BoxSystem_RefreshAlg, msg)
end

function WarChessNetworkCtrl:CS_WarChess_EventSystem_Select(identify, index, callback)
  self.treasureSelectMsg.identify = identify
  self.treasureSelectMsg.index = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_EventSystem_Select, proto_csmsg.CS_WarChess_EventSystem_Select, self.treasureSelectMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_EventSystem_Select, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_EventSystem_Select)
end

function WarChessNetworkCtrl:SC_WarChess_EventSystem_Select(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_EventSystem_Select error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  if msg.eventSystemData ~= nil then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl ~= nil then
      wcCtrl.eventCtrl:EnterNextWCEvent(msg.eventSystemData)
    end
  end
end

function WarChessNetworkCtrl:CS_WarChess_AlgDiscardSystem_Select(identify, tid, algId, callback)
  local msg = {}
  msg.identify = identify
  msg.tid = tid
  msg.algId = algId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_AlgDiscardSystem_Select, proto_csmsg.CS_WarChess_AlgDiscardSystem_Select, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_AlgDiscardSystem_Select, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_AlgDiscardSystem_Select)
end

function WarChessNetworkCtrl:SC_WarChess_AlgDiscardSystem_Select(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_AlgDiscardSystem_Select error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_AlgDiscardSystem_Quit(identify, callback)
  local msg = {}
  msg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_AlgDiscardSystem_Quit, proto_csmsg.CS_WarChess_AlgDiscardSystem_Quit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_AlgDiscardSystem_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_AlgDiscardSystem_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_AlgDiscardSystem_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_AlgDiscardSystem_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_AlgDiscardSystem_PurchaseAlgLimit(identify, tid, callback)
  local msg = {}
  msg.identify = identify
  msg.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_AlgDiscardSystem_PurchaseAlgLimit, proto_csmsg.CS_WarChess_AlgDiscardSystem_PurchaseAlgLimit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_AlgDiscardSystem_PurchaseAlgLimit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_AlgDiscardSystem_PurchaseAlgLimit)
end

function WarChessNetworkCtrl:SC_WarChess_AlgDiscardSystem_PurchaseAlgLimit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_AlgDiscardSystem_PurchaseAlgLimit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_RayCastSystem_Start(identify, callback)
  local msg = {}
  msg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Start, proto_csmsg.CS_WarChess_RayCastSystem_Start, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Start, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_RayCastSystem_Start)
end

function WarChessNetworkCtrl:SC_WarChess_RayCastSystem_Start(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_RayCastSystem_Start error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Start, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Start, true)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Start, msg.raySystemData)
end

function WarChessNetworkCtrl:CS_WarChess_RayCastSystem_Quit(identify, callback)
  local msg = {}
  msg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Quit, proto_csmsg.CS_WarChess_RayCastSystem_Quit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_RayCastSystem_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_RayCastSystem_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_RayCastSystem_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_RayCastSystem_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_SelectTeamForAlgSystem_Select(identify, tid, idx, callback)
  self.storeBuyChipMsg.identify = identify
  self.storeBuyChipMsg.tid = tid
  self.storeBuyChipMsg.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_SelectTeamForAlgSystem_Select, proto_csmsg.CS_WarChess_SelectTeamForAlgSystem_Select, self.storeBuyChipMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SelectTeamForAlgSystem_Select, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_SelectTeamForAlgSystem_Select)
end

function WarChessNetworkCtrl:SC_WarChess_SelectTeamForAlgSystem_Select(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_SelectTeamForAlgSystem_Select error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_SelectTeamForAlgSystem_Select, msg.remainAlgList)
end

function WarChessNetworkCtrl:CS_WarChess_SelectTeamForAlgSystem_Quit(identify, callback)
  self.storeQuitMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_SelectTeamForAlgSystem_Quit, proto_csmsg.CS_WarChess_SelectTeamForAlgSystem_Quit, self.storeQuitMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SelectTeamForAlgSystem_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_SelectTeamForAlgSystem_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_SelectTeamForAlgSystem_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_SelectTeamForAlgSystem_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_JumpSystemData_Start(identify, dir, movePos, callback)
  local msg = {
    identify = identify,
    dir = dir,
    movePos = movePos
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Start, proto_csmsg.CS_WarChess_JumpSystemData_Start, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Start, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_JumpSystemData_Start)
end

function WarChessNetworkCtrl:SC_WarChess_JumpSystemData_Start(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_JumpSystemData_Start error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Start, false)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Start, msg)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Start, true)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Start, msg)
end

function WarChessNetworkCtrl:CS_WarChess_JumpSystemData_Quit(identify, callback)
  self.storeQuitMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Quit, proto_csmsg.CS_WarChess_JumpSystemData_Quit, self.storeQuitMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_JumpSystemData_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_JumpSystemData_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_JumpSystemData_Quit error:" .. tostring(msg.ret)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_JumpSystemData_Move(identify, callback)
  self.storeQuitMsg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Move, proto_csmsg.CS_WarChess_JumpSystemData_Move, self.storeQuitMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_JumpSystemData_Move, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_JumpSystemData_Move, proto_csmsg_MSG_ID.MSG_SC_WarChess_BroadCastSync)
end

function WarChessNetworkCtrl:SC_WarChess_JumpSystemData_Move(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_JumpSystemData_Move error:" .. tostring(msg.ret)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_RoundStartSingle(wid, callback)
  self.turnOverMsg.wid = wid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle, proto_csmsg.CS_WarChess_RoundStartSingle, self.turnOverMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_RoundStartSingle)
end

function WarChessNetworkCtrl:SC_WarChess_RoundStartSingle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_RoundStartSingle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle, false)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle, 0)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle, true)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_RoundStartSingle, msg.roundId)
end

function WarChessNetworkCtrl:SC_WarChess_StartSystem(msg)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    wcCtrl:OnWCSystemChange(eWarChessEnum.eSystemOpCat.open, msg.systemState.cat, msg.identify, msg.systemState)
  end
end

function WarChessNetworkCtrl:SC_WarChess_OverSystem(msg)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    wcCtrl:OnWCSystemChange(eWarChessEnum.eSystemOpCat.close, msg.cat)
  end
end

function WarChessNetworkCtrl:SC_WarChess_SwitchingSystem(msg)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    wcCtrl:OnWCSystemChange(eWarChessEnum.eSystemOpCat.switch, msg.systemState.cat, msg.identify, msg.systemState)
  end
end

function WarChessNetworkCtrl:SC_WarChess_BroadCastSync(msg)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    wcCtrl:OnWCSync(msg.sync)
  end
end

function WarChessNetworkCtrl:SC_WarChess_BroadCastOver(msg)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    local castOverData = msg.seasonData
    WarChessManager:WarchesFinish(msg.win, castOverData)
  end
end

function WarChessNetworkCtrl:CS_WarChess_Quit(pickInfo, callback)
  local msg = {pickInfo = pickInfo}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Quit, proto_csmsg.CS_WarChess_Quit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Quit, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Quit)
end

function WarChessNetworkCtrl:SC_WarChess_Quit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_SC_WarChess_Quit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Quit, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function WarChessNetworkCtrl:CS_WarChess_Settle(selectedRewardInfo, callback)
  local msg = {identify = nil, pickInfo = selectedRewardInfo}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Settle, proto_csmsg.CS_WarChess_Settle, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Settle, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Settle)
end

function WarChessNetworkCtrl:SC_WarChess_Settle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_Settle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Settle, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function WarChessNetworkCtrl:CS_WarChess_Brief_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Brief_Detail, proto_csmsg.CS_WarChess_Brief_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Brief_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Brief_Detail)
end

function WarChessNetworkCtrl:SC_WarChess_Brief_Detail(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Brief_Detail, msg)
end

function WarChessNetworkCtrl:CS_WarChess_Detail(warChessType, callback)
  local msg = {}
  msg.warChessType = warChessType
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Detail, proto_csmsg.CS_WarChess_Detail, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Detail)
end

function WarChessNetworkCtrl:SC_WarChess_Detail(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_Detail, msg)
end

function WarChessNetworkCtrl:CS_WarChess_UniqueRewardBrief(warchessId, callback)
  self.rewardBrief.warChessConfigId = warchessId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_UniqueRewardBrief, proto_csmsg.CS_WarChess_UniqueRewardBrief, self.rewardBrief)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_UniqueRewardBrief, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_UniqueRewardBrief)
end

function WarChessNetworkCtrl:SC_WarChess_UniqueRewardBrief(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_UniqueRewardBrief error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_UniqueRewardBrief, msg.records)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function WarChessNetworkCtrl:CS_WarChess_ResetTheRound(wid, backRound, callback)
  self.resetMsg.wid = wid
  self.resetMsg.backRound = backRound
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_ResetTheRound, proto_csmsg.CS_WarChess_ResetTheRound, self.resetMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_ResetTheRound, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_ResetTheRound)
end

function WarChessNetworkCtrl:SC_WarChess_ResetTheRound(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_ResetTheRound error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl ~= nil then
    wcCtrl:WarChessApplyTimeRewind(msg.warChess)
  end
end

function WarChessNetworkCtrl:CS_WarChess_EnterWarChessLobby(warChessSeasonId, warChessTowerId, newStart, envId, callback)
  local msg = {}
  msg.warChessSeasonId = warChessSeasonId
  msg.warChessTowerId = warChessTowerId
  msg.newStart = newStart
  msg.environmentId = envId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_EnterWarChessLobby, proto_csmsg.CS_WarChess_EnterWarChessLobby, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_EnterWarChessLobby, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_EnterWarChessLobby)
end

function WarChessNetworkCtrl:SC_WarChess_EnterWarChessLobby(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_EnterWarChessLobby error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_EnterWarChessLobby, msg)
end

function WarChessNetworkCtrl:CS_WarChess_WarChessExchangePos(s_wid, s_tid, t_wid, t_tid, callback)
  self.exChangeMsg.identify.wid = s_wid
  self.exChangeMsg.identify.tid = s_tid
  self.exChangeMsg.identifyEnd.wid = t_wid
  self.exChangeMsg.identifyEnd.tid = t_tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_WarChessExchangePos, proto_csmsg.CS_WarChess_WarChessExchangePos, self.exChangeMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_WarChessExchangePos, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_WarChessExchangePos)
end

function WarChessNetworkCtrl:SC_WarChess_WarChessExchangePos(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_CS_WarChess_WarChessExchangePos error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_WarChessExchangePos)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_GlobalInteract(identify, eventPoolId, callback)
  local msg = {}
  msg.identify = identify
  msg.eventPoolId = eventPoolId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_GlobalInteract, proto_csmsg.CS_WarChess_GlobalInteract, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_GlobalInteract, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteract)
end

function WarChessNetworkCtrl:SC_WarChess_GlobalInteract(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_CS_WarChess_GlobalInteract error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_GlobalInteract)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_GetSeasonBackup(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_GetSeasonBackup, proto_csmsg.CS_WarChess_GetSeasonBackup, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_GetSeasonBackup, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_GetSeasonBackup)
end

function WarChessNetworkCtrl:SC_WarChess_GetSeasonBackup(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None and msg.ret ~= proto_csmsg_ErrorCode.WARCHESS_NOT_SEASON_BACKUP then
    local err = "MSG_CS_WarChess_GetSeasonBackup error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_GetSeasonBackup)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_GetSeasonBackup, msg.backUpData)
end

function WarChessNetworkCtrl:CS_WarChess_SeasonBackupChoice(index, callback)
  local msg = {warChessSeasonbackUpId = index}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_SeasonBackupChoice, proto_csmsg.CS_WarChess_SeasonBackupChoice, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SeasonBackupChoice, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_SeasonBackupChoice)
end

function WarChessNetworkCtrl:SC_WarChess_SeasonBackupChoice(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_CS_WarChess_SeasonBackupChoice error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SeasonBackupChoice)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_SeasonBackupChoice, msg.warChess)
end

function WarChessNetworkCtrl:CS_WarChess_SetSeasonBackup(index, callback)
  local msg = {warChessSeasonbackUpId = index}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_SetSeasonBackup, proto_csmsg.CS_WarChess_SetSeasonBackup, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SetSeasonBackup, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_SetSeasonBackup)
end

function WarChessNetworkCtrl:SC_WarChess_SetSeasonBackup(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_CS_WarChess_SetSeasonBackup error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_SetSeasonBackup)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_SetSeasonBackup)
end

function WarChessNetworkCtrl:CS_WarChess_Event_FreshFormation(identify, heroes, fromFormationIdx, powerNum, cancel, callback)
  self.rescueMsg.identify = identify
  self.rescueMsg.heroes = heroes
  self.rescueMsg.fromFormationIdx = fromFormationIdx
  self.rescueMsg.powerNum = powerNum
  self.rescueMsg.cancel = cancel or false
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Event_FreshFormation, proto_csmsg.CS_WarChess_Event_FreshFormation, self.rescueMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Event_FreshFormation, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Event_FreshFormation)
end

function WarChessNetworkCtrl:SC_WarChess_Event_FreshFormation(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_CS_WarChess_Event_FreshFormation error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Event_FreshFormation)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_Event_StrategySelect(identify, indexStrategyKey, rewardMapKey, tid, callback)
  local msg = {}
  msg.identify = identify
  msg.indexStrategyKey = indexStrategyKey
  msg.rewardMapKey = rewardMapKey
  msg.tid = tid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Event_StrategySelect, proto_csmsg.CS_WarChess_Event_StrategySelect, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Event_StrategySelect, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Event_StrategySelect)
end

function WarChessNetworkCtrl:SC_WarChess_Event_StrategySelect(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "CS_WarChess_Event_StrategySelect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Event_StrategySelect)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_GlobalInteractTrigger(identify, callback)
  local msg = {}
  msg.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_GlobalInteractTrigger, proto_csmsg.CS_WarChess_GlobalInteractTrigger, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_GlobalInteractTrigger, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteractTrigger)
end

function WarChessNetworkCtrl:SC_WarChess_GlobalInteractTrigger(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.WARCHESS_GLOBAL_TRIGGER_ITEM_NOT_ENOUGH then
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteractTrigger, false)
      return
    end
    local err = "SC_WarChess_GlobalInteractTrigger error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteractTrigger)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_SC_WarChess_GlobalInteractTrigger, true)
end

function WarChessNetworkCtrl:CS_WarChess_AvgOver(avgId, agvType, callback)
  local msg = {}
  msg.avgId = avgId
  msg.agvType = agvType
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_AvgOver, proto_csmsg.CS_WarChess_AvgOver, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_AvgOver, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_AvgOver)
end

function WarChessNetworkCtrl:SC_WarChess_AvgOver(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_AvgOver error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_AvgOver)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChessSeasonRecord(warChessSeasonId, callback)
  local msg = {warChessSeasonId = warChessSeasonId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChessSeasonRecord, proto_csmsg.CS_WarChessSeasonRecord, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChessSeasonRecord, callback, proto_csmsg_MSG_ID.MSG_SC_WarChessSeasonRecord)
end

function WarChessNetworkCtrl:SC_WarChessSeasonRecord(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChessSeasonRecord error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChessSeasonRecord)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChessSeasonRecord, msg)
end

function WarChessNetworkCtrl:CS_WarChess_OverReward_SelectAlg(identify, idx, tid, callback)
  local msg = {
    identify = identify,
    idx = idx,
    tid = tid
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_SelectAlg, proto_csmsg.CS_WarChess_OverReward_SelectAlg, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_SelectAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_OverReward_SelectAlg)
end

function WarChessNetworkCtrl:SC_WarChess_OverReward_SelectAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_OverReward_SelectAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_SelectAlg)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_SelectAlg, msg)
end

function WarChessNetworkCtrl:CS_WarChess_OverReward_DropAlg(identify, callback)
  local msg = {identify = identify}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_DropAlg, proto_csmsg.CS_WarChess_OverReward_DropAlg, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_DropAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_OverReward_DropAlg)
end

function WarChessNetworkCtrl:SC_WarChess_OverReward_DropAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_OverReward_DropAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_DropAlg)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_DropAlg, msg)
end

function WarChessNetworkCtrl:CS_WarChess_OverReward_RefreshAlg(identify, callback)
  local msg = {identify = identify}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_RefreshAlg, proto_csmsg.CS_WarChess_OverReward_RefreshAlg, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_RefreshAlg, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_OverReward_RefreshAlg)
end

function WarChessNetworkCtrl:SC_WarChess_OverReward_RefreshAlg(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_OverReward_RefreshAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_RefreshAlg)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_OverReward_RefreshAlg, msg)
end

function WarChessNetworkCtrl:CS_WarChess_Choice_Protocol(wid, buffId, callback)
  self._Choice_ProtocolTab.wid = wid
  self._Choice_ProtocolTab.buffId = buffId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_Choice_Protocol, proto_csmsg.CS_WarChess_Choice_Protocol, self._Choice_ProtocolTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Choice_Protocol, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_Choice_Protocol)
end

function WarChessNetworkCtrl:SC_WarChess_Choice_Protocol(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_Choice_Protocol error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_Choice_Protocol)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_MonsterPower(identify, wcPos, callback)
  self.getMonsterPower.identify = identify
  self.getMonsterPower.wcPos = wcPos
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_MonsterPower, proto_csmsg.CS_WarChess_MonsterPower, self.getMonsterPower)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_MonsterPower, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_MonsterPower)
end

function WarChessNetworkCtrl:SC_WarChess_MonsterPower(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_MonsterPower error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_MonsterPower, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_MonsterPower, msg)
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_BackBeforeBattle(identify, callback)
  self.backBeforeBattle.identify = identify
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_BackBeforeBattle, proto_csmsg.CS_WarChess_BattleSystem_BackBeforeBattle, self.backBeforeBattle)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_BackBeforeBattle, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_BackBeforeBattle)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_BackBeforeBattle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_WarChess_BattleSystem_BackBeforeBattle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_BackBeforeBattle, false)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_BackBeforeBattle, msg.warChess)
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_UpdateData(identify, monsterDic)
  self.updateHpData.identify = identify
  self.updateHpData.monster = monsterDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_UpdateData, proto_csmsg.CS_WarChess_BattleSystem_UpdateData, self.updateHpData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_UpdateData, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_UpdateData)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_UpdateData(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "CS_WarChess_BattleSystem_UpdateData error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_UpdateData)
    return
  end
end

function WarChessNetworkCtrl:CS_WarChess_EventInBattle(identify, eventPoolId, beforeEventInBattle, callback)
  local msg = {}
  msg.identify = identify
  msg.eventPoolId = eventPoolId
  msg.beforeEventInBattle = beforeEventInBattle
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_EventInBattle, proto_csmsg.CS_WarChess_EventInBattle, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_EventInBattle, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_EventInBattle)
end

function WarChessNetworkCtrl:SC_WarChess_EventInBattle(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_WarChess_EventInBattle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_EventInBattle)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WarChess_EventInBattle, msg.eventSystemData)
end

function WarChessNetworkCtrl:CS_WarChess_BattleSystem_ChoiceEvent(identify, index, callback)
  local msg = {}
  msg.identify = identify
  msg.index = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_ChoiceEvent, proto_csmsg.CS_WarChess_BattleSystem_ChoiceEvent, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_ChoiceEvent, callback, proto_csmsg_MSG_ID.MSG_SC_WarChess_BattleSystem_ChoiceEvent)
end

function WarChessNetworkCtrl:SC_WarChess_BattleSystem_ChoiceEvent(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_WarChess_BattleSystem_ChoiceEvent error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WarChess_BattleSystem_ChoiceEvent)
    return
  end
end

function WarChessNetworkCtrl:Reset()
end

return WarChessNetworkCtrl
