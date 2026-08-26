-- chunkname: @framework/network/socket/work/WorkGetLostCmdRespRequest.lua

module("framework.network.socket.work.WorkGetLostCmdRespRequest", package.seeall)

local WorkGetLostCmdRespRequest = class("WorkGetLostCmdRespRequest", BaseWork)
local GetLostCmdBlockKey = "GetLostCmd"

function WorkGetLostCmdRespRequest:onStart()
	WorkGetLostCmdRespRequest.super.onStart(self)
	ConnectAliveMgr.instance:ignoreUnimportantCmds()
	UIBlockMgr.instance:startBlock(GetLostCmdBlockKey)

	local downTag = ConnectAliveMgr.instance:getCurrDownTag()

	self._callbackId = SystemLoginRpc.instance:sendGetLostCmdRespRequest(downTag, self._onGetLostCmdRespCallback, self)

	TaskDispatcher.runDelay(self._timeout, self, NetworkConst.UnresponsiveMsgMaxTime)
end

function WorkGetLostCmdRespRequest:onResume()
	self._callbackId = SystemLoginRpc.instance:addCallback(3, self._onGetLostCmdRespCallback, self)

	TaskDispatcher.runDelay(self._timeout, self, NetworkConst.UnresponsiveMsgMaxTime)
end

function WorkGetLostCmdRespRequest:clearWork()
	UIBlockMgr.instance:endBlock(GetLostCmdBlockKey)
	SystemLoginRpc.instance:removeCallbackById(self._callbackId)
	TaskDispatcher.cancelTask(self._timeout, self)
end

function WorkGetLostCmdRespRequest:_onGetLostCmdRespCallback(resultCode, msg)
	logNormal("后端补包协议成功")
	self:onDone(true)
end

function WorkGetLostCmdRespRequest:_timeout()
	logNormal("后端补包协议超时")
	self:onDone(false)
end

return WorkGetLostCmdRespRequest
