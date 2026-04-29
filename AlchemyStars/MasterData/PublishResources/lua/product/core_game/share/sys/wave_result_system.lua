require("main_state_sys")
_class("WaveResultSystem", MainStateSystem)
WaveResultSystem = WaveResultSystem

function WaveResultSystem:_GetMainStateID()
  return GameStateID.WaveResult
end

local AssignWave = {
  None = 0,
  AssignEndWave = 1,
  AssignRand = 2
}
_enum("AssignWave", AssignWave)

function WaveResultSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicChainAttackDead()
  self:_DoRenderChainAttackDead(TT)
  self:_DoLogicCalc3StarProgress()
  self:_DoLogicCalcBonusObjective()
  self:_DoLogicClearChainPath(teamEntity)
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  self:_DoLogicNotifyWaveEnd(waveNum)
  self:_DoRenderNotifyWaveEnd(TT, waveNum)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  local turnToBattleResult, victory = self:_DoLogicCheckBattleResult(teamEntity)
  if turnToBattleResult then
    local hasDeadLogic = self:_DoLogicHandleTurnBattleResult(victory)
    self:_DoRenderHandleTurnBattleResult(TT, victory, hasDeadLogic)
  end
  self:_WaitTime(TT, 200)
  self:_DoLogicUpdateBattleStat()
  self:_DoLogicLeaveWaveResult(turnToBattleResult)
  self:_DoRenderSendWaveEnd(TT, turnToBattleResult, victory)
end

function WaveResultSystem:_DoLogicChainAttackDead()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local drops, deadEntityIDList = sMonsterShowLogic:DoAllMonsterDeadLogic()
end

function WaveResultSystem:_DoLogicClearChainPath(teamEntity)
  if teamEntity == nil then
    return
  end
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  logicChainPathCmpt:ClearLogicChainPath()
end

function WaveResultSystem:_DoLogicCalc3StarProgress()
  local starService = self._world:GetService("Star3Calc")
  starService:Calc3StarProgress()
end

function WaveResultSystem:_DoLogicCalcBonusObjective()
  local bonusService = self._world:GetService("BonusCalc")
  bonusService:CalcBonusObjective()
end

function WaveResultSystem:_DoLogicNotifyWaveEnd(waveNum)
  self._world:GetService("Trigger"):Notify(NTWaveTurnEnd:New(waveNum))
end

function WaveResultSystem:_DoLogicCheckBattleResult(teamEntity)
  local battleStatCmpt = self._world:BattleStat()
  local turn2BattleResult, victory = false, false
  if battleStatCmpt:AssignWaveResult() then
    turn2BattleResult = true
    victory = true
  else
    local battleService = self._world:GetService("Battle")
    local playerDead = battleService:HandlePlayerCalculation(teamEntity)
    local protectedTrapDead = battleService:HandleTrapCalculation()
    local curseTowerAllActive = battleService:HandleCurseTowerCalculation()
    local chessPetDead = battleService:HandleChessCalculation()
    local monsterEscapeTooMuch = battleService:HandleMonsterEscapeCalculation()
    local popStarNumNotEnough = battleService:HandlePopStarNumber()
    if playerDead or protectedTrapDead or curseTowerAllActive or chessPetDead or monsterEscapeTooMuch or popStarNumNotEnough then
      turn2BattleResult = true
      victory = false
    else
      local curseTowerGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.CurseTower)
      if curseTowerGroupEntities and 0 < #curseTowerGroupEntities then
        local isAllActive = true
        for _, eTower in ipairs(curseTowerGroupEntities) do
          local isActive = eTower:CurseTower():GetTowerState() == CurseTowerState.Active
          isAllActive = isAllActive and isActive
        end
        if isAllActive then
          turn2BattleResult = true
          victory = false
        end
      end
      local configService = self._world:GetService("Config")
      local levelConfigData = configService:GetLevelConfigData()
      local outOfRoundType = levelConfigData:GetOutOfRoundType()
      local leftRoundCount = battleStatCmpt:GetCurWaveRound()
      if outOfRoundType == 0 and leftRoundCount == 0 and not battleStatCmpt:LevelCompleteLimitAllRoundCount() then
        turn2BattleResult = true
        victory = false
      else
        local isLastWave = self:IsLastWave()
        if isLastWave then
          local AssignWaveType, isAssignWaveNotEnd = self:_CalAssignWaveAndRefreshNextWave(true)
          if isAssignWaveNotEnd then
            turn2BattleResult = false
            victory = false
          else
            turn2BattleResult = true
            victory = true
            local killAnyMonsterCountEnough = battleService:HandleKillAnyMonsterCountCalculation()
            if not killAnyMonsterCountEnough then
              victory = false
            end
            local killSpecificMonsterCountEnough = battleService:HandleKillSpecificMonsterCountCalculation()
            if not killSpecificMonsterCountEnough then
              victory = false
            end
            local killMoreThanPetMonster = battleService:HandleKillMoreThanPetMonsterCalculation()
            if killMoreThanPetMonster == false then
              victory = false
            end
          end
        else
          turn2BattleResult = false
          victory = false
        end
      end
    end
  end
  return turn2BattleResult, victory
end

function WaveResultSystem:_CalAssignWaveAndRefreshNextWave(battleLevelResult)
  local bRefresh = false
  if not battleLevelResult then
    return AssignWave.AssignEndWave, bRefresh
  end
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local levelCompleteConditionType = levelConfigData:GetLevelCompleteConditionType()
  if levelCompleteConditionType ~= CompleteConditionType.AssignWaveAndRandomNextWave then
    return AssignWave.None, bRefresh
  end
  local l_arrAssignWaveParams = levelConfigData:GetLevelCompleteConditionParams()[1]
  if table.count(l_arrAssignWaveParams) < LevelCompleteAssignWaveParamExp.RefreshUpProb then
    Log.fatal("if table.count(l_nAssignWaveParams) < ", LevelCompleteAssignWaveParamExp.RefreshUpProb, " then")
  end
  local l_nAssignWave = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.AssignWaveEnd]
  local battleStatCmpt = self._world:BattleStat()
  local l_nCurWaveIndex = battleStatCmpt:GetCurWaveIndex()
  if l_nAssignWave > l_nCurWaveIndex then
    return AssignWave.None, bRefresh
  end
  if l_nAssignWave < l_nCurWaveIndex then
    return AssignWave.AssignRand, bRefresh
  end
  local curType = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.BaseRefreshProb]
  if curType == WaveRefreshModeType.Cumulate then
    return self:_DoCumulateNextWave(l_arrAssignWaveParams)
  else
    return self:_DoRandomNextWave(l_arrAssignWaveParams)
  end
end

function WaveResultSystem:_DoCumulateNextWave(l_arrAssignWaveParams)
  local bRefresh = false
  local cumulateNumLimit = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.RefreshUpProb]
  if self._world.BW_WorldInfo.assign_wave_refresh_probability > 2 * cumulateNumLimit then
    self._world.BW_WorldInfo.assign_wave_refresh_probability = 0
  end
  self._world.BW_WorldInfo.assign_wave_refresh_probability = self._world.BW_WorldInfo.assign_wave_refresh_probability + 1 + self._world.BW_WorldInfo.asset_double_item_count
  if self._world.BW_WorldInfo.level_is_pass then
    if cumulateNumLimit <= self._world.BW_WorldInfo.assign_wave_refresh_probability then
      bRefresh = true
      self._world.BW_WorldInfo.assign_wave_refresh_probability = self._world.BW_WorldInfo.assign_wave_refresh_probability - cumulateNumLimit
    end
  else
    bRefresh = true
  end
  Log.fatal("Prob:", self._world.BW_WorldInfo.assign_wave_refresh_probability)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetAssignWaveResult(bRefresh)
  return AssignWave.AssignEndWave, bRefresh
end

function WaveResultSystem:_DoRandomNextWave(l_arrAssignWaveParams)
  local bRefresh = false
  local l_nPerThousandProbability = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.BaseRefreshProb]
  local l_nUpProb = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.RefreshUpProb]
  if l_nPerThousandProbability < self._world.BW_WorldInfo.assign_wave_refresh_probability then
    l_nPerThousandProbability = self._world.BW_WorldInfo.assign_wave_refresh_probability
  elseif l_nPerThousandProbability > self._world.BW_WorldInfo.assign_wave_refresh_probability then
    self._world.BW_WorldInfo.assign_wave_refresh_probability = l_nPerThousandProbability
  end
  if self._world.BW_WorldInfo.level_is_pass then
    local randomSvc = self._world:GetService("RandomLogic")
    local nRandNum = randomSvc:LogicRand(1, 1000)
    if l_nPerThousandProbability >= nRandNum then
      bRefresh = true
      self._world.BW_WorldInfo.assign_wave_refresh_probability = 0
    elseif l_nUpProb then
      if self._world.BW_WorldInfo.double_resource_state then
        Log.debug("Level is Double Resource State")
        l_nUpProb = l_nUpProb * 2
      end
      self._world.BW_WorldInfo.assign_wave_refresh_probability = self._world.BW_WorldInfo.assign_wave_refresh_probability + l_nUpProb
      Log.fatal("Prob:", self._world.BW_WorldInfo.assign_wave_refresh_probability)
    end
  else
    bRefresh = true
  end
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetAssignWaveResult(bRefresh)
  return AssignWave.AssignEndWave, bRefresh
end

function WaveResultSystem:_DoLogicHandleTurnBattleResult(victory)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetBattleLevelResult(victory)
  if victory then
    local battleService = self._world:GetService("Battle")
    return battleService:LevelWinKillAllMonster()
  end
end

function WaveResultSystem:_DoLogicUpdateBattleStat()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:ResetChainIndex()
end

function WaveResultSystem:_DoLogicLeaveWaveResult(turnToBattleResult)
  if turnToBattleResult == false then
    local matchType = self._world:MatchType()
    if matchType == MatchType.MT_MiniMaze then
      self._world:EventDispatcher():Dispatch(GameEventType.WaveResultFinish, 3)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.WaveResultFinish, 1)
    end
  else
    self._world:EventDispatcher():Dispatch(GameEventType.WaveResultFinish, 2)
  end
end

function WaveResultSystem:IsLastWave()
  local battleStatCmpt = self._world:BattleStat()
  local isLastWave = battleStatCmpt:IsLastWave()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local levelCompleteConditionType = levelConfigData:GetLevelCompleteConditionType()
  if levelCompleteConditionType ~= CompleteConditionType.AssignWaveAndRandomNextWave then
    return isLastWave
  else
    local l_nCurWaveIndex = battleStatCmpt:GetCurWaveIndex()
    local l_arrAssignWaveParams = levelConfigData:GetLevelCompleteConditionParams()[1]
    local l_nAssignWave = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.AssignWaveEnd]
    if l_nCurWaveIndex == l_nAssignWave then
      return true
    else
      return isLastWave
    end
  end
end

function WaveResultSystem:_DoRenderNotifyWaveEnd(TT, waveNum)
end

function WaveResultSystem:_DoRenderChainAttackDead(TT)
end

function WaveResultSystem:_DoRenderHandleTurnBattleResult(TT, victory, hasDeadLogic)
end

function WaveResultSystem:_DoRenderSendWaveEnd(TT, turnToBattleResult, victory)
end
