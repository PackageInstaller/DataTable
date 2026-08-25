local table = _ENV.table
local WorldGmRequest, Super = System.NewClass("WorldGmRequest", ProtoBase)

function WorldGmRequest:Startup()
  Super.Startup(self)
end

function WorldGmRequest:Shutdown()
  Super.Shutdown(self)
end

function WorldGmRequest:ClearData()
  Super.ClearData(self)
end

function WorldGmRequest:OnQueryGmData()
  Logger.Info("登录请求GM数据")
  local errcode, data = NetworkMgr.Instance.Gm:QueryGmData()
  Logger.Info("登录请求GM数据返回: data:%s,errcode:%s", table.tostring(data), table.tostring(errcode))
  return errcode, data
end

function WorldGmRequest:OnGmCommand(cmd, cmd_data)
  Logger.Info("GM命令,请求: cmd:%s %s", cmd, table.tostring(cmd_data, "", ""))
  local data, errcode = NetworkMgr.Instance.Gm:OnGmCommand(cmd, cmd_data)
  return data, errcode
end

function WorldGmRequest:OnGmCommandBySend(cmd, cmd_data)
  Logger.Info("GM命令,请求: cmd:%s %s", cmd, table.tostring(cmd_data, "", ""))
  NetworkMgr.Instance.Gm.OnGmCommand(cmd, cmd_data)
end

function WorldGmRequest:OnAddMoney(val)
  do return self.OnGmCommand, self, "addmoney" end
  return self.OnGmCommand, self, "addmoney", {money = val}
end

function WorldGmRequest:OnChangeEvent(uid, newTid)
  do return self.OnGmCommand, self, "event_change" end
  return self.OnGmCommand, self, "event_change", {uid = uid, tid = newTid}
end

function WorldGmRequest:OnAddRelic(relicTid)
  do return self.OnGmCommand, self, "add_relic" end
  return self.OnGmCommand, self, "add_relic", {tid = relicTid}
end

function WorldGmRequest:OnGmCopyAbility(data1)
  Logger.Info("GM命令,请求: %s", table.tostring(data1, "", ""))
  local data, errcode = NetworkMgr.Instance.Gm:OnGmCopyAbility(data1)
  return data, errcode
end

return WorldGmRequest
