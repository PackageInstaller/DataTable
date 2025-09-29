-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/reconnection/NetReconnectionConfig.lua

module("logic.starter.reconnection.NetReconnectionConfig", package.seeall)

local M = class("NetReconnectionConfig")

function M:ctor()
	self.ip = 0
	self.port = 0
	self.hostPorts = {}
	self.curHostIndex = 1
	self.connectionType = 0
	self.packageTimeout = 2
	self.packageTimeoutCheckInternal = 1.6
	self.quickReconnectTimes = 5
	self.quickReconnectInterval = 0.2
	self.reconnectInterval = 1
	self.reconnectTimeout = 10
	self.reconnectFaultTolerantTime = 5
	self.monitorPeriod = 10
	self.monitorMaxConnectedCount = 3
end

function M.genConfig(connectionType)
	local config = M.New()

	config.connectionType = connectionType

	return config
end

return M
