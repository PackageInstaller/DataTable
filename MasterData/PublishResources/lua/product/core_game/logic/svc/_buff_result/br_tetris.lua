require("_buff_result_base")
_class("BuffResultTetrisRandom", BuffResultBase)
BuffResultTetrisRandom = BuffResultTetrisRandom

function BuffResultTetrisRandom:Constructor(newTetrisIndex, newTetrisType)
  self._newTetrisIndex = newTetrisIndex
  self._newTetrisType = newTetrisType
end

function BuffResultTetrisRandom:GetNewTetrisIndex()
  return self._newTetrisIndex
end

function BuffResultTetrisRandom:GetNewTetrisType()
  return self._newTetrisType
end

_class("BuffResultTetrisChangePower", BuffResultBase)
BuffResultTetrisChangePower = BuffResultTetrisChangePower

function BuffResultTetrisChangePower:Constructor(newPower, newPos)
  self._newPower = newPower
  self._newPos = newPos
end

function BuffResultTetrisChangePower:GetNewPower()
  return self._newPower
end

function BuffResultTetrisChangePower:GetNewPos()
  return self._newPos
end
