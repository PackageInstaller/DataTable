require("sync_svc_l")
_class("ServerSyncLogicService", SyncLogicService)
ServerSyncLogicService = ServerSyncLogicService

function ServerSyncLogicService:ServerSendSyncCommand()
  local cmd = BattleSyncCommand:New()
  cmd:SetCmdSyncLog(self._world:GetSyncLogger():LocalLog())
  self._world:Player():SendCommand(cmd)
end
