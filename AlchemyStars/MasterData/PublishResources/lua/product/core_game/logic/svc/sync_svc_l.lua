require("base_service")
_class("SyncLogicService", BaseService)
SyncLogicService = SyncLogicService

function SyncLogicService:Initialize()
  self:OnInitialize()
end

function SyncLogicService:OnInitialize()
end

function SyncLogicService:DoBattleSync()
  if not _G.ENABLE_SYNC_LOG then
    return
  end
  self:ServerSendSyncCommand()
  self:ClientCheckBattleSync()
end

function SyncLogicService:ServerSendSyncCommand()
end

function SyncLogicService:ClientCheckBattleSync()
end
