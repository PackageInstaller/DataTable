require("main_state_sys")
_class("RoundResultSystem", MainStateSystem)
RoundResultSystem = RoundResultSystem

function RoundResultSystem:_GetMainStateID()
  return GameStateID.RoundResult
end

function RoundResultSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicNotifyRoundResultStart(teamEntity)
  self:_DoRenderNotifyRoundResultStart(TT, teamEntity)
  self:_DoLogicCloseAuroraTime()
  self:_DoRenderCloseAuroraTime(TT)
  if self:_IsBattleEnd() then
    self._world:EventDispatcher():Dispatch(GameEventType.RoundResultFinish, 2)
    return
  end
  self:_DoLogicTrapRoundResult()
  self:_DoRenderTrapAction(TT)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    self:_DoLogicBuffBeforeTrapRoundCount(teamEntity)
    self:_DoRenderBuffBeforeTrapRoundCount(TT, teamEntity)
    local traps = self:_DoLogicCalcTrapState()
    self:_DoRenderTrapState(TT, traps)
  else
    local traps = self:_DoLogicCalcTrapStateNonFightClub()
    self:_DoRenderCalcTrapStateNonFightClub(TT, traps)
  end
  self:_UpdateTrapGridRound(TT)
  self:_DoLogicNotifyRoundTurnEnd(teamEntity)
  self:_DoRenderNotifyRoundTurnEnd(TT, teamEntity)
  self:_DoLogicUpdateBattleState(teamEntity)
  self:_DoRenderRefreshCombinedWaveInfoOnRoundResult(TT)
  local battleCalcResult = self:_IsBattleEnd()
  self:_DoRenderShowRoundEnd(TT, battleCalcResult)
  local traps, monsters = self:_DoLogicSpawnInWaveMonsters(MonsterWaveInternalTime.RoundResult)
  self:_DoRenderInWave(TT, traps, monsters)
  self:_ClearShareSkillResult()
  self:_DoSaveDetailMatchLogger(TT)
  self:_DoLogicGotoNextState(teamEntity)
end

function RoundResultSystem:_DoLogicNotifyRoundResultStart(teamEntity)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTRoundResultStart:New(teamEntity))
end

function RoundResultSystem:_DoLogicNotifyRoundTurnEnd(teamEntity)
  local svc = self._world:GetService("Trigger")
  svc:Notify(NTRoundTurnEnd:New(teamEntity))
  svc:Notify(NTEnemyTurnEnd:New(teamEntity))
end

function RoundResultSystem:_DoLogicUpdateBattleState(teamEntity)
  local buffService = self._world:GetService("BuffLogic")
  if buffService:DoGuideLockRoundCount(teamEntity) then
    self._world:BattleStat():MoveToNextRound(0)
  elseif self._world:MatchType() == MatchType.MT_BlackFist then
    if self._world:GetGameTurn() == GameTurnType.RemotePlayerTurn then
      self._world:ChangeGameTurn()
      self._world:BattleStat():MoveToNextRound()
    else
      self._world:ChangeGameTurn()
    end
  else
    self._world:BattleStat():MoveToNextRound()
  end
  self._world:GetDataLogger():AddDataLog("OnRoundEnd")
end

function RoundResultSystem:_DoLogicTrapRoundResult()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:TrapActionRoundResult()
end

function RoundResultSystem:_DoLogicGotoNextState(teamEntity)
  local mazeNoLight = false
  if self._world:MatchType() == MatchType.MT_Maze then
    mazeNoLight = self._world:GetService("Maze"):GetLightCount() == 0
  end
  local battleStatCmpt = self._world:BattleStat()
  local leftRoundCount = battleStatCmpt:GetCurWaveRound()
  local battleService = self._world:GetService("Battle")
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  if battleService:IsWavePreEnd(teamEntity) or mazeNoLight or leftRoundCount == 0 and levelConfigData:GetOutOfRoundType() == 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.RoundResultFinish, 2)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.RoundResultFinish, 1)
  end
end

function RoundResultSystem:_DoLogicCalcTrapState()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  return trapServiceLogic:CalcTrapState(TrapDestroyType.DestroyByRound)
end

function RoundResultSystem:_DoLogicCalcTrapStateNonFightClub()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  return trapServiceLogic:CalcTrapState(TrapDestroyType.DestroyAtRoundResult)
end

function RoundResultSystem:_ClearShareSkillResult()
  local boardEntity = self._world:GetBoardEntity()
  boardEntity:ReplaceShareSkillResult()
end

function RoundResultSystem:_DoLogicBuffBeforeTrapRoundCount(teamEntity)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTMonsterRoundBeforeTrapRoundCount:New(teamEntity))
end

function RoundResultSystem:_DoRenderShowRoundEnd(TT, battleCalcResult)
end

function RoundResultSystem:_DoRenderNotifyRoundResultStart(TT, teamEntity)
end

function RoundResultSystem:_DoRenderNotifyRoundTurnEnd(TT)
end

function RoundResultSystem:_DoRenderInWave(TT, traps, monsters)
end

function RoundResultSystem:_DoRenderTrapAction(TT)
end

function RoundResultSystem:_DoRenderTrapState(TT)
end

function RoundResultSystem:_DoRenderRefreshCombinedWaveInfoOnRoundResult(TT)
end

function RoundResultSystem:_DoRenderCalcTrapStateNonFightClub(TT, calcStateTraps)
end

function RoundResultSystem:_UpdateTrapGridRound(TT)
end

function RoundResultSystem:_DoRenderBuffBeforeTrapRoundCount(TT, teamEntity)
end

function RoundResultSystem:_DoSaveDetailMatchLogger(TT)
end
