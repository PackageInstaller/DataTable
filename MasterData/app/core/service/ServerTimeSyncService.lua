local ServerTimeSyncService = class("ServerTimeSyncService")

function ServerTimeSyncService:ctor()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_G2C_LOGIN, self._onLogin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SYNC_TIME, self._onSyncTime, self)
end

function ServerTimeSyncService:_onLogin(arg_2_1, arg_2_2, arg_2_3)
	g.core.common.ServerTime:setTime(arg_2_3.time, (arg_2_3.zone - 720) / 60)
	g.core.service.ServiceManager:getServiceByName("CrossDayService"):start()
end

function ServerTimeSyncService:_onSyncTime(arg_3_1, arg_3_2, arg_3_3)
	g.core.common.ServerTime:setTime(arg_3_3.server_time, (arg_3_3.zone - 720) / 60)
	g.core.common.ServerTime:setOpenTime(arg_3_3.open)
	g.core.service.ServiceManager:getServiceByName("CrossDayService"):onSyncOpenTimeEnd()
end

return ServerTimeSyncService
