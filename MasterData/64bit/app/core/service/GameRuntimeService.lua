local GameRuntimeService = class("GameRuntimeService")
local Provider = require("app.core.common.Provider")
local var_0_2 = g.core.const.ConstMgr.BuglyTagConst

function GameRuntimeService:ctor()
	self._offline = false
	self._showAntiTip = false
	self._netErrCount = 0

	if device.isWindowsDebug() then
		self._netAnalyst = require("app.view.module.debug.model.ProtoAnalyst").getAnalyst()
	end

	local var_1_0 = g.core.event.enum

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RET_ERROR, self._onRetError, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_REQUEST_START, self._onNetRequestStart, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_REQUEST_RESPONSE, self._onNetRequestResponse, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_REQUEST_CANCEL, self._onNetRequestResponse, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_CONNECT_SUCCESS, self._onClearNetErrCount, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_G2C_LOGIN, self._onG2CLogin, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_G2C_CREATE, self._onG2CCreate, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_LOGIN_REPEAT, self._onLoginRepeat, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_G2C_OFFLINE_NEW, self._onOffLine, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_LOGIN_OFFINE, self._onLoginOffLine, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_S2C_ANTI_ADDICTION_NOTIFY, self._onAntiNotify, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_LOGIN_NOTIFY, self._onLoginNotify, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_LOGIN_STATE_CANCEL, self._onNetRequestResponse, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_CONNECT_START, self._onNetConnectStart, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_CONNECT_FINISH, self._onNetConnectFinish, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_CONNECT_FAIL, self._onNetConnectFail, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_CONNECT_BROKEN, self._onNetConnectBroken, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_DISCONNECTED, self._onNetDisconnected, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_TIMEOUT, self._onNetTimeOut, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_EXPIRED, self._onNetLoginExpired, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_NET_SERVER_BROKEN, self._onNetServerBroken, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_MODULE_EVENT, self._onModuleEvent, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_MODULE_EXIT, self._onModuleExit, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_RECV_ROLE_INFO, self._onRecvRoleInfo, self)
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_KEY_PAD, self._onKeypadClicked, self)
	g.core.layer.LayerManager:getRoot():addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	g.core.layer.LayerManager:getRoot():addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	g.core.layer.LayerManager:getRoot():addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	g.core.event.EventManager:addEventListener(var_1_0.EVENT_STOP_TOUCH_EFFECT, self._onStopTouchEffect, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
end

function GameRuntimeService:_onAddNetErrCount()
	self._netErrCount = self._netErrCount + 1

	if self._netErrCount > 3 then
		self:_onNetLoginExpired()

		return true
	end

	return false
end

function GameRuntimeService:_onClearNetErrCount()
	self._netErrCount = 0
end

function GameRuntimeService:_onRcvNotifyLeave()
	local var_4_0 = g.core.module.ModuleManager:getCurModule()
	local var_4_1 = g.core.module.ModuleManager:getPreviousModule()

	if var_4_0.name == "BATTLE" and (var_4_1.name == "GUILD_DUNGEON" or var_4_1.name == "GUILDBOSS_BATTLE" or var_4_1.name == "GUILD_STATUE" or var_4_1.name == "GUILD_CHAPTER") or (var_4_0 and var_4_0.display or nil) and var_4_0.display:getName() == "BattleResultLayer" or var_4_0.name == "BATTLE_SUMMARY" then
		g.core.module.ModuleManager:tip(g.core.lang:get(1128))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function GameRuntimeService:_onNetRequestStart(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_2 ~= g.core.network.proto.MSG_C2S_BackReward_Info and arg_5_2 ~= g.core.network.proto.MSG_C2S_GVE_WorldKeepAlive and arg_5_2 ~= g.core.network.proto.MSG_C2S_GVE_WorldMove and arg_5_2 ~= g.core.network.proto.MSG_C2S_NotifyUserViewDetail then
		g.core.module.ModuleManager:showLoading(true)
	end

	if arg_5_2 and next(arg_5_3) and arg_5_2 ~= g.core.network.proto.MSG_C2S_GetCommonRankList then
		Provider:clearCache()
	end

	if arg_5_2 then
		if arg_5_2 == 20001 then
			g.core.platform.BuglyProxy:trace(var_0_2.MSG_SEND, string.format("send msg: %s, responseId: %s, cid: %s", tostring(arg_5_2), tostring(arg_5_4), tostring(arg_5_5)))
		else
			g.core.platform.BuglyProxy:trace(var_0_2.MSG_SEND, string.format("send msg: %s, content: %s, responseId: %s, cid: %s", tostring(arg_5_2), json.encode(arg_5_3), tostring(arg_5_4), tostring(arg_5_5)))
		end
	end
end

function GameRuntimeService:_onNetRequestResponse(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:showLoading(false)

	if self._netAnalyst then
		self._netAnalyst:onNetRequestResponse(arg_6_2, arg_6_3, arg_6_4)
	end
end

function GameRuntimeService:_onNetConnectStart()
	g.core.module.ModuleManager:showLoading(true)
end

function GameRuntimeService:_onNetConnectFinish()
	g.core.module.ModuleManager:showLoading(false)
end

function GameRuntimeService:_onNetConnectFail()
	if self._offline then
		return
	end

	local var_9_0, var_9_1

	if self:_onAddNetErrCount() then
		do return end

		var_9_0 = require("app.view.base.component.BaseAssistPopComp").new
		var_9_1 = {
			info = "disconnected"
		}
	end

	var_9_1.text = g.core.lang:get(1149) .. "[-1]"
	var_9_1.text_ok = g.core.lang:get(1150)
	var_9_1.text_cancel = g.core.lang:get(1147)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new(var_9_1), {
		system = true
	})
end

function GameRuntimeService:_onNetConnectBroken()
	if self._offline then
		return
	end

	local var_10_0, var_10_1

	if self:_onAddNetErrCount() then
		do return end

		var_10_0 = require("app.view.base.component.BaseAssistPopComp").new
		var_10_1 = {
			info = "disconnected"
		}
	end

	var_10_1.text = g.core.lang:get(1149) .. "[-2]"
	var_10_1.text_ok = g.core.lang:get(1150)
	var_10_1.text_cancel = g.core.lang:get(1147)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new(var_10_1), {
		system = true
	})
end

function GameRuntimeService:_onNetDisconnected()
	if self._offline then
		return
	end

	local var_11_0, var_11_1

	if self:_onAddNetErrCount() then
		do return end

		var_11_0 = require("app.view.base.component.BaseAssistPopComp").new
		var_11_1 = {
			info = "disconnected"
		}
	end

	var_11_1.text = g.core.lang:get(1149) .. "[-3]"
	var_11_1.text_ok = g.core.lang:get(1150)
	var_11_1.text_cancel = g.core.lang:get(1147)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new(var_11_1), {
		system = true
	})
end

function GameRuntimeService:_onNetTimeOut(arg_12_1, arg_12_2)
	if self._offline then
		return
	end

	if self:_onAddNetErrCount() then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		info = "timeout",
		text = g.core.lang:get(1149) .. ((arg_12_2 and arg_12_2.msgId or nil) and "[" .. tostring(arg_12_2.msgId) .. "]"),
		text_ok = g.core.lang:get(1150),
		text_cancel = g.core.lang:get(1147)
	}), {
		system = true
	})
end

function GameRuntimeService:_onNetLoginExpired()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		type = 1,
		info = "login_expired",
		text = g.core.lang:get(1148),
		text_cancel = g.core.lang:get(1153)
	}), {
		system = true
	})
end

function GameRuntimeService:_onNetServerBroken(arg_14_1, arg_14_2)
	self._needFlush = false

	local var_14_0 = g.core.lang:get(1155, {
		broken = g.core.lang:getRet(arg_14_2)
	})

	if arg_14_2 == g.core.network.proto.RET_SERVER_NOT_OPEN then
		local var_14_1 = ""
		local var_14_2 = g.core.platform.ServerListProxy:getCurServer()

		if var_14_2 then
			if var_14_2.openTime and g.core.common.ServerTime:getLeftSeconds(var_14_2.openTime) > 0 then
				var_14_1 = g.core.lang:get(100035, {
					time = g.core.common.ServerTime:getDateMDHMFormat(var_14_2.openTime)
				})
			end
		end

		if var_14_1 == "" then
			local var_14_3 = g.core.config.net_msg_error.fetch(arg_14_2)

			if var_14_3 then
				var_14_0 = var_14_3.error_msg or var_14_0
			end
		else
			var_14_0 = var_14_1
		end
	elseif arg_14_2 == g.core.network.proto.RET_SERVER_FULL then
		var_14_0 = g.core.lang:get(1152)
		self._needFlush = true
	elseif arg_14_2 == g.core.network.proto.RET_MAX_REGISTER_LIMIT then
		var_14_0 = g.core.lang:get(1152)
		self._needFlush = true
	elseif arg_14_2 == g.core.network.proto.RET_SERVER_NEARLY_FULL then
		var_14_0 = g.core.lang:get(1152)
		self._needFlush = true

		local var_14_4 = g.core.platform.ServerListProxy:getCurServer()

		if var_14_4 and g.core.platform.ServerListProxy:isMyServer(var_14_4) then
			var_14_0 = g.core.lang:get(1151)
			self._needFlush = false
		end
	end

	local var_14_6 = {
		singleButton = true,
		title = g.core.lang:get(1257),
		desc = var_14_0
	}

	if arg_14_2 == g.core.network.proto.RET_VERSION then
		function var_14_6.onConfirm()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_VERISON, false, arg_14_2)
			device.restartGame()
		end

		local var_14_7 = require("app.view.base.pop.BaseConfirmPop").new(var_14_6)
	else
		var_14_6.onConfirmEventParams = {
			[1] = "txt_pop_cancel",
			[2] = "net_broken"
		}

		if self._needFlush then
			g.core.platform.PlatformProxy:requestPlatformConfig()
		end
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_14_6)))
end

function GameRuntimeService:_onLoginRepeat()
	self._offline = true

	local var_16_0 = require("app.view.base.component.BaseAssistPopComp").new({
		type = 1,
		info = "login_repeat",
		text = g.core.lang:get(1141),
		text_cancel = g.core.lang:get(1135)
	})

	g.core.common.Scheduler:newScheduleOnce(handler(self, function()
		if var_16_0 and var_16_0._onBtnCancel then
			var_16_0:_onBtnCancel()
		end
	end), 5)
	g.core.module.ModuleManager:pushPopup(var_16_0, {
		system = true
	})
end

function GameRuntimeService:_onOffLine(arg_18_1, arg_18_2, arg_18_3)
	self._offline = true

	local var_18_0 = "login_repeat"
	local var_18_1, var_18_2

	if arg_18_3.reason == 6 then
		var_18_0 = "sdk_logout"
		var_18_1 = require("app.view.base.component.BaseAssistPopComp").new
		var_18_2 = {
			type = 1
		}
	end

	var_18_2.text = g.core.lang:get(1250 + tonumber(arg_18_3.reason))
	var_18_2.text_cancel = g.core.lang:get(1135)
	var_18_2.info = var_18_0

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new(var_18_2), {
		system = true
	})
end

function GameRuntimeService:_onLoginOffLine(arg_19_1, arg_19_2, arg_19_3)
	self._offline = true

	local var_19_0 = g.core.lang:get(1141)

	if arg_19_3.ret == g.core.network.proto.RET_ANTI_ADDICTION_REASON_1 then
		var_19_0 = g.core.lang:get(1136)
	elseif arg_19_3.ret == g.core.network.proto.RET_ANTI_ADDICTION_REASON_2 then
		var_19_0 = g.core.lang:get(1137)
	elseif arg_19_3.ret == g.core.network.proto.RET_ANTI_ADDICTION_REASON_3 then
		var_19_0 = g.core.lang:get(1138)
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		type = 1,
		info = "login_repeat",
		text = var_19_0,
		text_cancel = g.core.lang:get(1135)
	}), {
		system = true
	})
end

function GameRuntimeService:_onAntiNotify(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_3.is_fcm == 1 and arg_20_3.fcm_status == 4 then
		g.core.platform.PlatformProxy:showGuest()

		return
	end

	local var_20_0

	if g.core.guide.GuideProxy:isGuideRunning() or self._showAntiTip then
		do return end

		var_20_0 = {
			singleButton = true,
			title = g.core.lang:get(111026)
		}
	end

	var_20_0.desc = g.core.lang:get(1139, {
		time = arg_20_3.remaining_time
	})

	function var_20_0.onConfirm()
		self._showAntiTip = false
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_20_0), {
		system = true
	})

	self._showAntiTip = true
end

function GameRuntimeService:_onLoginNotify(arg_22_1, arg_22_2)
	if arg_22_2.token then
		g.core.platform.BuglyProxy:removeUserValue("token")
		g.core.platform.BuglyProxy:addUserValue("token", arg_22_2.token)
	end

	g.core.platform.BuglyProxy:setUserValue({
		server_id = arg_22_2.server_id,
		sequence_id = arg_22_2.sequence_id
	})
	g.core.platform.BuglyProxy:uploadUserInfo()
end

function GameRuntimeService:_onG2CLogin(arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3.ret == g.core.network.proto.RET_OK then
		g.core.platform.BuglyProxy:setUserId(arg_23_3.uid)
		g.core.model.User:setPlatUserId(arg_23_3.uid)
		g.core.model.User.homeData:setServerGitInfo(arg_23_3)

		for iter_23_0, iter_23_1 in pairs({}) do
			g.core.platform.BuglyProxy:removeUserValue(iter_23_0)
			g.core.platform.BuglyProxy:addUserValue(iter_23_0, iter_23_1)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.LOGIN_SUCCESS
		})
	elseif arg_23_3.ret == g.core.network.proto.RET_USER_NOT_EXIST then
		-- block empty
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.LOGIN_ERROR,
			errMsg = g.core.lang:getRet(arg_23_3.ret)
		})
	end
end

function GameRuntimeService:_onG2CCreate(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3.ret == g.core.network.proto.RET_OK then
		g.core.platform.BuglyProxy:setUserId(arg_24_3.uid)
		g.core.model.User:setPlatUserId(arg_24_3.uid)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.CREATE_ROLE_SUCCESS
		})
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.CREATE_ROLE_ERROR,
			errMsg = g.core.lang:getRet(arg_24_3.ret)
		})
	end
end

function GameRuntimeService:_onRetError(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_2 == g.core.network.proto.RET_BATTLE_FAILED or arg_25_2 == g.core.network.proto.RET_USER_NOT_JOIN_GUILD or arg_25_2 == g.core.network.proto.RET_CLIENT_NEED_FLUSH or arg_25_2 == g.core.network.proto.RET_GUILD_HISTORY_NOT_LOAD then
		return
	end

	if arg_25_2 == g.core.network.proto.RET_SERVER_NOT_OPEN then
		local var_25_0 = ""
		local var_25_1 = g.core.platform.ServerListProxy:getCurServer()

		if var_25_1 then
			if var_25_1.openTime and g.core.common.ServerTime:getLeftSeconds(var_25_1.openTime) > 0 then
				var_25_0 = g.core.lang:get(100035, {
					time = g.core.common.ServerTime:getDateMDHMFormat(var_25_1.openTime)
				})
			end
		end

		if var_25_0 == "" then
			local var_25_2 = g.core.config.net_msg_error.fetch(arg_25_2)

			var_25_0 = var_25_2 and var_25_2.error_msg or var_25_0
		end

		if var_25_0 ~= "" then
			g.core.module.ModuleManager:tip(var_25_0)
		end

		return
	end

	local var_25_3 = g.core.config.net_msg_error.fetch(arg_25_2)
	local var_25_4 = ""

	var_25_4 = var_25_3 and var_25_3.error_msg or g.core.lang:getRet(arg_25_2)

	if arg_25_2 == g.core.network.proto.RET_SERVER_MAINTAIN or arg_25_2 == g.core.network.proto.RET_SERVER_NOT_OPEN or arg_25_2 == g.core.network.proto.RET_SERVER_FULL or arg_25_2 == g.core.network.proto.RET_SERVER_REGISTER_FULL then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
			type = 1,
			text = var_25_4
		}), {
			system = true
		})
	else
		g.core.module.ModuleManager:tip(var_25_4)
	end
end

function GameRuntimeService:_onModuleEvent(arg_26_1, arg_26_2, arg_26_3)
	if arg_26_2 == "txt_pop_ok" then
		if arg_26_3 == "timeout" or arg_26_3 == "disconnected" then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_RECONNECT)
			g.core.network.GameNetProxy:reconnect()
		elseif arg_26_3 == "login_expired" then
			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		elseif arg_26_3 == "sdk_logout" then
			g.core.platform.PlatformProxy:setAntiLogoutFlag(true)
			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		end
	elseif arg_26_2 == "txt_pop_cancel" then
		if arg_26_3 == "timeout" or arg_26_3 == "disconnected" then
			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		elseif arg_26_3 == "login_expired" then
			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		elseif arg_26_3 == "login_repeat" then
			self._offline = false

			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		elseif arg_26_3 == "sdk_logout" then
			g.core.platform.PlatformProxy:setAntiLogoutFlag(true)
			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		elseif arg_26_3 == "net_broken" then
			self:_onClearNetErrCount()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT)
		end
	end
end

function GameRuntimeService:_onModuleEnter(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = {}
	local var_27_1 = arg_27_3:getParams()

	if var_27_1 and #var_27_1 > 0 then
		for iter_27_0 = 1, #var_27_1 do
			var_27_0[tostring(iter_27_0)] = type(var_27_1[iter_27_0]) == "table" and not var_27_1[iter_27_0].resName and "*TABLE*" or var_27_1[iter_27_0]
		end
	end

	local var_27_2 = g.view.entrance.MODULE_NAME[arg_27_2]
	local var_27_3

	if not g.view.entrance.MODULE_NAME[arg_27_2] and var_27_1 and type(var_27_1[1]) == "table" and var_27_1[1].resName then
		var_27_2 = var_27_1[1].resName
		var_27_3 = json.encode(var_27_0) or ""
	end

	g.core.platform.BuglyProxy:trace(var_0_2.MODULE_ENTER, string.format("module %s enter, params is %s", tostring(var_27_2), var_27_3))
end

function GameRuntimeService:_onModuleExit(arg_28_1, arg_28_2)
	if arg_28_2 then
		g.core.platform.BuglyProxy:trace(var_0_2.MODULE_EXIT, string.format("module %s exit", g.view.entrance.MODULE_NAME[arg_28_2] or "UNKNOWN"))
	end
end

function GameRuntimeService:_onRecvRoleInfo(arg_29_1, arg_29_2, arg_29_3)
	if arg_29_3.user then
		g.core.platform.BuglyProxy:setUserValue({
			name = arg_29_3.user.name,
			level = arg_29_3.user.level,
			guide_id = arg_29_3.user.guide_id
		})
		g.core.platform.BuglyProxy:uploadUserInfo()
	end
end

function GameRuntimeService:_onTouchBegin(arg_30_1)
	arg_30_1:captureTouch()

	local var_30_0 = arg_30_1:getInput():getTouch()

	if not var_30_0 then
		return
	end

	local var_30_1 = var_30_0:getLocation()

	if not self._touchEffect then
		self._touchEffect = g.core.layer.LayerManager:getTipLayer():addEffectSpine({
			name = "eff_ui_common_click",
			isLoop = false,
			x = var_30_1.x,
			y = -(display.height - var_30_1.y)
		})
	else
		self._touchEffect:setPosition(cc.p(var_30_1.x, -(display.height - var_30_1.y)))
		self._touchEffect:setAnimation(0, "play", false)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CLICK_START)
end

function GameRuntimeService:_onTouchMove(arg_31_1)
	return
end

function GameRuntimeService:_onTouchEnd(arg_32_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CLICK_FINISH, false, arg_32_1)
end

function GameRuntimeService:_onStopTouchEffect(arg_33_1)
	return
end

function GameRuntimeService:_needReplaceExit(arg_34_1)
	return false
end

function GameRuntimeService:_onKeypadClicked(arg_35_1, arg_35_2, arg_35_3)
	if arg_35_3 == "backClicked" then
		local var_35_0 = g.core.guide.GuideProxy:isGuideRunning()

		if var_35_0 or g.core.model.User.storyData:isInStory() then
			local var_35_1 = g.core.module.ModuleManager:getCurModule()

			if not var_35_0 and (not var_35_1 or var_35_1.display:getName() ~= "StoryReviewPop") then
				if g.core.model.User.storyData:isInStory() and var_35_1 and var_35_1.display:getName() ~= "StorySkipPop" and var_35_1.display._onClickSkip then
					var_35_1.display:_onClickSkip()
				elseif var_35_1 and var_35_1.display:getName() == "StorySkipPop" then
					var_35_1.display:_onClickBack()
				else
					g.core.module.ModuleManager:tip(g.core.lang:get(1163))
				end

				return
			elseif var_35_0 then
				return
			end
		elseif g.core.battle.BattleProxy:isInBattle() then
			return
		elseif g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() then
			g.core.module.ModuleManager:tip(g.core.lang:get(500252))

			return
		end

		local var_35_2 = g.core.module.ModuleManager:getCurModule()

		if not var_35_2 then
			return
		end

		local var_35_3 = g.core.module.ModuleManager:getCurRootModule()

		if var_35_3 == g.view.entrance.FOG_NIGHTMARE_EXPLORE or var_35_3 == g.view.entrance.ANNIVERSARY_JIGSAW_LAYER then
			return
		end

		local var_35_4 = var_35_2.module

		if var_35_2.module == g.view.entrance.HOME or var_35_4 == g.view.entrance.LOGIN then
			if config.PCSDK_ENABLED then
				return
			end

			local function var_35_5()
				local var_36_0 = cc.Application:getInstance():getTargetPlatform()

				if var_36_0 == cc.PLATFORM_OS_IPHONE or var_36_0 == cc.PLATFORM_OS_IPAD then
					os.exit()
				else
					cc.Director:getInstance():endToLua()
				end
			end

			if self:_needReplaceExit(function()
				if g.core.model.User:getId() > 0 then
					g.core.platform.PlatformProxy:addLocalVitFullSchedule({
						num = g.core.model.User.resourceData:getVit()
					})
				end

				g.core.platform.PlatformProxy:sendAdvExit()
				cc.Director:getInstance():endToLua()
			end) then
				-- block empty
			else
				(function()
					if g.core.platform.PlatformProxy:isChannelOfChina() then
						g.core.platform.PlatformProxy:exit()
					else
						local var_37_0

						if g.core.model.User:getId() > 0 then
							g.core.platform.PlatformProxy:addLocalVitFullSchedule({
								num = g.core.model.User.resourceData:getVit()
							})

							var_37_0 = require("app.view.base.pop.BaseConfirmPop").new
						end

						local var_37_1 = require("app.view.base.pop.BaseConfirmPop").new({
							title = g.core.lang:get(1257),
							desc = g.core.lang:get(1258),
							confirmText = g.core.lang:get(1153),
							cancelText = g.core.lang:get(1147),
							onConfirm = handler(self, function()
								g.core.platform.PlatformProxy:exit()
								var_35_5()
							end)
						})

						var_37_1:setName("exitNamePop")
						g.core.module.ModuleManager:pushPopup(var_37_1, {
							ignoreTouch = var_35_4 == g.view.entrance.HOME
						})
					end
				end)()
			end
		elseif var_35_4 == g.view.entrance.UPGRADE or var_35_4 == g.view.entrance.SILENT_UPGRADE then
			return
		elseif var_35_2.modType == g.view.entrance.POPUP then
			if var_35_2.module and var_35_2.module.params and var_35_2.module.params.ignoreTouch and not ({
				FurnitureComfortBuffPop = true,
				GoldSavingTurnGameLayer = true
			})[var_35_2.display:getName()] and not ((var_35_2.module and var_35_2.display or nil) and var_35_2.display:getName() == "exitNamePop") then
				return
			end

			if g.core.service.ServiceManager:getServiceByName("LaunchService"):isExitGame() then
				return
			end

			if var_35_2.display.onCancelCallback then
				var_35_2.display:onCancelCallback()

				return
			elseif var_35_2.display._onClickClose then
				var_35_2.display:_onClickClose()

				return
			elseif var_35_2.display._onClickCancel then
				var_35_2.display:_onClickCancel()

				return
			elseif var_35_2.display.homeLayerAutoPopup then
				var_35_2.display:homeLayerAutoPopup()
				var_35_2.display:removeFromParent()

				return
			elseif g.core.module.ModuleManager:getPreModuleName() ~= "none" then
				g.core.module.ModuleManager:popModule()
			else
				g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
			end
		else
			local var_35_7 = var_35_2.display:getChild("topBarComp")

			if var_35_2.display.onClickBackBtn then
				var_35_2.display:onClickBackBtn()
			elseif not var_35_7 and not var_35_2.display:getChild("topBar") then
				g.core.module.ModuleManager:tip(g.core.lang:get(1163))
			else
				local var_35_8 = g.core.module.ModuleManager:getCurModule()

				if var_35_8 and var_35_8.module and var_35_8.module.previous then
					g.core.module.ModuleManager:popModule()
				else
					g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
				end
			end
		end
	end
end

return GameRuntimeService
