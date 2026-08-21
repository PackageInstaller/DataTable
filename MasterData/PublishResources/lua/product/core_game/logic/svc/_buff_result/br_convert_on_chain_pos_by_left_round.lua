_class("BuffResultConvertOnChainPosByLeftRound", BuffResultBase)
BuffResultConvertOnChainPosByLeftRound = BuffResultConvertOnChainPosByLeftRound

function BuffResultConvertOnChainPosByLeftRound:Constructor(pos, oldPieceType, newPieceType)
  self._gridPos = pos
  self._oldPieceType = oldPieceType
  self._newPieceType = newPieceType
end

function BuffResultConvertOnChainPosByLeftRound:GetGridPos()
  return self._gridPos
end

function BuffResultConvertOnChainPosByLeftRound:GetOldPieceType()
  return self._oldPieceType
end

function BuffResultConvertOnChainPosByLeftRound:GetNewPieceType()
  return self._newPieceType
end
