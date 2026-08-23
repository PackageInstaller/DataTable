local NetSocket = import("..NetSocket")
local ScheduleTask = import("..ScheduleTask")
local NetRequest = import("..NetRequest")
local LoginProxy = class("LoginProxy")

function LoginProxy:ctor(arg_1_1)
	self._netSocket = nil
	self._curTask = nil
	self._seqFactory = nil
	self._protoCache = {}
	self._lastTask = nil
	self._stateListener = arg_1_1
end

function LoginProxy:destroy()
	self:reset()
end

function LoginProxy:reset()
	if self._loginTask then
		self._loginTask:cancel()

		self._loginTask = nil
	end

	if self._curTask then
		self._curTask:cancel()

		self._curTask = nil
	end
end

function LoginProxy:enter(arg_4_1, arg_4_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_ENTER)

	self._netSocket = arg_4_1
	self._seqFactory = arg_4_2

	self:_startConnect()
end

function LoginProxy:exit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_EXIT)
end

function LoginProxy:isSending()
	return checkbool(self._curTask)
end

function LoginProxy:sendMsg(arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_1 == g.core.network.proto.MSG_C2G_Create then
		var_7_0 = self:_sendCreateRole(arg_7_2)
	elseif arg_7_1 == g.core.network.proto.MSG_C2G_Activate then
		var_7_0 = self:_sendAccountActivate(arg_7_2)
	end

	if not self._netSocket:isConnected() then
		if var_7_0 then
			self._lastTask = var_7_0

			self:_stateListener("reset")
		end
	elseif var_7_0 then
		self:_setTask(var_7_0)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_RESUME)
	end
end

function LoginProxy:onNetEvent(arg_8_1)
	if self._loginTask then
		self._loginTask:result(arg_8_1, ...)
	end

	if self._curTask then
		self._curTask:result(arg_8_1, ...)
	end
end

function LoginProxy:cancelTaskById(arg_9_1)
	return
end

function LoginProxy:_startConnect()
	self:_setTask(ScheduleTask.new({
		onStart = function()
			self._netSocket:connect()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_CONNECT_START)
		end,
		onTimeup = function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_CONNECT_FINISH)
			self:_stateListener("disconnected")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
				event_id = g.core.const.ConstMgr.SuperSdkConst.CONNECT_SERVER_ERROR
			})
		end,
		onResult = function(arg_13_0, arg_13_1, arg_13_2)
			arg_13_1:cancel()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_CONNECT_FINISH)

			if arg_13_2 == NetSocket.EVENT_NET_CONNECT_SUCCESS then
				self:_stateListener("connected")
				self:_startLogin()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_CONNECT_SUCCESS)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = g.core.const.ConstMgr.SuperSdkConst.CONNECT_SERVER_SUCCESS
				})
			else
				self:_stateListener("disconnected")
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = g.core.const.ConstMgr.SuperSdkConst.CONNECT_SERVER_ERROR
				})
			end
		end
	}, 300))
end

function LoginProxy:_startLogin()
	local var_14_0 = g.core.platform.ServerListProxy:getSelectedServer()

	g.core.platform.ServerListProxy:saveLastServer(var_14_0)
	g.core.platform.ServerListProxy:clearSummonServer()

	local var_14_1 = self._seqFactory:getValidCid()
	local var_14_3 = (g.core.common.Storage:load("upgrade_config.json", false) or {}).local_version or 0
	local var_14_4 = g.core.utils.Tools.getSilentObbVersion()

	var_14_3 = var_14_4 < var_14_3 and var_14_3 or var_14_4

	local var_14_5 = {
		server_id = var_14_0.sid,
		token = g.core.platform.PlatformProxy:getToken(),
		version = var_14_3,
		sequence_id = var_14_1,
		client = g.core.platform.PlatformProxy:getClientData()
	}

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_LOGIN_NOTIFY, false, var_14_5)

	local var_14_6 = NetRequest.new(g.core.network.proto.MSG_C2G_Login, var_14_5)

	function var_14_6:onStart(arg_15_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
		self:_startTimeoutTask()
	end

	function var_14_6.onTimeup(arg_16_0, arg_16_1)
		NetRequest.onTimeup(arg_16_0)
		self:_onTimeout()
	end

	g.core.platform.ServerListProxy:setLoginServer(var_14_0)

	function var_14_6.onResult(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		if arg_17_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_17_0, arg_17_3, arg_17_4) then
				arg_17_1:cancel()

				if arg_17_4.ret == g.core.network.proto.RET_OK then
					self._netSocket:setUserId(arg_17_4.uid)
					self._netSocket:setSessionId(arg_17_4.sid)
					self:_stateListener("logined", {
						uid = arg_17_4.uid
					})

					if not arg_17_4.auto_flush then
						if var_14_1 == 0 then
							self:_startFlush()
						else
							if self._loginTask then
								self._loginTask:cancel()

								self._loginTask = nil
							end

							if not self._seqFactory:isDiscarded() then
								self:_stateListener("expired")
							else
								self._seqFactory:reset()
								self:_stateListener("reset")
							end
						end
					else
						self._seqFactory:pickUpCid()

						if g.core.model.User.rechargeData:isHasNewOrderId() then
							self:_startFlush()
							g.core.model.User.rechargeData:resetHasNewOrderId()
						else
							self:_startSync()
						end
					end

					g.core.platform.PlatformProxy:riskCheck()
					g.core.common.Setting:loadQualityConfig()
				elseif arg_17_4.ret == g.core.network.proto.RET_USER_NOT_EXIST then
					if self._lastTask then
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_RESUME)
						self._lastTask:start()

						self._curTask = self._lastTask
						self._lastTask = nil
					end

					g.core.platform.PlatformProxy:riskCheck()
				else
					if arg_17_4.ret == g.core.network.proto.RET_VERSION and self._loginTask then
						self._loginTask:cancel()

						self._loginTask = nil
					end

					self:_stateListener("broken", arg_17_4.ret)
				end
			end
		else
			arg_17_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	self:_setTask(ScheduleTask.new(var_14_6))
end

function LoginProxy:_startTimeoutTask()
	self._loginTask = ScheduleTask.new({
		onStart = function()
			return
		end,
		onTimeup = function()
			if self:isSending() then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_CANCEL)
			end

			self._loginTask = nil

			self:_onTimeout()
		end,
		onResult = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
			if arg_21_2 == NetSocket.EVENT_NET_MSG then
				if arg_21_3 == g.core.network.proto.MSG_G2C_Login or arg_21_3 == g.core.network.proto.MSG_G2C_Create then
					if arg_21_4.ret ~= g.core.network.proto.RET_OK then
						arg_21_1:cancel()

						self._loginTask = nil
					end
				elseif arg_21_3 == g.core.network.proto.MSG_S2C_Flush or arg_21_3 == g.core.network.proto.MSG_S2C_SyncProto then
					arg_21_1:cancel()

					self._loginTask = nil
				end
			else
				arg_21_1:cancel()

				self._loginTask = nil
			end
		end
	}, 60)

	self._loginTask:start()
end

function LoginProxy:_sendCreateRole(arg_22_1)
	local var_22_0 = NetRequest.new(g.core.network.proto.MSG_C2G_Create, arg_22_1)

	function var_22_0:onStart(arg_23_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
		self:_startTimeoutTask()
	end

	function var_22_0.onTimeup(arg_24_0, arg_24_1)
		NetRequest.onTimeup(arg_24_0)
		self:_onTimeout()
	end

	function var_22_0.onResult(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
		if arg_25_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_25_0, arg_25_3, arg_25_4) then
				arg_25_1:cancel()

				if arg_25_4.ret == g.core.network.proto.RET_OK then
					self._netSocket:setUserId(arg_25_4.uid)
					self._netSocket:setSessionId(arg_25_4.sid)
					self:_stateListener("logined", {
						uid = arg_25_4.uid
					})
					self:_startFlush()
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_PAUSE)
				end
			end
		else
			arg_25_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	return ScheduleTask.new(var_22_0)
end

function LoginProxy:_sendAccountActivate(arg_26_1)
	local var_26_0 = NetRequest.new(g.core.network.proto.MSG_C2G_Activate, arg_26_1)

	function var_26_0:onStart(arg_27_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_26_0.onTimeup(arg_28_0, arg_28_1)
		NetRequest.onTimeup(arg_28_0)
		self:_onTimeout()
	end

	function var_26_0.onResult(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		if arg_29_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_29_0, arg_29_3, arg_29_4) then
				arg_29_1:cancel()

				if arg_29_4.ret ~= g.core.network.proto.RET_OK then
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_LOGIN_STATE_PAUSE)
				end
			end
		else
			arg_29_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	return ScheduleTask.new(var_26_0)
end

function LoginProxy:_startFlush()
	local var_30_0 = NetRequest.new(g.core.network.proto.MSG_C2S_Flush, {
		unite_token = true,
		knight = true,
		formation = true,
		biography_item = true,
		red_point = true,
		skin = true,
		resource = true,
		dress = true,
		artifact = true,
		favorability_item = true,
		furnishing = true,
		user = true,
		succuba = true,
		pet = true,
		kSoul = true,
		expirable_item = true,
		item = true,
		privilege = true,
		equipment = true,
		fragment = true,
		treasure = true,
		red_packet = true,
		advance_equipment = true
	}, nil, nil, (self._seqFactory:cid()))

	function var_30_0:onStart(arg_31_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_30_0.onTimeup(arg_32_0, arg_32_1)
		NetRequest.onTimeup(arg_32_0)
		self:_onTimeout()
	end

	function var_30_0.onResult(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
		if arg_33_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_33_0, arg_33_3, arg_33_4) then
				arg_33_1:cancel()

				if arg_33_4.ret == g.core.network.proto.RET_OK then
					self:_startDungeon()
				end
			end
		else
			arg_33_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	self:_setTask(ScheduleTask.new(var_30_0, 60))
end

function LoginProxy:_startDungeon()
	local var_34_0 = NetRequest.new(g.core.network.proto.MSG_C2S_Dungeon_GetChapterList, {})

	function var_34_0:onStart(arg_35_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_34_0.onTimeup(arg_36_0, arg_36_1)
		NetRequest.onTimeup(arg_36_0)
		self:_onTimeout()
	end

	function var_34_0.onResult(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		if arg_37_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_37_0, arg_37_3, arg_37_4) then
				arg_37_1:cancel()

				if arg_37_4.ret == g.core.network.proto.RET_OK then
					self:_startGame()
				end
			end
		else
			arg_37_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	self:_setTask(ScheduleTask.new(var_34_0))
end

function LoginProxy:_startSync()
	local var_38_0 = NetRequest.new(g.core.network.proto.MSG_C2S_SyncProto, {
		client_id = self._seqFactory:getValidCid(),
		server_id = self._seqFactory:sid()
	})

	function var_38_0:onStart(arg_39_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_38_0.onTimeup(arg_40_0, arg_40_1)
		NetRequest.onTimeup(arg_40_0)
		self:_onTimeout()
	end

	function var_38_0.onResult(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
		if arg_41_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_41_0, arg_41_3, arg_41_4) then
				arg_41_1:cancel()

				self._protoCache = {}

				self:_resumeGame(self._protoCache)
			else
				self._protoCache[arg_41_3] = (self._protoCache[arg_41_3] or 0) + 1
			end
		else
			arg_41_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	self:_setTask(ScheduleTask.new(var_38_0))
end

function LoginProxy:_startGame()
	self:_stateListener("next")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGIN_FINISH, true)
end

function LoginProxy:_resumeGame(arg_43_1)
	self:_stateListener("next", arg_43_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_RESUME_FINISH, true)
end

function LoginProxy:_setTask(arg_44_1)
	self._curTask = arg_44_1

	arg_44_1:start()
end

function LoginProxy:_onTimeout()
	local var_45_0 = 0

	if self._curTask then
		var_45_0 = self._curTask:getMissionId()
	end

	self:reset()
	self:_stateListener("timeout", {
		msgId = var_45_0
	})
end

return LoginProxy
