-- chunkname: @framework/network/socket/ConnectAliveMgr.lua

module("framework.network.socket.ConnectAliveMgr", package.seeall)

local ConnectAliveMgr = class("ConnectAliveMgr")

function ConnectAliveMgr:ctor()
	self._isConnected = false

	LuaEventSystem.addEventMechanism(self)
end

function ConnectAliveMgr:init()
	self._connectLoginContext = {}
	self._loginFlow = FlowSequence.New()
	self._loginFlow.flowName = "loginFlow"

	self._loginFlow:addWork(WorkConnectSocket.New(true))
	self._loginFlow:addWork(WorkSystemLogin.New({
		connectWay = 0
	}))
	self._loginFlow:registerDoneListener(self._onLoginDone, self)

	self._keepAliveFlow = FlowSequence.New()
	self._keepAliveFlow.flowName = "keepAliveFlow"

	self._keepAliveFlow:addWork(WorkAliveConnectCheck.New())
	self._keepAliveFlow:addWork(WorkWaitSeconds.New(1))
	self._keepAliveFlow:addWork(WorkSocketDispose.New())
	self._keepAliveFlow:addWork(WorkConnectSocket.New())
	self._keepAliveFlow:addWork(WorkSystemLogin.New({
		connectWay = 1
	}))
	self._keepAliveFlow:addWork(WorkGetLostCmdRespRequest.New())
	self._keepAliveFlow:addWork(WorkResendPackets.New())
	self._keepAliveFlow:registerDoneListener(self._onLostConnect, self)

	self._reconectFlow = FlowSequence.New()
	self._reconectFlow.flowName = "reconectFlow"

	self._reconectFlow:addWork(WorkConnectSocket.New())
	self._reconectFlow:addWork(WorkSystemLogin.New({
		connectWay = 1
	}))
	self._reconectFlow:addWork(WorkGetLostCmdRespRequest.New())
	self._reconectFlow:addWork(WorkResendPackets.New())
	self._reconectFlow:registerDoneListener(self._onReconnectDone, self)

	self._logoutFlow = FlowSequence.New()
	self._logoutFlow.flowName = "logoutFlow"

	self._logoutFlow:addWork(WorkSystemLogout.New())
	self._logoutFlow:registerDoneListener(self._onLogoutDone, self)

	self._preSender = AliveCheckPreSender.New()
	self._preReceiver = AliveCheckPreReceiver.New(self._preSender)

	LuaSocketMgr.instance:registerPreSender(self._preSender)
	LuaSocketMgr.instance:registerPreReceiver(self._preReceiver)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnMsgTimeout, self._onMsgTimeout, self)
end

function ConnectAliveMgr:dispose()
	self._loginFlow:stop()
	self._keepAliveFlow:stop()
	self._reconectFlow:stop()
	self._logoutFlow:stop()

	self._isConnected = false

	LuaSocketMgr.instance:unregisterPreSender(self._preSender)
	LuaSocketMgr.instance:unregisterPreReceiver(self._preReceiver)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnMsgTimeout, self._onMsgTimeout, self)
end

function ConnectAliveMgr:login(ip, port, account, password, callback, callbackObj)
	self._connectLoginContext.dontReconnect = nil
	self._connectLoginContext.msg = nil
	self._connectLoginContext.ip = ip
	self._connectLoginContext.port = port
	self._connectLoginContext.account = account
	self._connectLoginContext.password = password
	self._loginCallback = callback
	self._loginCallbackObj = callbackObj

	self:clearUnresponsiveMsgList()
	self._loginFlow:start(self._connectLoginContext)
end

function ConnectAliveMgr:logout()
	if self._loginFlow.status == WorkStatus.Running then
		self._loginFlow:stop()
		logError("都没登录成功，怎么logout的")
	end

	if self._logoutFlow.status == WorkStatus.Running then
		self._logoutFlow:stop()
		logError("重复调用logout了")
	end

	if self._keepAliveFlow.status == WorkStatus.Running then
		self._keepAliveFlow:stop()
		logNormal("活动连接过程中调用logout")
	end

	if self._reconectFlow.status == WorkStatus.Running then
		self._reconectFlow:stop()
		logNormal("重连过程中调用logout")
	end

	self._isConnected = false

	self._logoutFlow:start({})
	self:clearUnresponsiveMsgList()
	self:clearCurrDownTag()
end

function ConnectAliveMgr:reconnect()
	self._connectLoginContext.dontReconnect = nil
	self._connectLoginContext.msg = nil

	self._reconectFlow:start(self._connectLoginContext)
end

function ConnectAliveMgr:stopReconnect()
	if self._reconectFlow.status == WorkStatus.Running then
		self._reconectFlow:stop()
	end
end

function ConnectAliveMgr:isConnected()
	return self._isConnected
end

function ConnectAliveMgr:getFirstUnresponsiveMsg()
	return self._preSender:getFirstUnresponsiveMsg()
end

function ConnectAliveMgr:getUnresponsiveMsgList()
	return self._preSender:getUnresponsiveMsgList()
end

function ConnectAliveMgr:clearUnresponsiveMsgList()
	self._preSender:clear()
end

function ConnectAliveMgr:addUnresponsiveMsg(cmd, proto, socketId)
	self._preSender:preSendProto(cmd, proto, socketId)
end

function ConnectAliveMgr:ignoreUnimportantCmds()
	self._preSender:ignoreUnimportantCmds()
end

function ConnectAliveMgr:setNonResendCmds(cmds)
	for _, cmd in ipairs(cmds) do
		WorkResendPackets.NonResendCmdDict[cmd] = true
	end
end

function ConnectAliveMgr:getCurrDownTag()
	return self._preReceiver:getCurrDownTag()
end

function ConnectAliveMgr:clearCurrDownTag()
	self._preReceiver:clearCurrDownTag()
end

function ConnectAliveMgr:lostMessage()
	LuaSocketMgr.instance:endConnect()

	self._connectLoginContext.dontReconnect = true

	self._loginFlow:stop()
	self._keepAliveFlow:stop()
	self._reconectFlow:stop()
	self._logoutFlow:stop()

	self._isConnected = false

	ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnLostMessage)
end

function ConnectAliveMgr:_onLoginDone(isSuccess)
	if isSuccess then
		logNormal("<color=#00FF00>ConnectAliveMgr:_onLoginDone() success </color>")

		self._connectLoginContext.dontReconnect = nil
		self._connectLoginContext.msg = nil
		self._isConnected = true

		self._keepAliveFlow:start(self._connectLoginContext)
	else
		self._isConnected = false

		logNormal("<color=red>ConnectAliveMgr:_onLoginDone() fail </color>")
		LuaSocketMgr.instance:endConnect()
	end

	if self._loginCallback then
		local resultTable = {}

		if self._connectLoginContext.socketFail then
			self._connectLoginContext.socketFail = nil
			resultTable.socketFail = true
		end

		if self._connectLoginContext.systemLoginFail then
			self._connectLoginContext.systemLoginFail = nil
			resultTable.systemLoginFail = true
			resultTable.msg = self._connectLoginContext.msg
			self._connectLoginContext.msg = nil
		end

		if self._loginCallbackObj then
			self._loginCallback(self._loginCallbackObj, isSuccess, resultTable)
		else
			self._loginCallback(isSuccess, resultTable)
		end
	end

	self._loginCallback = nil
	self._loginCallbackObj = nil
end

function ConnectAliveMgr:_onLogoutDone(isSuccess)
	logNormal("<color=orange>主动登出完成</color>")
end

function ConnectAliveMgr:_onMsgTimeout()
	self._isConnected = false
end

function ConnectAliveMgr:_onLostConnect(isSuccess)
	local dontReconnect = self._keepAliveFlow.context.dontReconnect
	local msg = self._keepAliveFlow.context.msg

	self._connectLoginContext.dontReconnect = nil
	self._connectLoginContext.msg = nil

	if isSuccess then
		logNormal("<color=orange>断线自动重连成功</color>")

		self._isConnected = true

		self._keepAliveFlow:start(self._connectLoginContext)
		ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnReconnectSucc_def)
	else
		self._isConnected = false

		logNormal("<color=orange>断线了，需要用户操作重连</color>")
		LuaSocketMgr.instance:endConnect()
		ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnLostConnect, dontReconnect, msg)
	end
end

function ConnectAliveMgr:_onReconnectDone(isSuccess)
	local dontReconnect = self._reconectFlow.context.dontReconnect
	local msg = self._reconectFlow.context.msg

	self._connectLoginContext.dontReconnect = nil
	self._connectLoginContext.msg = nil

	if isSuccess then
		logNormal("<color=#00FF00>用户主动重连成功</color>")

		self._isConnected = true

		self._keepAliveFlow:start(self._connectLoginContext)
		ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnReconnectSucc)
	else
		self._isConnected = false

		logNormal("<color=#00FF00>用户主动重连失败，需要用户再次操作重连</color>")
		LuaSocketMgr.instance:endConnect()
		ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnReconnectFail, dontReconnect, msg)
	end
end

ConnectAliveMgr.instance = ConnectAliveMgr.New()

return ConnectAliveMgr
