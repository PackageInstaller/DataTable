-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/reconnection/NetFaultMonitor.lua

module("logic.starter.reconnection.NetFaultMonitor", package.seeall)

local M = class("NetFaultMonitor")

function M:ctor(netReconnection)
	self._reconnection = netReconnection
	self._firstConnectedTimestamp = 0
	self._connectedCount = 0
end

function M:clear()
	self._firstConnectedTimestamp = 0
	self._connectedCount = 0
end

function M:checkNewConnectedEvent()
	local reconnectionConfig = self._reconnection:getReconnectionConfig()
	local nowTimestamp = ServerTime.now()
	local deltaTime = nowTimestamp - self._firstConnectedTimestamp

	if deltaTime <= reconnectionConfig.monitorPeriod then
		self._connectedCount = self._connectedCount + 1

		return self._connectedCount < reconnectionConfig.monitorMaxConnectedCount
	else
		self._connectedCount = 0
		self._firstConnectedTimestamp = nowTimestamp

		return true
	end
end

return M
