_class("BuffLogicDoControlIncrease", BuffLogicBase)
BuffLogicDoControlIncrease = BuffLogicDoControlIncrease

function BuffLogicDoControlIncrease:Constructor(_buffIns, logicParam)
  self._val = tonumber(logicParam.val)
  assert(self._val, "DoControlIncrease: parameter [val] is required. ")
end

function BuffLogicDoControlIncrease:DoLogic(notify)
  local e = self:GetEntity()
  self._buffLogicService:ChangeControlIncrease(e, self:GetBuffSeq(), self._val)
end

_class("BuffLogicUndoControlIncrease", BuffLogicBase)
BuffLogicUndoControlIncrease = BuffLogicUndoControlIncrease

function BuffLogicUndoControlIncrease:DoLogic(notify)
  local e = self:GetEntity()
  self._buffLogicService:RemoveControlIncrease(e, self:GetBuffSeq())
end
