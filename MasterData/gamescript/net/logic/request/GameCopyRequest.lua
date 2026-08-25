local table = _ENV.table
local GameCopyRequest, Super = System.NewClass("GameCopyRequest", ProtoBase)

function GameCopyRequest:Startup()
  Super.Startup(self)
end

function GameCopyRequest:Shutdown()
  Super.Shutdown(self)
end

function GameCopyRequest:ClearData()
  Super.ClearData(self)
end

function GameCopyRequest:OnEnter(id, storyLineTid, awakerTids)
  Logger.Info("GameCopyRequest:OnEnter", self.__name, id, storyLineTid, table.tostring(awakerTids))
  if 0 == id then
    id = 1
  end
  local data, err = NetworkMgr.Instance.GameCopy:Enter(id, storyLineTid, awakerTids)
  Logger.Info("%s:Entry: Recv data: %s, errcode: %s", self.__name, table.tostring(data), err)
  return data, err
end

function GameCopyRequest:OnEnterSuccess()
  local data, err = NetworkMgr.Instance.GameCopy:EnterSuccess()
  Logger.Info("%s:OnEnterSuccess: Recv data: %s, errcode: %s", self.__name, data, err)
  return data, err
end

function GameCopyRequest:OnExit(id)
  Logger.Info("%s:OnExit: Recv data: %s, errcode: %s", self.__name, id)
  local data, err = NetworkMgr.Instance.GameCopy:Exit(id)
  return data, err
end

function GameCopyRequest:ChooseCopies(tid)
  local data, err = NetworkMgr.Instance.MainCopy:ChooseCopies(tid)
  return data, err
end

function GameCopyRequest:ChooseStoryLine(tid)
  local data, err = NetworkMgr.Instance.MainCopy:ChooseStoryLine(tid)
  Logger.Info("%s:Entry: Recv data: %s, errcode: %s", self.__name, tid)
  return data, err
end

function GameCopyRequest:OnMoppingup(count, copyId, plot)
  Logger.Info("%s:OnMoppingup:", self.__name)
  local data, err = NetworkMgr.Instance.GameCopy:OnMoppingup(count, copyId, plot)
  return data, err
end

function GameCopyRequest:BuyPlotChallengeTimes(plotTid, times)
  Logger.Info("%s:OnMoppingup:", self.__name)
  local data, err = NetworkMgr.Instance.MainCopy:BuyPlotChallengeTimes(plotTid, times)
  return data, err
end

function GameCopyRequest:OnRecover(ret)
  Logger.Info("%s:OnRecover:", self.__name, ret)
  local data, err = NetworkMgr.Instance.GameCopy:OnRecover(ret)
  return data, err
end

function GameCopyRequest:OnRecoverTowerChallenge(ret)
  Logger.Info("%s:OnRecoverTowerChallenge:", self.__name, ret)
  local data, err = NetworkMgr.Instance.GameChallenge:OnRecover(ret)
  return data, err
end

return GameCopyRequest
