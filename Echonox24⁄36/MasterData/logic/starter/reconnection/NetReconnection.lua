-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/reconnection/NetReconnection.lua

module("logic.starter.reconnection.NetReconnection", package.seeall)

local M = class("NetReconnection")
local kReason = {
	MonitorFault = -1001
}
local kSystemExtId = -1

function M:ctor(reconnectionConfig, listener)
	self._listener = listener
	self._reconnectionConfig = reconnectionConfig
	self._msgQueue = NetMsgQueue.New(self)
	self._reconnectHandler = NetReconnectionHandler.New(self)
	self._netFaultMonitor = NetFaultMonitor.New(self)
	self._blockCount = 0
	self._receivedLostMsgCount = false
	self._firstSendTime = false
	self._currentDownTag = false
	self._isConnected = false
	self._isReconnecting = false
	self._isReconnectDisable = false

	NetConnMgr.instance:addSendFilter(self._sendMsgFilter, self)
	NetConnMgr.instance:addReceiveFilter(self._receiveMsgFilter, self)
	NetConnMgr.instance:setConnectCallback(reconnectionConfig.connectionType, self._onConnectEvent, self)
	NetConnMgr.instance:setDisconnectCallback(reconnectionConfig.connectionType, self._onDisconnectEvent, self)
end

function M:connect(ip, port, hostPorts)
	self:clear()

	self._firstSendTime = 0
	self._reconnectionConfig.ip = ip
	self._reconnectionConfig.port = port
	self._reconnectionConfig.hostPorts = hostPorts
	self._reconnectionConfig.curHostIndex = 1

	Netkit.SetConnectClock()
	NetConnMgr.instance:connect(ip, port, self._reconnectionConfig.connectionType)
end

function M:hasNewHost()
	local hostPorts = self._reconnectionConfig.hostPorts
	local nextHostIndex = self._reconnectionConfig.curHostIndex + 1

	return nextHostIndex and nextHostIndex <= #hostPorts
end

function M:connectNewHost()
	if not self:hasNewHost() then
		return false
	end

	self._reconnectionConfig.curHostIndex = self._reconnectionConfig.curHostIndex + 1

	local hostPort = self._reconnectionConfig.hostPorts[self._reconnectionConfig.curHostIndex]
	local ip = hostPort[1]
	local port = hostPort[2]

	self:clear()

	self._firstSendTime = 0
	self._reconnectionConfig.ip = ip
	self._reconnectionConfig.port = port

	Netkit.SetConnectClock()
	NetConnMgr.instance:connect(ip, port, self._reconnectionConfig.connectionType)

	return true
end

function M:forceReconnect()
	self._reconnectHandler:resetForReconnect()
	self:_tryReconnect()

	return true
end

function M:clear()
	self:_disconnect()

	self._blockCount = 0
	self._receivedLostMsgCount = false
	self._firstSendTime = false
	self._currentDownTag = false
	self._isConnected = false
	self._isReconnecting = false
	self._isReconnectDisable = false

	self._msgQueue:clear()
	self._reconnectHandler:clear()
	self._netFaultMonitor:clear()
	removetimer(self._onCheckTimeout, self)
end

function M:isReconnecting()
	return self._isReconnecting
end

function M:isConnected()
	return self._isConnected
end

function M:getBlockCount()
	return self._blockCount
end

function M:getCurrentDownTag()
	return self._currentDownTag
end

function M:getReconnectionConfig()
	return self._reconnectionConfig
end

function M:setReconnectListener(listener)
	self._listener = listener
end

function M:setReconnectEnable(enable)
	self._isReconnectDisable = not enable
end

function M:skipGetLostMsg()
	if enableLog then
		printInfo("reconnection::skip get lost msg finish")
	end

	self:_handleReconnectFinish()
end

function M:_sendMsgFilter(extId, cmd, msg, connectionType)
	if not self:_isCaredConnectionType(connectionType) then
		return
	end

	if self:_isSystemExtId(extId) then
		if enableLog then
			printInfo("reconnection::send sys msg", extId, cmd)
		end

		return
	end

	local cmdConfig = self:_getCmdConfig(extId, cmd)
	local isRequestAndResponseMsg = cmdConfig and #cmdConfig == 2

	if not isRequestAndResponseMsg then
		if enableErrorLog then
			printError("reconnection::send a msg without response")
		end

		return
	end

	if not self._isConnected and not self._isReconnecting then
		if enableWarnLog then
			printWarn("reconnection::find an invalid msg, try send a msg but the net is disconnected")
		end

		return false
	end

	local isBlockMsg = cmdConfig and cmdConfig.block

	if isBlockMsg then
		self._blockCount = self._blockCount + 1

		self._listener:onBlockCountChanged(self._blockCount)
	end

	if self._msgQueue:isEmpty() then
		self._firstSendTime = ServerTime.now()

		if enableLog then
			printInfo("reconnection::recalculateFirstSendTime", tostring(self._firstSendTime))
		end
	end

	self._msgQueue:enqueue(extId, cmd, msg)

	if not self._isConnected or self._isReconnecting then
		return false
	end
end

function M:_receiveMsgFilter(extId, cmd, status, name, msg, downTag, connectionType)
	if not self:_isCaredConnectionType(connectionType) then
		return
	end

	if not self._isConnected then
		if enableWarnLog then
			printWarn("reconnection::received an invalid msg cause the net is disconnected", extId, cmd)
		end

		return
	end

	if downTag >= 0 and downTag <= 127 then
		self._currentDownTag = downTag
	end

	if self:_isSystemExtId(extId) then
		self:_handleReceiveSystemMsg(cmd, status, msg)

		return
	end

	local cmdConfig = self:_getCmdConfig(extId, cmd)
	local isRequestAndResponseMsg = cmdConfig and #cmdConfig == 2

	if not isRequestAndResponseMsg then
		return
	end

	local isBlockMsg = cmdConfig and cmdConfig.block

	if isBlockMsg then
		self._blockCount = self._blockCount - 1

		self._listener:onBlockCountChanged(self._blockCount)
	end

	if self._receivedLostMsgCount then
		self._receivedLostMsgCount = self._receivedLostMsgCount + 1
	end

	self._msgQueue:dequeue()
	self:_recalculateFirstSendTime()
end

function M:_onConnectEvent(connectionType, isConnected)
	if not self:_isCaredConnectionType(connectionType) then
		return
	end

	if enableLog then
		printInfo(string.format("reconnection::on connect event,isConnected = %s,isReconnecting = %s", tostring(isConnected), tostring(self._isReconnecting)))
	end

	self._isConnected = isConnected

	if self._isConnected then
		if not self._netFaultMonitor:checkNewConnectedEvent() then
			if enableLog then
				printInfo("reconnection::net fault monitor triggerred!")
			end

			self:_disconnect()
			self._listener:onReconnectCanceled(kReason.MonitorFault)

			return
		end

		self:_recalculateFirstSendTime()
		self:_startPackageTimeoutCheck()
		self._listener:onNetConnected(self._isConnected, self._isReconnecting)
	else
		self:_tryReconnect()
	end
end

function M:_onDisconnectEvent(connectionType)
	if not self:_isCaredConnectionType(connectionType) then
		return
	end

	if enableLog then
		printInfo(string.format("reconnection::on disconnect event,isReconnecting = %s", tostring(self._isReconnecting)))
	end

	if not self._isReconnecting then
		self._listener:onNetDisconnected(self._isReconnecting)
	end
end

function M:_startPackageTimeoutCheck()
	settimer(self._reconnectionConfig.packageTimeoutCheckInternal, self._onCheckTimeout, self, true)
end

function M:_stopPackageTimeoutCheck()
	removetimer(self._onCheckTimeout, self)
end

function M:_onCheckTimeout()
	if not self._firstSendTime then
		return
	end

	if ServerTime.now() - self._firstSendTime >= self._reconnectionConfig.packageTimeout then
		if enableWarnLog then
			local firstMsg = self._msgQueue:peekFirstNode()

			if firstMsg then
				printWarn("reconnection::msg send time out,", string.format("extId = [%s], cmd = [%s]", firstMsg.extId, firstMsg.cmd))
			end
		end

		self:_tryReconnect()
	end
end

function M:_tryReconnect()
	if self._isReconnectDisable then
		self._listener:onReconnectCanceled(false)

		return
	end

	if not self._isReconnecting then
		self._isReconnecting = true

		self._reconnectHandler:resetForReconnect()
		self._listener:onReconnectStarted()
		self:_stopPackageTimeoutCheck()
	end

	if self._isConnected then
		self:_disconnect()
		self:_stopPackageTimeoutCheck()
	end

	if self._reconnectHandler:isReconnectTimeout() then
		self._listener:onReconnectTimeout()

		return
	end

	self._reconnectHandler:tryReconnect()
end

function M:_disconnect()
	if self._isConnected then
		self._isConnected = false

		NetConnMgr.instance:disconnect(self._reconnectionConfig.connectionType)
	end
end

function M:_handleReceiveSystemMsg(cmd, status, msg)
	if cmd == 1 then
		self:_handleLoginFinish(status, msg)
	elseif cmd == 3 then
		self:_handleGetLostMsgFinish(status, msg)
	elseif cmd == 5 then
		self._receivedLostMsgCount = 0
	end
end

function M:_handleLoginFinish(status)
	if status == 0 then
		NetConnMgr.instance:resetSeqNo()
		NetConnMgr.instance:resetUpTag()
		self:_recalculateFirstSendTime()

		if self._isReconnecting then
			self._reconnectHandler:requestGetLostCmd()
		end

		self._listener:onLoginFinished(true, self._isReconnecting, status)
	else
		self._listener:onLoginFinished(false, self._isReconnecting, status)
	end
end

function M:_handleGetLostMsgFinish(status, msg)
	if not msg.canGet then
		if enableLog then
			printInfo("reconnection::get lost msg failed")
		end

		self._isReconnecting = false

		self:_disconnect()
		self:_stopPackageTimeoutCheck()
		self._listener:onReconnectCanceled(status)

		return
	end

	self:_handleReconnectFinish()
end

function M:_handleReconnectFinish()
	local needResendMsgCount = self._msgQueue:getSize()

	if enableLog then
		printInfo(string.format("reconnection::receive lost msg finished! receivedLostMsgCount = %s,needResendMsgCount = %s", self._receivedLostMsgCount, needResendMsgCount))
	end

	self._blockCount = 0
	self._isReconnecting = false
	self._receivedLostMsgCount = false

	self._reconnectHandler:clear()
	self._listener:onBlockCountChanged(self._blockCount)

	local connectionType = self._reconnectionConfig.connectionType

	while needResendMsgCount > 0 do
		local cachedMsg = self._msgQueue:dequeue()

		NetConnMgr.instance:sendMsg(cachedMsg, connectionType)

		needResendMsgCount = needResendMsgCount - 1
	end

	self:_recalculateFirstSendTime()
	self._listener:onReconnectSucceeded()
end

function M:_recalculateFirstSendTime()
	if self._msgQueue:isEmpty() then
		self._firstSendTime = false
	else
		local faultTolerantTime = self._isReconnecting and self._reconnectionConfig.reconnectFaultTolerantTime or 0

		self._firstSendTime = ServerTime.now() + faultTolerantTime
	end

	if enableLog then
		printInfo("reconnection::_recalculateFirstSendTime", tostring(self._firstSendTime))
	end
end

function M:_isCaredConnectionType(connectionType)
	return self._reconnectionConfig.connectionType == connectionType
end

function M:_isSystemExtId(extId)
	return extId == -1
end

function M:_getCmdConfig(extId, cmd)
	local setting = NetConnMgr.instance._setting
	local extConfig = setting[extId]

	return extConfig and extConfig[cmd] or false
end

return M
