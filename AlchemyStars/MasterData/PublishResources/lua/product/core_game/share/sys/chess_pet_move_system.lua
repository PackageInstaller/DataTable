require("main_state_sys")
_class("ChessPetMoveSystem", MainStateSystem)
ChessPetMoveSystem = ChessPetMoveSystem

function ChessPetMoveSystem:_GetMainStateID()
  return GameStateID.ChessPetMove
end

function ChessPetMoveSystem:_OnMainStateEnter(TT)
  self:_DoLogicChessPetMove()
  local svc = self._world:GetService("L2R")
  svc:L2RChessPathData()
  self:_DoRenderChessPetMove(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.ChessPetMoveFinish, 1)
end

function ChessPetMoveSystem:_DoLogicChessPetMove()
  local chessLogic = self._world:GetService("ChessLogic")
  chessLogic:DoChessPetPathMove()
end

function ChessPetMoveSystem:_DoRenderChessPetMove(TT)
end
