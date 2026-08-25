local table = _ENV.table
local PvpRequest, Super = System.NewClass("PvpRequest", ProtoBase)

function PvpRequest:Startup()
  Super.Startup(self)
end

function PvpRequest:Shutdown()
  Super.Shutdown(self)
end

function PvpRequest:ClearData()
  Super.ClearData(self)
end

function PvpRequest:OnMatch(param)
  Logger.Proto("PvpRequest:OnMatch param ", table.tostring(param))
  local errcode, data = NetworkMgr.Instance.PvpMatch:OnMatch(param)
  return errcode, data
end

function PvpRequest:OnCancel()
  Logger.Proto("PvpRequest:OnCancel")
  local errcode, data = NetworkMgr.Instance.PvpMatch:OnCancel()
  return errcode, data
end

function PvpRequest:TryRecoverPrepare()
  Logger.Proto("PvpRequest:TryRecoverPrepare")
  local errcode, data = NetworkMgr.Instance.PvpMatch:TryRecoverPrepare()
  return errcode, data
end

function PvpRequest:ReqMatch()
  Logger.Proto("PvpRequest:ReqMatch")
  local errcode, data = NetworkMgr.Instance.PvpMatch:Match()
  return errcode, data
end

function PvpRequest:ReqCancelMatch()
  Logger.Proto("PvpRequest:ReqCancelMatch")
  local errcode, data = NetworkMgr.Instance.PvpMatch:Cancel()
  return errcode, data
end

function PvpRequest:DraftAdjustTeam(fieldName, idxFrom, idxTo, ready)
  Logger.Proto("PvpRequest:DraftAdjustTeam ", fieldName, idxFrom, idxTo, ready)
  local errcode, data = NetworkMgr.Instance.PvpMatch:DraftAdjustTeam(fieldName, idxFrom, idxTo, ready)
  return errcode, data
end

function PvpRequest:DraftChooseCollect(collectTid, isConfirm)
  Logger.Proto("PvpRequest:DraftChooseCollect ", collectTid, isConfirm)
  local errcode, data = NetworkMgr.Instance.PvpMatch:DraftChooseCollect(collectTid, isConfirm)
  return errcode, data
end

function PvpRequest:OnGetMatchQueueCount()
  Logger.Proto("PvpRequest:GetMatchQueueCount")
  local errcode, data = NetworkMgr.Instance.PvpMatch:OnGetMatchQueueCount()
  return errcode, data
end

function PvpRequest:StartBattle()
  Logger.Proto("PvpRequest:StartBattle")
  do return NetworkMgr.Instance.BattleFlow.StartBattle end
  return NetworkMgr.Instance.BattleFlow.StartBattle, NetworkMgr.Instance.BattleFlow
end

function PvpRequest:OnReceiveCommand(msgId, msgData)
  Logger.Proto("PvpRequest:OnReceiveCommand", msgId, table.tostring(msgData))
  NetworkMgr.Instance.BattleFlow.OnReceiveCommand(msgId, msgData)
  return true
end

function PvpRequest:InviteFriendGame(uid, pvpType)
  Logger.Proto("PvpRequest:InviteFriendGame")
  local data, err = NetworkMgr.Instance.Pvp:InviteFriendGame(uid, pvpType)
  Logger.Proto("PvpRequest:InviteFriendGame", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:CancelInviteFriendGame(uid)
  Logger.Proto("PvpRequest:CancelInviteFriendGame")
  local data, err = NetworkMgr.Instance.Pvp:CancelInviteFriendGame(uid)
  Logger.Proto("PvpRequest:CancelInviteFriendGame", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:HandleInviteFriendGame(uid, isAccept)
  Logger.Proto("PvpRequest:HandleInviteFriendGame")
  local data, err = NetworkMgr.Instance.Pvp:HandleInviteFriendGame(uid, isAccept)
  Logger.Proto("PvpRequest:HandleInviteFriendGame", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:OnChooseTeam(index)
  Logger.Proto("PvpRequest:OnChooseTeam")
  local data, err = NetworkMgr.Instance.Pvp:OnChooseTeam(index)
  Logger.Proto("PvpRequest:OnChooseTeam", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:OnWatchPvpReplay(battleUuid, stageGroupTid)
  Logger.Proto("PvpRequest:OnWatchPvpReplay", battleUuid, stageGroupTid)
  local data, err = NetworkMgr.Instance.Pvp:OnWatchPvpReplay(battleUuid, stageGroupTid)
  Logger.Proto("PvpRequest:OnWatchPvpReplay", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:OnCopyOpponentDeck(stageGroupTid)
  Logger.Proto("PvpRequest:OnCopyOpponentDeck", stageGroupTid)
  local data, err = NetworkMgr.Instance.Pvp:OnCopyOpponentDeck(stageGroupTid)
  Logger.Proto("PvpRequest:OnCopyOpponentDeck", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:OnTrialDefeatAwaker(unitUid)
  Logger.Proto("PvpRequest:OnTrialDefeatAwaker")
  local data, err = NetworkMgr.Instance.Pvp:OnTrialDefeatAwaker(unitUid)
  Logger.Proto("PvpRequest:OnTrialDefeatAwaker", table.tostring(data), table.tostring(err))
  return data, err
end

function PvpRequest:Good(uid)
  Logger.Proto("PvpRequest:Good, uid: %s", uid)
  local data, err = NetworkMgr.Instance.Pvp:Good(uid)
  Logger.Proto("PvpRequest:Good", table.tostring(data), table.tostring(err))
  return data, err
end

return PvpRequest
