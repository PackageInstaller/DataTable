require("chess_pet_move_and_attack_system")
_class("ClientChessPetMoveAndAttackSystem_Render", ChessPetMoveAndAttackSystem)
ClientChessPetMoveAndAttackSystem_Render = ClientChessPetMoveAndAttackSystem_Render

function ClientChessPetMoveAndAttackSystem_Render:_DoRenderChessPetMove(TT)
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:DoRenderChessPetPathMove(TT)
end

function ClientChessPetMoveAndAttackSystem_Render:_DoRenderChessPetAttack(TT)
  local chessSvcRender = self._world:GetService("ChessRender")
  local waitTaskID = chessSvcRender:DoRenderChessPetAttack(TT)
  return waitTaskID
end

function ClientChessPetMoveAndAttackSystem_Render:_DoRenderSetChessPetDir(TT, chessPetEntity)
  local dir = chessPetEntity:GetGridDirection()
  chessPetEntity:SetDirection(dir)
end

function ClientChessPetMoveAndAttackSystem_Render:_DoRenderChessPetFinishAttack(TT)
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ShowCurChessPetEndTurnEffect(TT)
end
