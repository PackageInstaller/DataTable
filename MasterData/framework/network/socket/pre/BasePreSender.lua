-- chunkname: @framework/network/socket/pre/BasePreSender.lua

module("framework.network.socket.pre.BasePreSender", package.seeall)

local BasePreSender = class("BasePreSender")

function BasePreSender:ctor()
	return
end

function BasePreSender:preSendSysMsg(cmd, dataTable, socketId)
	return
end

function BasePreSender:blockSendProto(cmd, proto, socketId)
	return nil
end

function BasePreSender:preSendProto(cmd, proto, socketId)
	return
end

return BasePreSender
