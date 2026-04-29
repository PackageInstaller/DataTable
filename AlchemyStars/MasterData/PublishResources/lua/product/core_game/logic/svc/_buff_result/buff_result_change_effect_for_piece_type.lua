require("_buff_result_base")
_class("BuffResultChangeEffectForPieceType", BuffResultBase)
BuffResultChangeEffectForPieceType = BuffResultChangeEffectForPieceType

function BuffResultChangeEffectForPieceType:Constructor(notifyType, pos, beforePieceType, afterPieceType)
  self._notifyType = notifyType
  self._pos = pos
  self._beforePieceType = beforePieceType
  self._afterPieceType = afterPieceType
end

function BuffResultChangeEffectForPieceType:GetNotifyType()
  return self._notifyType
end

function BuffResultChangeEffectForPieceType:GetPos()
  return self._pos
end

function BuffResultChangeEffectForPieceType:GetBeforePieceType()
  return self._beforePieceType
end

function BuffResultChangeEffectForPieceType:GetAfterPieceType()
  return self._afterPieceType
end
