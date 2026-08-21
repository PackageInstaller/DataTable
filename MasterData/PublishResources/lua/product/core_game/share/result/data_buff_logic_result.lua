_class("DataBuffLogicResult", Object)
DataBuffLogicResult = DataBuffLogicResult

function DataBuffLogicResult:Constructor(entityID, buffSeq, buffLogicName, notify, buffResult, triggers, buffID)
  self._entityID = entityID
  self._buffSeq = buffSeq
  self._buffLogicName = buffLogicName
  self._notify = notify
  self._buffResult = buffResult
  self._triggers = triggers
  self._buffID = buffID
  self._logicType = ""
end

function DataBuffLogicResult:GetEntityID()
  return self._entityID
end

function DataBuffLogicResult:GetBuffSeq()
  return self._buffSeq
end

function DataBuffLogicResult:GetBuffLogicName()
  return self._buffLogicName
end

function DataBuffLogicResult:GetNotify()
  return self._notify
end

function DataBuffLogicResult:GetBuffResult()
  return self._buffResult
end

function DataBuffLogicResult:GetTriggers()
  return self._triggers
end

function DataBuffLogicResult:GetBuffID()
  return self._buffID
end

function DataBuffLogicResult:SetBuffID(buffID)
  self._buffID = buffID
end

function DataBuffLogicResult:GetLogicType()
  return self._logicType
end

function DataBuffLogicResult:SetLogicType(logicType)
  self._logicType = logicType
end
