_class("MonsterRefreshService", BaseService)
MonsterRefreshService = MonsterRefreshService

function MonsterRefreshService:Constructor(world)
  self._monsterRefreshFunc = {}
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.AfterMonsterDead] = self._IsMonsterDead
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.EveryRoundCount] = self._IsRoundAccept
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.WatchTarget] = self._WatchTargetExceptMonsterTurn
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.AllMonsterDead] = self._AllMonsterDead
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.TargetRound] = self._TargetRound
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.RoundResultWatchTarget] = self._RoundResultTargetRound
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.RoundResultCheckMonsterCount] = self._RoundResultCheckMonsterCount
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.AssignRefreshTypeAndTime] = self._AssignRefreshTypeAndTime
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.CompareMonsterNumber] = self._CompareMonsterNumber
  self._monsterRefreshFunc[MonsterWaveInternalRefreshType.OnlySpecifiedMonsterSurvival] = self._OnlySpecifiedMonsterSurvival
end

function MonsterRefreshService:IsRefreshMonster(refreshType, refreshParam, monsterWaveInternalTime, hadRefreshRound)
  return self._monsterRefreshFunc[refreshType](self, refreshParam, monsterWaveInternalTime, hadRefreshRound)
end

function MonsterRefreshService:_IsMonsterDead(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  if not notCheckTime and monsterWaveInternalTime == MonsterWaveInternalTime.MonsterTurn then
    return false
  end
  local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  if self:_GetBattleStatComponent():IsCurWaveHasDeadRefreshMonster() then
    return false
  end
  local needMonsterList = table.cloneconf(refreshParam)
  local monsterIDList = self:_GetBattleStatComponent():GetCurWaveDeadMonsterIDList()
  for _, id in ipairs(monsterIDList) do
    table.removev(needMonsterList, id)
  end
  local ret = #needMonsterList == 0
  self:_GetBattleStatComponent():SetCurWaveHasDeadRefreshMonsterState(ret)
  return ret
end

function MonsterRefreshService:_IsRoundAccept(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  if not notCheckTime and monsterWaveInternalTime ~= MonsterWaveInternalTime.MonsterTurn then
    return false
  end
  local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  local condition = tonumber(refreshParam[1])
  if roundCount < condition then
    return false
  end
  local _, r = math.modf(roundCount / condition)
  return r == 0
end

function MonsterRefreshService:_WatchTargetExceptMonsterTurn(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  if not notCheckTime and monsterWaveInternalTime == MonsterWaveInternalTime.MonsterTurn then
    return false
  end
  return self:_WatchTarget(refreshParam, hadRefreshRound)
end

function MonsterRefreshService:_WatchTarget(refreshParam, hadRefreshRound)
  local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  local monsterID = refreshParam[1]
  local monsterTargetCount = tonumber(refreshParam[2])
  local limitCount = tonumber(refreshParam[3])
  if limitCount and limitCount <= table.count(hadRefreshRound) then
    return false
  end
  local curMonsterCount = 0
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, aiEntity in ipairs(group:GetEntities()) do
    if not aiEntity:HasDeadMark() then
      local monsterIDCmpt = aiEntity:MonsterID()
      if monsterIDCmpt ~= nil then
        local curID = monsterIDCmpt:GetMonsterID()
        if type(monsterID) ~= "table" and curID == tonumber(monsterID) then
          curMonsterCount = curMonsterCount + 1
        elseif type(monsterID) == "table" and table.intable(monsterID, curID) then
          curMonsterCount = curMonsterCount + 1
        elseif type(monsterID) == "table" and #monsterID == 0 then
          curMonsterCount = curMonsterCount + 1
        end
      end
    end
  end
  if monsterTargetCount > curMonsterCount then
    return true
  end
  return false
end

function MonsterRefreshService:_RoundResultTargetRound(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  local invalidTime = {
    MonsterWaveInternalTime.ActiveSkill,
    MonsterWaveInternalTime.MonsterTurn
  }
  if not notCheckTime and table.icontains(invalidTime, monsterWaveInternalTime) then
    return false
  end
  return self:_WatchTarget(refreshParam, hadRefreshRound)
end

function MonsterRefreshService:_AllMonsterDead(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  if not notCheckTime and monsterWaveInternalTime == MonsterWaveInternalTime.MonsterTurn then
    return false
  end
  local battleStatCmpt = self:_GetBattleStatComponent()
  local roundCount = battleStatCmpt:GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  if 0 < #hadRefreshRound then
    return false
  end
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local curMonsterCount = #group:GetEntities()
  local offBoardMonsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.OffBoardMonster)
  curMonsterCount = curMonsterCount + #offBoardMonsterGroup:GetEntities()
  if curMonsterCount ~= 0 then
    return false
  end
  local strRefreshTimes = refreshParam[1]
  if strRefreshTimes ~= nil then
    local nRefreshTimes = tonumber(strRefreshTimes)
    local nCurRefreshTimes = battleStatCmpt:GetCurWaveAllMonsterDeadTimes()
    if nRefreshTimes <= nCurRefreshTimes then
      return false
    end
    battleStatCmpt:AddCurWaveAllmonsterDeadTimes()
    return true
  end
  return true
end

function MonsterRefreshService:_TargetRound(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  if not notCheckTime and monsterWaveInternalTime ~= MonsterWaveInternalTime.MonsterTurn then
    return false
  end
  local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  if 0 < #hadRefreshRound then
    return false
  end
  local condition = tonumber(refreshParam[1])
  return condition == roundCount
end

function MonsterRefreshService:_RoundResultCheckMonsterCount(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  if not notCheckTime and MonsterWaveInternalTime.RoundResult ~= monsterWaveInternalTime then
    return false
  end
  return self:_WatchTarget(refreshParam, hadRefreshRound)
end

function MonsterRefreshService:_AssignRefreshTypeAndTime(refreshParam, monsterWaveInternalTime, hadRefreshRound)
  local assignType = refreshParam.refreshType
  local assignParam = refreshParam.refreshParam
  local assignTimeList = refreshParam.time
  if not table.icontains(assignTimeList, monsterWaveInternalTime) then
    return false
  end
  return self._monsterRefreshFunc[assignType](self, assignParam, monsterWaveInternalTime, hadRefreshRound, true)
end

function MonsterRefreshService:_CompareMonsterNumber(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  local type = tonumber(refreshParam[1])
  local count = tonumber(refreshParam[2])
  local curMonsterCount = 0
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monster in ipairs(group:GetEntities()) do
    if not monster:HasDeadMark() then
      curMonsterCount = curMonsterCount + 1
    end
  end
  return CompareFunByType(type, curMonsterCount, count)
end

function MonsterRefreshService:_OnlySpecifiedMonsterSurvival(refreshParam, monsterWaveInternalTime, hadRefreshRound, notCheckTime)
  local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
  if table.intable(hadRefreshRound, roundCount) then
    return false
  end
  local monsterID = refreshParam[1]
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monster in ipairs(group:GetEntities()) do
    if not monster:HasDeadMark() then
      local monsterIDCmpt = monster:MonsterID()
      if monsterIDCmpt ~= nil then
        local curID = monsterIDCmpt:GetMonsterID()
        if type(monsterID) ~= "table" and curID ~= tonumber(monsterID) then
          return false
        elseif type(monsterID) == "table" and not table.intable(monsterID, curID) then
          return false
        end
      end
    end
  end
  return true
end
