local var_0_0 = json.decode
local var_0_1 = json.encode
local var_0_2 = {
	e_cmd_login_respone = 4,
	e_cmd_queryRoleList_respone = 12,
	e_cmd_querySrvList_request = 7,
	e_cmd_game_online_request = 25,
	e_cmd_setInterval_request = 23,
	e_cmd_queryLastRole_respone = 14,
	e_cmd_AntiAddict_start = 26,
	e_cmd_deleteRole_request = 21,
	e_cmd_bind_request = 1,
	e_cmd_deviceinfo_request = 28,
	e_cmd_updateRoles_request = 19,
	e_cmd_enterGame_request = 15,
	e_cmd_openUrl_request = 32,
	e_cmd_action_request = 33,
	e_cmd_action_sdk_request = 35,
	e_cmd_action_respone = 34,
	e_cmd_pay_respone = 6,
	e_cmd_report_respone = 31,
	e_cmd_updateRoles_respone = 20,
	e_cmd_queryRecSrvList_request = 9,
	e_cmd_deleteRole_respone = 22,
	e_cmd_game_online_get_respone = 27,
	e_cmd_report_request = 30,
	e_cmd_setInterval_respone = 24,
	e_cmd_queryRoleList_request = 11,
	e_cmd_deviceinfo_respone = 29,
	e_cmd_createRole_respone = 18,
	e_cmd_enterGame_respone = 16,
	e_cmd_pay_request = 5,
	e_cmd_login_request = 3,
	e_cmd_createRole_request = 17,
	e_cmd_queryRecSrvList_respone = 10,
	e_cmd_bind_respone = 2,
	e_cmd_querySrvList_respone = 8,
	e_cmd_queryLastRole_request = 13,
	e_cmd_heartbeat = 0
}
local var_0_3 = {
	openVip = "openVip",
	get_figure = "get_figure",
	restart = "restart",
	get_multi_info = "get_multi_info",
	get_info = "get_info",
	blue_vip_info = "blue_vip_info",
	filter_uic = "filter_uic",
	query_real_name = "query_real_name",
	get_app_friends = "get_app_friends"
}
local var_0_4 = {
	logged_off = "logged_off",
	web_close = "web_close",
	pay_close = "pay_close",
	buy_vip_close = "buy_vip_close"
}
local var_0_5
local var_0_6 = PcSdkHandler:getInstance()

var_0_6:registerScriptHandler(function(arg_1_0, arg_1_1)
	if var_0_5 then
		var_0_5:onNetEvent(arg_1_0, ...)
	end
end)

local PcSDKProxy = class("PcSDKProxy", require("app.core.platform.PlatformProxy"))

function PcSDKProxy:ctor()
	PcSDKProxy.super.ctor(self)

	var_0_5 = self
	self._connectIndex = 1
	self._base_info_map = nil
	self._osdk_user_id = nil
	self._token = nil
	self._tokenData = nil
	self._deviceInfo = nil
end

function PcSDKProxy:init()
	self:connectToServer()
end

function PcSDKProxy:isInitSdkOK()
	return self._base_info_map ~= nil
end

function PcSDKProxy:login()
	return
end

function PcSDKProxy:isLogined()
	return self._osdk_user_id ~= nil
end

function PcSDKProxy:_syncMicro()
	g.core.module.ModuleManager:pushModule(g.view.entrance.LOGIN)
end

function PcSDKProxy:onNetEvent(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_1 == "connect_success" then
		var_0_6:start(self._connectIndex)
	elseif arg_8_1 == "netmsg" then
		if arg_8_2 == var_0_2.e_cmd_bind_respone then
			if arg_8_3 == 1 then
				self:onBind(arg_8_4)
			end
		elseif arg_8_2 == var_0_2.e_cmd_login_respone then
			if arg_8_3 == 1 then
				arg_8_4 = var_0_0(arg_8_4)
				self._osdk_user_id = arg_8_4.osdk_user_id
				self._token = arg_8_4.token
				self._tokenData = from_base64(self._token.osdk_ticket)
				self._tokenData = json.decode(self._tokenData)

				if self:isChannelOfEnPC() or self:isChannelOfKrPC() then
					self._osdk_user_id = self._tokenData.osdk_user_id
				end

				self:onLogin(self._tokenData.user_id)
				self:reqAccountServer()
			else
				self:_goWrong("login_failed", arg_8_4)
			end
		elseif arg_8_2 == var_0_2.e_cmd_pay_respone then
			if arg_8_3 == 111111 then
				-- block empty
			else
				g.core.module.ModuleManager:tip(arg_8_4)
			end
		elseif arg_8_2 == var_0_2.e_cmd_querySrvList_respone then
			if arg_8_3 == 1 then
				self:onQuerySrvList(arg_8_4)
			else
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_SERVER_LIST_FAIL, false, arg_8_4)
			end
		elseif arg_8_2 == var_0_2.e_cmd_game_online_get_respone then
			if arg_8_3 == 1 then
				self:onOnlineGet(arg_8_4)
			end
		elseif arg_8_2 == var_0_2.e_cmd_deviceinfo_respone then
			self:onDeviceInfo(arg_8_4)
		elseif arg_8_2 == var_0_2.e_cmd_action_respone then
			self:onAction(arg_8_4)
		elseif arg_8_2 == var_0_2.e_cmd_action_sdk_request then
			self:onActionSdk(arg_8_4)
		end
	else
		self:_goWrong(arg_8_1, arg_8_4)
	end
end

function PcSDKProxy:_goWrong(arg_9_1, arg_9_2)
	arg_9_2 = var_0_0(arg_9_2)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		singleButton = true,
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(1148) .. ": " .. arg_9_1,
		onConfirm = function()
			cc.Director:getInstance():endToLua()
		end
	}), {
		system = true
	})
end

function PcSDKProxy:connectToServer()
	var_0_6:connectToServer(self._connectIndex)
end

function PcSDKProxy:start()
	var_0_6:start(self._connectIndex)
end

function PcSDKProxy:requestLogin()
	if self._base_info_map == nil then
		return
	end

	var_0_6:requestLogin(self._base_info_map)
end

function PcSDKProxy:requestPay(arg_14_1)
	var_0_6:requestPay(arg_14_1.amount, arg_14_1.currency, arg_14_1.server_id, arg_14_1.product_id, arg_14_1.product_name, arg_14_1.game_role_id, arg_14_1.server_name, arg_14_1.game_role_name, arg_14_1.custom_data)
end

function PcSDKProxy:requestQueryServers(arg_15_1)
	if self._base_info_map == nil then
		return
	end

	local var_15_0 = self._base_info_map

	self._curQueryServerGameId = nil

	if arg_15_1 then
		var_15_0 = string.gsub(self._base_info_map, "\"opgameid\":\"%d+\"", "\"opgameid\":\"" .. arg_15_1 .. "\"")
		self._curQueryServerGameId = arg_15_1
	end

	var_0_6:requestQueryServers(var_15_0, "{\"isCache\":\"1\",\"backColums\":[\"gateway_domain\",\"gateway_port\", \"op_sid\"]}")
end

function PcSDKProxy:requestQueryRoles()
	if self._base_info_map == nil then
		return
	end

	var_0_6:requestQueryRoles(self._base_info_map, self._osdk_user_id, "{\"isCache\":\"1\"}")
end

function PcSDKProxy:requestQueryLastRole()
	if self._base_info_map == nil then
		return
	end

	var_0_6:requestQueryLastRole(self._base_info_map, self._osdk_user_id, "")
end

function PcSDKProxy:requestEnterGame(arg_18_1)
	if self._base_info_map == nil then
		return
	end

	arg_18_1 = var_0_1(arg_18_1)

	var_0_6:requestEnterGame(self._base_info_map, self._osdk_user_id, arg_18_1)
end

function PcSDKProxy:requestCreateRole(arg_19_1)
	if self._base_info_map == nil then
		return
	end

	arg_19_1 = var_0_1(arg_19_1)

	var_0_6:requestCreateRole(self._base_info_map, self._osdk_user_id, arg_19_1)
end

function PcSDKProxy:requestUpdateRole(arg_20_1)
	if self._base_info_map == nil then
		return
	end

	arg_20_1 = var_0_1(arg_20_1)

	var_0_6:requestUpdateRole(self._base_info_map, self._osdk_user_id, arg_20_1)
end

function PcSDKProxy:requestAntiAddict()
	if self._base_info_map == nil then
		return
	end

	var_0_6:requestAntiAddict(self._base_info_map)
end

function PcSDKProxy:requestDeviceInfo()
	if self._base_info_map == nil then
		return
	end

	var_0_6:requestDeviceInfo(self._base_info_map)
end

function PcSDKProxy:requestReport(arg_23_1)
	var_0_6:requestReport(arg_23_1.event_id, arg_23_1.event_label, arg_23_1.desc, (var_0_1(arg_23_1.extra)))
end

function PcSDKProxy:requestOpenUrl(arg_24_1, arg_24_2)
	arg_24_1.caption = arg_24_1.caption or ""
	arg_24_1.witdh = arg_24_1.witdh or 800
	arg_24_1.height = arg_24_1.height or 600
	arg_24_2 = arg_24_2 or 0

	var_0_6:requestOpenUrl(var_0_1(arg_24_1), arg_24_2)
end

function PcSDKProxy:requestAction(arg_25_1)
	var_0_6:requestAction(arg_25_1)
end

function PcSDKProxy:requestQuit(arg_26_1)
	xpcall(function()
		var_0_6:requestQuit(arg_26_1)
	end, function(arg_28_0)
		g.core.log:error("requestQuit error:", arg_28_0)
	end)
end

function PcSDKProxy:onBind(arg_29_1)
	self._base_info_map = arg_29_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_INIT_SUCCESS, false)
	self:reqServerList()
	self:requestDeviceInfo()
	self:requestLogin()
end

function PcSDKProxy:onQuerySrvList(arg_30_1)
	arg_30_1 = var_0_0(arg_30_1)

	local var_30_0 = false

	if arg_30_1.code == 1 then
		if type(arg_30_1.data.list) == "table" and #arg_30_1.data.list > 0 then
			var_30_0 = true

			g.core.platform.ServerListProxy:setServerList(arg_30_1.data.list, self._curQueryServerGameId)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_SERVER_LIST)
		end
	end

	if not var_30_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_SERVER_LIST_FAIL, false, arg_30_1)
	end
end

function PcSDKProxy:onQueryRecSrvList(arg_31_1)
	return
end

function PcSDKProxy:onOnlineGet(arg_32_1)
	arg_32_1 = var_0_0(arg_32_1)

	local var_32_0 = arg_32_1.data or {}

	self.is_fcm = tostring(var_32_0.is_fcm)
	self.fcm_status = tostring(var_32_0.fcm_status)
	self.is_warning = tostring(var_32_0.is_warning)

	self:checkFCM()
end

function PcSDKProxy:onDeviceInfo(arg_33_1)
	arg_33_1 = var_0_0(arg_33_1)

	if arg_33_1.code == 1 then
		self._deviceInfo = arg_33_1.msg
	end
end

function PcSDKProxy:onAction(arg_34_1)
	arg_34_1 = var_0_0(arg_34_1)

	if arg_34_1 == nil then
		return
	end

	local var_34_0 = arg_34_1.action

	if arg_34_1.action == var_0_3.restart then
		cc.Director:getInstance():endToLua()

		return
	end

	if arg_34_1.result.ret ~= 0 then
		return
	end

	g.core.event.EventManager:dispatchEvent("PCSDK_ACTION_RESPONSE", false, {
		action = var_34_0,
		result = arg_34_1.result
	})
end

function PcSDKProxy:onActionSdk(arg_35_1)
	local var_35_0 = var_0_0(arg_35_1)

	if var_35_0 == nil then
		return
	end

	local var_35_1 = var_35_0.action

	g.core.event.EventManager:dispatchEvent("PSCDK_ACTIONSDK_RESPONSE", false, {
		action = var_35_0.action
	})

	if var_35_1 == var_0_4.logged_off then
		self:_goWrong("logged_off", arg_35_1)
	end
end

function PcSDKProxy:login()
	return
end

function PcSDKProxy:getTokenData()
	return self._tokenData or {}
end

function PcSDKProxy:getToken()
	return (self._token or nil) and (self._token.osdk_ticket or "")
end

function PcSDKProxy:getAccount()
	return (self._tokenData or nil) and (self._tokenData.user_id or "")
end

function PcSDKProxy:getSdkAccount()
	return (self._tokenData or nil) and (self._tokenData.osdk_user_id or "")
end

function PcSDKProxy:getDeviceId()
	return (self._deviceInfo or nil) and (self._deviceInfo.device_id or "")
end

function PcSDKProxy:checkVerifiedInfo()
	self:requestAntiAddict()
end

function PcSDKProxy:_getSDKUserInfo()
	if g.core.model.User:getId() ~= 0 then
		local var_43_0 = {
			level = tostring(g.core.model.User:getLevel()),
			role_id = string.format("%d", g.core.model.User:getId()),
			role_name = g.core.model.User:getName()
		}

		var_43_0.server_id = tostring(g.core.platform.ServerListProxy:getSelectedServer().sid or 0)
		var_43_0.vip_grade = tostring(g.core.model.User:getVipLevel())

		return var_43_0
	end

	return nil
end

function PcSDKProxy:enterGame()
	local var_44_0 = self:_getSDKUserInfo()

	if var_44_0 then
		var_44_0.roleLoginTime = tostring(g.core.common.ServerTime:getTime())

		self:requestEnterGame(var_44_0)
	end
end

function PcSDKProxy:createRole()
	local var_45_0 = self:_getSDKUserInfo()

	if var_45_0 then
		var_45_0.roleCreateTime = tostring(g.core.model.User:getCreateTime())

		self:requestCreateRole(var_45_0)
	end
end

function PcSDKProxy:levelUp(arg_46_1)
	local var_46_0 = self:_getSDKUserInfo()

	if var_46_0 and not arg_46_1 then
		var_46_0.roleUpdateTime = tostring(g.core.common.ServerTime:getTime())

		self:requestUpdateRole(var_46_0)
	end
end

function PcSDKProxy:getClientData()
	local var_47_0 = {
		device_tp = "windows",
		spare_one = "",
		country = "Japan",
		model = "pc",
		bundle_id = "dmm_pc",
		version = tostring(self:getVersion())
	}

	var_47_0.ip = self:getTokenData().ip or self:getClientIp()

	if self._deviceInfo then
		var_47_0.device = self._deviceInfo.device_name or ""
	end

	if self._deviceInfo then
		var_47_0.device_os = self._deviceInfo.os or ""
	end

	var_47_0.device_id = tostring(self:getDeviceId())

	if self._deviceInfo then
		var_47_0.language = self._deviceInfo.language or ""
	end

	var_47_0.timestamp = g.core.common.ServerTime:getTime()
	var_47_0.op_id = self:getOpId()

	local var_47_1 = os.time()

	var_47_0.time_zone = string.format("GMT+%s", tostring(os.difftime(var_47_1, os.time(os.date("!*t", var_47_1))) / 3600))

	return var_47_0
end

function PcSDKProxy:startStatsData(arg_48_1, arg_48_2, arg_48_3)
	if self._base_info_map == nil then
		return
	end

	local var_48_0 = g.core.model.User
	local var_48_1 = g.core.platform.ServerListProxy:getCurServer() or {}
	local var_48_2 = {
		desc = "pc_clientreport",
		event_label = "pc_clientreport",
		event_id = tostring(arg_48_1)
	}
	local var_48_3 = self._tokenData or {}
	local var_48_4 = {
		server_type = 2,
		role_type = 2,
		ad_user = 2,
		gameid = self:getGameId(),
		account = var_48_3.osdk_user_id
	}

	var_48_4.server_id = var_48_1.id or ""
	var_48_4.extra_event_id = arg_48_1
	var_48_4.opid = self:getOpId()
	var_48_4.opgameid = self:getOpGameId()
	var_48_4.role_id = string.format("%d", var_48_0:getId())
	var_48_4.role_name = var_48_0:getName()
	var_48_4.level = var_48_0:getLevel()
	var_48_4.client_ip = var_48_3.ip
	var_48_4.role_regtime = var_48_0:getCreateTime()
	var_48_4.role_power = var_48_0:getFightValue()
	var_48_4.vip_level = var_48_0:getVipLevel()
	var_48_2.extra = var_48_4

	self:requestReport(var_48_2)
end

function PcSDKProxy:getGameId()
	if self._base_info_map then
		return var_0_0(self._base_info_map).yz_game_id
	end

	return PcSDKProxy.super.getGameId(self)
end

function PcSDKProxy:getOpGameId()
	if self._base_info_map then
		return var_0_0(self._base_info_map).opgameid
	end

	return PcSDKProxy.super.getOpGameId(self)
end

function PcSDKProxy:getOpId()
	if self._base_info_map then
		return var_0_0(self._base_info_map).opid
	end

	return PcSDKProxy.super.getOpId(self)
end

function PcSDKProxy:getOpenKey()
	if self._base_info_map then
		return var_0_0(self._base_info_map).openkey
	end

	return ""
end

function PcSDKProxy:getPf()
	if self._base_info_map then
		return var_0_0(self._base_info_map).pf
	end

	return ""
end

function PcSDKProxy:reqServerList(arg_54_1)
	if not config.SERVER_JSON_ENABLED then
		self:requestQueryServers(arg_54_1)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_SERVER_LIST)
	end
end

function PcSDKProxy:reqAccountServer()
	if not self:isLogined() then
		return
	end

	PcSDKProxy.super.reqAccountServer(self, true)
end

function PcSDKProxy:pay(arg_56_1, arg_56_2, arg_56_3, arg_56_4, arg_56_5, arg_56_6, arg_56_7, arg_56_8)
	arg_56_8 = arg_56_8 or {}
	arg_56_8.goodsurl = "https://cdn-wx-studio.gtarcade.com/product-2013005/cdn1/res/icon_128/51.png"

	local var_56_0 = g.core.platform.ServerListProxy:getSelectedServer()

	if self:isDmmPC() then
		arg_56_1 = string.format("%d", arg_56_1)
	end

	local var_56_2 = {
		amount = tostring(arg_56_1),
		currency = (g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].RECHARGE_CURRENCY or nil) and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].RECHARGE_CURRENCY
	}

	var_56_2.server_id = tostring(var_56_0.sid or 0)
	var_56_2.product_id = tostring(arg_56_2)
	var_56_2.product_name = string.gsub(arg_56_3, "%s+", "")
	var_56_2.game_role_id = string.format("%d", g.core.model.User:getId())
	var_56_2.game_role_name = g.core.model.User:getName()
	var_56_2.server_name = var_56_0.name
	var_56_2.custom_data = var_0_1(arg_56_8)

	self:requestPay(var_56_2)
end

function PcSDKProxy:openPrivPolicy()
	self:openWebView((self:_getPrivPolicyUrl()))
end

function PcSDKProxy:openUserService()
	self:openWebView((self:_getUserServiceUrl()))
end

function PcSDKProxy:openWebViewWithoutUser(arg_59_1)
	arg_59_1 = arg_59_1 .. self:getLinkParams()

	self:openWebView(arg_59_1)
end

function PcSDKProxy:openWebView(arg_60_1, arg_60_2)
	if type(arg_60_1) == "table" then
		self:requestOpenUrl(arg_60_1, arg_60_2)
	else
		self:requestOpenUrl({
			url = arg_60_1
		}, arg_60_2)
	end
end

function PcSDKProxy:openURL(arg_61_1)
	self:openWebView(arg_61_1)
end

function PcSDKProxy:shareGame(arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5, arg_62_6)
	g.core.module.ModuleManager:tip(g.core.lang:get(100536))
end

function PcSDKProxy:hasCustomerService()
	return true
end

function PcSDKProxy:openCustomerService()
	self:openURL(({
		["2942"] = "https://support.gtarcade.com/search/choose-form?gid=2013002",
		["3166"] = "https://dmg.ekokari.jp/main/news?id=7015860"
	})[self:getOpId()] or "https://echocalypse.gtarcade.com/en/main")
end

function PcSDKProxy:accountInfoJson()
	return
end

function PcSDKProxy:showAccountLinkJson(arg_66_1)
	({}).bindType = arg_66_1

	g.core.module.ModuleManager:tip(g.core.lang:get(100536))
end

function PcSDKProxy:restartGame()
	self:requestAction((var_0_1({
		action = var_0_3.restart
	})))
end

function PcSDKProxy:getClientIp()
	local var_68_0 = io.popen("ipconfig")

	var_68_0:close()

	return var_68_0:read("*a"):match("IPv4.-%s+: (%d+%.%d+%.%d+%.%d+)") or ""
end

return PcSDKProxy
