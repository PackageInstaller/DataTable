-- chunkname: @framework/network/socket/work/WorkSystemLogin.lua

module("framework.network.socket.work.WorkSystemLogin", package.seeall)

local WorkSystemLogin = class("WorkSystemLogin", BaseWork)
local SystemLoginBlockKey = "SystemLogin"

function WorkSystemLogin:ctor(params)
	self._connectWay = params.connectWay
end

function WorkSystemLogin:onStart(context)
	UIBlockMgr.instance:startBlock(SystemLoginBlockKey)

	self._account = context.account
	self._password = context.password
	self._callbackId = SystemLoginRpc.instance:sendLoginRequest(self._account, self._password, self._connectWay, self._onLoginCallback, self)

	TaskDispatcher.runDelay(self._onSystemLoginTimeout, self, NetworkConst.SystemLoginTimeout)
end

function WorkSystemLogin:clearWork()
	UIBlockMgr.instance:endBlock(SystemLoginBlockKey)
	SystemLoginRpc.instance:removeCallbackById(self._callbackId)
	TaskDispatcher.cancelTask(self._onSystemLoginTimeout, self)
end

function WorkSystemLogin:_onLoginCallback(cmd, status, msg)
	if status == 0 then
		self:onDone(true)
	else
		self.context.dontReconnect = true
		self.context.systemLoginFail = true
		self.context.msg = msg.reason

		self:onDone(false)
	end
end

function WorkSystemLogin:_onSystemLoginTimeout()
	self:onDone(false)
end

return WorkSystemLogin
