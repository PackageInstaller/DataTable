require("_buff_result_base")
_class("BuffResultMapPieceType", BuffResultBase)
BuffResultMapPieceType = BuffResultMapPieceType

function BuffResultMapPieceType:Constructor(mapByPieceType, sourcePiece, targetPiece)
  self._mapByPieceType = mapByPieceType
  self._sourcePiece = sourcePiece
  self._targetPiece = targetPiece
end

function BuffResultMapPieceType:GetMapByPieceType()
  return self._mapByPieceType
end

function BuffResultMapPieceType:GetSourcePiece()
  return self._sourcePiece
end

function BuffResultMapPieceType:GetTargetPiece()
  return self._targetPiece
end
