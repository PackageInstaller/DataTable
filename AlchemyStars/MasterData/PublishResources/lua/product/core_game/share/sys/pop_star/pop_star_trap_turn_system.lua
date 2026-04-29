require("main_state_sys")
_class("PopStarTrapTurnSystem", MainStateSystem)
PopStarTrapTurnSystem = PopStarTrapTurnSystem

function PopStarTrapTurnSystem:_GetMainStateID()
  return GameStateID.PopStarTrapTurn
end

function PopStarTrapTurnSystem:_OnMainStateEnter(TT)
  local calcStateTraps = self:_DoLogicCalcTrapState()
  self:_DoRenderTrapState(TT, calcStateTraps)
  self:_DoLogicTrapBeforeMonster()
  self:_DoRenderTrapBeforeMonster(TT)
  self:_DoLogicTrapAfterMonster()
  self:_DoRenderTrapAfterMonster(TT)
  self:_UpdateTrapGridRound(TT)
  self:_DoLogicChangeGameState()
end

function PopStarTrapTurnSystem:_DoLogicCalcTrapState()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  return trapServiceLogic:CalcTrapState(TrapDestroyType.DestroyByRound)
end

function PopStarTrapTurnSystem:_DoLogicChangeGameState()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarTrapTurnFinish, 1)
end

function PopStarTrapTurnSystem:_DoLogicTrapBeforeMonster()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:StartBeforeMainAI()
end

function PopStarTrapTurnSystem:_DoLogicTrapAfterMonster()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:TrapActionAfterAI()
end

function PopStarTrapTurnSystem:_DoRenderTrapState(TT, calcStateTraps)
end

function PopStarTrapTurnSystem:_DoRenderTrapBeforeMonster(TT)
end

function PopStarTrapTurnSystem:_DoRenderTrapAfterMonster(TT)
end

function PopStarTrapTurnSystem:_UpdateTrapGridRound(TT)
end
