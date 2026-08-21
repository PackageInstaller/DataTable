local ST_ASYNC_OPERATION_STATUS = {
  NO_CALL = 0,
  IN_PROGRESS = 1,
  FINISHED = 2
}
_enum("ST_ASYNC_OPERATION_STATUS", ST_ASYNC_OPERATION_STATUS)
local ST_ASYNC_OPERATION_RESULT = {
  UNFINISHED = 0,
  SUCCESS = 1,
  ERROR = 2
}
_enum("ST_ASYNC_OPERATION_RESULT", ST_ASYNC_OPERATION_RESULT)
_class("AsyncOperationStatusData", Object)
AsyncOperationStatusData = AsyncOperationStatusData

function AsyncOperationStatusData:Constructor()
  self._status = ST_ASYNC_OPERATION_STATUS.NO_CALL
  self._result = ST_ASYNC_OPERATION_RESULT.UNFINISHED
  self._message = "A brand new AsyncOperationStatusData object. "
  self._customData = {}
end

function AsyncOperationStatusData:SetStatus(v)
  self._status = v
end

function AsyncOperationStatusData:SetResult(v)
  self._result = v
end

function AsyncOperationStatusData:SetMessage(msg)
  self._message = msg
end

function AsyncOperationStatusData:IsFinished()
  return self._status == ST_ASYNC_OPERATION_STATUS.FINISHED
end

function AsyncOperationStatusData:IsErrorOccured()
  return self._result == ST_ASYNC_OPERATION_RESULT.ERROR
end

function AsyncOperationStatusData:SetCustomData(key, value)
  self._customData[key] = value
end

function AsyncOperationStatusData:GetCustomData(key)
  return self._customData[key]
end
