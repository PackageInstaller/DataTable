local ProtoBase = require("Net.Base.ProtoBase")
local NetworkMgr = require("Network.NetworkMgr")
local TaskRequest, Super = System.NewClass("TaskRequest", ProtoBase)

function TaskRequest:OnTaskOpen()
  Logger.Proto("%s:OnTaskOpen: ", self.__name)
  do return NetworkMgr.Instance.TaskModuleMgr.OnOpen end
  return NetworkMgr.Instance.TaskModuleMgr.OnOpen, NetworkMgr.Instance.TaskModuleMgr, self.__name
end

function TaskRequest:OnTaskModuleOpen(taskSvrIdx)
  Logger.Proto("OnTaskModuleOpen:%s", taskSvrIdx)
  do return NetworkMgr.Instance.TaskModuleMgr.OnOpenTaskModule, NetworkMgr.Instance.TaskModuleMgr end
  return NetworkMgr.Instance.TaskModuleMgr.OnOpenTaskModule, NetworkMgr.Instance.TaskModuleMgr, taskSvrIdx
end

function TaskRequest:OnBatchGainPrize(modType, taskTidList)
  Logger.Proto("%s:OnBatchGainPrize: %s %s", self.__name, modType, table.tostring(taskTidList))
  do return NetworkMgr.Instance.TaskModuleMgr.OnBatchGainPrize, NetworkMgr.Instance.TaskModuleMgr, modType end
  return NetworkMgr.Instance.TaskModuleMgr.OnBatchGainPrize, NetworkMgr.Instance.TaskModuleMgr, modType, taskTidList, table.tostring(taskTidList)
end

function TaskRequest:OnTaskAwakerDelegate(uid, awakers)
  Logger.Proto("%s:OnTaskAwakerDelegate: %s %s", self.__name, uid, table.tostring(awakers, "", ""))
  do return NetworkMgr.Instance.TaskModuleMgr.OnAwakerDelegate, NetworkMgr.Instance.TaskModuleMgr, uid, table.clone(awakers) end
  return NetworkMgr.Instance.TaskModuleMgr.OnAwakerDelegate, NetworkMgr.Instance.TaskModuleMgr, uid, table.clone(awakers)
end

function TaskRequest:OnTaskRecallAwaker(uid)
  Logger.Proto("%s:OnTaskRecallAwaker: %s", self.__name, uid)
  do return NetworkMgr.Instance.TaskModuleMgr.OnRecall, NetworkMgr.Instance.TaskModuleMgr end
  return NetworkMgr.Instance.TaskModuleMgr.OnRecall, NetworkMgr.Instance.TaskModuleMgr, uid, uid
end

function TaskRequest:OnTaskGainPrize(uid, extraParams)
  Logger.Proto("%s:OnTaskGainPrize: %s, %s", self.__name, uid, table.tostring(extraParams))
  do return NetworkMgr.Instance.TaskModuleMgr.OnGainPrize, NetworkMgr.Instance.TaskModuleMgr, uid end
  return NetworkMgr.Instance.TaskModuleMgr.OnGainPrize, NetworkMgr.Instance.TaskModuleMgr, uid, extraParams, table.tostring(extraParams)
end

function TaskRequest:OnTaskGainAllPrize(taskSvrIdx)
  Logger.Proto("%s:OnTaskGainAllPrize: %s", self.__name, taskSvrIdx)
  do return NetworkMgr.Instance.TaskModuleMgr.OnGainAllPrize, NetworkMgr.Instance.TaskModuleMgr end
  return NetworkMgr.Instance.TaskModuleMgr.OnGainAllPrize, NetworkMgr.Instance.TaskModuleMgr, taskSvrIdx, taskSvrIdx
end

function TaskRequest:OnTaskAwakerDelegateBatch(tbl)
  Logger.Proto("%s:OnTaskAwakerDelegateBatch: %s", self.__name, table.tostring(tbl))
  do return NetworkMgr.Instance.TaskModuleMgr.OnAwakerDelegateBatch, NetworkMgr.Instance.TaskModuleMgr end
  return NetworkMgr.Instance.TaskModuleMgr.OnAwakerDelegateBatch, NetworkMgr.Instance.TaskModuleMgr, tbl, table.tostring(tbl)
end

return TaskRequest
