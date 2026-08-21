require("random")
_class("RandomServiceLogic", BaseService)
RandomServiceLogic = RandomServiceLogic

function RandomServiceLogic:Constructor(world)
  self._logicRandor = lcg(world.BW_WorldInfo.world_seed)
  self._logicRandCount = 0
  self._boardLogicRandor = lcg(world.BW_WorldInfo.boardSeed)
  self._boardLogicRandCount = 0
  self._world = world
  self._useBoardSeed = false
end

function RandomServiceLogic:Initialize()
  if self:GetMatchType(GetMatchTypeType.WorldBossBattle) == MatchType.MT_WorldBoss then
    self._useBoardSeed = true
  end
  if self._world.BW_WorldInfo.world_seed ~= self._world.BW_WorldInfo.boardSeed then
    self._useBoardSeed = true
  end
end

function RandomServiceLogic:BoardLogicRandSelectByMatchType(m, n)
  if self._useBoardSeed then
    return self:BoardLogicRand(m, n)
  else
    return self:LogicRand(m, n)
  end
end

function RandomServiceLogic:BoardLogicRand(m, n)
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call BoardLogicRand() ", Log.traceback())
      return nil
    end
  end
  local randomNum = -1
  if m == nil and n == nil then
    randomNum = self._boardLogicRandor:random()
  else
    randomNum = self:Rounding(self._boardLogicRandor:random(m, n))
  end
  self._boardLogicRandCount = self._boardLogicRandCount + 1
  if self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    self._world:GetSyncLogger():Trace({
      key = "BoardLogicRand",
      randCount = self._boardLogicRandCount,
      randValue = randomNum
    })
  end
  return randomNum
end

function RandomServiceLogic:LogicRand(m, n)
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call LogicRand() ", Log.traceback())
      return nil
    end
  end
  local randomNum = -1
  if m == nil and n == nil then
    randomNum = self._logicRandor:random()
  else
    randomNum = self:Rounding(self._logicRandor:random(m, n))
  end
  self._logicRandCount = self._logicRandCount + 1
  if self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    self._world:GetSyncLogger():Trace({
      key = "LogicRand",
      randCount = self._logicRandCount,
      randValue = randomNum
    })
  end
  return randomNum
end

function RandomServiceLogic:Rounding(value)
  local f = math.floor(value)
  if f == value then
    return f
  else
    return math.floor(value + 0.5)
  end
end

function RandomServiceLogic:Shuffle(t)
  for i = 1, #t do
    local n = self:LogicRand(1, #t)
    t[i], t[n] = t[n], t[i]
  end
  return t
end

function RandomServiceLogic:ShuffleUseBoardRand(t)
  for i = 1, #t do
    local n = self:BoardLogicRand(1, #t)
    t[i], t[n] = t[n], t[i]
  end
  return t
end

function RandomServiceLogic:GetUseBoardSeed()
  return self._useBoardSeed
end

function RandomServiceLogic:SetUseBoardSeed(use)
  self._useBoardSeed = use
end
