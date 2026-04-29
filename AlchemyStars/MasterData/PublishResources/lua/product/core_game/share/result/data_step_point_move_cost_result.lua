_class("DataStepPointMoveCostResult", Object)
DataStepPointMoveCostResult = DataStepPointMoveCostResult

function DataStepPointMoveCostResult:Constructor(curVal, oldVal)
  self._curVal = curVal
  self._oldVal = oldVal
end

function DataStepPointMoveCostResult:GetCurVal()
  return self._curVal
end

function DataStepPointMoveCostResult:GetOldVal()
  return self._oldVal
end
