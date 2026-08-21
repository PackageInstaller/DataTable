_class("BuffResultChangeAUOEValue", BuffResultBase)
BuffResultChangeAUOEValue = BuffResultChangeAUOEValue

function BuffResultChangeAUOEValue:Constructor(curValue, oldValue, realModifyValue)
  self._curValue = curValue
  self._oldValue = oldValue
  self._realModifyValue = realModifyValue
end

function BuffResultChangeAUOEValue:GetCurValue()
  return self._curValue
end

function BuffResultChangeAUOEValue:GetOldValue()
  return self._oldValue
end

function BuffResultChangeAUOEValue:GetRealModifyValue()
  return self._realModifyValue
end
