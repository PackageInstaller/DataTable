_class("DataStepPointRoundChangeResult", Object)
DataStepPointRoundChangeResult = DataStepPointRoundChangeResult

function DataStepPointRoundChangeResult:Constructor(curVal, oldVal)
  self._curVal = curVal
  self._oldVal = oldVal
end

function DataStepPointRoundChangeResult:GetCurVal()
  return self._curVal
end

function DataStepPointRoundChangeResult:GetOldVal()
  return self._oldVal
end
