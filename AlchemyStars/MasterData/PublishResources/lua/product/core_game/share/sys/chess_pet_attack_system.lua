require("main_state_sys")
_class("ChessPetAttackSystem", MainStateSystem)
ChessPetAttackSystem = ChessPetAttackSystem

function ChessPetAttackSystem:_GetMainStateID()
  return GameStateID.ChessPetAttack
end

function ChessPetAttackSystem:_OnMainStateEnter(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.ChessPetAttackFinish, 1)
end
