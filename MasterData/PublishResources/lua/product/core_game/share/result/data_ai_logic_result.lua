_class("DataAILogicResult", Object)
DataAILogicResult = DataAILogicResult

function DataAILogicResult:Constructor(res)
  self._res = res
end

function DataAILogicResult:GetAIRecorder()
  return self._res
end
