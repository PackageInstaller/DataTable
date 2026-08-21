require("main_state_sys")
_class("ChessPetResultSystem", MainStateSystem)
ChessPetResultSystem = ChessPetResultSystem

function ChessPetResultSystem:_GetMainStateID()
  return GameStateID.ChessPetResult
end

function ChessPetResultSystem:_OnMainStateEnter(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoLogicChessPetDead()
  self:_DoRenderChessPetDead(TT)
  local chessSvc = self._world:GetService("ChessLogic")
  local isAllChessPetTurnEnd = chessSvc:IsAllChessPetTurnFinish()
  local isWaveEnded = self:IsBattleEnded()
  self:_DoRenderHandleChessPetResult(TT, isAllChessPetTurnEnd, isWaveEnded)
  if self:_IsBattleEnd() then
    self._world:EventDispatcher():Dispatch(GameEventType.ChessPetResultFinish, 3)
  elseif isAllChessPetTurnEnd then
    self._world:EventDispatcher():Dispatch(GameEventType.ChessPetResultFinish, 2)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.ChessPetResultFinish, 1)
  end
end

function ChessPetResultSystem:_DoRenderHandleChessPetResult(TT, isAllChessPetTurnEnd, isWaveEnded)
end
