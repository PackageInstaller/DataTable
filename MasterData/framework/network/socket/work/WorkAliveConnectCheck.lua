-- chunkname: @framework/network/socket/work/WorkAliveConnectCheck.lua

module("framework.network.socket.work.WorkAliveConnectCheck", package.seeall)

local WorkAliveConnectCheck = class("WorkAliveConnectCheck", BaseWork)

function WorkAliveConnectCheck:onStart(context)
	self:_addEvents()
end

function WorkAliveConnectCheck:onResume()
	self:_addEvents()
end

function WorkAliveConnectCheck:clearWork()
	self:_removeEvents()
end

function WorkAliveConnectCheck:_addEvents()
	TaskDispatcher.runRepeat(self._onSecond, self, 1)
end

function WorkAliveConnectCheck:_removeEvents()
	TaskDispatcher.cancelTask(self._onSecond, self)
end

function WorkAliveConnectCheck:_onSecond()
	if not LuaSocketMgr.instance:isConnected() then
		logNormal("socket 断开了，检查工作结束，准备发起自动重连")
		self:onDone(true)

		return
	end

	local msg = ConnectAliveMgr.instance:getFirstUnresponsiveMsg()

	if msg and Time.realtimeSinceStartup - msg.time > NetworkConst.UnresponsiveMsgMaxTime then
		local timeOutMsg = "cmd_" .. msg.cmd .. " 超时未响应，主动断开连接，准备发起自动重连, "
		local timeLogMsg = string.format("%.2f - %.2f > %.2f", Time.realtimeSinceStartup, msg.time, NetworkConst.UnresponsiveMsgMaxTime)
		local list = ConnectAliveMgr.instance:getUnresponsiveMsgList()
		local unresponsiveMsg = ", 未响应包" .. #list .. ": "

		for i, one in ipairs(list) do
			unresponsiveMsg = string.format("%s%d(%.2f)", unresponsiveMsg, one.cmd, one.time)
		end

		logNormal(timeOutMsg .. timeLogMsg .. unresponsiveMsg)
		LuaSocketMgr.instance:endConnect()
		ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnMsgTimeout)
		self:onDone(true)
	end
end

return WorkAliveConnectCheck
