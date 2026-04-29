require("entity_commands")
_class("BattleSyncCommand", IEntityCommand)
BattleSyncCommand = BattleSyncCommand

function BattleSyncCommand:Constructor()
  self._commandType = "BattleSync"
  self._syncLog = nil
end

function BattleSyncCommand:GetCommandType()
  return self._commandType
end

function BattleSyncCommand:GetExecStateID()
  return 0
end

function BattleSyncCommand:IsExecExcluded()
  return 0
end

function BattleSyncCommand:DependRoundCount()
  return false
end

function BattleSyncCommand:GetCmdSyncLog()
  return self._syncLog
end

function BattleSyncCommand:SetCmdSyncLog(data)
  self._syncLog = data
end

function BattleSyncCommand:ToNetMessage()
  local msg = CEventLuaCommand:New()
  msg.cmd = echo(self)
  return msg
end

function BattleSyncCommand:FromNetMessage(msg)
  local cmd = ohce(msg.cmd)
  self._syncLog = cmd:GetCmdSyncLog()
end
