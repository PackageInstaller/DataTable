_class("DataBuffAddResult", Object)
DataBuffAddResult = DataBuffAddResult

function DataBuffAddResult:Constructor(entityID, buffSeq, buffID, context)
  self._entityID = entityID
  self._buffSeq = buffSeq
  self._buffID = buffID
  self._buffContext = context
end

function DataBuffAddResult:GetEntityID()
  return self._entityID
end

function DataBuffAddResult:GetBuffSeq()
  return self._buffSeq
end

function DataBuffAddResult:GetBuffID()
  return self._buffID
end

function DataBuffAddResult:GetBuffContext()
  return self._buffContext
end
