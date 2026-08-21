require("_buff_result_base")
_class("BuffResultChangeMaintainColorTrapEffect", BuffResultBase)
BuffResultChangeMaintainColorTrapEffect = BuffResultChangeMaintainColorTrapEffect

function BuffResultChangeMaintainColorTrapEffect:Constructor(notifyType, pos, beforePieceType, afterPieceType)
  self._notifyType = notifyType
  self._pos = pos
  self._beforePieceType = beforePieceType
  self._afterPieceType = afterPieceType
end

function BuffResultChangeMaintainColorTrapEffect:GetNotifyType()
  return self._notifyType
end

function BuffResultChangeMaintainColorTrapEffect:GetPos()
  return self._pos
end

function BuffResultChangeMaintainColorTrapEffect:GetBeforePieceType()
  return self._beforePieceType
end

function BuffResultChangeMaintainColorTrapEffect:GetAfterPieceType()
  return self._afterPieceType
end

function BuffResultChangeMaintainColorTrapEffect:SetIsInit(isInit)
  self._isInit = isInit
end

function BuffResultChangeMaintainColorTrapEffect:GetIsInit()
  return self._isInit
end
