_class("BaseService", Object)
BaseService = BaseService

function BaseService:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._mathService = self._world:GetService("Math")
  local runPos = self._world:GetRunningPosition()
  if runPos == WorldRunPostion.AtServer then
    local serverWorld = self._world
    self._eventDispatcher = serverWorld:EventDispatcher()
  else
    self._eventDispatcher = GameGlobal.EventDispatcher()
  end
end

function BaseService:_GetBattleStatComponent()
  return self._world:BattleStat()
end

function BaseService:_GetEventDispatcher()
  return self._eventDispatcher
end

function BaseService:_GetRandomNumber(m, n)
  local randomService = self._world:GetService("RandomLogic")
  return randomService:LogicRand(m, n)
end

function BaseService:GetBoardRandomNumber(m, n)
  local randomService = self._world:GetService("RandomLogic")
  return randomService:BoardLogicRand(m, n)
end

function BaseService:GetService(name)
  return self._world:GetService(name)
end

function BaseService:GetMatchType()
  return self._world:MatchType()
end

function BaseService:LogNotice(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(self._className, " ", ...)
  end
end

function BaseService:LogWarn(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.warn(self._className, " ", ...)
  end
end

function BaseService:LogError(...)
  Log.error(self._className, " ", ...)
end

function BaseService:ThrowException(...)
  Log.exception(self._className, " ", ...)
end
