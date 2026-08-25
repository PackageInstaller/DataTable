local RPC = System.RPC
local WorldResponse, Super = System.NewClass("World", ProtoBase)

function WorldResponse:Startup()
  Super.Startup(self)
end

function WorldResponse:Shutdown()
  Super.Shutdown(self)
end

function WorldResponse:ClearData()
  Super.ClearData(self)
end

RPC("T")

function WorldResponse:OnSyncCard(data)
  self:Dispatch("OnSyncCard", data)
  Logger.Proto("OnSyncCard")
end

RPC("T")

function WorldResponse:OnSyncRelic(data)
  self:Dispatch("OnSyncRelic", data)
  Logger.Proto("OnSyncRelic .. data %s", table.tostring(data))
end

RPC("T")

function WorldResponse:OnChaosRelic(data)
  self:Dispatch("OnChaosRelic", data)
  Logger.Proto("OnChaosRelic .. data %s", table.tostring(data))
end

RPC("T")

function WorldResponse:OnSyncCurrency(data)
  Logger.Proto("WorldResponse:OnSyncCurrency: data =", table.tostring(data))
  self:Dispatch("OnSyncCurrency", data)
end

RPC("T")

function WorldResponse:OnSyncNewEvents(data)
  Logger.Proto("WorldResponse:OnSyncNewEvents: data =", table.tostring(data))
  self:Dispatch("OnSyncNewEvents", data)
end

RPC("T")

function WorldResponse:OnEventStatusChanged(data)
  Logger.Proto("WorldResponse:OnEventStatusChanged data=", table.tostring(data))
  self:Dispatch("OnEventStatusChanged", data)
end

RPC("T")

function WorldResponse:OnSaveAndExit(data)
  Logger.Proto("WorldResponse:OnSaveAndExit: data =", table.tostring(data))
  self:Dispatch("OnSaveAndExit", data)
end

RPC("T")

function WorldResponse:OnSyncNewTasks(data)
  Logger.Proto("WorldResponse:OnSyncNewTasks: data =", table.tostring(data))
  self:Dispatch("OnSyncNewTasks", data)
end

RPC("I")

function WorldResponse:OnSyncTips(data)
  Logger.Proto("WorldResponse:OnSyncTips: data =", data)
  self:Dispatch("OnSyncTips", data)
end

RPC("T")

function WorldResponse:OnSyncCopyRolesAttrs(data)
  Logger.Proto("WorldResponse:OnSyncCopyRolesAttrs: data =", data)
  self:Dispatch("OnSyncCopyRolesAttrs", data)
end

RPC("T")

function WorldResponse:OnSyncUpdateArgs(data)
  Logger.Proto("WorldResponse:OnSyncUpdateArgs: data =", data)
  self:Dispatch("OnSyncUpdateArgs", data)
end

RPC("T")

function WorldResponse:OnSyncWorldEffect(data)
  Logger.Proto("WorldResponse:OnSyncWorldEffect: data =", data)
  self:Dispatch("OnSyncWorldEffect", data)
end

RPC("T")

function WorldResponse:OnSyncShopData(data)
  Logger.Proto("WorldResponse:OnSyncShopData: data =", data)
  self:Dispatch("OnSyncShopData", data)
end

RPC("T")

function WorldResponse:OnSyncGearInfo(data)
  Logger.Proto("WorldResponse:OnSyncGearInfo: data =", table.tostring(data))
  self:Dispatch("OnSyncGearInfo", data)
end

RPC("T")

function WorldResponse:OnSyncWorldPlayerPos(data)
  Logger.Proto("WorldResponse:OnSyncWorldPlayerPos: data =", table.tostring(data))
  self:Dispatch("OnSyncWorldPlayerPos", data)
end

RPC("T")

function WorldResponse:OnSyncConnectLevel(data)
  Logger.Proto("WorldResponse:OnSyncConnectLevel: data =", table.tostring(data))
  self:Dispatch("OnSyncConnectLevel", data)
end

RPC("T")

function WorldResponse:OnSyncFilter(data)
  Logger.Proto("WorldResponse:OnSyncFilter: data =", table.tostring(data))
  self:Dispatch("OnSyncFilter", data)
end

RPC("T")

function WorldResponse:OnSyncPlayerAttrs(data)
  Logger.Proto("WorldResponse:OnSyncPlayerAttrs: data =", table.tostring(data))
  self:Dispatch("OnSyncPlayerAttrs", data)
end

RPC("T")

function WorldResponse:OnSyncSchoolArgs(data)
  Logger.Proto("WorldResponse:OnSyncSchoolArgs: data =", table.tostring(data))
  self:Dispatch("OnSyncSchoolArgs", data)
end

RPC("T")

function WorldResponse:OnAddAwaker(data)
  Logger.Proto("WorldResponse:OnAddAwaker: data =", table.tostring(data))
  self:Dispatch("OnAddAwaker", data)
end

RPC("T")

function WorldResponse:OnSyncCopiesItems(data)
  Logger.Proto("WorldResponse:OnSyncCopiesItems: data =", table.tostring(data))
  self:Dispatch("OnSyncCopiesItems", data)
end

RPC("I", "T")

function WorldResponse:OnReceiveCommand(msgId, data)
  self:Dispatch("OnReceiveBattleCommand", msgId, data)
end

RPC("T")

function WorldResponse:CreateBattle(info)
  Logger.Proto("WorldResponse:CreateBattle PVP: info =", info.gameplayType, info.battleTid)
  self:Dispatch("OnCreatePvPBattle", info)
end

RPC("T")

function WorldResponse:ReenterBattle(info)
  self:Dispatch("OnReenterBattle", info)
end

RPC("T")

function WorldResponse:OnEventBattleLose(data)
  Logger.Proto("WorldResponse:OnEventBattleLose: data =", table.tostring(data))
  self:Dispatch("OnEventBattleLose", data)
end

RPC("T")

function WorldResponse:OnWorldExit(data)
  Logger.ReportApusInfo("WorldResponse:OnWorldExit")
  Logger.Proto("WorldResponse:OnWorldExit: data =", table.tostring(data))
  self:Dispatch("OnWorldExit", data)
end

RPC("T")

function WorldResponse:OnClearByStageExpire(data)
  Logger.Proto("WorldResponse:OnClearByStageExpire: data =", table.tostring(data))
  self:Dispatch("OnClearByStageExpire", data)
end

RPC("T")

function WorldResponse:OnGmWorldExit(data)
  Logger.Proto("WorldResponse:OnGmWorldExit: data =", table.tostring(data))
  self:Dispatch("OnWorldExit", data)
  BattleManager.Instance:CloseBattle()
  BattleManager.Instance:OnBattleFinish(0)
end

RPC("T")

function WorldResponse:OnClearFog(data)
  Logger.Proto("WorldResponse:OnClearFog: data =", table.tostring(data))
  self:Dispatch("OnClearFog", data)
end

RPC("T")

function WorldResponse:OnRecoverWorld(data)
  Logger.Proto("WorldResponse:OnRecoverWorld: data =", table.tostring(data))
  self:Dispatch("OnRecoverWorld", data)
end

RPC("T")

function WorldResponse:OnSyncAwakerAddLike(data)
  Logger.Proto("WorldResponse:OnSyncAwakerAddLike: data =", table.tostring(data))
  self:Dispatch("OnSyncAwakerAddLike", data)
end

RPC("T")

function WorldResponse:OnSyncAreaData(data)
  Logger.Proto("WorldResponse:OnSyncAreaData: data =", table.tostring(data))
  self:Dispatch("OnSyncAreaData", data)
end

RPC("T")

function WorldResponse:OnServerNotify(data)
  Logger.Proto("WorldResponse:OnServerNotify: data =", table.tostring(data))
  ErrorMsg.ShowErrCodeTips(data, data.args)
end

RPC("T")

function WorldResponse:OnRespawn(data)
  Logger.Proto("WorldResponse:OnRespawn: data =", table.tostring(data))
  self:Dispatch("OnRespawn", data)
end

RPC("T")

function WorldResponse:OnGearDelete(data)
  Logger.Proto("WorldResponse:OnGearDelete: data =", table.tostring(data))
  self:Dispatch("OnGearDelete", data)
end

RPC("T")

function WorldResponse:OnTriggerGearData(data)
  Logger.Proto("WorldResponse:OnTriggerGearData: data =", table.tostring(data))
  self:Dispatch("OnTriggerGearData", data)
end

RPC("T")

function WorldResponse:OnTriggerBattle(data)
  Logger.Proto("WorldResponse:OnTriggerBattle: data =", table.tostring(data))
  self:Dispatch("OnTriggerBattle", data)
end

RPC("T")

function WorldResponse:OnSyncStateData(data)
  Logger.Proto("WorldResponse:OnSyncStateData")
  StateDataUtils.OnSyncStateData(data)
end

RPC("T")

function WorldResponse:OnCmdChooseData(data)
  Logger.Proto("WorldResponse:OnCmdChooseData: data =", table.tostring(data))
  self:Dispatch("OnCmdChooseData", data)
end

RPC("T")

function WorldResponse:OnSyncView(data)
  Logger.Proto("%s:OnSyncView: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncView", data)
end

RPC("T")

function WorldResponse:RefreshShopData(data)
  Logger.Proto("%s:RefreshShopData: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncShopData", data)
end

RPC("T")

function WorldResponse:OnDestructionGear(data)
  Logger.Proto("%s:OnDestructionGear: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnDestructionGear", data)
end

RPC("T")

function WorldResponse:OnNewGearData(data)
  Logger.Proto("%s:OnNewGearData: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnNewGearData", data)
end

RPC("T")

function WorldResponse:OnSyncWorldDataByReconnect(data)
  Logger.Proto("%s:OnSyncWorldDataByReconnect: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncWorldDataByReconnect", data)
end

RPC("T")

function WorldResponse:OnSyncWorldTaskFinish(data)
  Logger.Proto("%s:OnSyncWorldTaskFinish: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncWorldTaskFinish", data)
end

RPC("T")

function WorldResponse:OnSyncWorldTaskUnlock(data)
  Logger.Proto("%s:OnSyncWorldTaskUnlock: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncWorldTaskUnlock", data)
end

RPC("T")

function WorldResponse:SyncWorldStats(data)
  Logger.Proto("%s:SyncWorldStats: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncWorldStats", data)
end

RPC("T")

function WorldResponse:OnSyncRailWayWorld(data)
  Logger.Proto("%s:OnSyncRailWayWorld: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncRailWayWorld", data)
end

RPC("S")

function WorldResponse:LogBattle(msg)
  self:Dispatch("LogBattle", msg)
end

RPC("S", "S", "I")

function WorldResponse:LogStage(msg, wid, tid)
  Logger.Proto("LogStage: msg =%s wid=%s tid=%s", msg, wid, tid)
  self:Dispatch("LogStage", msg, wid, tid)
end

RPC("T")

function WorldResponse:LogBattleDetail(data)
  self:Dispatch("LogBattleDetail", data)
end

RPC("T")

function WorldResponse:OnReviveChoose(data)
  Logger.Proto("%s:OnReviveChoose: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnReviveChoose", data)
end

RPC("T")

function WorldResponse:OnSyncWorldAchivementData(data)
  Logger.Proto("%s:OnSyncWorldAchivementData: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncWorldAchivementData", data)
end

RPC("T")

function WorldResponse:OnSyncWorldTaskData(data)
  Logger.Proto("%s:OnSyncWorldTaskData: data =%s", self.__Name, table.tostring(data))
  self:Dispatch("OnSyncWorldTaskData", data)
end

RPC()

function WorldResponse:OnKickToLoginPanel()
  Logger.Proto("WorldResponse:OnKickToLoginPanel")
  SceneMgr.Instance:EnterLogin()
end

return WorldResponse
