-- chunkname: @framework/network/socket/work/WorkConnectSocket.lua

module("framework.network.socket.work.WorkConnectSocket", package.seeall)

local WorkConnectSocket = class("WorkConnectSocket", BaseWork)
local ConnectSocketBlockKey = "ConnectSocket"

function WorkConnectSocket:ctor(firstLogin)
	self._firstLogin = firstLogin
end

function WorkConnectSocket:onStart(context)
	self._ip = SLFramework.UnityHelper.ParseDomainToIp(context.ip)
	self._port = context.port

	if self._firstLogin then
		self._startTime = os.time()

		SLFramework.TimeWatch.Instance:Start()

		local req = {}

		req.account = context.account
		req.password = context.password
		req.connectWay = 0
		self._dataLength = LuaSocketMgr.instance:getSysMsgSendBuffLen(1, req)
	end

	UIBlockMgr.instance:startBlock(ConnectSocketBlockKey)
	LuaSocketMgr.instance:setConnectBeginCallback(self._onConnectBegin, self)

	local result = LuaSocketMgr.instance:beginConnect(self._ip, self._port)

	if result then
		TaskDispatcher.runDelay(self._onConnectTimeout, self, NetworkConst.SocketConnectTimeout)
	else
		logWarn("<color=#FF0000>connect fail: isConnecting, or IpEndPoint = null</color>")

		self.context.socketFail = true

		self:onDone(false)
	end
end

function WorkConnectSocket:onResume()
	LuaSocketMgr.instance:setConnectBeginCallback(self._onConnectBegin, self)
	TaskDispatcher.runDelay(self._onConnectTimeout, self, NetworkConst.SocketConnectTimeout)
end

function WorkConnectSocket:clearWork()
	UIBlockMgr.instance:endBlock(ConnectSocketBlockKey)
	LuaSocketMgr.instance:setConnectBeginCallback(nil, nil)
	TaskDispatcher.cancelTask(self._onConnectTimeout, self)
end

function WorkConnectSocket:_onConnectBegin(socketId, isConnected)
	if self._firstLogin then
		if isConnected then
			if not SDKDataTrackMgr.RequestResult.success then
				do
					local result = SDKDataTrackMgr.RequestResult.fail
					local spendTime = SLFramework.TimeWatch.Instance:Watch()

					spendTime = spendTime - spendTime % 0.001

					SDKDataTrackMgr.instance:trackSocketConnectEvent(result, self._startTime, spendTime, self._dataLength, self._ip .. ":" .. self._port)
				end

				if isConnected then
					self.context.socketFail = nil

					self:onDone(true)

					goto label_5_0
				end
			end
		end
	end

	self.context.socketFail = true

	self:onDone(false)

	::label_5_0::
end

function WorkConnectSocket:_onConnectTimeout()
	if self._firstLogin then
		local spendTime = SLFramework.TimeWatch.Instance:Watch()

		spendTime = spendTime - spendTime % 0.001

		SDKDataTrackMgr.instance:trackSocketConnectEvent(SDKDataTrackMgr.RequestResult.fail, self._startTime, spendTime, self._dataLength, self._ip .. ":" .. self._port)
	end

	self.context.socketFail = true

	self:onDone(false)
end

return WorkConnectSocket
