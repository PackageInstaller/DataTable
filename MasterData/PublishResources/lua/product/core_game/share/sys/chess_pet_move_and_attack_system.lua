require("main_state_sys")
_class("ChessPetMoveAndAttackSystem", MainStateSystem)
ChessPetMoveAndAttackSystem = ChessPetMoveAndAttackSystem

function ChessPetMoveAndAttackSystem:_GetMainStateID()
  return GameStateID.ChessPetMoveAndAttack
end

function ChessPetMoveAndAttackSystem:_OnMainStateEnter(TT)
  local boardEntity = self._world:GetBoardEntity()
  local logicChessPathComponent = boardEntity:LogicChessPath()
  local chessPath = logicChessPathComponent:GetLogicChessPath()
  local entityID = logicChessPathComponent:GetLogicChessPetEntityID()
  local pickUpPos = logicChessPathComponent:GetLogicPickUpPos()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  local svc = self._world:GetService("L2R")
  self:_DoLogicChessPetMove()
  svc:L2RChessPathData()
  self:_DoRenderChessPetMove(TT)
  self:_DoLogicSetChessPetDir(chessPetEntity, pickUpPos, chessPetEntity:GetGridPosition())
  self:_DoRenderSetChessPetDir(TT, chessPetEntity)
  self:_DoLogicChessPetAttack()
  svc:L2RChessAttackData(chessPetEntity)
  local castSkillTaskID = self:_DoRenderChessPetAttack(TT)
  self:_WaitTasksEnd(TT, {castSkillTaskID})
  self:_DoRenderChessPetFinishAttack(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.ChessPetMoveAndAttackFinish, 1)
end

function ChessPetMoveAndAttackSystem:_DoLogicChessPetMove()
  local chessLogic = self._world:GetService("ChessLogic")
  chessLogic:DoChessPetPathMove()
end

function ChessPetMoveAndAttackSystem:_DoLogicChessPetAttack()
  local chessLogic = self._world:GetService("ChessLogic")
  chessLogic:DoChessPetAttack()
end

function ChessPetMoveAndAttackSystem:_DoLogicSetChessPetDir(chessPetEntity, pickUpPos, targetMovePos)
  if pickUpPos then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local dir = utilScopeSvc:GetChessEntityGridDirWithPickUpPos(chessPetEntity, pickUpPos, targetMovePos)
    chessPetEntity:SetGridDirection(dir)
  end
end

function ChessPetMoveAndAttackSystem:_DoRenderChessPetMove(TT)
end

function ChessPetMoveAndAttackSystem:_DoRenderChessPetAttack(TT)
end

function ChessPetMoveAndAttackSystem:_DoRenderSetChessPetDir(TT, chessPetEntity)
end

function ChessPetMoveAndAttackSystem:_DoRenderChessPetFinishAttack(TT)
end
