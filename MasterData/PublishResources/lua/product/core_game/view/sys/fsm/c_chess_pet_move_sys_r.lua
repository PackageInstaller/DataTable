require("chess_pet_move_system")
_class("ClientChessPetMoveSystem_Render", ChessPetMoveSystem)
ClientChessPetMoveSystem_Render = ClientChessPetMoveSystem_Render

function ClientChessPetMoveSystem_Render:_DoRenderChessPetMove(TT)
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:DoRenderChessPetPathMove(TT)
  chessSvcRender:ShowCurChessPetEndTurnEffect(TT)
end
