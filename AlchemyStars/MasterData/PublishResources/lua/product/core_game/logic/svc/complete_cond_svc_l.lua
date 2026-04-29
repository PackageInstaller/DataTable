_class("CompleteConditionService", BaseService)
CompleteConditionService = CompleteConditionService
CompleteConditionCheckFlagType = {
  [1] = "Hero",
  [2] = "MonsterID",
  [3] = "Trap",
  Hero = 1,
  Monster = 2,
  Trap = 3
}

function CompleteConditionService:Constructor(world)
  self._completeConditionFunc = {}
  self._completeConditionFunc[CompleteConditionType.AllMonsterDead] = CCAllMonsterDead:New(world)
  self._completeConditionFunc[CompleteConditionType.CollectItems] = CCCollectItems:New(world)
  self._completeConditionFunc[CompleteConditionType.WaveEnd] = CCWaveEnd:New(world)
  self._completeConditionFunc[CompleteConditionType.RuneDisappear] = CCRuneDisappear:New(world)
  self._completeConditionFunc[CompleteConditionType.AllBossNotSurvival] = CCAllBossNotSurvival:New(world)
  self._completeConditionFunc[CompleteConditionType.MonsterEscape] = CCMonsterEscape:New(world)
  self._completeConditionFunc[CompleteConditionType.RoundCountLimit] = CCRoundCountLimit:New(world)
  self._completeConditionFunc[CompleteConditionType.ArriveAtPos] = CCArriveAtPos:New(world)
  self._completeConditionFunc[CompleteConditionType.MonsterDead] = CCMonsterDead:New(world)
  self._completeConditionFunc[CompleteConditionType.AllRefreshMonsterDead] = CCAllRefreshMonsterDead:New(world)
  self._completeConditionFunc[CompleteConditionType.AllRefreshMonsterDeadOrRoundCountLimit] = CCAllRefreshMonsterDeadOrRoundCountLimit:New(world)
  self._completeConditionFunc[CompleteConditionType.CheckFlagBuffCount] = CCCheckFlagBuffCount:New(world)
  self._completeConditionFunc[CompleteConditionType.AssignWaveAndRandomNextWave] = CCAssignWaveAndRandomNextWave:New(world)
  self._completeConditionFunc[CompleteConditionType.KillAnyMonsterCount] = CKillAnyMonsterCount:New(world)
  self._completeConditionFunc[CompleteConditionType.UpHoldAndKillAllInternalRefreshMonster] = CCUpHoldAndKillAnyMonsterWave:New(world)
  self._completeConditionFunc[CompleteConditionType.AllMonsterNotSurvival] = CCAllMonsterNotSurvival:New(world)
  self._completeConditionFunc[CompleteConditionType.RemotePlayerDead] = CCRemotePlayerDead:New(world)
  self._completeConditionFunc[CompleteConditionType.AllConfigMonsterDead] = CCAllConfigMonsterDead:New(world)
  self._completeConditionFunc[CompleteConditionType.AllConfigMonsterHPLock] = CCAllConfigMonsterHPLock:New(world)
  self._completeConditionFunc[CompleteConditionType.TrapTypeDeadAndAllMonsterDead] = CCTrapTypeDeadAndAllMonsterDead:New(world)
  self._completeConditionFunc[CompleteConditionType.RoundCountLimitAndCheckMonsterEscape] = CCRoundCountLimitAndCheckMonsterEscape:New(world)
  self._completeConditionFunc[CompleteConditionType.ChessEscape] = CCChessEscape:New(world)
  self._completeConditionFunc[CompleteConditionType.SelectChessEscape] = CCChessEscape:New(world)
  self._completeConditionFunc[CompleteConditionType.CompareMonsterNumber] = CCCompareMonsterNumber:New(world)
  self._completeConditionFunc[CompleteConditionType.OnlySpecifiedMonsterSurvival] = CCOnlySpecifiedMonsterSurvival:New(world)
  self._completeConditionFunc[CompleteConditionType.AllMonsterNotSurvivaldifferent] = CCAllMonsterNotSurvival:New(world)
  self._completeConditionFunc[CompleteConditionType.ComparePopStarNumber] = CCComparePopStarNumber:New(world)
  self._completeConditionFunc[CompleteConditionType.KillSpecificMonsterCount] = CCKillSpecificMonsterCount:New(world)
  self._completeConditionFunc[CompleteConditionType.KillMoreThanPetMonster] = CCKillMoreThanPetMonster:New(world)
  self._completeConditionFunc[CompleteConditionType.AllMonsterDeadOrCollectItems] = CCAllMonsterDeadOrCollectItems:New(world)
end

function CompleteConditionService:IsDoneCompleteCondition(conditionType, conditionParam, combinedConditionArguments)
  if conditionType == CompleteConditionType.CombinedCompleteCondition then
    return self:_IsDoneCombinedCondition(conditionParam, combinedConditionArguments)
  end
  local checker = self._completeConditionFunc[conditionType]
  if not checker then
    Log.fatal("IsDoneCompleteCondition() not find checker! conditionType=", conditionType)
    return false
  end
  return checker:CheckCondition(conditionParam)
end

function CompleteConditionService:_IsDoneCombinedCondition(conditionParam, combinedConditionArguments)
  local mode = conditionParam[1][1]
  local conditionA = combinedConditionArguments.conditionA
  local conditionParamA = combinedConditionArguments.conditionParamA
  local conditionB = combinedConditionArguments.conditionB
  local conditionParamB = combinedConditionArguments.conditionParamB
  local resultA, paramA = self:IsDoneCompleteCondition(conditionA, conditionParamA)
  local resultB, paramB = self:IsDoneCompleteCondition(conditionB, conditionParamB)
  paramA = paramA or {}
  paramA.isCompleted = resultA
  paramB = paramB or {}
  paramB.isCompleted = resultB
  local uniqueBattleStat = self._world:BattleStat()
  uniqueBattleStat:AppendCombinedConditionRecord(resultA, resultB)
  if mode == CombinedCompleteConditionMode.And then
    return resultA and resultB, paramA, paramB
  elseif mode == CombinedCompleteConditionMode.Or then
    if resultA then
      return true, paramA, paramB
    end
    return resultB, paramA, paramB
  end
end

function CompleteConditionService:GetArchivedData(conditionType)
  local checker = self._completeConditionFunc[conditionType]
  return checker:GetArchivedData()
end

function CompleteConditionService:SetArchivedData(conditionType, data)
  local checker = self._completeConditionFunc[conditionType]
  checker:SetArchivedData(data)
end

_class("ComplateConditionBase", Object)
ComplateConditionBase = ComplateConditionBase

function ComplateConditionBase:Constructor(world)
  self._world = world
end

function ComplateConditionBase:CheckCondition(conditionParam)
  Log.exception("CheckCondition() not implemented! cls=", self._className)
end

function ComplateConditionBase:GetArchivedData()
end

function ComplateConditionBase:SetArchivedData(data)
end

function ComplateConditionBase:_CalcMonsterCount()
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monster_entities = monster_group:GetEntities()
  local count = 0
  for k, v in ipairs(monster_entities) do
    local monsterIDCmpt = v:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not v:HasDeadMark() and not skipComplateCondition then
      count = count + 1
    end
  end
  local offBoardMonsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.OffBoardMonster)
  local offBoardMonsterEntities = offBoardMonsterGroup:GetEntities()
  for k, v in ipairs(offBoardMonsterEntities) do
    local monsterIDCmpt = v:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not v:HasDeadMark() and not skipComplateCondition then
      count = count + 1
    end
  end
  return count
end

function ComplateConditionBase:_IsAllMonsterDead()
  local count = self:_CalcMonsterCount()
  if count <= 0 then
    return true
  end
  return false
end

_class("CCAllMonsterDead", ComplateConditionBase)
CCAllMonsterDead = CCAllMonsterDead

function CCAllMonsterDead:CheckCondition(conditionParam)
  local monster_count = self:_CalcMonsterCount()
  if monster_count <= 0 then
    return true
  end
  return false
end

_class("CCCollectItems", ComplateConditionBase)
CCCollectItems = CCCollectItems

function CCCollectItems:CheckCondition(conditionParam)
  local maxCollectCount = conditionParam[1][2]
  local curCollectNum = self._world:BattleStat():GetDropCollectNum()
  if maxCollectCount <= curCollectNum then
    return true
  end
  return false
end

function CCCollectItems:GetArchivedData()
  local curCollectNum = self._world:BattleStat():GetDropCollectNum()
  return curCollectNum
end

function CCCollectItems:SetArchivedData(data)
  self._world:BattleStat():SetDropCollectNum(data)
end

_class("CCAllMonsterDeadOrCollectItems", ComplateConditionBase)
CCAllMonsterDeadOrCollectItems = CCAllMonsterDeadOrCollectItems

function CCAllMonsterDeadOrCollectItems:CheckCondition(conditionParam)
  local monster_count = self:_CalcMonsterCount()
  if monster_count <= 0 then
    return true
  end
  local maxCollectCount = conditionParam[1][2]
  local curCollectNum = self._world:BattleStat():GetDropCollectNum()
  if maxCollectCount <= curCollectNum then
    return true
  end
  return false
end

function CCAllMonsterDeadOrCollectItems:GetArchivedData()
  local curCollectNum = self._world:BattleStat():GetDropCollectNum()
  return curCollectNum
end

function CCAllMonsterDeadOrCollectItems:SetArchivedData(data)
  self._world:BattleStat():SetDropCollectNum(data)
end

_class("CCWaveEnd", ComplateConditionBase)
CCWaveEnd = CCWaveEnd

function CCWaveEnd:CheckCondition(conditionParam)
  local isAllMonsterDead = self:_IsAllMonsterDead()
  local hasNextWave = self._world:BattleStat():HasNextWave()
  if isAllMonsterDead == true and hasNextWave == false then
    return true
  end
  return false
end

_class("CCRuneDisappear", ComplateConditionBase)
CCRuneDisappear = CCRuneDisappear

function CCRuneDisappear:CheckCondition(conditionParam)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    local trapCmpt = e:Trap()
    if trapCmpt:IsRuneChange() then
      return false
    end
  end
  return self:_IsAllMonsterDead()
end

_class("CCAllBossNotSurvival", ComplateConditionBase)
CCAllBossNotSurvival = CCAllBossNotSurvival

function CCAllBossNotSurvival:CheckCondition(conditionParam)
  local hasNextWave = self._world:BattleStat():HasNextWave()
  local param = conditionParam[1]
  local monsterIDList = {}
  for _, strID in ipairs(param) do
    table.insert(monsterIDList, tonumber(strID))
  end
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monster_entities = monster_group:GetEntities()
  local count = 0
  for _, id in ipairs(monsterIDList) do
    for k, v in ipairs(monster_entities) do
      local monsterEntity = v
      if v:HasMonsterID() and v:MonsterID():GetMonsterID() == id then
        local monsterIDCmpt = v:MonsterID()
        local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
        if not monsterEntity:HasDeadMark() and not skipComplateCondition then
          return false
        end
      end
    end
  end
  if not hasNextWave then
    return true
  else
    return false
  end
end

_class("CCMonsterEscape", ComplateConditionBase)
CCMonsterEscape = CCMonsterEscape

function CCMonsterEscape:Constructor()
  self._escapeCount = 0
  self._archivedCount = 0
end

function CCMonsterEscape:CheckCondition(conditionParam)
  local entityGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterEscape)
  local es = entityGroup:GetEntities()
  local nEscape = 0
  for _, e in ipairs(es) do
    local monsterEscapeComponent = e:MonsterEscape()
    if monsterEscapeComponent and monsterEscapeComponent:IsEscapeSuccess() then
      nEscape = nEscape + 1
    end
  end
  local nLimitCount = conditionParam[1]
  self._escapeCount = nEscape
  return nEscape > nLimitCount
end

function CCMonsterEscape:GetArchivedData()
  return self._escapeCount
end

function CCMonsterEscape:SetArchivedData(data)
  self._archivedCount = data
end

_class("CCRoundCountLimit", ComplateConditionBase)
CCRoundCountLimit = CCRoundCountLimit

function CCRoundCountLimit:CheckCondition(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  local nRoundNow = battleStatCmpt:GetCurWaveTotalRoundCount()
  local nRoundLimit = conditionParam[1][1]
  local levelSupplementRoundCount = battleStatCmpt:GetLevelSupplementRoundCount()
  local nRoundMax = nRoundLimit + levelSupplementRoundCount
  if nRoundNow > nRoundMax then
    return true, {
      current = nRoundNow - 1,
      full = nRoundMax
    }
  end
  return false, {
    current = nRoundNow - 1,
    full = nRoundMax
  }
end

function CCRoundCountLimit:GetArchivedData()
  local battleStatCmpt = self._world:BattleStat()
  local nRoundNow = battleStatCmpt:GetCurWaveTotalRoundCount()
  return nRoundNow
end

function CCRoundCountLimit:SetArchivedData(data)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetCurWaveTotalRoundCount(data)
end

_class("CCRoundCountLimitAndCheckMonsterEscape", ComplateConditionBase)
CCRoundCountLimitAndCheckMonsterEscape = CCRoundCountLimitAndCheckMonsterEscape

function CCRoundCountLimitAndCheckMonsterEscape:Constructor()
  self._escapeCount = 0
  self._archivedCount = 0
end

function CCRoundCountLimitAndCheckMonsterEscape:CheckCondition(conditionParam)
  local escapeOk, escapeParam = self:_CheckEscape(conditionParam)
  if escapeOk then
    local roundOk = self:_CheckRound(conditionParam)
    if roundOk then
      return true, escapeParam
    end
  end
  return false
end

function CCRoundCountLimitAndCheckMonsterEscape:_CheckRound(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  local nRoundNow = battleStatCmpt:GetCurWaveTotalRoundCount()
  local nRoundLimit = conditionParam[1][1]
  local levelSupplementRoundCount = battleStatCmpt:GetLevelSupplementRoundCount()
  local nRoundMax = nRoundLimit + levelSupplementRoundCount
  if nRoundNow > nRoundMax then
    return true, {
      current = nRoundNow - 1,
      full = nRoundMax
    }
  end
  return false, {
    current = nRoundNow - 1,
    full = nRoundMax
  }
end

function CCRoundCountLimitAndCheckMonsterEscape:_CheckEscape(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  local nLimitCount = conditionParam[1][2]
  local nEscape = battleStatCmpt:GetMonsterEscapeNum()
  self._escapeCount = nEscape
  return nLimitCount > nEscape, {
    current = self._escapeCount,
    full = nLimitCount
  }
end

function CCRoundCountLimitAndCheckMonsterEscape:GetArchivedData()
  local data = {}
  local battleStatCmpt = self._world:BattleStat()
  local nRoundNow = battleStatCmpt:GetCurWaveTotalRoundCount()
  data.nRoundNow = nRoundNow
  data.escapeCount = self._escapeCount
  return data
end

function CCRoundCountLimitAndCheckMonsterEscape:SetArchivedData(data)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetCurWaveTotalRoundCount(data.nRoundNow)
  self._archivedCount = data.escapeCount
end

_class("CCArriveAtPos", ComplateConditionBase)
CCArriveAtPos = CCArriveAtPos

function CCArriveAtPos:CheckCondition(conditionParam)
  local ePlayer = self._world:Player():GetLocalTeamEntity()
  if ePlayer and ePlayer:GridLocation().Position == Vector2(conditionParam[1][1], conditionParam[1][2]) then
    return true
  end
  return false
end

_class("CCMonsterDead", ComplateConditionBase)
CCMonsterDead = CCMonsterDead

function CCMonsterDead:CheckCondition(conditionParam)
  local monsterIDList = {}
  for _, monsterID in ipairs(conditionParam[1]) do
    table.insert(monsterIDList, tonumber(monsterID))
  end
  local battleStatCmpt = self._world:BattleStat()
  local totalDeadMonsterIDList = battleStatCmpt:GetTotalDeadMonsterIDList()
  for _, id in ipairs(monsterIDList) do
    local bFind = false
    for k, v in ipairs(totalDeadMonsterIDList) do
      if v:GetMonsterID() == id then
        bFind = true
      end
    end
    if not bFind then
      return false
    end
  end
  return true
end

_class("CCAllRefreshMonsterDead", ComplateConditionBase)
CCAllRefreshMonsterDead = CCAllRefreshMonsterDead

function CCAllRefreshMonsterDead:CheckCondition(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  local totalDeadMonsterIDList = battleStatCmpt:GetTotalDeadMonsterIDList()
  local levelConfigData = self._world:GetService("Config"):GetLevelConfigData()
  local monsterIds = levelConfigData:GetAllMonsterID()
  local monsterIdsCopy = {}
  table.appendArray(monsterIdsCopy, monsterIds)
  for _, monsterDeadParam in ipairs(totalDeadMonsterIDList) do
    local deadMonsterID = monsterDeadParam:GetMonsterID()
    if table.intable(monsterIdsCopy, deadMonsterID) then
      table.removev(monsterIdsCopy, deadMonsterID)
    end
  end
  if #monsterIdsCopy == 0 then
    return true
  end
  return false
end

_class("CCAllRefreshMonsterDeadOrRoundCountLimit", ComplateConditionBase)
CCAllRefreshMonsterDeadOrRoundCountLimit = CCAllRefreshMonsterDeadOrRoundCountLimit

function CCAllRefreshMonsterDeadOrRoundCountLimit:CheckCondition(conditionParam)
  local ccsvc = self._world:GetService("CompleteCondition")
  local _roundCountLimit = ccsvc:IsDoneCompleteCondition(CompleteConditionType.RoundCountLimit, conditionParam)
  local _allRefreshMonsterDead = ccsvc:IsDoneCompleteCondition(CompleteConditionType.AllRefreshMonsterDead, conditionParam)
  if _roundCountLimit or _allRefreshMonsterDead then
    return true
  end
  return false
end

function CCAllRefreshMonsterDeadOrRoundCountLimit:GetArchivedData()
  local data = {}
  local battleStatCmpt = self._world:BattleStat()
  local waveDeadMonsterIDList = battleStatCmpt:GetCurWaveDeadMonsterIDList()
  data.deadMonsterIDList = waveDeadMonsterIDList
  local battleStatCmpt = self._world:BattleStat()
  local nRoundNow = battleStatCmpt:GetCurWaveTotalRoundCount()
  data.waveRoundCount = nRoundNow
  return data
end

function CCAllRefreshMonsterDeadOrRoundCountLimit:SetArchivedData(data)
  local battleStatCmpt = self._world:BattleStat()
  for i, monsterID in ipairs(data.deadMonsterIDList) do
    battleStatCmpt:AddDeadMonsterID(monsterID)
  end
  battleStatCmpt:SetCurWaveTotalRoundCount(data.waveRoundCount)
end

_class("CCAssignWaveAndRandomNextWave", ComplateConditionBase)
CCAssignWaveAndRandomNextWave = CCAssignWaveAndRandomNextWave

function CCAssignWaveAndRandomNextWave:CheckCondition(conditionParam)
  local baseParamInfoIndex = LevelCompleteAssignWaveParamExp.BaseLevelCompleteCond
  local param = conditionParam[1]
  local battleStatCmpt = self._world:BattleStat()
  local nCurWave = battleStatCmpt:GetCurWaveIndex()
  local l_nAssignWave = param[LevelCompleteAssignWaveParamExp.AssignWaveEnd]
  local l_nBaseCompleteConditionType = param[baseParamInfoIndex]
  local isFinish = false
  if nCurWave == l_nAssignWave then
    if l_nBaseCompleteConditionType and l_nBaseCompleteConditionType ~= CompleteConditionType.WaveEnd then
      local baseParam = {}
      local baseParamCount = table.count(param)
      if baseParamInfoIndex < baseParamCount then
        for i = baseParamInfoIndex + 1, baseParamCount do
          baseParam[i - baseParamInfoIndex] = param[i]
        end
      end
      local ccsvc = self._world:GetService("CompleteCondition")
      isFinish = ccsvc:IsDoneCompleteCondition(l_nBaseCompleteConditionType, baseParam)
    else
      isFinish = self:_IsAllMonsterDead()
    end
    return isFinish
  elseif nCurWave > l_nAssignWave then
    return true
  else
    return false
  end
end

_class("CCCheckFlagBuffCount", ComplateConditionBase)
CCCheckFlagBuffCount = CCCheckFlagBuffCount

function CCCheckFlagBuffCount:CheckCondition(conditionParam)
  local param = conditionParam[1]
  local targetType = param[1]
  local flagID = param[2]
  local requiredCount = param[3]
  local entities = {}
  if targetType == CompleteConditionCheckFlagType.Hero then
    table.insert(entities, self._world:Player():GetLocalTeamEntity())
  else
    local groupMatcher = self._world.BW_WEMatchers[CompleteConditionCheckFlagType[targetType]]
    local group = self._world:GetGroup(groupMatcher)
    if not group then
      Log.fatal("No entity group for targetType ", tostring(targetType))
      return false
    end
    entities = group:GetEntities()
  end
  if #entities == 0 then
    return false
  end
  local currentMaxCount = 0
  for _, entity in ipairs(entities) do
    currentMaxCount = math.max(currentMaxCount, self:_GetFlagBuffCount(entity, flagID))
  end
  return requiredCount <= currentMaxCount
end

function CCCheckFlagBuffCount:_GetFlagBuffCount(entity, flagID)
  if not entity:HasBuff() then
    return 0
  end
  local buffComponent = entity:BuffComponent()
  local flagKey = string.format(BattleConst.FlagBuffOverlayKeyFormatter, flagID)
  return buffComponent:GetBuffValue(flagKey) or 0
end

function CCCheckFlagBuffCount:GetArchivedData()
end

function CCCheckFlagBuffCount:SetArchivedData(data)
end

_class("CKillAnyMonsterCount", ComplateConditionBase)
CKillAnyMonsterCount = CKillAnyMonsterCount

function CKillAnyMonsterCount:CheckCondition(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  local totalDeadMonsterIDList = battleStatCmpt:GetCurWaveDeadMonsterIDList()
  local deadMonsterCount = table.count(totalDeadMonsterIDList)
  local needKillCount = conditionParam[1][1]
  if deadMonsterCount >= needKillCount then
    return true, {current = deadMonsterCount, full = needKillCount}
  end
  return false, {current = deadMonsterCount, full = needKillCount}
end

_class("CCUpHoldAndKillAnyMonsterWave", CCAllRefreshMonsterDead)
CCUpHoldAndKillAnyMonsterWave = CCUpHoldAndKillAnyMonsterWave

function CCUpHoldAndKillAnyMonsterWave:CheckCondition(conditionParam)
  return CCUpHoldAndKillAnyMonsterWave.super.CheckCondition(self, conditionParam)
end

_class("CCAllMonsterNotSurvival", ComplateConditionBase)
CCAllMonsterNotSurvival = CCAllMonsterNotSurvival

function CCAllMonsterNotSurvival:CheckCondition(conditionParam)
  local monsterIDList = {}
  for _, strID in ipairs(conditionParam[1]) do
    table.insert(monsterIDList, tonumber(strID))
  end
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monster_entities = monster_group:GetEntities()
  local count = 0
  for _, id in ipairs(monsterIDList) do
    for k, v in ipairs(monster_entities) do
      local monsterEntity = v
      if v:HasMonsterID() and v:MonsterID():GetMonsterID() == id then
        local monsterIDCmpt = v:MonsterID()
        local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
        if not monsterEntity:HasDeadMark() and not skipComplateCondition then
          return false
        end
      end
    end
  end
  return true
end

_class("CCRemotePlayerDead", ComplateConditionBase)
CCRemotePlayerDead = CCRemotePlayerDead

function CCRemotePlayerDead:CheckCondition(conditionParam)
  local remoteTeamEntity = self._world:Player():GetRemoteTeamEntity()
  if remoteTeamEntity and remoteTeamEntity:HasTeamDeadMark() then
    return true
  end
  return false
end

_class("CCAllConfigMonsterDead", ComplateConditionBase)
CCAllConfigMonsterDead = CCAllConfigMonsterDead

function CCAllConfigMonsterDead:CheckCondition(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  for i, param in ipairs(conditionParam) do
    if type(param) == "number" and not battleStatCmpt:IsMonsterHasDead(param) then
      return false
    end
    if type(param) == "table" then
      local noOne = true
      for _, v in ipairs(param) do
        local monsterID = tonumber(v)
        if battleStatCmpt:IsMonsterHasDead(monsterID) then
          noOne = false
          break
        end
      end
      if noOne then
        return false
      end
    end
  end
  return true
end

_class("CCAllConfigMonsterHPLock", ComplateConditionBase)
CCAllConfigMonsterHPLock = CCAllConfigMonsterHPLock

function CCAllConfigMonsterHPLock:CheckCondition(conditionParam)
  local monsterClassIDTable = conditionParam[1]
  local lockHPDic = {}
  local bufflsvc = self._world:GetService("BuffLogic")
  local GLOBALmonsterGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, entity in ipairs(GLOBALmonsterGroupEntities) do
    if not entity:HasDeadMark() then
      local cMonsterID = entity:MonsterID()
      local monsterClassID = cMonsterID:GetMonsterClassID()
      if table.icontains(monsterClassIDTable, monsterClassID) then
        local hasLockHPBuff, isLock = bufflsvc:CheckEntityLockHP(entity)
        if hasLockHPBuff then
          local curHp = entity:Attributes():GetCurrentHP()
          local maxHp = entity:Attributes():CalcMaxHp()
          local leftHPPercent = curHp / maxHp * 100
          local lockHPPercent = bufflsvc:GetLockHPInfo(entity)
          if 0 < lockHPPercent then
            lockHPDic[monsterClassID] = true
          end
        end
      end
    end
  end
  local isAllConfigMonsterHPLock = true
  for _, classID in ipairs(monsterClassIDTable) do
    isAllConfigMonsterHPLock = isAllConfigMonsterHPLock and lockHPDic[classID]
  end
  return isAllConfigMonsterHPLock
end

_class("CCTrapTypeDeadAndAllMonsterDead", ComplateConditionBase)
CCTrapTypeDeadAndAllMonsterDead = CCTrapTypeDeadAndAllMonsterDead

function CCTrapTypeDeadAndAllMonsterDead:CheckCondition(conditionParam)
  local trapType = conditionParam[1][1]
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    local trapCmpt = e:Trap()
    if trapCmpt:GetTrapType() == trapType and not e:HasDeadMark() then
      return false
    end
  end
  local monster_count = self:_CalcMonsterCount()
  if 0 < monster_count then
    return false
  end
  return true
end

_class("CCChessEscape", ComplateConditionBase)
CCChessEscape = CCChessEscape

function CCChessEscape:Constructor()
  self._escapeCount = 0
  self._archivedCount = 0
end

function CCChessEscape:CheckCondition(conditionParam)
  local limitCount = conditionParam[1][1]
  local targetChessClassID = conditionParam[1][2] or 0
  local monster_count = self:_CalcMonsterCount()
  if monster_count <= 0 then
    return true, {current = limitCount, full = limitCount}
  end
  local entityGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterEscape)
  local es = entityGroup:GetEntities()
  local nEscape = 0
  for _, e in ipairs(es) do
    local monsterEscapeComponent = e:MonsterEscape()
    local chessPetCmpt = e:ChessPet()
    if monsterEscapeComponent and monsterEscapeComponent:IsEscapeSuccess() and chessPetCmpt then
      if targetChessClassID ~= 0 then
        local chessPetClassID = chessPetCmpt:GetChessPetClassID()
        if targetChessClassID == chessPetClassID then
          nEscape = nEscape + 1
        end
      else
        nEscape = nEscape + 1
      end
    end
  end
  self._escapeCount = nEscape
  return limitCount <= nEscape, {current = nEscape, full = limitCount}
end

_class("CCCompareMonsterNumber", ComplateConditionBase)
CCCompareMonsterNumber = CCCompareMonsterNumber

function CCCompareMonsterNumber:CheckCondition(conditionParam)
  local type = conditionParam[1][1] or ConditionCompareType.Equal
  local count = conditionParam[1][2] or 0
  local curCount = self:_CalcMonsterCount()
  return CompareFunByType(type, curCount, count)
end

_class("CCOnlySpecifiedMonsterSurvival", ComplateConditionBase)
CCOnlySpecifiedMonsterSurvival = CCOnlySpecifiedMonsterSurvival

function CCOnlySpecifiedMonsterSurvival:CheckCondition(conditionParam)
  local monsterIDList = {}
  for _, strID in ipairs(conditionParam[1]) do
    table.insert(monsterIDList, tonumber(strID))
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monsters = monsterGroup:GetEntities()
  for k, v in ipairs(monsters) do
    local monsterID
    if v:HasMonsterID() then
      monsterID = v:MonsterID():GetMonsterID()
    end
    if monsterID and not table.icontains(monsterIDList, monsterID) then
      local monsterIDCmpt = v:MonsterID()
      local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
      if not v:HasDeadMark() and not skipComplateCondition then
        return false
      end
    end
  end
  return true
end

_class("CCComparePopStarNumber", ComplateConditionBase)
CCComparePopStarNumber = CCComparePopStarNumber

function CCComparePopStarNumber:CheckCondition(conditionParam)
  local popNumMax = conditionParam[1][1]
  local popStarSvc = self._world:GetService("PopStarLogic")
  local curNum = popStarSvc:GetPopGridNum()
  if popNumMax <= curNum then
    return true
  end
  return false
end

_class("CCKillSpecificMonsterCount", ComplateConditionBase)
CCKillSpecificMonsterCount = CCKillSpecificMonsterCount

function CCKillSpecificMonsterCount:CheckCondition(conditionParam)
  local battleStatCmpt = self._world:BattleStat()
  local specificMonsterID = conditionParam[1][1]
  local needKillCount = conditionParam[1][2]
  local totalDeadMonsterIDList = battleStatCmpt:GetCurWaveDeadMonsterIDList()
  local specificMonsetDeadCount = 0
  for index, value in ipairs(totalDeadMonsterIDList) do
    if value == specificMonsterID then
      specificMonsetDeadCount = specificMonsetDeadCount + 1
    end
  end
  if needKillCount <= specificMonsetDeadCount then
    return true, {current = specificMonsetDeadCount, full = needKillCount}
  end
  return false, {current = specificMonsetDeadCount, full = needKillCount}
end

_class("CCKillMoreThanPetMonster", ComplateConditionBase)
CCKillMoreThanPetMonster = CCKillMoreThanPetMonster

function CCKillMoreThanPetMonster:CheckCondition(conditionParam)
  local targetMonsterID = conditionParam[1][1]
  local battleStatCmpt = self._world:BattleStat()
  local levelRoundCount = battleStatCmpt:GetLevelLeftRoundCount()
  if levelRoundCount ~= 0 then
    return false
  end
  local battleStatCmpt = self._world:BattleStat()
  local monsterKilledCountAll = battleStatCmpt:GetMonsterKilledCount()
  local monsterKilledCountByTargetMonster = battleStatCmpt:GetMonsterKilledCountByMonsterID(targetMonsterID)
  local monsterKilledCountByPet = monsterKilledCountAll - monsterKilledCountByTargetMonster
  if monsterKilledCountByTargetMonster < monsterKilledCountByPet then
    return true
  end
  return false
end
