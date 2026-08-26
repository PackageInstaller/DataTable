-- chunkname: @framework/network/socket/SystemLoginRpc.lua

module("framework.network.socket.SystemLoginRpc", package.seeall)

local SystemLoginRpc = class("SystemLoginRpc", BaseRpc)

function SystemLoginRpc:sendLoginRequest(account, password, connectWay, callback, callbackObj)
	local req = {}

	req.account = account
	req.password = password
	req.connectWay = connectWay

	logNormal("请求系统登录: " .. cjson.encode(req))

	return self:sendSysMsg(1, req, callback, callbackObj)
end

function SystemLoginRpc:onReceiveLoginResponse(resultCode, msg)
	if resultCode == 0 then
		logNormal("登录成功！ login succ, userId = " .. msg.userId)
	else
		logNormal("登录失败！ login fail: " .. msg.reason)
	end

	LuaSocketMgr.instance:setSeqId(0)
end

function SystemLoginRpc:sendGetLostCmdRespRequest(downTag, callback, callbackObj)
	local req = {}

	req.downTag = downTag or 0

	return self:sendSysMsg(3, req, callback, callbackObj)
end

function SystemLoginRpc:onReceiveGetLostCmdRespResponse(resultCode, msg)
	logNormal("请求补包结束，是否真的有补发协议：canGet = " .. (msg.canGet and "true" or "false"))
end

function SystemLoginRpc:onReceiveForceLogoutResponse(resultCode, msg)
	logNormal(string.format("<color=red>被系统强踢下线 reason = %s resultCode = %d</color>", msg.reason or "nil", resultCode))
	ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnServerKickedOut, msg.reason, resultCode)
end

function SystemLoginRpc:onReceiveGetLostCmdRespResponseStartTag(resultCode, msg)
	logNormal("服务端开始补发重连期间错过的业务协议！！！")
end

SystemLoginRpc.instance = SystemLoginRpc.New()

return SystemLoginRpc
