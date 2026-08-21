_class("BuffLogicMapPieceType", BuffLogicBase)
BuffLogicMapPieceType = BuffLogicMapPieceType

function BuffLogicMapPieceType:Constructor(buffInstance, logicParam)
  self._sourcePiece = logicParam.sourcePiece
  self._targetPiece = logicParam.targetPiece
end

function BuffLogicMapPieceType:DoLogic()
  local e = self._buffInstance:Entity()
  local board = self._world:GetBoardEntity():Board()
  board:AddMapByPieceType(self._sourcePiece, self._targetPiece)
  local mapByPieceType = board:GetMapByPieceType()
  local buffResult = BuffResultMapPieceType:New(mapByPieceType, self._sourcePiece, self._targetPiece)
  return buffResult
end
