require("base_service")
_class("BattleService", BaseService)
BattleService = BattleService

function BattleService:Constructor(world)
  self._comboNum = 0
  self._logicComboNum = 0
  self._logicChainNum = 0
end

function BattleService:IsValidPiecePos(pos)
  local utilData = self._world:GetService("UtilData")
  local isValidGrid = utilData:IsValidPiecePos(pos)
  return isValidGrid
end

function BattleService:IsPosBlock(pos, blockFlag)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local isBlocked = boardServiceLogic:IsPosBlock(pos, blockFlag)
  return isBlocked
end

function BattleService:GetLogicComboNum()
  return self._logicComboNum
end

function BattleService:SetLogicComboNum(comboNum)
  self._logicComboNum = comboNum
end

function BattleService:SetLogicChainNum(chainNum)
  self._logicChainNum = chainNum
end

function BattleService:GetLogicChainNum()
  return self._logicChainNum
end

function BattleService:BattleCalculation()
  local player_entity = self._world:Player():GetLocalTeamEntity()
  if player_entity and self:HandlePlayerCalculation() then
    return true
  end
  local protectedTrapDead = self:HandleTrapCalculation()
  if protectedTrapDead then
    return true
  end
  local curseTowerAllActive = self:HandleCurseTowerCalculation()
  if curseTowerAllActive then
    return true
  end
  local chessPetDead = self:HandleChessCalculation()
  if chessPetDead then
    return true
  end
  local monsterEscapeTooMuch = self:HandleMonsterEscapeCalculation()
  if monsterEscapeTooMuch then
    return true
  end
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  local completeService = self._world:GetService("CompleteCondition")
  cmptBattleStat:SetBattleWaveResult(false)
  local combinedConditionArguments = self:WaveCombinedConditionArguments()
  if completeService:IsDoneCompleteCondition(completeConditionType, completeConditionParm, combinedConditionArguments) then
    cmptBattleStat:SetBattleWaveResult(true)
    return true
  end
  return false
end

function BattleService:IsCompletConditionMonsterDead()
  local levelConfigData = self._configService:GetLevelConfigData()
  local levelCompleteConditionType = levelConfigData:GetLevelCompleteConditionType()
  return levelCompleteConditionType == CompleteConditionType.AllMonsterDead or levelCompleteConditionType == CompleteConditionType.WaveEnd or levelCompleteConditionType == CompleteConditionType.AllMonsterDeadOrCollectItems
end

function BattleService:CheckLevelFinish()
  local levelConfigData = self._configService:GetLevelConfigData()
  local levelCompleteConditionType = levelConfigData:GetLevelCompleteConditionType()
  local levelCompleteConditionParam = levelConfigData:GetLevelCompleteConditionParams()
  local combinedConditionArguments = levelConfigData:GetCombinedCompleteConditionArguments()
  local completeService = self._world:GetService("CompleteCondition")
  local isComplete = completeService:IsDoneCompleteCondition(levelCompleteConditionType, levelCompleteConditionParam, combinedConditionArguments)
  return isComplete
end

function BattleService:HandlePlayerCalculation()
  local player_entity = self._world:Player():GetLocalTeamEntity()
  if player_entity == nil then
    return false
  end
  local curHP = player_entity:Attributes():GetCurrentHP()
  local affixService = self._world:GetService("Affix")
  if curHP <= 0 or affixService:IsEnoughPlayerBeHitCount() then
    self:LogNotice("player hp turn to zero,he has dead~")
    self:_GetBattleStatComponent():SetBattleWaveResult(false)
    return true
  end
  return false
end

function BattleService:HandleTrapCalculation()
  local levelCfgData = self._configService:GetLevelConfigData()
  local ingore = levelCfgData:GetIgnoreProtectedTrapDead()
  if ingore == 1 then
    return false
  end
  local utilSvc = self._world:GetService("UtilData")
  if utilSvc:GetProtectedTrap() then
    local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    local protectedTrap
    for _, e in ipairs(trapGroup:GetEntities()) do
      local trapCmpt = e:Trap()
      if trapCmpt:GetTrapType() == TrapType.Protected then
        protectedTrap = e
        local curHP = e:Attributes():GetCurrentHP()
        if curHP <= 0 then
          self:_GetBattleStatComponent():SetBattleWaveResult(false)
          return true
        end
      end
    end
    if not protectedTrap then
      return true
    end
  end
  return false
end

function BattleService:HandleCurseTowerCalculation()
  local curseTowerGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.CurseTower)
  if curseTowerGroupEntities and 0 < #curseTowerGroupEntities then
    local isAllActive = true
    for _, eTower in ipairs(curseTowerGroupEntities) do
      local isActive = eTower:CurseTower():GetTowerState() == CurseTowerState.Active
      isAllActive = isAllActive and isActive
    end
    if isAllActive then
      return true
    end
  end
  return false
end

function BattleService:HandleChessCalculation()
  if self._world:MatchType() ~= MatchType.MT_Chess then
    return false
  end
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  local chessPetGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.ChessPet)
  if completeConditionType == CompleteConditionType.CombinedCompleteCondition then
    local args = levelConfigData:GetCombinedCompleteConditionArguments()
    if args.conditionA == CompleteConditionType.ChessEscape or args.conditionA == CompleteConditionType.SelectChessEscape then
      completeConditionType = args.conditionA
      completeConditionParm = args.conditionParamA
    elseif args.conditionB == CompleteConditionType.ChessEscape or args.conditionB == CompleteConditionType.SelectChessEscape then
      completeConditionType = args.conditionB
      completeConditionParm = args.conditionParamB
    end
  end
  if completeConditionType == CompleteConditionType.SelectChessEscape then
    local targetChessClassID = completeConditionParm[1][2]
    if chessPetGroupEntities and 0 < #chessPetGroupEntities then
      for _, chessPet in ipairs(chessPetGroupEntities) do
        local chessPetCmpt = chessPet:ChessPet()
        local chessPetClassID = chessPetCmpt:GetChessPetClassID()
        local curHP = chessPet:Attributes():GetCurrentHP()
        if 0 < curHP and targetChessClassID == chessPetClassID then
          return false
        end
      end
    end
  elseif completeConditionType == CompleteConditionType.ChessEscape then
    local limitCount = completeConditionParm[1][1]
    local aliveChessCount = 0
    local escapeChessCount = 0
    if chessPetGroupEntities and 0 < #chessPetGroupEntities then
      for _, chessPet in ipairs(chessPetGroupEntities) do
        local chessPetCmpt = chessPet:ChessPet()
        local chessPetClassID = chessPetCmpt:GetChessPetClassID()
        local curHP = chessPet:Attributes():GetCurrentHP()
        if 0 < curHP and not chessPet:HasMonsterEscape() then
          aliveChessCount = aliveChessCount + 1
        end
        if chessPet:HasMonsterEscape() then
          escapeChessCount = escapeChessCount + 1
        end
      end
    end
    if 0 < aliveChessCount or limitCount <= escapeChessCount then
      return false
    end
  elseif chessPetGroupEntities and 0 < #chessPetGroupEntities then
    for _, chessPet in ipairs(chessPetGroupEntities) do
      local curHP = chessPet:Attributes():GetCurrentHP()
      if 0 < curHP then
        return false
      end
    end
  end
  return true
end

function BattleService:HandleMonsterEscapeCalculation()
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  if completeConditionType == CompleteConditionType.RoundCountLimitAndCheckMonsterEscape then
    local limit = completeConditionParm[1][2]
    local nEscape = cmptBattleStat:GetMonsterEscapeNum()
    local escapeTooMuch = limit <= nEscape
    return escapeTooMuch
  end
  return false
end

function BattleService:HandleKillAnyMonsterCountCalculation()
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  if completeConditionType == CompleteConditionType.CombinedCompleteCondition then
    local mode = completeConditionParm[1][1]
    if mode == CombinedCompleteConditionMode.And then
      local args = levelConfigData:GetCombinedCompleteConditionArguments()
      if args.conditionA == CompleteConditionType.KillAnyMonsterCount then
        completeConditionType = args.conditionA
        completeConditionParm = args.conditionParamA
      elseif args.conditionB == CompleteConditionType.KillAnyMonsterCount then
        completeConditionType = args.conditionB
        completeConditionParm = args.conditionParamB
      end
    end
  end
  if completeConditionType == CompleteConditionType.KillAnyMonsterCount then
    local completeService = self._world:GetService("CompleteCondition")
    if not completeService:IsDoneCompleteCondition(completeConditionType, completeConditionParm, nil) then
      return false
    end
  end
  return true
end

function BattleService:HandleKillSpecificMonsterCountCalculation()
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  if completeConditionType == CompleteConditionType.CombinedCompleteCondition then
    local mode = completeConditionParm[1][1]
    if mode == CombinedCompleteConditionMode.And then
      local args = levelConfigData:GetCombinedCompleteConditionArguments()
      if args.conditionA == CompleteConditionType.KillSpecificMonsterCount then
        completeConditionType = args.conditionA
        completeConditionParm = args.conditionParamA
      elseif args.conditionB == CompleteConditionType.KillSpecificMonsterCount then
        completeConditionType = args.conditionB
        completeConditionParm = args.conditionParamB
      end
    end
  end
  if completeConditionType == CompleteConditionType.KillSpecificMonsterCount then
    local completeService = self._world:GetService("CompleteCondition")
    if not completeService:IsDoneCompleteCondition(completeConditionType, completeConditionParm, nil) then
      return false
    end
  end
  return true
end

function BattleService:HandleKillMoreThanPetMonsterCalculation()
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  if completeConditionType == CompleteConditionType.KillMoreThanPetMonster then
    local targetMonsterID = completeConditionParm[1][1]
    local battleStatCmpt = self._world:BattleStat()
    local monsterKilledCountAll = battleStatCmpt:GetMonsterKilledCount()
    local monsterKilledCountByTargetMonster = battleStatCmpt:GetMonsterKilledCountByMonsterID(targetMonsterID)
    local monsterKilledCountByPet = monsterKilledCountAll - monsterKilledCountByTargetMonster
    if monsterKilledCountByTargetMonster >= monsterKilledCountByPet then
      return false
    end
  end
  return true
end

function BattleService:HandleMonsterCalculation(monster_entity)
end

function BattleService:CalcMonsterCount()
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local count = 0
  for k, v in ipairs(monster_group:GetEntities()) do
    count = count + 1
  end
  return count
end

function BattleService:SelectMonsterOnPos(grid_pos_list, limit)
  local monsters = {}
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, grid_pos in ipairs(grid_pos_list) do
    for _, e in ipairs(monster_group:GetEntities()) do
      local monster_grid_location_cmpt = e:GridLocation()
      if monster_grid_location_cmpt.Position == grid_pos and limit > #monsters then
        table.insert(monsters, e)
      end
    end
  end
  return monsters
end

function BattleService:IsAllMonstersPreDead(teamEntity)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemy = teamEntity:Team():GetEnemyTeamEntity()
    return enemy:HasTeamDeadMark()
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local isDead = e:HasDeadMark()
    local monsterIDCmpt = e:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not isDead and not skipComplateCondition then
      return false
    end
  end
  local offBoardMonsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.OffBoardMonster)
  local offBoardMonsterEntities = offBoardMonsterGroup:GetEntities()
  for _, e in ipairs(offBoardMonsterEntities) do
    local isDead = e:HasDeadMark()
    local monsterIDCmpt = e:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not isDead and not skipComplateCondition then
      return false
    end
  end
  return true
end

function BattleService:CheckAllMonstersDead(teamEntity)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemy = teamEntity:Team():GetEnemyTeamEntity()
    return enemy:HasTeamDeadMark()
  end
  local globalOffBoardMonsterGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.OffBoardMonster)
  if globalOffBoardMonsterGroup and 0 < #globalOffBoardMonsterGroup then
    return false
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  if monsterGroup == nil then
    return true
  end
  local aiActorCount = #monsterGroup:GetEntities()
  if aiActorCount <= 0 then
    return true
  end
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local curHP = e:Attributes():GetCurrentHP()
    if 0 < curHP then
      return false
    end
  end
  return true
end

function BattleService:CheckSpecificTrapDead()
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  if completeConditionType == CompleteConditionType.TrapTypeDeadAndAllMonsterDead then
    local completeService = self._world:GetService("CompleteCondition")
    if completeService:IsDoneCompleteCondition(completeConditionType, completeConditionParm, nil) then
      return true
    end
  else
    return true
  end
  return false
end

function BattleService:CurWaveCompleteConditionType()
  local waveCount = self:_GetBattleStatComponent():GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParam = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  return completeConditionType, completeConditionParam
end

function BattleService:WaveCombinedConditionArguments(waveCount)
  waveCount = waveCount or self:_GetBattleStatComponent():GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  return levelConfigData:GetWaveCombinedCompleteConditionArguments(waveCount)
end

function BattleService:IsWavePreEnd(teamEntity)
  local curWaveFinishType, curWaveFinishParam = self:CurWaveCompleteConditionType()
  local allMonsterPreDead = self:IsAllMonstersPreDead(teamEntity)
  if curWaveFinishType == CompleteConditionType.AllMonsterDead or curWaveFinishType == CompleteConditionType.AllMonsterDeadOrCollectItems then
    if allMonsterPreDead == true then
      return true
    end
  else
    local combinedConditionArguments = self:WaveCombinedConditionArguments()
    local completeServices = self._world:GetService("CompleteCondition")
    local isFinish = completeServices:IsDoneCompleteCondition(curWaveFinishType, curWaveFinishParam, combinedConditionArguments)
    return isFinish
  end
  return false
end

function BattleService:LevelWinKillAllMonster()
  local curWaveFinishType = self:CurWaveCompleteConditionType()
  if curWaveFinishType ~= CompleteConditionType.AllBossNotSurvival then
    return false
  end
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monster_entities = monster_group:GetEntities()
  for _, v in ipairs(monster_entities) do
    v:Attributes():Modify("HP", 0)
    sMonsterShowLogic:AddMonsterDeadMark(v, true)
  end
  local drops, deadEntityIDList = sMonsterShowLogic:DoAllMonsterDeadLogic()
  return true
end

function BattleService:IsFinalAttack()
  local isLastWave = self:_GetBattleStatComponent():IsLastWave()
  if not isLastWave then
    return false
  end
  local curWaveFinishType, curWaveFinishParam = self:CurWaveCompleteConditionType()
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  if curWaveFinishType ~= CompleteConditionType.CombinedCompleteCondition and not self:_IsNeedFinalAttack(curWaveFinishType) then
    return false
  end
  if self:IsCompletConditionMonsterDead() then
    return self:IsAllMonsterHasDeadMarkAndNoDeadSkillSummon()
  else
    local combinedConditionArguments = self:WaveCombinedConditionArguments()
    local completeServices = self._world:GetService("CompleteCondition")
    local isFinish = completeServices:IsDoneCompleteCondition(curWaveFinishType, curWaveFinishParam, combinedConditionArguments)
    if isFinish and curWaveFinishType == CompleteConditionType.CombinedCompleteCondition then
      local isFinalAttack = self:_IsCombinedConditionNeedFinalAttack(curWaveFinishParam, combinedConditionArguments)
      return isFinalAttack
    end
    return isFinish
  end
end

function BattleService:IsPlayerTurnFinalAttack()
  return self:IsFinalAttack()
end

function BattleService:IsAllMonsterHasDeadMarkAndNoDeadSkillSummon()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local isDead = e:HasDeadMark()
    local monsterIDCmpt = e:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not isDead and not skipComplateCondition then
      return false
    end
    if self:HasDeadSkillSummonMonster(e) then
      return false
    end
  end
  local offBoardMonsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.OffBoardMonster)
  local offBoardMonsterEntities = offBoardMonsterGroup:GetEntities()
  for _, e in ipairs(offBoardMonsterEntities) do
    local isDead = e:HasDeadMark()
    local monsterIDCmpt = e:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not isDead and not skipComplateCondition then
      return false
    end
  end
  return true
end

function BattleService:HasDeadSkillSummonMonster(entity)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterIDCmpt = entity:MonsterID()
  local deathSkillID = 0
  if monsterIDCmpt then
    deathSkillID = monsterConfigData:GetMonsterDeathSkillID(monsterIDCmpt:GetMonsterID())
    if deathSkillID then
      local configService = self._world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(deathSkillID)
      local cfgEffectArray = skillConfigData:GetSkillEffect()
      for index, cfgEffectParam in ipairs(cfgEffectArray) do
        if cfgEffectParam:GetEffectType() == SkillEffectType.SummonEverything then
          return true
        end
      end
    end
  end
  return false
end

function BattleService:_IsNeedFinalAttack(curWaveFinishType)
  if curWaveFinishType == CompleteConditionType.CollectItems or curWaveFinishType == CompleteConditionType.RoundCountLimit or curWaveFinishType == CompleteConditionType.ArriveAtPos or curWaveFinishType == CompleteConditionType.AllRefreshMonsterDeadOrRoundCountLimit or curWaveFinishType == CompleteConditionType.CheckFlagBuffCount or curWaveFinishType == CompleteConditionType.KillMoreThanPetMonster then
    return false
  end
  return true
end

function BattleService:_IsCombinedConditionNeedFinalAttack(conditionParam, combinedConditionArguments)
  local mode = conditionParam[1][1]
  local conditionA = combinedConditionArguments.conditionA
  local conditionParamA = combinedConditionArguments.conditionParamA
  local conditionB = combinedConditionArguments.conditionB
  local conditionParamB = combinedConditionArguments.conditionParamB
  local uniqueBattleStat = self._world:BattleStat()
  local records = uniqueBattleStat:GetCombinedConditionRecord()
  if #records == 0 then
    Log.error("_IsCombinedConditionNeedFinalAttack: no combined condition record???")
    return true
  end
  local determiningConditionType
  if mode == CombinedCompleteConditionMode.And then
    local last = records[#records]
    local lastA = last.resultA
    local lastB = last.resultB
    if not lastA or not lastB then
      return false
    end
    for i = #records - 1, 1, -1 do
      local data = records[i]
      if not data.resultA and not data.resultB then
        determiningConditionType = conditionB
        break
      elseif not data.resultA or not data.resultB then
        if not data.resultA then
          determiningConditionType = conditionA
          break
        end
        determiningConditionType = conditionB
        break
      end
      lastA = data.resultA
      lastB = data.resultB
    end
  elseif mode == CombinedCompleteConditionMode.Or then
    local first = records[#records]
    local lastA = first.resultA
    local lastB = first.resultB
    if not lastA and not lastB then
      return false
    end
    if lastA ~= lastB then
      determiningConditionType = lastA and conditionA or conditionB
    else
      for i = #records - 1, 1, -1 do
        local data = records[i]
        if not (data.resultA or data.resultB) then
          break
        end
        lastA = data.resultA
        lastB = data.resultB
        if lastA ~= lastB then
          break
        end
      end
      if lastA ~= lastB then
        determiningConditionType = lastA and conditionA or conditionB
      else
        determiningConditionType = conditionA
      end
    end
  else
    Log.error("invalid combined complete condition mode: ", tostring(mode))
    return true
  end
  local condParam = determiningConditionType == conditionA and conditionParamA or conditionParamB
  local completeServices = self._world:GetService("CompleteCondition")
  return completeServices:IsDoneCompleteCondition(conditionA, condParam, nil)
end

function BattleService:GetMathService()
  local mathService = self._world:GetService("Math")
  return mathService
end

function BattleService:GetRandom(m, n)
  local randomSvc = self._world:GetService("RandomLogic")
  return randomSvc:LogicRand(m, n)
end

function BattleService:IsCurWaveExit()
  local waveType, _ = self:CurWaveCompleteConditionType()
  if waveType == CompleteConditionType.ArriveAtPos then
    return true
  end
  return false
end

function BattleService:CurWaveExitPos()
  local waveType, waveParam = self:CurWaveCompleteConditionType()
  if waveType == CompleteConditionType.ArriveAtPos then
    return Vector2(waveParam[1][1], waveParam[1][2])
  end
end

function BattleService:InitWordBuff(GameStartBuffs)
  local words = self._world.BW_WorldInfo.wordBuffIds
  if words == nil or #words == 0 then
    return
  end
  local buffLogic = self._world:GetService("BuffLogic")
  for _, wordID in ipairs(words) do
    local cfg = Cfg.cfg_word_buff[wordID]
    if cfg == nil then
      Log.fatal("word not found: ", wordID)
      return
    end
    for _, id in ipairs(cfg.BuffID) do
      local ret = buffLogic:AddBuffByTargetType(id, cfg.BuffTargetType, cfg.BuffTargetParam)
      for _, inst in ipairs(ret) do
        GameStartBuffs[#GameStartBuffs + 1] = {
          inst:Entity(),
          inst:BuffSeq()
        }
      end
    end
  end
end

function BattleService:InitTalePetBuff(GameStartBuffs)
  local buffLogic = self._world:GetService("BuffLogic")
  local taleBuff = self._world.BW_WorldInfo.tale_pet_buffs
  if taleBuff and 0 < #taleBuff then
    for _, id in ipairs(taleBuff) do
      local ret = buffLogic:AddBuffByTargetType(id, BuffTargetType.AllTalePet, {})
      for _, inst in ipairs(ret) do
        GameStartBuffs[#GameStartBuffs + 1] = {
          inst:Entity(),
          inst:BuffSeq()
        }
      end
    end
  end
  local nonTaleBuff = self._world.BW_WorldInfo.normal_pet_buffs
  if nonTaleBuff and 0 < #nonTaleBuff then
    for _, id in ipairs(nonTaleBuff) do
      local ret = buffLogic:AddBuffByTargetType(id, BuffTargetType.AllNonTalePet, {})
      for _, inst in ipairs(ret) do
        GameStartBuffs[#GameStartBuffs + 1] = {
          inst:Entity(),
          inst:BuffSeq()
        }
      end
    end
  end
end

function BattleService:ParseSkillType(skillID)
  if not skillID then
    return nil
  end
  local cfgSvc = self._world:GetService("Config")
  local skillCfg = cfgSvc:GetSkillConfigData(skillID)
  return skillCfg:GetSkillType()
end

function BattleService:PlayerIsDead(teamEntity)
  if self._world:MatchType() == MatchType.MT_Chess then
    local allChessDead = self:HandleChessCalculation()
    if allChessDead then
      return true
    end
    return false
  end
  local attributeCmpt = teamEntity:Attributes()
  local playerHp = attributeCmpt:GetCurrentHP()
  if 0 < playerHp then
    local affixService = self._world:GetService("Affix")
    if affixService:IsEnoughPlayerBeHitCount() then
      return true
    end
    local isAllTowerActive = self:HandleCurseTowerCalculation()
    if isAllTowerActive then
      return true
    end
    return false
  else
    return true
  end
end

function BattleService:UpdateTeamHPLogic(teamEntity)
  local teamAttrConmpt = teamEntity:Attributes()
  local petList = teamEntity:Team():GetTeamPetEntities()
  local maxHP = 0
  for i, entity in ipairs(petList) do
    local attributesComponent = entity:Attributes()
    if attributesComponent then
      local petMaxHP = attributesComponent:CalcMaxHp()
      maxHP = petMaxHP + maxHP
    end
  end
  teamAttrConmpt:Modify("MaxHP", maxHP)
  self:LogNotice("UpdateTeamHPLogic()  maxHP=", maxHP)
end

function BattleService:UpdateTeamDefenceLogic(teamEntity)
  local teamAttrConmpt = teamEntity:Attributes()
  local petList = teamEntity:Team():GetTeamPetEntities()
  local defence = 0
  for i, entity in ipairs(petList) do
    local attributesComponent = entity:Attributes()
    if attributesComponent then
      local petdefence = attributesComponent:GetDefence()
      defence = petdefence + defence
    end
  end
  defence = math.ceil(defence)
  teamAttrConmpt:Modify("Defense", defence)
  self:LogNotice("UpdateTeamDefenceLogic defense=", defence)
end

function BattleService:UnloadPetLogic(teamEntity)
end

function BattleService:GetCasterHP(casterEntity)
  local attributeCmpt
  if casterEntity:HasPetPstID() then
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    attributeCmpt = teamEntity:Attributes()
  else
    attributeCmpt = casterEntity:Attributes()
  end
  local HP = attributeCmpt:GetCurrentHP()
  local maxHP = attributeCmpt:CalcMaxHp()
  return HP, maxHP
end

function BattleService:GetAliveMonsterCount()
  local MonsterEntityArray = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local liveCount = 0
  for k, entity in ipairs(MonsterEntityArray) do
    local monsterIDCmpt = entity:MonsterID()
    local skipComplateCondition = monsterIDCmpt and monsterIDCmpt:GetSkipComplateCondition()
    if not entity:HasDeadMark() and not skipComplateCondition then
      liveCount = liveCount + 1
    end
  end
  return liveCount
end

function BattleService:CalcTeamElementTypeCount()
  local elementList = {}
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(teamMembers) do
    local elementCmpt = petEntity:Element()
    local elementType = elementCmpt:GetPrimaryType()
    if not table.icontains(elementList, elementType) then
      table.insert(elementList, elementType)
    end
  end
  return #elementList
end

function BattleService:GetWorldBossTotalDamage(result, victory)
  local battleStatCmpt = self._world:BattleStat()
  local total_damage = battleStatCmpt:GetMainWorldBossBeHitDamageValue()
  if not victory then
    result.victory = 0 < total_damage
  end
  if total_damage > BattleConst.TotalDamageMaxValue then
    Log.fatal("[SyncLog],type:", BattleFailedType.TotalDamageTooLarge, " TotalDamageValue:", total_damage)
    total_damage = total_damage % BattleConst.TotalDamageMaxValueMod
  else
    total_damage = battleStatCmpt:GetMainWorldBossBeHitDamageValue()
    Log.debug("WorldBossResult Damage:", total_damage)
  end
  return total_damage
end

function BattleService:CalcBattleResultLogic(matchType, victory)
  local battleStatCmpt = self._world:BattleStat()
  local result = MatchResult:New()
  result.victory = victory
  result.assign_wave_refresh_probability = self._world.BW_WorldInfo.assign_wave_refresh_probability
  if matchType == MatchType.MT_Mission then
    local mr = MissionResult:New()
    mr.star_condition = battleStatCmpt:GetBonusMatchResult() or {}
    if GameSingle then
      local match = GameGlobal.GetModule(MatchModule)
      if match then
        local enterData = match:GetMatchEnterData()
        if enterData and enterData._match_type == MatchType.MT_Mission then
          local missionID = enterData:GetMissionCreateInfo().mission_id
          mr.mission_id = missionID
        end
      end
    end
    result.mission_result[1] = mr
  elseif matchType == MatchType.MT_Campaign then
    local mr = CampaignMissionResult:New()
    mr.star_condition = battleStatCmpt:GetBonusMatchResult() or {}
    result.campaign_result[1] = mr
  elseif matchType == MatchType.MT_ExtMission then
    local mr = ExtMissionResult:New()
    mr.m_vecCondition = battleStatCmpt:GetBonusMatchResult() or {}
    result.ext_mission_result[1] = mr
  elseif matchType == MatchType.MT_ResDungeon then
    local mr = ResDungeonResult:New()
    if result.victory then
      mr.ext_rewards = battleStatCmpt:GetDropRoleAsset()
      mr.ext_rewards_no_double = battleStatCmpt:GetDropRoleAssetNoDouble()
    end
    mr.m_vecCondition = battleStatCmpt:GetBonusMatchResult() or {}
    result.res_dungeon_result[1] = mr
  elseif matchType == MatchType.MT_TalePet then
    local mr = TalePetResult:New()
    result.tale_pet_reward[1] = mr
  elseif matchType == MatchType.MT_LostArea then
    local mr = LostAreaResult:New()
    result.lost_area_result[1] = mr
  elseif matchType == MatchType.MT_Maze then
    local mr = MazeResult:New()
    local mazeService = self._world:GetService("Maze")
    local pet_infos = {}
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local petEntities = teamEntity:Team():GetTeamPetEntities()
    for _, e in ipairs(petEntities) do
      local info = MatchPetResult:New()
      info.pet_pstid = e:PetPstID():GetPstID()
      info.pet_power = e:Attributes():GetAttribute("Power")
      info.pet_legendPower = e:Attributes():GetAttribute("LegendPower")
      local hp = e:Attributes():GetCurrentHP()
      info.pet_blood = hp / e:Attributes():CalcMaxHp()
      if hp <= 0 then
        info.pet_is_dead = true
      end
      table.insert(pet_infos, info)
    end
    mr.pet_result = pet_infos
    mr.relics_counters = mazeService:GetRelicCounters()
    local drops = battleStatCmpt:GetTotalDropAssets()
    if drops then
      mr.drop_rewards = table.toArray(drops)
    end
    mr.battle_archive = self:CalcBattleArchive()
    mr.save_archive = false
    result.maze_result[1] = mr
  elseif matchType == MatchType.MT_Tower then
    local mr = TowerResult:New()
    result.tower_result[1] = mr
  elseif matchType == MatchType.MT_Conquest then
    local mr = ConquestMissionResult:New()
    local curTeamHP = battleStatCmpt:GetPlayerHP()
    local currentWaveIndex = battleStatCmpt:GetCurWaveIndex()
    if curTeamHP <= 0 and currentWaveIndex <= 1 then
      result.victory = false
    else
      result.victory = true
    end
    if not battleStatCmpt:GetBattleLevelResult() then
      currentWaveIndex = currentWaveIndex - 1
    end
    mr.pass_wave_index = currentWaveIndex
    result.conquest_mission_result[1] = mr
  elseif matchType == MatchType.MT_BlackFist then
    local mr = BlackFistResult:New()
    result.black_fist_result[1] = mr
  elseif matchType == MatchType.MT_WorldBoss then
    local mr = WorldBossResult:New()
    mr.total_damage = self:GetWorldBossTotalDamage(result, victory)
    result.world_boss_result[1] = mr
  elseif matchType == MatchType.MT_Chess then
    local mr = ChessMissionResult:New()
    mr.star_condition = battleStatCmpt:GetBonusMatchResult() or {}
    result.chess_mission_result[1] = mr
  elseif matchType == MatchType.MT_DifficultyMission then
    local mr = DifficultyMissionResult:New()
    if GameSingle then
      local match = GameGlobal.GetModule(MatchModule)
      if match then
        local enterData = match:GetMatchEnterData()
        mr.sub_mission_id = enterData:GetDifficultyMissionInfo().sub_mission_id
        mr.parent_mission_id = enterData:GetDifficultyMissionInfo().parent_mission_id
      end
    end
    result.difficulty_mission_result[1] = mr
  elseif matchType == MatchType.MT_SailingMission then
    local mr = SailingMissionResult:New()
    result.sailing_mission_result[1] = mr
  elseif matchType == MatchType.MT_MiniMaze then
    local mr = BloodsuckerMissionResult:New()
    local curTeamHP = battleStatCmpt:GetPlayerHP()
    local currentWaveIndex = battleStatCmpt:GetCurWaveIndex()
    if curTeamHP <= 0 and currentWaveIndex <= 1 then
      result.victory = false
    else
      result.victory = true
    end
    if not battleStatCmpt:GetBattleLevelResult() then
      currentWaveIndex = currentWaveIndex - 1
    end
    mr.is_full_blood = battleStatCmpt:IsFullBlood()
    mr.kill_monster_num = battleStatCmpt:GetKillMonsterCount()
    mr.pass_pet_type_num = self:CalcTeamElementTypeCount()
    mr.pass_wave_index = currentWaveIndex
    mr.select_pets = battleStatCmpt:GetAllMiniMazePartnerList()
    mr.select_relics = battleStatCmpt:GetAllMiniMazeRelicList()
    result.bloodsucker_mission_result[1] = mr
  elseif matchType == MatchType.MT_PopStar then
    local mr = PopStarMissionResult:New()
    mr.star_condition = battleStatCmpt:GetBonusMatchResult() or {}
    local popStarSvc = self._world:GetService("PopStarLogic")
    mr.star_num = popStarSvc:GetPopGridNum()
    result.popstar_mission_result[1] = mr
  elseif matchType == MatchType.MT_Season then
    local mr = SeasonMissionResult:New()
    mr.star_condition = battleStatCmpt:GetBonusMatchResult() or {}
    result.season_mission_result[1] = mr
  elseif matchType == MatchType.MT_EightPets then
    local mr = EightPetsResult:New()
    result.eight_pets_mission_result[1] = mr
  elseif matchType == MatchType.MT_PopStarPro then
    local mr = AnipopMissionResult:New()
    local popStarProSvc = self._world:GetService("PopStarProLogic")
    mr.star_num = popStarProSvc:GetPopGridNum()
    local petInfoList = {}
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local petEntities = teamEntity:Team():GetTeamPetEntities()
    for _, e in ipairs(petEntities) do
      local info = MatchPetResult:New()
      info.pet_pstid = e:PetPstID():GetPstID()
      info.pet_power = e:Attributes():GetAttribute("Power")
      info.pet_legendPower = e:Attributes():GetAttribute("LegendPower")
      table.insert(petInfoList, info)
    end
    mr.pet_result = petInfoList
    mr.feature_info_list = popStarProSvc:GetPopStarProFeatureInfoList()
    mr.relics_counters = popStarProSvc:GetRelicCounters()
    result.anipop_mission_result[1] = mr
  elseif matchType == MatchType.MT_SimpleBattleField then
    local mr = SimpleConquestMissionResult:New()
    local curTeamHP = battleStatCmpt:GetPlayerHP()
    local currentWaveIndex = battleStatCmpt:GetCurWaveIndex()
    local configService = self._world:GetService("Config")
    local cfg = configService:GetSimpleConquestConfig()
    if 0 < curTeamHP or currentWaveIndex == cfg.WaveCount then
      result.victory = true
    else
      result.victory = false
    end
    result.conquest_mission_result[1] = mr
  elseif matchType == MatchType.MT_SeasonMaze then
    local seasonMazeSvc = self._world:GetService("SeasonMaze")
    result.season_maze_mission_result[1] = seasonMazeSvc:BuildResult(result, victory)
  end
  return result
end

function BattleService:CalcBattleArchive()
  local t = {}
  local boardEntity = self._world:GetBoardEntity()
  local pieceTypes = boardEntity:Board().Pieces
  local pieces = {}
  t.pieces = pieces
  for x, row in pairs(pieceTypes) do
    pieces[x] = {}
    for y, v in pairs(row) do
      pieces[x][y] = v
    end
  end
  local monsters = {}
  t.monsters = monsters
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(monsterGroup:GetEntities()) do
    local val = e:Attributes():GetCurrentHP()
    if val and 0 < val then
      local monsterID = e:MonsterID():GetMonsterID()
      local m = {
        monsterID = monsterID,
        hp = val,
        pos = e:GridLocation().Position,
        dir = e:GridLocation().Direction,
        offset = e:GridLocation().Offset,
        bodyArea = e:BodyArea():GetArea(),
        aiData = e:AI():GetRuntimeData()
      }
      local effHolder = e:EffectHolder()
      if effHolder then
        m.effect = effHolder:GetBindEffectID()
      end
      m.buffData = e:BuffComponent():SaveArchivedData()
      table.insert(monsters, m)
    end
  end
  local team = self._world:Player():GetLocalTeamEntity()
  t.team = {
    pos = team:GridLocation().Position,
    dir = team:GridLocation().Direction
  }
  local traps = {}
  t.traps = traps
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if e:Trap():GetTrapType() ~= TrapType.Protected and not e:HasDeadMark() then
      traps[#traps + 1] = {
        trapID = e:Trap():GetTrapID(),
        pos = e:GridLocation().Position,
        dir = e:GridLocation().Direction
      }
    end
  end
  local protectTrap = self._world:BattleStat():GetSavedProtectTrap()
  if protectTrap then
    for k, v in ipairs(protectTrap) do
      traps[#traps + 1] = v
    end
  end
  local completion = {}
  t.completion = completion
  local cfgsvc = self._world:GetService("Config")
  local cond = cfgsvc:GetLevelConfigData():GetLevelCompleteConditionType()
  completion.cond = cond
  local ccsvc = self._world:GetService("CompleteCondition")
  completion.data = ccsvc:GetArchivedData(cond)
  local drops = self._world:BattleStat():GetArchivedDrops()
  t.drops = drops
  return echo(t)
end

function BattleService:GetLocalTeamHP()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local attributeCmpt = teamEntity:Attributes()
  local curHP = attributeCmpt:GetCurrentHP()
  local maxHP = attributeCmpt:CalcMaxHp()
  return curHP, maxHP
end

function BattleService:GetWorldBossEntity()
  local groupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for k, entity in ipairs(groupEntities) do
    if entity:MonsterID():IsWorldBoss() then
      return entity
    end
  end
end

function BattleService:GetWorldBossEntityArray()
  local entityArray = {}
  local groupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for k, entity in ipairs(groupEntities) do
    if entity:MonsterID():IsWorldBoss() then
      table.insert(entityArray, entity)
    end
  end
  return entityArray
end

function BattleService:ChangeLocalTeamLeader(petPstID, sendNTTeamOrderChange)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petEntity = teamEntity:Team():GetPetEntityByPetPstID(petPstID)
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  if not petEntity or petEntity:GetID() == teamLeaderEntity:GetID() then
    Log.fatal("ChangeTeamLeader Failed Pet Invalid PetPstID:", petPstID)
    return false
  end
  Log.debug("ChangeTeamLeader oldPet=", teamLeaderEntity:GetID(), " newPet=", petEntity:GetID())
  local teamOrderBeforeTmp = teamEntity:Team():GetTeamOrder()
  local teamOrderBefore = table.cloneconf(teamOrderBeforeTmp)
  teamEntity:SetTeamLeaderPetEntity(petEntity)
  local teamOrderAfter = teamEntity:Team():GetTeamOrder()
  local teamOrderAfterClone = table.cloneconf(teamOrderAfter)
  if sendNTTeamOrderChange then
    self._world:GetService("Trigger"):Notify(NTTeamOrderChange:New(teamEntity, teamOrderBefore, teamOrderAfter))
  end
  return teamOrderBefore, teamOrderAfterClone
end

function BattleService:GetFirstLeaderCandidate(teamEntity)
  local cTeam = teamEntity:Team()
  local tTeamOrder = cTeam:GetTeamOrder()
  for i = 2, #tTeamOrder do
    local pstID = tTeamOrder[i]
    local e = cTeam:GetPetEntityByPetPstID(pstID)
    if not e:HasBuffFlag(BuffFlags.SealedCurse) and not e:HasBuffFlag(BuffFlags.Pet1702361NotLinkLine) and not e:PetPstID():IsHelpPet() then
      return e
    end
  end
end

function BattleService:CanBeTeamLeader(entity)
  if not entity:HasPetPstID() or entity:PetPstID():IsHelpPet() then
    return false
  end
  local bSealed = entity:HasBuffFlag(BuffFlags.SealedCurse) or entity:HasBuffFlag(BuffFlags.Pet1702361NotLinkLine)
  local bAble = true
  if bSealed then
    bAble = false
  end
  return bAble
end

function BattleService:FindMonsterEntityInPos(checkPos, withDead)
  local targetEntityID = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if withDead or not e:HasDeadMark() then
      local monsterEntityID = e:GetID()
      local monster_grid_location_cmpt = e:GridLocation()
      local monster_body_area_cmpt = e:BodyArea()
      local monster_body_area = monster_body_area_cmpt:GetArea()
      for i, bodyArea in ipairs(monster_body_area) do
        local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
        if curMonsterBodyPos == checkPos then
          if e:HasRide() and e:Ride():GetRiderID() == monsterEntityID then
            table.insert(targetEntityID, 1, monsterEntityID)
            break
          end
          table.insert(targetEntityID, monsterEntityID)
          break
        end
      end
      if not table.intable(targetEntityID, monsterEntityID) and monster_grid_location_cmpt:GetGridPos() == checkPos then
        table.insert(targetEntityID, monsterEntityID)
      end
    end
  end
  return targetEntityID
end

function BattleService:KillPlayer()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local attributeCmpt = teamEntity:Attributes()
  attributeCmpt:Modify("HP", 0)
  teamEntity:AddTeamDeadMark()
end

function BattleService:ApplyRelic(relicID, switchState, reApply)
  Log.debug("[MiniMaze] BattleService ApplyRelic relicID: ", relicID)
  local cfg = Cfg.cfg_item_relic[relicID]
  if not cfg then
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  if not battleStatCmpt then
    return
  end
  if not reApply then
    if switchState == WaveResultAwardNextStateType.WaitInput then
      battleStatCmpt:SetChooseRelic(relicID)
      local talentSvc = self._world:GetService("Talent")
      local talentCmpt = talentSvc:GetTalentComponent()
      talentCmpt:SetIsChosenOpeningRelic(true)
    else
      battleStatCmpt:SetWaveChooseRelic(battleStatCmpt:GetCurWaveIndex(), relicID)
    end
  end
  Log.debug("[MiniMaze] BattleService ApplyRelic step has battle stat")
  if #cfg.BuffID == 0 then
    return
  end
  Log.debug("[MiniMaze] BattleService ApplyRelic step has BuffID")
  local relicBuffs = {}
  local buffLogicSvc = self._world:GetService("BuffLogic")
  for _, buffID in ipairs(cfg.BuffID) do
    if 0 < buffID then
      Log.notice("[MiniMazeRelic] add buff:", buffID, " relic:", relicID)
      local buffIns = buffLogicSvc:AddBuffByTargetType(buffID, cfg.BuffTargetType, cfg.BuffTargetParam)
      for _, buffIn in ipairs(buffIns) do
        buffIn:SetRelicID(relicID)
        relicBuffs[#relicBuffs + 1] = {
          buffIn:Entity(),
          buffIn:BuffSeq()
        }
      end
    end
  end
  return relicID, relicBuffs
end

function BattleService:CalcRandomRelic(groupID, count)
  local relicGroupID = groupID
  local randomCount = count
  local battleStatCmpt = self._world:BattleStat()
  if not relicGroupID and not randomCount then
    local curWaveIndex = battleStatCmpt:GetCurWaveIndex()
    local levelConfigData = self._configService:GetLevelConfigData()
    local cfgMiniMazeWave = levelConfigData:GetMiniMazeWaveCfg(curWaveIndex)
    if not cfgMiniMazeWave then
      return
    end
    if not cfgMiniMazeWave.RelicGroupID then
      return
    end
    if not cfgMiniMazeWave.RelicCount or cfgMiniMazeWave.RelicCount <= 0 then
      return
    end
    relicGroupID = cfgMiniMazeWave.RelicGroupID
    randomCount = cfgMiniMazeWave.RelicCount
  end
  local relicGroupCfg = Cfg.cfg_mini_maze_relic_group[relicGroupID]
  if not relicGroupCfg then
    return
  end
  local relicIDArray = relicGroupCfg.RelicIDArray
  if not relicIDArray or #relicIDArray <= 0 then
    return
  end
  local talentSvc = self._world:GetService("Talent")
  local unlockRelicIDList = talentSvc:GetUnlockRelicIDList()
  local lockRelicIDArray = {}
  if relicGroupCfg.LockRelicIDArray then
    for _, value in ipairs(relicGroupCfg.LockRelicIDArray) do
      if not table.icontains(unlockRelicIDList, value) then
        table.insert(lockRelicIDArray, value)
      end
    end
  end
  local tmpRelicIDList = table.cloneconf(relicIDArray)
  local randomRelicIDList = {}
  local invalidRelicIDList = battleStatCmpt:GetInvalidRelicIDList(relicGroupID) or {}
  table.appendArray(invalidRelicIDList, lockRelicIDArray)
  local selectedRelicIDList = battleStatCmpt:GetAllMiniMazeRelicList() or {}
  table.appendArray(invalidRelicIDList, selectedRelicIDList)
  for _, value in ipairs(tmpRelicIDList) do
    if not table.icontains(invalidRelicIDList, value) then
      table.insert(randomRelicIDList, value)
    end
  end
  local relics = {}
  for i = 1, randomCount do
    if #randomRelicIDList < 1 then
      local selectedRelicIDList = battleStatCmpt:GetAllMiniMazeRelicList()
      table.appendArray(selectedRelicIDList, lockRelicIDArray)
      table.appendArray(selectedRelicIDList, relics)
      for _, value in ipairs(tmpRelicIDList) do
        if not table.icontains(selectedRelicIDList, value) then
          table.insert(randomRelicIDList, value)
        end
      end
    end
    if 1 <= #randomRelicIDList then
      local randomRes = self:GetRandom(1, #randomRelicIDList)
      local relicID = randomRelicIDList[randomRes]
      table.insert(relics, relicID)
      table.removev(randomRelicIDList, relicID)
    end
  end
  if 0 < #relics then
    battleStatCmpt:SetInvalidRelicIDList(relicGroupID, relics)
    return relics
  end
end

function BattleService:_RandomByWeight(eliteGroup, weightGroup)
  if #eliteGroup ~= #weightGroup or #eliteGroup < 1 then
    return
  end
  local totalWeight = 0
  for _, w in ipairs(weightGroup) do
    totalWeight = totalWeight + w
  end
  local rand = self:GetRandom()
  local eliteID = eliteGroup[1]
  local curWeight = rand * totalWeight
  for i, w in ipairs(weightGroup) do
    curWeight = curWeight - w
    if curWeight <= 0 then
      eliteID = eliteGroup[i]
      table.remove(eliteGroup, i)
      table.remove(weightGroup, i)
      return eliteID
    end
  end
end

function BattleService:CalcEliteIDArray(nMonsterID)
  local monsterCfgData = self._configService:GetMonsterConfigData()
  local eliteIDArray = monsterCfgData:GetEliteIDArray(nMonsterID)
  local eliteIDGroupArray = monsterCfgData:GetEliteIDGroupArray(nMonsterID)
  local expectBuffIDArray = {}
  local randomParam = monsterCfgData:GetEliteIDRandomParam(nMonsterID)
  if randomParam then
    local eliteCount = randomParam.count
    local weightArray = table.cloneconf(randomParam.weight)
    if not eliteIDGroupArray then
      if eliteCount > #eliteIDArray or #weightArray ~= #eliteIDArray then
        Log.error("Monster Elite Random Weight config err, monsterID=", nMonsterID)
        return
      end
      local randomEliteIDArray = {}
      for i = 1, eliteCount do
        local eliteID = self:_RandomByWeight(eliteIDArray, weightArray)
        if eliteID then
          table.insert(randomEliteIDArray, eliteID)
        end
      end
      if 0 < #randomEliteIDArray then
        eliteIDArray = randomEliteIDArray
      end
    else
      if eliteCount > #eliteIDGroupArray or #weightArray ~= #eliteIDGroupArray then
        Log.error("Monster Elite Random Weight config err, monsterID=", nMonsterID)
        return
      end
      local randomEliteIDArray = {}
      local randomExpectBuffIDArray = {}
      for i = 1, eliteCount do
        local eliteIDGroup = self:_RandomByWeight(eliteIDGroupArray, weightArray)
        if eliteIDGroup then
          table.appendArray(randomEliteIDArray, eliteIDGroup.EliteID)
          table.appendArray(randomExpectBuffIDArray, eliteIDGroup.ModifyBuffID)
        end
      end
      if 0 < #randomEliteIDArray then
        eliteIDArray = randomEliteIDArray
      end
      if 0 < #randomExpectBuffIDArray then
        expectBuffIDArray = randomExpectBuffIDArray
      end
    end
  end
  local affixSvc = self._world:GetService("Affix")
  local retEliteID = affixSvc:ReplaceMonsterEliteBuff(nMonsterID, eliteIDArray)
  retEliteID = affixSvc:AddMonsterEliteBuff(nMonsterID, retEliteID)
  return retEliteID or {}, expectBuffIDArray or {}
end

function BattleService:HandlePopStarNumber()
  if self._world:MatchType() ~= MatchType.MT_PopStar then
    return false
  end
  local cmptBattleStat = self:_GetBattleStatComponent()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local levelConfigData = self._configService:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  local popStarSvc = self._world:GetService("PopStarLogic")
  if completeConditionType == CompleteConditionType.ComparePopStarNumber then
    local popBaseNumber = completeConditionParm[1][2]
    local curPopNum = popStarSvc:GetPopGridNum()
    local notEnough = popBaseNumber > curPopNum
    return notEnough
  end
  return false
end

function BattleService:GetPetSexType(entity)
  local petPstIDCmpt = entity:PetPstID()
  local templateID = petPstIDCmpt:GetTemplateID()
  local cfgPet = Cfg.cfg_pet[templateID]
  if cfgPet then
    return cfgPet.PetProperty
  end
end

function BattleService:IsPosInAuraRange(groupID, pos)
  local count = self:GetAuraSuperposedCount(groupID, pos)
  if not count then
    return false
  end
  return 0 < count
end

function BattleService:GetAuraSuperposedCount(groupID, pos)
  local boardEntity = self._world:GetBoardEntity()
  if not boardEntity:HasAuraRange() then
    return
  end
  local auraRangeCmpt = boardEntity:AuraRange()
  return auraRangeCmpt:GetAuraSuperposedCount(groupID, pos)
end

function BattleService:AddAuraRange(groupID, range)
  local boardEntity = self._world:GetBoardEntity()
  if not boardEntity:HasAuraRange() then
    return
  end
  local auraRangeCmpt = boardEntity:AuraRange()
  auraRangeCmpt:AddRange(groupID, range)
end

function BattleService:RemoveAuraRange(groupID, range)
  local boardEntity = self._world:GetBoardEntity()
  if not boardEntity:HasAuraRange() then
    return
  end
  local auraRangeCmpt = boardEntity:AuraRange()
  auraRangeCmpt:RemoveRange(groupID, range)
end

function BattleService:AddMonsterAuraRange(monsterEntity)
  if not monsterEntity:HasMonsterID() or monsterEntity:HasDeadMark() or not monsterEntity:MonsterID():GetAuraRangeSkillID() then
    return
  end
  local skillID = monsterEntity:MonsterID():GetAuraRangeSkillID()
  local groupID = monsterEntity:MonsterID():GetAuraGroupID()
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillScopeRes = utilScopeSvc:CalcSkillScope(skillConfigData, monsterEntity:GetGridPosition(), monsterEntity, monsterEntity:GetGridDirection())
  self:AddAuraRange(groupID, skillScopeRes:GetAttackRange())
end

function BattleService:RemoveMonsterAuraRange(monsterEntity)
  if not monsterEntity:HasMonsterID() or not monsterEntity:MonsterID():GetAuraRangeSkillID() then
    return
  end
  local skillID = monsterEntity:MonsterID():GetAuraRangeSkillID()
  local groupID = monsterEntity:MonsterID():GetAuraGroupID()
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillScopeRes = utilScopeSvc:CalcSkillScope(skillConfigData, monsterEntity:GetGridPosition(), monsterEntity, monsterEntity:GetGridDirection())
  self:RemoveAuraRange(groupID, skillScopeRes:GetAttackRange())
end

function BattleService:UpdateMonsterAuraRange(monsterEntity, newPos)
  if not monsterEntity:HasMonsterID() or monsterEntity:HasDeadMark() or not monsterEntity:MonsterID():GetAuraRangeSkillID() then
    return
  end
  local skillID = monsterEntity:MonsterID():GetAuraRangeSkillID()
  local groupID = monsterEntity:MonsterID():GetAuraGroupID()
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local oldSkillScopeRes = utilScopeSvc:CalcSkillScope(skillConfigData, monsterEntity:GetGridPosition(), monsterEntity, monsterEntity:GetGridDirection())
  local newSkillScopeRes = utilScopeSvc:CalcSkillScope(skillConfigData, newPos, monsterEntity, monsterEntity:GetGridDirection())
  self:RemoveAuraRange(groupID, oldSkillScopeRes:GetAttackRange())
  self:AddAuraRange(groupID, newSkillScopeRes:GetAttackRange())
end

function BattleService:GetTeamHP()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local attributeCmpt = teamEntity:Attributes()
  local HP = attributeCmpt:GetCurrentHP()
  local maxHP = attributeCmpt:CalcMaxHp()
  return HP, maxHP
end

function BattleService:GetCountByModifyType(modifyType)
  if self._world:MatchType() == MatchType.MT_PopStarPro then
    local popStarProSvc = self._world:GetService("PopStarProLogic")
    if not popStarProSvc then
      return
    end
    return popStarProSvc:GetCountByModifyType(modifyType)
  elseif self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local seasonMazeSvc = self._world:GetService("SeasonMaze")
    if not seasonMazeSvc then
      return
    end
    return seasonMazeSvc:GetCountByModifyType(modifyType)
  end
end

function BattleService:Compare2Num(num1, num2, opType)
  if opType == ComparisonOperator.EQ then
    return num1 == num2
  elseif opType == ComparisonOperator.GE then
    return num2 <= num1
  elseif opType == ComparisonOperator.NE then
    return num1 ~= num2
  elseif opType == ComparisonOperator.GT then
    return num2 < num1
  elseif opType == ComparisonOperator.LT then
    return num1 < num2
  elseif opType == ComparisonOperator.LE then
    return num1 <= num2
  end
end

function BattleService:GetAlivePetCount()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petList = teamEntity:Team():GetTeamPetEntities()
  return #petList
end
