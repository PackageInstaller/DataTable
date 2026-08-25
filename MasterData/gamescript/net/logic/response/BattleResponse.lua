local RPC = System.RPC
local BattleResponse, Super = System.NewClass("Battle", ProtoBase)

function BattleResponse:Startup()
  Super.Startup(self)
end

function BattleResponse:Shutdown()
  Super.Shutdown(self)
end

function BattleResponse:ClearData()
  Super.ClearData(self)
end

RPC("T")

function BattleResponse:StartBattleByServer(data)
  self:Dispatch("StartBattleByServer", data)
end

RPC("I", "I")

function BattleResponse:OnRequest(casterUid, targetUid)
  self:Dispatch("OnRequest", casterUid, targetUid)
end

RPC("I", "I")

function BattleResponse:OnRequestTimeOut(casterUid, targetUid)
  self:Dispatch("OnRequestTimeOut", casterUid, targetUid)
end

RPC("I", "I")

function BattleResponse:OnReject(casterUid, targetUid)
  self:Dispatch("OnReject", casterUid, targetUid)
end

RPC("B", "T")

function BattleResponse:OnAnswer(isEnterWorld, data)
  self:Dispatch("OnAnswer", isEnterWorld, data)
end

RPC("T", "T")

function BattleResponse:OnBattleReady(casterArmyInfos, targetArmyInfos)
  self:Dispatch("OnBattleReady", casterArmyInfos, targetArmyInfos)
end

RPC("I", "I")

function BattleResponse:OnPreBattleStatus(status, statusDate)
  Logger.Debug("-----------------------------BattleResponse:OnPreBattleStatus", status, statusDate)
  self:Dispatch("OnPreBattleStatus", status, statusDate)
end

RPC("T")

function BattleResponse:OnReplayDataRecv(act)
  self:Dispatch("OnReplayDataRecv", act)
end

RPC("I", "B", "B")

function BattleResponse:OnGiveUp(battleId, casterGiveUp, targetGiveUp)
  Logger.Debug("-----------------------------BattleResponse:OnGiveUp")
  self:Dispatch("OnGiveUp", battleId, casterGiveUp, targetGiveUp)
end

RPC("T", "T")

function BattleResponse:OnEndBattle(balance, data)
  self:Dispatch("OnEndBattle", balance, data)
end

return BattleResponse
