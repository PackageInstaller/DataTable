_class("DataBuffDelResult", Object)
DataBuffDelResult = DataBuffDelResult

function DataBuffDelResult:Constructor(entityID, buffSeq, buffID, notifyType)
  self._entityID = entityID
  self._buffSeq = buffSeq
  self._buffID = buffID
  self._notifyType = notifyType
end

function DataBuffDelResult:GetEntityID()
  return self._entityID
end

function DataBuffDelResult:GetBuffSeq()
  return self._buffSeq
end

function DataBuffDelResult:GetBuffID()
  return self._buffID
end

function DataBuffDelResult:GetNotifyType()
  return self._notifyType
end
