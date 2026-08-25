local System = require("System.System")
local StageLogClient = System.NewClass("StageLogClient")

function StageLogClient:IsEnabled()
  do return end
  return ApplicationUtils.is_editor_mode
end

function StageLogClient:GetCsLogInstance()
  return CS.Z1Client.Z1StageLog.Instance
end

function StageLogClient:GetWidSuffix(wid)
  if not wid or "" == wid then
    return nil
  end
  wid = tostring(wid)
  local head, tail = string.match(wid, "^([^-]+)-.-([^-]+)$")
  if head and tail then
    return head .. "_" .. tail
  end
  return string.match(wid, "^([^-]+)") or wid
end

function StageLogClient:BuildFileName(stageId, wid)
  local serverId = "serverId"
  local account = "account"
  if LoginMgr.Instance then
    serverId = LoginMgr.Instance:GetServerId()
    account = LoginMgr.Instance:GetAccount()
  end
  if not account or "" == account then
    account = "account"
  end
  local stageCfg = DT.Stage[stageId]
  local stageName = stageCfg and stageCfg.CnID or tostring(stageId)
  local fileName = string.format("%s_%s_%s_%s", serverId, account, stageName, os.date("%Y_%m_%d_%H_%M_%S", os.time()))
  local widSuffix = self:GetWidSuffix(wid)
  if widSuffix then
    fileName = fileName .. "_" .. widSuffix
  end
  return fileName
end

function StageLogClient:GetFileNameByWid(widKey)
  if not self.widFileNameMap or not widKey then
    return nil
  end
  return self.widFileNameMap[widKey]
end

function StageLogClient:RememberFileName(widKey, fileName)
  if not widKey or not fileName then
    return
  end
  self.widFileNameMap = self.widFileNameMap or {}
  self.widFileNameMap[widKey] = fileName
end

function StageLogClient:EnsureLogFile(stageId, wid)
  if not self:IsEnabled() then
    return
  end
  local widKey = wid and tostring(wid) or nil
  if self.isLogging and widKey and self.logWid == widKey then
    return
  end
  self:StopLogFile()
  local fileName = self:GetFileNameByWid(widKey)
  if not fileName then
    fileName = self:BuildFileName(stageId, wid)
    self:RememberFileName(widKey, fileName)
  end
  local csLogInstance = self:GetCsLogInstance()
  csLogInstance:CleanUp()
  csLogInstance:SetFileName(fileName)
  self.isLogging = true
  self.logWid = widKey
end

function StageLogClient:StartLogFile(stageId, wid, reason)
  if not self:IsEnabled() then
    return
  end
  self:EnsureLogFile(stageId, wid)
  self:Log(string.format("客户端关卡日志 reason=%s stageId=%s wid=%s", reason or "Enter", stageId, wid or 0))
end

function StageLogClient:Log(msg, wid, tid)
  if not self:IsEnabled() or not msg then
    return
  end
  if wid then
    self:EnsureLogFile(tid, wid)
  end
  if not self.isLogging then
    return
  end
  self:GetCsLogInstance():LogStage(msg)
end

function StageLogClient:Flush()
  if not self:IsEnabled() or not self.isLogging then
    return
  end
  self:GetCsLogInstance():SaveLog()
end

function StageLogClient:StopLogFile()
  if not self:IsEnabled() then
    return
  end
  if self.isLogging then
    self:GetCsLogInstance():SaveLog()
  end
  self.isLogging = false
  self.logWid = nil
end

return StageLogClient
