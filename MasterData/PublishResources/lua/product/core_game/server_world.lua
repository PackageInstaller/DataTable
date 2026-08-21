require("main_world")
_class("ServerWorld", MainWorld)
ServerWorld = ServerWorld

function ServerWorld:Constructor(worldInfo, coreGameLogic)
  self._coreGameLogic = coreGameLogic
  self._runningPosition = WorldRunPostion.AtServer
  self._gameEventDispatcher = GameEventDispatcher:New()
  self._gameEventListenerIDGenerator = IDGenerator:New(IDGeneratorType.GAME_EVENT_LISTENER_FIRST_ID)
end

function ServerWorld:GetCoreGameLogic()
  return self._coreGameLogic
end

function ServerWorld:IsDevelopEnv()
  return self._coreGameLogic:GetServerLuaLogConfig()
end

function ServerWorld:EventDispatcher()
  return self._gameEventDispatcher
end

function ServerWorld:HandleCommand(cmd)
  local e = self:GetEntityByID(cmd.EntityID)
  if e then
    e:ReceiveCommand(cmd)
  else
    Log.fatal("ServerWorld:HandleCommand can not find entity ID=", cmd.EntityID)
  end
end

function ServerWorld:IDGenerator()
  return self._gameEventListenerIDGenerator
end

function ServerWorld:HandleSyncFailed(failedType, failedMsg)
  if self._coreGameLogic then
    local battleServer = self:GetService("Battle")
    local result = battleServer:CalcBattleResultLogic(self:MatchType(GetMatchTypeType.CalcBattleResult), false)
    result.exception = true
    if failedType then
      result.exception_code = failedType
    end
    if failedMsg then
      result.exception_msg = failedMsg
    end
    self._coreGameLogic:SetResult(result)
    self._coreGameLogic:GameOver()
  end
end

function ServerWorld:FindCehuaMatch()
  local pCoreGameLogic = self:GetCoreGameLogic()
  if nil == pCoreGameLogic then
    return nil
  end
  local pCoreGameManager = pCoreGameLogic:GetCoreGameMng()
  if nil == pCoreGameManager then
    return nil
  end
  local nMatchID = pCoreGameLogic:GetMatchID()
  return pCoreGameManager:FindCehuaMatch(nMatchID)
end
