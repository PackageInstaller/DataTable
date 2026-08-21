require("sync_svc_l")
_class("ClientSyncLogicService", SyncLogicService)
ClientSyncLogicService = ClientSyncLogicService

function ClientSyncLogicService:Constructor()
  self._localLogs = {}
  self._recvLogs = {}
  self._nextSeq = 1
  self._cacheLength = 500
end

function ClientSyncLogicService:OnRecvSyncCommand(cmd)
  if not _G.ENABLE_SYNC_LOG then
    return
  end
  local logs = cmd:GetCmdSyncLog()
  if not next(logs) then
    return
  end
  table.appendArray(self._recvLogs, logs)
end

function ClientSyncLogicService:ClientCheckBattleSync()
  if not _G.ENABLE_SYNC_LOG then
    return
  end
  self:_CheckSyncLog()
end

function ClientSyncLogicService:_CheckSyncLog()
  if not next(self._recvLogs) then
    return true
  end
  local logger = self._world:GetSyncLogger()
  local localLogs = logger:LocalLog()
  if not localLogs then
    return true
  end
  table.appendArray(self._localLogs, localLogs)
  local nextSeq = self._nextSeq
  for i = self._nextSeq, #self._localLogs do
    nextSeq = i
    local t = self._localLogs[i]
    local r = self._recvLogs[i]
    if not r then
      break
    end
    local eq = table_equal(t, r, {
      fsm = 1,
      tim = 1,
      desc = 1,
      _f1 = 1,
      _f2 = 1,
      _f3 = 1
    })
    if not eq then
      local prefix = os.date("%y%m%d-%H%M")
      self:_DumpLogToFile(self._localLogs, prefix, "ClientLog")
      self:_DumpLogToFile(self._recvLogs, prefix, "ServerLog")
      Log.exception("同步日志异常：seq=", t.seq)
      self:GetService("AutoFight"):EnableAutoMove(false)
      if EDITOR then
        UnityEngine.Time.timeScale = 0
      end
      return false
    end
  end
  self._nextSeq = nextSeq
  if self._nextSeq > self._cacheLength * 2 then
    self._localLogs = table.sub(self._localLogs, self._cacheLength + 1)
    self._recvLogs = table.sub(self._recvLogs, self._cacheLength + 1)
    self._nextSeq = self._nextSeq - self._cacheLength
  end
  Log.debug("本次同步日志比对正常:seq=", self._localLogs[self._nextSeq].seq)
  return true
end

function ClientSyncLogicService:_DumpLogToFile(t, prefix, affix)
  local dir = EngineGameHelper.StoragePath .. "GameSyncLog/"
  App.MakeDir(dir)
  local filePath = dir .. prefix .. affix .. ".lua"
  local file = io.open(filePath, "w")
  if file then
    file:write(echo(t))
    io.close(file)
  end
end

function ClientSyncLogicService:DumpSyncLog()
  if not _G.ENABLE_SYNC_LOG then
    return
  end
  local logger = self._world:GetSyncLogger()
  local localLogs = logger:LocalLog()
  if localLogs then
    table.appendArray(self._localLogs, localLogs)
  end
  local prefix = os.date("%y%m%d-%H%M")
  self:_DumpLogToFile(self._localLogs, prefix, "ClientLog")
  self:_DumpLogToFile(self._recvLogs, prefix, "ServerLog")
end
