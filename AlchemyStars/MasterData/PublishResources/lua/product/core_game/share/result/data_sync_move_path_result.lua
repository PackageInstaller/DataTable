_class("DataSyncMovePathResult", Object)
DataSyncMovePathResult = DataSyncMovePathResult

function DataSyncMovePathResult:Constructor(entityID, movePath)
  self._entityID = entityID
  self._syncMovePathResult = movePath
end

function DataSyncMovePathResult:SetEntityID(entityID)
  self._entityID = entityID
end

function DataSyncMovePathResult:GetEntityID()
  return self._entityID
end

function DataSyncMovePathResult:SetSyncMovePathResult(res)
  self._syncMovePathResult = res
end

function DataSyncMovePathResult:GetSyncMovePathResult()
  return self._syncMovePathResult
end
