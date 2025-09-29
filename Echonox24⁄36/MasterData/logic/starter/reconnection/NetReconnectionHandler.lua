-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/reconnection/NetReconnectionHandler.lua

module("logic.starter.reconnection.NetReconnectionHandler", package.seeall)

local M = class("NetReconnectionHandler")
local networkManager = Astral.NetworkManager.Instance

function M:ctor(netReconnection)
	self._reconnection = netReconnection
	self._reconnectTryTimes = 0
	self._reconnectStartTime = 0
	self._isTryingReconnect = false
end

function M:clear()
	self._reconnectTryTimes = 0
	self._reconnectStartTime = 0
	self._isTryingReconnect = false

	removetimer(self._doReconnect, self)
end

function M:resetForReconnect()
	self._reconnectTryTimes = 0
	self._isTryingReconnect = false
	self._reconnectStartTime = ServerTime.now()

	removetimer(self._doReconnect, self)
end

function M:isReconnectTimeout()
	local reconnectStartTime = self._reconnectStartTime
	local reconnectionConfig = self._reconnection:getReconnectionConfig()

	if reconnectStartTime > 0 and ServerTime.now() - reconnectStartTime >= reconnectionConfig.reconnectTimeout then
		return true
	end

	return false
end

function M:requestGetLostCmd()
	local reconnectionConfig = self._reconnection:getReconnectionConfig()
	local connectionType = reconnectionConfig.connectionType
	local downTag = self._reconnection:getCurrentDownTag()

	if enableLog then
		printInfo(string.format("reconnection::request get lost cmd,connectionType = %s, downtag = %s", connectionType, downTag))
	end

	local req = {}

	req.downTag = downTag and downTag or 127

	NetConnMgr.instance:sendSysMsg(3, req, connectionType)
end

function M:tryReconnect()
	if self._isTryingReconnect then
		if enableLog then
			printInfo("reconnection::is reconnecting")
		end

		return
	end

	if enableLog then
		printInfo("reconnection::settimer for reconnection")
	end

	local reconnectionConfig = self._reconnection:getReconnectionConfig()

	self._isTryingReconnect = true
	self._reconnectTryTimes = self._reconnectTryTimes + 1

	if self._reconnectTryTimes <= reconnectionConfig.quickReconnectTimes then
		settimer(reconnectionConfig.quickReconnectInterval, self._doReconnect, self, false)
	else
		settimer(reconnectionConfig.reconnectInterval, self._doReconnect, self, false)
	end
end

function M:_doReconnect()
	local reconnectionConfig = self._reconnection:getReconnectionConfig()
	local connectionType = reconnectionConfig.connectionType

	if networkManager:GetChannelActive(connectionType) then
		if enableLog then
			printInfo(string.format("reconnection::current channel is active,we need to wait. connectionType = %s", connectionType))
		end

		settimer(reconnectionConfig.quickReconnectInterval, self._doReconnect, self, false)

		return
	end

	if enableLog then
		printInfo(string.format("reconnection::reconnect,ip = %s, port = %s, connectionType = %s", reconnectionConfig.ip, reconnectionConfig.port, connectionType))
	end

	self._isTryingReconnect = false

	Netkit.SetConnectClock()
	NetConnMgr.instance:disconnect(connectionType)
	NetConnMgr.instance:connect(reconnectionConfig.ip, reconnectionConfig.port, connectionType)
end

return M
