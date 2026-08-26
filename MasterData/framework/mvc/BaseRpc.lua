-- chunkname: @framework/mvc/BaseRpc.lua

module("framework.mvc.BaseRpc", package.seeall)

local BaseRpc = class("BaseRpc")

function BaseRpc:onInit()
	return
end

function BaseRpc:reInit()
	return
end

function BaseRpc:onInitInternal()
	self._callbackId = 0
	self._cmdCallbackTab = {}

	self:onInit()
end

function BaseRpc:reInitInternal()
	self._callbackId = 0
	self._cmdCallbackTab = {}

	self:reInit()
end

function BaseRpc:sendSysMsg(cmd, data, callback, callbackObj, socketId)
	if LuaSocketMgr.instance:isConnected(socketId) then
		LuaSocketMgr.instance:sendSysMsg(cmd, data, socketId)

		return self:addCallback(cmd, callback, callbackObj)
	else
		logWarn("send system cmd_" .. cmd .. " fail, reason: lost connect")
	end
end

function BaseRpc:sendMsg(protobuf, callback, callbackObj, socketId)
	local cmd = LuaSocketMgr.instance:getCmdByPbStructName(protobuf.__cname)

	if LuaSocketMgr.instance:isConnected(socketId) and ConnectAliveMgr.instance:isConnected() then
		LuaSocketMgr.instance:sendMsg(protobuf, socketId)

		return self:addCallback(cmd, callback, callbackObj)
	else
		logWarn("send protobuf cmd_" .. cmd .. " fail, reason: lost connect")
		ConnectAliveMgr.instance:addUnresponsiveMsg(cmd, protobuf, socketId)

		return self:addCallback(cmd, callback, callbackObj)
	end
end

local kcpSocketUtil = PartyGame.Runtime.Utils.KcpSocketUtil

function BaseRpc:sendKcpMsg(protobuf)
	kcpSocketUtil.SendMessage(protobuf)
end

function BaseRpc:addCallback(cmd, callback, callbackObj)
	if callback then
		self._callbackId = self._callbackId + 1

		local cbList = self._cmdCallbackTab[cmd]

		if not cbList then
			cbList = {}
			self._cmdCallbackTab[cmd] = cbList
		end

		local luaCb = LuaGeneralCallback.getPool():getObject()

		luaCb.callback = callback

		luaCb:setCbObj(callbackObj)

		luaCb.id = self._callbackId

		table.insert(cbList, luaCb)

		return luaCb.id
	end
end

function BaseRpc:removeCallbackByCmd(cmd)
	local list = self._cmdCallbackTab[cmd]

	if not list then
		return
	end

	self._cmdCallbackTab[cmd] = nil

	for _, luaCb in ipairs(list) do
		LuaGeneralCallback.getPool():putObject(luaCb)
	end
end

function BaseRpc:removeCallbackById(callbackId)
	for _, cbList in pairs(self._cmdCallbackTab) do
		if cbList then
			local length = #cbList

			for i = length, 1, -1 do
				if callbackId == cbList[i].id then
					LuaGeneralCallback.getPool():putObject(cbList[i])
					table.remove(cbList, i)

					return
				end
			end
		end
	end
end

function BaseRpc:onReceiveMsg(resultCode, cmd, recvProtoName, msg, downTag, socketId)
	local handleFunc = self["onReceive" .. recvProtoName]

	if handleFunc then
		callWithCatch(handleFunc, self, resultCode, msg)
	else
		logError(string.format("cmd_%d onReceive%s = nil, %s", cmd, recvProtoName, self.__cname))
	end

	if not self._cmdCallbackTab then
		logError(string.format("cmd callbackDict = nil, %s => module_mvc.lua ", self.__cname))

		return
	end

	local cbList = self._cmdCallbackTab[cmd]

	if cbList then
		self._cmdCallbackTab[cmd] = nil

		for _, luaCb in ipairs(cbList) do
			callWithCatch(luaCb.invoke, luaCb, cmd, resultCode, msg)
			LuaGeneralCallback.getPool():putObject(luaCb)
		end
	end
end

return BaseRpc
