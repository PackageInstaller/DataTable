-- chunkname: @framework/network/socket/pre/BasePreReceiver.lua

module("framework.network.socket.pre.BasePreReceiver", package.seeall)

local BasePreReceiver = class("BasePreReceiver")

function BasePreReceiver:ctor()
	return
end

function BasePreReceiver:preReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)
	return
end

function BasePreReceiver:preReceiveSysMsg(resultCode, cmd, responseName, msg, downTag, socketId)
	return
end

return BasePreReceiver
