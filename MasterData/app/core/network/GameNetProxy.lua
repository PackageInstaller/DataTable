local var_0_0 = string
local var_0_1 = string.find
local var_0_2 = tostring
local NetSocket = import(".NetSocket")
local ScheduleTask = import(".ScheduleTask")
local NetRequest = import(".NetRequest")
local ProtoBuilder = import(".ProtoBuilder")
local ProtoHandler = import(".handler.ProtoHandler")
local LoginProxy = import(".state.LoginProxy")
local InteractiveProxy = import(".state.InteractiveProxy")
local var_0_10 = {}

setmetatable(var_0_10, {
	__index = function(arg_1_0, arg_1_1)
		if type(arg_1_1) ~= "string" or not var_0_1(arg_1_1, "send_C2S") and not var_0_1(arg_1_1, "send_C2G") then
			return
		end

		local var_1_0 = var_0_0.sub(arg_1_1, 10)

		assert(g.core.network.proto.list[var_1_0], "Could not find the send msg with named: " .. var_0_2(var_1_0))

		local var_1_1 = g.core.network.proto.list[var_1_0][4]

		assert(g.core.network.proto.list[var_1_0][4], "Could not find the send msg id with named: " .. var_0_2(var_1_0))

		return function(arg_2_0, arg_2_1)
			return arg_2_0:sendMsg(var_1_1, arg_2_1, ...)
		end
	end
})

local GameNetProxy = class("GameNetProxy", var_0_10)

function GameNetProxy:ctor()
	self._netSocket = nil
	self._ip = nil
	self._port = nil
	self._seqFactory = self:_createSeqFactory()
	self._stateOrder = {
		"login",
		"interactive"
	}
	self._stateIndex = 0
	self._netState = nil
	self._netStateInstance = {}
	self._heartTask = nil
	self._syncTimeTask = nil
	self._msgHook = nil
end

function GameNetProxy:reset()
	self:closeManually()

	for iter_4_0, iter_4_1 in pairs(self._netStateInstance) do
		iter_4_1:destroy()
	end

	self._netStateInstance = {}
	self._stateIndex = 0
	self._netState = nil
	self._heartTask = nil
	self._syncTimeTask = nil
	self._seqFactory = self:_createSeqFactory()
end

function GameNetProxy:setMsgHook(arg_5_1)
	self._msgHook = arg_5_1
end

function GameNetProxy:clearMsgHook()
	self._msgHook = nil
end

function GameNetProxy:sendMsg(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1

	if not arg_7_3 and self._msgHook then
		arg_7_1, arg_7_2, var_7_0 = self._msgHook(arg_7_1, arg_7_2)
	end

	if self._netState then
		self._netState:sendMsg(arg_7_1, arg_7_2, var_7_0)
	end
end

function GameNetProxy:connect(arg_8_1, arg_8_2)
	if self._netSocket and (self._netSocket:isConnecting() or self._netSocket:isConnected()) then
		return
	end

	self._ip = arg_8_1
	self._port = arg_8_2

	local var_8_0 = NetSocket.new(arg_8_1, arg_8_2)

	var_8_0:setNetListener(self)
	var_8_0:setProtoBuilder(ProtoBuilder)

	self._netSocket = var_8_0

	self:_resetState()
end

function GameNetProxy:reconnect(arg_9_1)
	if self._netSocket then
		self._netSocket:invalid()
	end

	if arg_9_1 then
		self._seqFactory:discardCid()
	end

	if self._ip == nil or self._port == nil then
		return
	end

	self:connect(self._ip, self._port)
end

function GameNetProxy:isConnected()
	return self._netSocket and self._netSocket:isConnected()
end

function GameNetProxy:closeManually()
	if not self._netSocket or not self._netSocket:isConnected() then
		return
	end

	self:_stopKeepAlive()
	self:_stopSyncTime()

	if self._netState then
		self._netState:exit()

		self._netState = nil
	end

	self._netStateInstance = {}
	self._stateIndex = 0

	self._netSocket:destroy()

	self._netSocket = nil
end

function GameNetProxy:onNetEvent(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	if arg_12_3 == g.core.network.proto.MSG_S2C_SyncProto then
		if arg_12_4.server_id > 0 then
			self._seqFactory:setSid(arg_12_4.server_id)
		end

		if arg_12_4.client_id > 0 then
			self._seqFactory:setValidCid(arg_12_4.client_id)
		end
	elseif arg_12_6 and arg_12_6 > 0 then
		self._seqFactory:setSid(arg_12_5)
		self._seqFactory:setValidCid(arg_12_6)
	end

	if self._heartTask then
		self._heartTask:result(arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	end

	if self._syncTimeTask then
		self._syncTimeTask:result(arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	end

	if self._netState then
		self._netState:onNetEvent(arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	end

	if arg_12_2 == NetSocket.EVENT_NET_MSG then
		ProtoHandler:onNetEvent(arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	end
end

function GameNetProxy:getUserId()
	return self._userId
end

function GameNetProxy:_onDisconnected()
	self:_stopKeepAlive()
	self:_stopSyncTime()

	if self._netSocket then
		self._netSocket:invalid()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_DISCONNECTED)
end

function GameNetProxy:_onTimeout(arg_15_1)
	self:_stopKeepAlive()
	self:_stopSyncTime()

	if self._netSocket then
		self._netSocket:invalid()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_TIMEOUT, false, arg_15_1)
end

function GameNetProxy:_onExpired()
	self._seqFactory:reset()
	self:closeManually()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_EXPIRED)
end

function GameNetProxy:_onBroken(arg_17_1)
	self._seqFactory:reset()
	self:closeManually()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_SERVER_BROKEN, false, arg_17_1)
end

function GameNetProxy:_switchState()
	if self._netState then
		self._netState:exit()
	end

	local var_18_0 = self._stateOrder[self._stateIndex]
	local var_18_1 = self._netStateInstance
	local var_18_2 = handler(self, self._onNetStateChange)

	if self._stateOrder[self._stateIndex] == "login" then
		var_18_1[var_18_0] = var_18_1[var_18_0] or LoginProxy.new(var_18_2)
	elseif var_18_0 == "interactive" then
		var_18_1[var_18_0] = var_18_1[var_18_0] or InteractiveProxy.new(var_18_2)
	end

	self._netState = var_18_1[var_18_0]

	self._netState:enter(self._netSocket, self._seqFactory, ...)
end

function GameNetProxy:_onNetStateChange(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 == "connected" then
		self:_startKeepAlive()
	elseif arg_19_2 == "logined" then
		self._userId = arg_19_3.uid

		self:_startSyncTime()
	elseif arg_19_2 == "next" then
		self:_nextState(arg_19_3)
	elseif arg_19_2 == "reset" then
		self:reconnect(arg_19_3)
	elseif arg_19_2 == "timeout" then
		self:_onTimeout(arg_19_3)
	elseif arg_19_2 == "disconnected" then
		self:_onDisconnected()
	elseif arg_19_2 == "expired" then
		self:_onExpired()
	elseif arg_19_2 == "broken" then
		self:_onBroken(arg_19_3)
	end
end

function GameNetProxy:_nextState()
	self._stateIndex = self._stateIndex + 1

	self:_switchState(...)
end

function GameNetProxy:_resetState()
	self._stateIndex = 1

	self:_switchState()
end

function GameNetProxy:_startKeepAlive()
	local var_22_0 = {}
	local var_22_1
	local var_22_2 = false

	function var_22_0.onStart()
		var_22_1 = self:_createKeepAliveTask()

		var_22_1:start()
	end

	function var_22_0.onTimeup(arg_24_0, arg_24_1)
		if var_22_2 then
			self:_startKeepAlive()
		elseif not self._netState:isSending() then
			self._netSocket:invalid()
		end
	end

	function var_22_0.onResult(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		if arg_25_2 == NetSocket.EVENT_NET_MSG then
			if arg_25_3 == g.core.network.proto.MSG_G2C_KeepAlive then
				var_22_2 = true

				if var_22_1 then
					var_22_1:result(arg_25_2, arg_25_3, ...)
				end
			end
		else
			arg_25_1:cancel()

			if var_22_1 then
				var_22_1:cancel()
			end
		end
	end

	self._heartTask = ScheduleTask.new(var_22_0, 15)

	self._heartTask:start()
end

function GameNetProxy:_createKeepAliveTask()
	local var_26_0 = NetRequest.new(g.core.network.proto.MSG_C2G_KeepAlive, {}, true)

	function var_26_0:onStart(arg_27_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_26_0.onTimeup(arg_28_0, arg_28_1)
		NetRequest.onTimeup(arg_28_0)
	end

	function var_26_0.onResult(arg_29_0, arg_29_1, arg_29_2)
		if NetRequest.onResult(arg_29_0, ...) then
			arg_29_1:cancel()
		end
	end

	return ScheduleTask.new(var_26_0)
end

function GameNetProxy:_stopKeepAlive()
	if self._heartTask then
		self._heartTask:cancel()

		self._heartTask = nil
	end
end

function GameNetProxy:_startSyncTime()
	local var_31_0 = {}
	local var_31_1

	function var_31_0.onStart()
		var_31_1 = self:_createSyncTimeTask()

		var_31_1:start()
	end

	function var_31_0.onTimeup(arg_33_0, arg_33_1)
		self:_startSyncTime()
	end

	function var_31_0.onResult(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_2 == NetSocket.EVENT_NET_MSG then
			if var_31_1 then
				var_31_1:result(arg_34_2, ...)
			end
		else
			arg_34_1:cancel()

			if var_31_1 then
				var_31_1:cancel()
			end
		end
	end

	local var_31_2 = 300

	if config.SHOW_DEBUG_BTN or config.DEBUG_VERSION then
		var_31_2 = (g.core.common.Storage:load("sync_server_time.json", false) or {}).every5s and 5 or var_31_2
	end

	self._syncTimeTask = ScheduleTask.new(var_31_0, var_31_2)

	self._syncTimeTask:start()
end

function GameNetProxy:_createSyncTimeTask()
	local var_35_0 = NetRequest.new(g.core.network.proto.MSG_C2S_SyncTime, {
		client_time = g.core.common.ServerTime:getTime()
	}, true)

	function var_35_0:onStart(arg_36_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_35_0.onTimeup(arg_37_0, arg_37_1)
		NetRequest.onTimeup(arg_37_0)
	end

	function var_35_0.onResult(arg_38_0, arg_38_1, arg_38_2)
		if NetRequest.onResult(arg_38_0, ...) then
			arg_38_1:cancel()
		end
	end

	return ScheduleTask.new(var_35_0)
end

function GameNetProxy:_stopSyncTime()
	if self._syncTimeTask then
		self._syncTimeTask:cancel()

		self._syncTimeTask = nil
	end
end

function GameNetProxy:_createSeqFactory()
	local var_40_0 = {
		cid = function(self)
			self._cid = self._cid + 1

			return self._cid
		end,
		sid = function(self)
			return self._sid
		end,
		reset = function(arg_43_0)
			arg_43_0._cid = 1
			arg_43_0._validCid = 0
			arg_43_0._sid = 0
			arg_43_0._discardCid = false
		end,
		setSid = function(arg_44_0, arg_44_1)
			arg_44_0._sid = arg_44_1
		end,
		setValidCid = function(arg_45_0, arg_45_1)
			arg_45_0._validCid = arg_45_1
		end,
		getValidCid = function(self)
			return self._validCid
		end,
		discardCid = function(arg_47_0)
			arg_47_0._discardCid = true
		end,
		pickUpCid = function(arg_48_0)
			arg_48_0._discardCid = false
		end,
		isDiscarded = function(self)
			return self._discardCid
		end
	}

	var_40_0:reset()

	return var_40_0
end

function GameNetProxy:cancelTaskById(arg_50_1)
	if self._netState then
		self._netState:cancelTaskById(arg_50_1)
	end
end

function GameNetProxy:onSplitPacketMessage()
	self:onNetEvent(self._netState, 0, ...)
end

return GameNetProxy
