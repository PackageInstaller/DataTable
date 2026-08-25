local table = _ENV.table
local AvgCommunicateRequest, Super = System.NewClass("AvgCommunicateRequest", ProtoBase)

function AvgCommunicateRequest:Startup()
  Super.Startup(self)
end

function AvgCommunicateRequest:Shutdown()
  Super.Shutdown(self)
end

function AvgCommunicateRequest:ClearData()
  Super.ClearData(self)
end

function AvgCommunicateRequest:OnGetCurrentDialogInfos()
  Logger.Proto("AvgCommunicateRequest:OnGetCurrentDialogInfos")
  local data, err = NetworkMgr.Instance.AvgCommunicate:OnGetCurrentDialogInfos()
  Logger.Proto("AvgCommunicateRequest:OnGetCurrentDialogInfos returns", table.tostring(data))
  return data, err
end

function AvgCommunicateRequest:OnGetCompletedDialogInfos()
  Logger.Proto("AvgCommunicateRequest:OnGetCompletedDialogInfos")
  local data, err = NetworkMgr.Instance.AvgCommunicate:OnGetCompletedDialogInfos()
  Logger.Proto("AvgCommunicateRequest:OnGetCompletedDialogInfos returns", table.tostring(data))
  return data, err
end

function AvgCommunicateRequest:OnSendMessage(dialogId, history)
  Logger.Proto("AvgCommunicateRequest:OnSendMessage", dialogId, table.tostring(history))
  local data, err = NetworkMgr.Instance.AvgCommunicate:OnSendMessage(dialogId, history)
  Logger.Proto("AvgCommunicateRequest:OnSendMessage returns", table.tostring(data))
  return data, err
end

function AvgCommunicateRequest:OnDialogFinish(dialogId)
  Logger.Proto("AvgCommunicateRequest:OnDialogFinish", dialogId, table.tostring(dialogId))
  local data, err = NetworkMgr.Instance.AvgCommunicate:OnDialogFinish(dialogId)
  Logger.Proto("AvgCommunicateRequest:OnDialogFinish returns", table.tostring(data))
  return data, err
end

return AvgCommunicateRequest
