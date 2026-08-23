local var_0_0 = type
local var_0_1 = tostring
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_3 = MsgProcessHandler:getInstance()
local var_0_4 = {}

var_0_3:registerScriptHandler(function(arg_1_0, arg_1_1)
	local var_1_0 = var_0_4[var_0_1(arg_1_1)]

	if var_1_0 then
		var_1_0:onNetEvent(arg_1_0, ...)
	end
end)

local var_0_5 = 0
local NetSocket = class("NetSocket")

NetSocket.EVENT_NET_MSG = 0
NetSocket.EVENT_NET_CONNECT_SUCCESS = 1
NetSocket.EVENT_NET_CONNECT_FAIL = 2
NetSocket.EVENT_NET_CONNECT_BROKEN = 3
NetSocket.EVENT_NET_EXCEPTION = 4
NetSocket.CONNECT_NONE = 0
NetSocket.CONNECT_PROCESSING = 1
NetSocket.CONNECT_FINISH = 2

function NetSocket:ctor(arg_2_1, arg_2_2)
	self._ip = arg_2_1
	self._port = arg_2_2
	self._netListener = nil
	self._protoBuilder = nil
	self._connIndex = nil
	self._connectedState = NetSocket.CONNECT_NONE
	self._invalid = false
	self._stagingMsgList = {}
end

function NetSocket:getStagingMsgData(arg_3_1)
	return self._stagingMsgList[arg_3_1] or {}
end

function NetSocket:addStagingMsgData(arg_4_1, arg_4_2)
	self._stagingMsgList[arg_4_1] = self._stagingMsgList[arg_4_1] or {}

	table.insertto(self._stagingMsgList[arg_4_1], arg_4_2)
end

function NetSocket:resetStagingMsgData(arg_5_1)
	self._stagingMsgList[arg_5_1] = {}
end

function NetSocket:destroy()
	if self._connectedState == NetSocket.CONNECT_PROCESSING then
		self:invalid()
	elseif not self._invalid and self._connIndex then
		self._invalid = true
		self._connectedState = NetSocket.CONNECT_NONE
		var_0_4[var_0_1(self._connIndex)] = nil

		var_0_3:abandonConnect(self._connIndex)

		self._connIndex = nil
	end
end

function NetSocket:invalid()
	if self._invalid then
		return
	end

	self._invalid = true
	self._connectedState = NetSocket.CONNECT_NONE

	var_0_3:abandonConnect(self._connIndex)
end

function NetSocket:getIP()
	return self._ip
end

function NetSocket:getPort()
	return self._port
end

function NetSocket:setProtoBuilder(arg_10_1)
	assert(arg_10_1, "Invalid protoBuilder: " .. tostring(arg_10_1))
	assert(arg_10_1.encode and arg_10_1.decode, "The protoBuilder must have \"encode\" and \"decode\" function !")

	self._protoBuilder = arg_10_1
end

function NetSocket:setNetListener(arg_11_1)
	local var_11_0 = var_0_0(arg_11_1)

	assert(var_11_0 == "function" or var_11_0 == "table" and arg_11_1.onNetEvent, "Invalid net listener: " .. tostring(arg_11_1))

	self._netListener = arg_11_1
end

function NetSocket:connect()
	self._connectedState = NetSocket.CONNECT_PROCESSING
	self._invalid = false

	if not self._connIndex then
		self._connIndex = var_0_5
		var_0_5 = var_0_5 + 1
		var_0_4[var_0_1(self._connIndex)] = self

		var_0_3:connectToServer(self._connIndex, self._ip, self._port)
	else
		var_0_3:reconnectToServer(self._connIndex)
	end
end

function NetSocket:isConnecting()
	return self._connectedState == NetSocket.CONNECT_PROCESSING
end

function NetSocket:isConnected()
	return self._connectedState == NetSocket.CONNECT_FINISH
end

function NetSocket:sendMsg(arg_15_1, arg_15_2, arg_15_3)
	if self._invalid then
		return
	end

	if self._connectedState ~= NetSocket.CONNECT_FINISH then
		return
	end

	assert(var_0_0(arg_15_1) == "number", "Invalid msgId: " .. tostring(arg_15_1))

	if DebugCommon.getDebugGlobalValueByKey("proto_dump") == true and arg_15_1 ~= 10006 then
		local var_15_0 = g.core.network.proto.list[var_0_1(arg_15_1)]

		dump(arg_15_2, string.format("C2%s_%s", var_15_0[2], var_15_0[1]), nil, true)
	end

	local var_15_1 = arg_15_2

	if self._protoBuilder then
		var_15_1 = self._protoBuilder:encode(arg_15_1, arg_15_2)
	end

	assert(var_0_0(var_15_1) == "string", "Invalid protoData: " .. tostring(var_15_1))
	var_0_3:sendMessage(self._connIndex, arg_15_1, var_15_1, #var_15_1, arg_15_3)
end

function NetSocket:onNetEvent(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	if self._invalid then
		return
	end

	if arg_16_1 == "netmsg" then
		self:_onReceiveNetMsg(arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	elseif arg_16_1 == "connect_success" then
		self:_onConnectSuccess()
	elseif arg_16_1 == "connect_fail" then
		self:_onConnectFailed()
	elseif arg_16_1 == "connect_broken" then
		self:_onConnectBroken()
	elseif arg_16_1 == "exception" then
		self:_onNetException()
	end
end

function NetSocket:setUserId(arg_17_1)
	var_0_3:setUserId(arg_17_1)
end

function NetSocket:setSessionId(arg_18_1)
	var_0_3:setSessionId(arg_18_1)
end

function NetSocket:_onReceiveNetMsg(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = arg_19_1

	if self._protoBuilder then
		var_19_0 = self._protoBuilder:decode(arg_19_3, arg_19_1, arg_19_2)
	end

	if not self:_checkSubMsgPackage(arg_19_3, var_19_0) then
		return
	end

	self:_dispatchEvent(NetSocket.EVENT_NET_MSG, arg_19_3, var_19_0, arg_19_4, arg_19_5)
end

function NetSocket:_checkSubMsgPackage(arg_20_1, arg_20_2)
	if arg_20_1 == g.core.network.proto.MSG_S2C_GetCommonRankList then
		self:addStagingMsgData(arg_20_1 .. "_" .. arg_20_2.id, arg_20_2.rank_units or {})

		if arg_20_2.finish then
			local var_20_1 = self:getStagingMsgData(arg_20_1 .. "_" .. arg_20_2.id)

			table.sort(var_20_1, function(arg_21_0, arg_21_1)
				return (arg_21_0.rank or 0) < (arg_21_1.rank or 0)
			end)

			arg_20_2.rank_units = var_20_1

			self:resetStagingMsgData(arg_20_1 .. "_" .. arg_20_2.id)

			return true
		end

		return arg_20_2.finish
	elseif arg_20_1 == g.core.network.proto.MSG_S2C_StormCity_GetRanklist then
		if arg_20_2.rank_tp == 1 then
			return true
		end

		local var_20_2 = arg_20_1 .. "_" .. arg_20_2.rank_tp

		self:addStagingMsgData(arg_20_1 .. "_" .. arg_20_2.rank_tp, arg_20_2.units or {})

		if arg_20_2.finish then
			local var_20_3 = self:getStagingMsgData(var_20_2)

			table.sort(var_20_3, function(arg_22_0, arg_22_1)
				return (arg_22_0.rank or 0) < (arg_22_1.rank or 0)
			end)

			arg_20_2.units = var_20_3

			self:resetStagingMsgData(var_20_2)

			return true
		end
	elseif arg_20_1 == g.core.network.proto.MSG_S2C_FlushKnight then
		self:addStagingMsgData(arg_20_1, arg_20_2.knights or {})

		if arg_20_2.finish then
			arg_20_2.knights = self:getStagingMsgData(arg_20_1)

			self:resetStagingMsgData(arg_20_1)

			return true
		end
	elseif arg_20_1 == g.core.network.proto.MSG_S2C_NewSlg_GetReportList then
		self:addStagingMsgData(arg_20_1, arg_20_2.reports or {})

		if arg_20_2.finish then
			arg_20_2.reports = self:getStagingMsgData(arg_20_1)

			self:resetStagingMsgData(arg_20_1)

			return true
		end
	else
		return true
	end

	return false
end

function NetSocket:_onConnectSuccess()
	self._connectedState = NetSocket.CONNECT_FINISH

	self:_dispatchEvent(NetSocket.EVENT_NET_CONNECT_SUCCESS)
end

function NetSocket:_onConnectFailed()
	self._connectedState = NetSocket.CONNECT_NONE

	self:_dispatchEvent(NetSocket.EVENT_NET_CONNECT_FAIL)
end

function NetSocket:_onConnectBroken()
	self._connectedState = NetSocket.CONNECT_NONE

	self:_dispatchEvent(NetSocket.EVENT_NET_CONNECT_BROKEN)
end

function NetSocket:_onNetException()
	self._connectedState = NetSocket.CONNECT_NONE

	self:_dispatchEvent(NetSocket.EVENT_NET_EXCEPTION)
end

function NetSocket:_dispatchEvent(arg_27_1)
	if not self._netListener then
		return
	end

	;((var_0_0(self._netListener) == "table" or nil) and handler(self._netListener, self._netListener.onNetEvent))(self, arg_27_1, ...)
end

return NetSocket
