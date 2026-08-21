_class("SyncLogger", Object)
SyncLogger = SyncLogger

function SyncLogger:Constructor(world)
  self._world = world
  self._seq = 1
  self._logs = {}
end

function SyncLogger:CheckEnabled(enable)
  if enable ~= nil then
    _G.ENABLE_SYNC_LOG = enable
  else
    _G.ENABLE_SYNC_LOG = self._world:IsDevelopEnv()
  end
end

function SyncLogger:Trace(t)
  if not _G.ENABLE_SYNC_LOG then
    return
  end
  t.seq = self._seq
  t.tim = os.date("%H:%M:%S", os.time())
  local gamefsm = self._world:GameFSM()
  if gamefsm then
    t.fsm = GetEnumKey("GameStateID", gamefsm:CurStateID())
  end
  local f1 = debug.getinfo(2, "n")
  if f1 then
    t._f1 = f1.name
    local f2 = debug.getinfo(3, "n")
    if f2 then
      t._f2 = f2.name
      local f3 = debug.getinfo(4, "n")
      if f3 then
        t._f3 = f3.name
      end
    end
  end
  table.insert(self._logs, t)
  self._seq = self._seq + 1
end

function SyncLogger:EchoLog()
  local s = "return " .. echo(self._logs)
  self._logs = {}
  return s
end

function SyncLogger:LocalLog()
  local log = self._logs
  self._logs = {}
  return log
end
