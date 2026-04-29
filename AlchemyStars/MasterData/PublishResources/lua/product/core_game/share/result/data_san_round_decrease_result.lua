_class("DataSanRoundDecreaseResult", Object)
DataSanRoundDecreaseResult = DataSanRoundDecreaseResult

function DataSanRoundDecreaseResult:Constructor(curVal, oldVal, modifyValue, debtVal, modifyTimes)
  self._curVal = curVal
  self._oldVal = oldVal
  self._modifyVal = modifyValue
  self._debtVal = debtVal
  self._modifyTimes = modifyTimes
end

function DataSanRoundDecreaseResult:GetCurVal()
  return self._curVal
end

function DataSanRoundDecreaseResult:GetOldVal()
  return self._oldVal
end

function DataSanRoundDecreaseResult:GetModifyVal()
  return self._modifyVal
end

function DataSanRoundDecreaseResult:GetDebtVal()
  return self._debtVal
end

function DataSanRoundDecreaseResult:GetModifyTimes()
  return self._modifyTimes
end
