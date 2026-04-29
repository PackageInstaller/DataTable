require("main_state_sys")
_class("PopStarRoundResultSystem", MainStateSystem)
PopStarRoundResultSystem = PopStarRoundResultSystem

function PopStarRoundResultSystem:_GetMainStateID()
  return GameStateID.PopStarRoundResult
end

function PopStarRoundResultSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if self:_IsBattleEnd() then
    self._world:EventDispatcher():Dispatch(GameEventType.PopStarRoundResultFinish, 2)
    return
  end
  self:_DoLogicTrapRoundResult()
  self:_DoRenderTrapAction(TT)
  local traps = self:_DoLogicCalcTrapState()
  self:_DoRenderTrapState(TT, traps)
  self:_DoLogicNotifyRoundTurnEnd(teamEntity)
  self:_DoRenderNotifyRoundTurnEnd(TT, teamEntity)
  self:_DoLogicUpdateBattleState(teamEntity)
  local isBattleEnd = self:_IsBattleEnd()
  self:_DoRenderShowRoundEnd(TT, isBattleEnd)
  self:_ClearShareSkillResult()
  self:_DoLogicSwitchState(teamEntity)
end

function PopStarRoundResultSystem:_DoLogicTrapRoundResult()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:TrapActionRoundResult()
end

function PopStarRoundResultSystem:_DoLogicCalcTrapState()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  return trapServiceLogic:CalcTrapState(TrapDestroyType.DestroyAtRoundResult)
end

function PopStarRoundResultSystem:_DoLogicNotifyRoundTurnEnd(teamEntity)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTRoundTurnEnd:New(teamEntity))
end

function PopStarRoundResultSystem:_DoLogicUpdateBattleState(teamEntity)
  local buffService = self._world:GetService("BuffLogic")
  if buffService:DoGuideLockRoundCount(teamEntity) then
    self._world:BattleStat():MoveToNextRound(0)
  else
    self._world:BattleStat():MoveToNextRound()
  end
  self._world:GetDataLogger():AddDataLog("OnRoundEnd")
end

function PopStarRoundResultSystem:_ClearShareSkillResult()
  local boardEntity = self._world:GetBoardEntity()
  boardEntity:ReplaceShareSkillResult()
end

function PopStarRoundResultSystem:_DoLogicSwitchState(teamEntity)
  local battleStatCmpt = self._world:BattleStat()
  local leftRoundCount = battleStatCmpt:GetCurWaveRound()
  local battleService = self._world:GetService("Battle")
  if battleService:IsWavePreEnd(teamEntity) or leftRoundCount == 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.PopStarRoundResultFinish, 2)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.PopStarRoundResultFinish, 1)
  end
end

function PopStarRoundResultSystem:_DoRenderTrapAction(TT)
end

function PopStarRoundResultSystem:_DoRenderTrapState(TT, traps)
end

function PopStarRoundResultSystem:_DoRenderNotifyRoundTurnEnd(TT)
end

function PopStarRoundResultSystem:_DoRenderShowRoundEnd(TT, isBattleEnd)
end
