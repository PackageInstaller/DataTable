local PlatformProxy = class("PlatformProxy")

require("cocos.cocos2d.base64")

local NativeCallUtils = require("app.core.platform.NativeCallUtils")
local var_0_3 = json.decode
local var_0_4 = json.encode
local ChannelConst = require("app.core.platform.const.ChannelConst")

function PlatformProxy:ctor()
	self._antiLogout = false
	self._isLogined = false
	self._account = nil
	self._curPatchMd5 = ""
	self._osdkId = ""
	self._initTest = true
	self._hasRecharge = nil
	self._barInfo = nil
	self.is_fcm = ""
	self.fcm_status = ""
	self.is_warning = ""
	self._flrState = ""

	require("app.core.platform.PlatformProxyExLogic").setExtLogic(self)
end

function PlatformProxy:init()
	if not device.isSdkEnabled() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_INIT_SUCCESS, false)
	end

	local var_2_0 = cc.Director:getInstance():getEventDispatcher()

	var_2_0:removeCustomEventListeners("APP_ENTER_FOREGROUND_EVENT")

	local var_2_1 = g.view.entrance

	var_2_0:addEventListenerWithFixedPriority(cc.EventListenerCustom:create("APP_ENTER_FOREGROUND_EVENT", function()
		local var_3_0 = g.core.module.ModuleManager:getCurRootModule()

		if var_3_0 ~= var_2_1.LOGIN and var_3_0 ~= var_2_1.CREATE and not g.core.network.GameNetProxy:isConnected() then
			g.core.network.GameNetProxy:closeManually()

			local var_3_1 = g.core.platform.ServerListProxy:getSelectedServer()

			g.core.network.GameNetProxy:connect(var_3_1.address, var_3_1.port)
		end
	end), 1)

	return true
end

function PlatformProxy:isInitSdkOK()
	return true
end

function PlatformProxy:setHasRecharge(arg_5_1)
	if self._hasRecharge == nil then
		self._hasRecharge = arg_5_1
	end
end

function PlatformProxy:getHasRecharge()
	return self._hasRecharge
end

function PlatformProxy:fixHasRecharge()
	self._hasRecharge = true
end

function PlatformProxy:isLogined()
	return self._isLogined
end

function PlatformProxy:setAntiLogoutFlag(arg_9_1)
	self._antiLogout = arg_9_1
end

function PlatformProxy:isAntiLogout()
	return self._antiLogout
end

function PlatformProxy:setAccount(arg_11_1)
	self._account = arg_11_1
	self._isLogined = true

	g.core.common.Storage:save("account.json", {
		account = arg_11_1
	}, false)
	self:_updateTokenServer()
end

function PlatformProxy:resetLogin()
	self._isLogined = false
	self._account = nil
end

function PlatformProxy:login()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGIN_ACCOUNT_START)
end

function PlatformProxy:onLogin(arg_14_1)
	self:setAccount(arg_14_1)

	if device.isOHOS() then
		g.core.platform.ServerListProxy:setMergeServerList({}, 0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGIN_ACCOUNT_FINISH, false, arg_14_1)
end

function PlatformProxy:logout()
	self:onLogout()
end

function PlatformProxy:onLogout()
	self._account = nil
	self._isLogined = false
	self._antiLogout = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGOUT_ACCOUNT)
end

function PlatformProxy:getAccount()
	if not self._account then
		local var_17_0 = g.core.common.Storage:load("account.json", false)

		if var_17_0 then
			self._account = var_17_0.account or ""
		end

		if self._account ~= "" then
			self._isLogined = true
		end

		self:_updateTokenServer()
	end

	return self._account
end

function PlatformProxy:_updateTokenServer()
	local var_18_0 = self:getAccount()
	local var_18_1, var_18_2 = self:isLoginTokenCode(self._account)

	if var_18_1 and var_18_2 and var_18_2.sid then
		local var_18_3 = var_18_2.sid

		var_18_2.sid = nil
		self._account = to_base64(json.encode(var_18_2))

		if config.GS_VERSION and not self._data then
			self._data = require("app.core.platform.SuperSdkData").new()

			self._data:initWithTicket(self._account)
		end

		local var_18_4 = g.core.platform.ServerListProxy

		if self:isChannelOfChina() then
			var_18_4:updateServerList()
		end

		if not g.core.platform.ServerListProxy:getServerBySid(var_18_2.sid) then
			local var_18_5 = string.split(var_18_2.extend, "|")

			if #var_18_5 < 3 then
				return
			end

			local var_18_8, var_18_9

			if self:isChannelOfChina() then
				local var_18_6 = tonumber(string.sub(var_18_2.sid, 1, 4))
				local var_18_7 = 0

				for iter_18_0, iter_18_1 in pairs(ChannelConst.ValueConst[self:getGameId()]) do
					for iter_18_2, iter_18_3 in pairs(iter_18_1) do
						if var_18_6 == iter_18_2 then
							var_18_7 = iter_18_0

							break
						end
					end

					if var_18_7 ~= 0 then
						break
					end
				end

				var_18_5[1] = var_18_7
				var_18_5[3] = var_18_6
				var_18_2.extend = table.concat(var_18_5, "|")
				var_18_8 = require("app.core.network.HttpRequest").new
				var_18_9 = self:_getGssfUrl(var_18_2.sid, var_18_2)
			end

			require("app.core.network.HttpRequest"):new(nil, {
				success = function(self)
					self = json.decode(self)

					if self.data and #self.data > 0 then
						var_18_4:setServerList(self.data)
						var_18_4:setSelectedServer(var_18_3)
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_SERVER_LIST)
					end
				end,
				fail = function(arg_20_0, arg_20_1)
					print("errmsg:" .. json.encode(arg_20_1))
				end
			}):send()
		else
			local var_18_10, var_18_11 = var_18_4:getServerById(tonumber(var_18_2.sid))

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_LOCAL_CHOOSE_SERVER, false, var_18_10, var_18_11)
		end
	elseif config.GS_VERSION then
		self._account = nil
		self._isLogined = false

		g.core.module.ModuleManager:tip("wrong account")
	end
end

function PlatformProxy:_getGssfUrl(arg_21_1, arg_21_2)
	local var_21_0 = string.split(arg_21_2.extend, "|")

	return (g.core.lang:getByString((not self:isChannelOfChina() or nil) and "https://gssf.gtarcade.com/server/queryAppointServer?gameId=#gameId#&appId=#gameId#.gtarcade.com&opId=#opId#&opgameId=#opgameId#&serverIds=[#sid#]&columns=[\"gateway_domain\",\"gateway_port\"]", {
		gameId = var_21_0[2],
		opId = var_21_0[1],
		opgameId = var_21_0[3],
		sid = arg_21_1
	}))
end

function PlatformProxy:getSdkUserId()
	local var_22_0 = self:getAccount()
	local var_22_1, var_22_2 = self:isLoginTokenCode(var_22_0)

	if var_22_1 then
		var_22_0 = var_22_2.osdk_user_id
	end

	return var_22_0
end

local function var_0_6(arg_23_0)
	return string.gsub(arg_23_0, "([\"']?user_id[\"']?%s*:%s*)(%d+)", "%1\"%2\"")
end

function PlatformProxy:isLoginTokenCode(arg_24_1)
	if string.len(arg_24_1) > 50 then
		local var_24_0 = json.decode((var_0_6((from_base64(arg_24_1)))))

		if type(var_24_0) == "table" then
			return true, var_24_0
		end
	end

	return false
end

function PlatformProxy:getSdkAccount()
	return self:getAccount()
end

function PlatformProxy:getTokenData()
	return nil
end

function PlatformProxy:getToken()
	local var_27_0
	local var_27_1 = self:getAccount()

	xpcall(function()
		assert((self:isLoginTokenCode(var_27_1)))

		var_27_0 = var_27_1
	end, function()
		local var_29_0 = {}

		var_29_0.account_system_id = "1_"
		var_29_0.osdk_game_id = "196377847"
		var_29_0.user_id = string.urlencode(var_27_1)
		var_29_0.time = os.time()
		var_29_0.osdk_user_id = "1_" .. var_27_1
		var_29_0.extend = string.format("%s|%s|%s", self:getOpId(), self:getGameId(), self:getOpGameId())
		var_29_0.channel_id = "1"

		local var_29_1 = {}

		for iter_29_0 in pairs(var_29_0) do
			var_29_1[#var_29_1 + 1] = iter_29_0
		end

		table.sort(var_29_1)

		local var_29_2 = ""

		for iter_29_1 = 1, #var_29_1 do
			var_29_2 = iter_29_1 == #var_29_1 and var_29_2 .. var_29_1[iter_29_1] .. "=" .. var_29_0[var_29_1[iter_29_1]] or var_29_2 .. var_29_1[iter_29_1] .. "=" .. var_29_0[var_29_1[iter_29_1]] .. "&"
		end

		print("signStr = " .. var_29_2 .. config.GAME_SECRET)

		var_29_0.sign = (function(arg_30_0)
			local md5 = require("cocos.framework.extends.md5")
			local var_30_1 = md5.new()

			var_30_1:update(arg_30_0)

			return md5.tohex(var_30_1:finish())
		end)(var_29_2 .. config.GAME_SECRET)
		var_27_0 = to_base64(json.encode(var_29_0))

		print("osdk_ticket = " .. var_27_0)
	end)

	return nil or ""
end

function PlatformProxy:_getLanKey()
	local var_31_0 = require("app.core.lang.MultilingualMgr"):getUseLang()
	local var_31_1 = "en-us"

	if var_31_0 == "cn" or self:isChannelOfChina() then
		var_31_1 = "zh-cn"
	elseif var_31_0 == "tw" then
		var_31_1 = "zh-zh"
	elseif var_31_0 == "jp" then
		var_31_1 = "jp-jp"
	elseif var_31_0 == "en" then
		var_31_1 = "en-us"
	elseif var_31_0 == "id" then
		var_31_1 = "id-id"
	elseif var_31_0 == "th" then
		var_31_1 = "th-th"
	elseif var_31_0 == "fr" then
		var_31_1 = "fr-fr"
	elseif var_31_0 == "es" then
		var_31_1 = "es-es"
	elseif var_31_0 == "de" then
		var_31_1 = "de-de"
	elseif var_31_0 == "pt" then
		var_31_1 = "pt-pt"
	elseif var_31_0 == "ru" then
		var_31_1 = "ru-ru"
	elseif var_31_0 == "kr" then
		var_31_1 = "kr-kr"
	end

	return var_31_1
end

function PlatformProxy:_getPaperKey()
	return ({
		"NVpqolIxP9Yt3dHY",
		"3JHj8HCFdLSUU7Vg",
		"thUJ3YkSAEP7GAqs",
		"6CbaeDjpEuaClhSK",
		"zjygyQUTBuoUxtdA",
		"vCNiKbmZHPgEK1sc"
	})[config.PUBLISH_REGION]
end

function PlatformProxy:_getPaperAPPID()
	return ({
		96,
		81,
		82,
		91,
		94,
		104
	})[config.PUBLISH_REGION]
end

function PlatformProxy:_getPaperParam()
	return {
		lang_key = self:_getLanKey(),
		app_id = self:_getPaperAPPID(),
		APP_KEY = self:_getPaperKey()
	}
end

function PlatformProxy:openPaperUrl(arg_35_1, arg_35_2)
	local var_35_0 = g.core.platform.ServerListProxy:getSelectedServer()
	local var_35_1 = self:_getPaperParam()

	release_print("the config param is : " .. var_0_4(var_35_1))

	local var_35_2 = {
		app_id = var_35_1.app_id,
		qn_id = arg_35_2,
		server_id = var_35_0.sid,
		server_name = var_35_0.name,
		role_id = g.core.model.User:getId(),
		role_name = g.core.model.User:getName(),
		timeline = os.time(),
		lang_key = var_35_1.lang_key
	}

	local function var_35_3(arg_36_0)
		local var_36_0 = {}

		for iter_36_0 in pairs(var_35_2) do
			var_36_0[#var_36_0 + 1] = iter_36_0
		end

		if arg_36_0 then
			table.sort(var_36_0)
		end

		local var_36_1 = ""

		for iter_36_1 = 1, #var_36_0 do
			var_36_1 = iter_36_1 == #var_36_0 and var_36_1 .. var_36_0[iter_36_1] .. "=" .. var_35_2[var_36_0[iter_36_1]] or var_36_1 .. var_36_0[iter_36_1] .. "=" .. var_35_2[var_36_0[iter_36_1]] .. "&"
		end

		return var_36_1
	end

	var_35_2.sign = (function(arg_37_0)
		local md5 = require("cocos.framework.extends.md5")
		local var_37_1 = md5.new()

		var_37_1:update(arg_37_0)

		return md5.tohex(var_37_1:finish())
	end)(var_35_3(true) .. var_35_1.APP_KEY)

	release_print("the url param is : " .. var_0_4(var_35_2))

	local var_35_4 = ("https://" .. arg_35_1 .. "?data=") .. string.urlencode(to_base64((var_35_3())))

	release_print(var_35_4)

	if device.isSdkEnabled() then
		self:openWebView(var_35_4)
	else
		self:openURL(var_35_4)
	end
end

function PlatformProxy:openURL(arg_38_1)
	NativeCallUtils.call("openURL", {
		{
			url = arg_38_1
		}
	})
end

function PlatformProxy:initNoticeSdk()
	NativeCallUtils.call("initNoticeSdk", {
		{
			appId = "14"
		},
		{
			appKey = "YwmeGOHVEoGfkRmduNWbXeokoMNQNUUs"
		},
		{
			gameId = "360"
		},
		{
			opId = (device.isIOS() or nil) and "2107"
		}
	}, "void")
end

function PlatformProxy:showPreAuto()
	NativeCallUtils.call("showPreAuto", nil, "void")
end

function PlatformProxy:showPreByUser()
	NativeCallUtils.call("showPreByUser", nil, "void")
end

function PlatformProxy:showImageNotice()
	NativeCallUtils.call("showImageNotice", nil, "void")
end

function PlatformProxy:getDeviceId()
	return ""
end

function PlatformProxy:getLanguage()
	return self:getSingleLanguage()
end

function PlatformProxy:getSingleLanguage()
	local var_45_0 = cc.Application:getInstance():getCurrentLanguage()

	g.core.log:info("current language is " .. var_45_0)

	var_45_0 = var_45_0 == cc.LANGUAGE_CHINESE and "zh" or var_45_0 == cc.LANGUAGE_JAPANESE and "ja" or var_45_0 == cc.LANGUAGE_KOREAN and "kr" or var_45_0 == cc.LANGUAGE_FRENCH and "fr" or var_45_0 == cc.LANGUAGE_SPANISH and "es" or var_45_0 == cc.LANGUAGE_GERMAN and "de" or var_45_0 == cc.LANGUAGE_PORTUGUESE and "pt" or var_45_0 == cc.LANGUAGE_RUSSIAN and "ru" or "en"

	return var_45_0
end

function PlatformProxy:hasUserCenter()
	return false
end

function PlatformProxy:openUserCenter()
	return
end

function PlatformProxy:autheInfoJson()
	return
end

function PlatformProxy:showAuthennticationView()
	return
end

function PlatformProxy:openPayProtocol()
	return
end

function PlatformProxy:hasCustomerService()
	return false
end

function PlatformProxy:openCustomerService()
	return
end

function PlatformProxy:getPrivateSpaceInfo()
	return
end

function PlatformProxy:openSystemBrowser()
	return
end

function PlatformProxy:hasForum()
	return false
end

function PlatformProxy:openForum()
	return
end

function PlatformProxy:getProductsInfo()
	return
end

function PlatformProxy:getProductDetails()
	return
end

function PlatformProxy:sendAdvBigRecharge()
	return
end

function PlatformProxy:sendAdvExit()
	return
end

function PlatformProxy:sendAdvStoreOpened()
	return
end

function PlatformProxy:sendAdvPayInciated()
	return
end

function PlatformProxy:sendAdvPayCompleted()
	return
end

function PlatformProxy:sendAdvStartUpdate()
	return
end

function PlatformProxy:sendAdvUpdateDone()
	return
end

function PlatformProxy:sendAdvSplashScreen()
	return
end

function PlatformProxy:sendAdvGameStart()
	return
end

function PlatformProxy:sendAdvVideoFinished()
	return
end

function PlatformProxy:sendAdvGuideCompleted()
	return
end

function PlatformProxy:sendAdvFirstGuildJoin()
	return
end

function PlatformProxy:sendAdvVip()
	return
end

function PlatformProxy:sendAdvLogin()
	return
end

function PlatformProxy:accountInfo()
	return
end

function PlatformProxy:showAccountLink(arg_74_1)
	return
end

function PlatformProxy:isIphoneX()
	if device.isWindows() then
		return false
	else
		return NativeCallUtils.call("isIphoneX", nil, "boolean")
	end
end

function PlatformProxy:hasNetwork()
	if device.isWindows() then
		return true
	else
		return NativeCallUtils.call("hasNetwork", nil, "boolean")
	end
end

function PlatformProxy:getNetworkState()
	if device.isWindows() then
		return "1"
	else
		return tostring((NativeCallUtils.call("getNetworkState", nil, "int")))
	end
end

function PlatformProxy:isWIFIState()
	if config.PCSDK_ENABLED then
		return false
	end

	return self:getNetworkState() == "1"
end

function PlatformProxy:getGameId()
	return config.SPECIFIC_GAME_ID
end

function PlatformProxy:getOpGameId()
	return config.SPECIFIC_OP_GAME_ID
end

function PlatformProxy:getOpId()
	return config.SPECIFIC_OP_ID
end

function PlatformProxy:getCollectionData()
	return
end

function PlatformProxy:getClientData()
	local var_83_0 = {}

	var_83_0.ip = "61.174.15.229"
	var_83_0.version = "0"
	var_83_0.op_id = self:getOpId()

	return var_83_0
end

function PlatformProxy:startStatsData(arg_84_1)
	return
end

function PlatformProxy:getVersion()
	return (g.core.common.Storage:load("upgrade_config.json", false) or {}).local_version or g.core.utils.Tools.getSilentObbVersion(), config.GAME_VERSION_NO
end

function PlatformProxy:openLoginPage()
	return
end

function PlatformProxy:openHomePage()
	return
end

function PlatformProxy:enterGame()
	return
end

function PlatformProxy:createRole()
	return
end

function PlatformProxy:levelUp()
	return
end

function PlatformProxy:openPrivPolicy()
	return
end

function PlatformProxy:openUserService()
	return
end

function PlatformProxy:checkVerifiedInfo()
	return
end

function PlatformProxy:openWebView()
	if self._initTest then
		NativeCallUtils.call("setAutoOrientation")
	else
		NativeCallUtils.call("setLandOrientation")
	end

	self._initTest = not self._initTest
end

function PlatformProxy:addLocalFoodSchedule()
	return
end

function PlatformProxy:removeLocalFoodSchedule()
	return
end

function PlatformProxy:setLocalFoodScheduleEnabled()
	return
end

function PlatformProxy:addLocalVitFullSchedule()
	return
end

function PlatformProxy:removeLocalVitFullSchedule()
	return
end

function PlatformProxy:setLocalVitFullScheduleEnabled()
	return
end

function PlatformProxy:addLocalStormSchedule()
	return
end

function PlatformProxy:removeLocalStormSchedule()
	return
end

function PlatformProxy:setLocalStormScheduleEnabled()
	return
end

function PlatformProxy:addLocalMineSchedule()
	return
end

function PlatformProxy:removeLocalMineSchedule()
	return
end

function PlatformProxy:setLocalMineScheduleEnabled()
	return
end

function PlatformProxy:pay()
	return
end

function PlatformProxy:addSchedule()
	return
end

function PlatformProxy:removeSchedule()
	return
end

function PlatformProxy:exit()
	return
end

function PlatformProxy:reqServerList()
	return
end

function PlatformProxy:reqAccountServer(arg_112_1)
	if not device.isSdkEnabled() then
		return
	end

	local var_112_0 = self:getSdkAccount()

	require("app.core.network.HttpRequest").new(config.ACCOUNT_SERVER_URL .. "/account?uuid=" .. var_112_0 .. "&opgameid=" .. self:getOpGameId(), nil, {
		success = function(self)
			self = var_0_3(self)

			if self and type(self) == "table" then
				g.core.platform.ServerListProxy:setMyServerList(var_112_0, self.data)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SDK_GET_MY_SERVER_LIST)

			if not arg_112_1 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = g.core.const.ConstMgr.SuperSdkConst.GET_ACCOUNT_SERVER_SUCCESS
				})
			end
		end,
		fail = function(arg_114_0, arg_114_1)
			if not arg_112_1 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = g.core.const.ConstMgr.SuperSdkConst.GET_ACCOUNT_SERVER_ERROR,
					errMsg = var_0_4(arg_114_1)
				})
			end
		end
	}):send()
end

function PlatformProxy:initIM()
	return
end

function PlatformProxy:imLogout()
	return
end

function PlatformProxy:imJoinRoom()
	return
end

function PlatformProxy:imLeaveRoom()
	return
end

function PlatformProxy:imStartMessage()
	return
end

function PlatformProxy:imSendMessage()
	return
end

function PlatformProxy:imCancelMessage()
	return
end

function PlatformProxy:imPlayAudio()
	return
end

function PlatformProxy:imStopAudio()
	return
end

function PlatformProxy:cafeStartHome()
	return
end

function PlatformProxy:shareGame()
	return
end

function PlatformProxy:showGuest()
	return
end

function PlatformProxy:sendOpenRecharge()
	return
end

function PlatformProxy:sendClikToPay()
	return
end

function PlatformProxy:checkFCM()
	if not device.isSdkEnabled() then
		return
	end

	if self.is_fcm == "1" then
		local function var_129_0()
			cc.Director:getInstance():endToLua()
		end

		local var_129_1 = ""

		if self.fcm_status == "1" then
			var_129_1 = g.core.lang:get(1158)
		elseif self.fcm_status == "2" then
			var_129_1 = g.core.lang:get(1131)
		elseif self.fcm_status == "3" then
			var_129_1 = g.core.lang:get(1219)
		elseif self.fcm_status == "4" then
			var_129_1 = g.core.lang:get(1214)
		end

		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			type = 1,
			text = var_129_1,
			text_cancel = g.core.lang:get(1067),
			handler_cancel = function()
				var_129_0()
			end
		})))
	elseif self.is_warning == "1" then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			type = 1,
			text = g.core.lang:get(1217),
			text_cancel = g.core.lang:get(1067)
		})))
	end
end

function PlatformProxy:HttpGet(arg_132_1, arg_132_2)
	local var_132_0 = cc.XMLHttpRequest:new()

	var_132_0.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	var_132_0:open("GET", self)
	var_132_0:registerScriptHandler(function(arg_133_0)
		if var_132_0.readyState == 4 then
			if var_132_0.status == 200 then
				if arg_132_1 then
					arg_132_1((json.decode(var_132_0.response, 1)))
				end
			elseif arg_132_2 then
				arg_132_2({
					status = var_132_0.status
				})
			end
		elseif arg_132_2 then
			arg_132_2({
				readyState = var_132_0.readyState
			})
		end
	end)
	var_132_0:send()

	return var_132_0
end

function PlatformProxy:getHttpPostSign(arg_134_1, arg_134_2)
	local var_134_0 = clone(arg_134_1)
	local var_134_1 = {}

	for iter_134_0, iter_134_1 in pairs(var_134_0) do
		var_134_1[#var_134_1 + 1] = iter_134_0
	end

	table.sort(var_134_1)

	local var_134_2 = ""

	for iter_134_2 = 1, #var_134_1 do
		var_134_2 = iter_134_2 < #var_134_1 and var_134_2 .. var_134_1[iter_134_2] .. "=" .. string.urlencode(var_134_0[var_134_1[iter_134_2]]) .. "&" or var_134_2 .. var_134_1[iter_134_2] .. "=" .. string.urlencode(var_134_0[var_134_1[iter_134_2]])
	end

	local md5 = require("cocos.framework.extends.md5")
	local var_134_4 = md5.new()

	var_134_4:update(var_134_2 .. arg_134_2)

	return (md5.tohex(var_134_4:finish()))
end

function PlatformProxy:HttpPost(arg_135_1, arg_135_2, arg_135_3, arg_135_4)
	local function var_135_0(arg_136_0)
		if type(arg_136_0) ~= "table" then
			return nil
		end

		local var_136_0 = {}

		for iter_136_0, iter_136_1 in pairs(arg_136_0) do
			table.insert(var_136_0, iter_136_0 .. "=" .. iter_136_1)
		end

		local var_136_1 = ""

		for iter_136_2 = 1, #var_136_0 do
			var_136_1 = var_136_1 .. tostring(var_136_0[iter_136_2])

			if iter_136_2 < #var_136_0 then
				var_136_1 = var_136_1 .. "&&"
			end
		end

		return var_136_1
	end

	local var_135_1 = cc.XMLHttpRequest:new()

	var_135_1.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON

	var_135_1:open("POST", arg_135_1)
	var_135_1:registerScriptHandler(function(arg_137_0)
		if var_135_1.readyState == 4 then
			if var_135_1.status == 200 then
				if arg_135_3 then
					arg_135_3((json.decode(var_135_1.response, 1)))
				end
			elseif arg_135_4 then
				arg_135_4(var_135_1.status)
			end
		elseif arg_135_4 then
			arg_135_4(var_135_1.readyState)
		end
	end)

	local var_135_2 = var_135_0(arg_135_2)

	var_135_1:send(var_135_0(arg_135_2))

	return var_135_1
end

function PlatformProxy:_updatePatchMd5(arg_138_1)
	if arg_138_1 then
		local var_138_0 = arg_138_1.config or {}

		if var_138_0 then
			local var_138_1 = var_138_0.patchCode or ""

			if var_138_1 and var_138_1 ~= "" then
				self._curPatchMd5 = var_138_0.md5 or ""

				local var_138_2, var_138_3 = require("app.core.patch.PatchProxy"):createPatch(var_138_1, self:getCurrentVersion())

				if var_138_2 then
					var_138_2:applyPatch()

					if not var_138_2:onFetchConfigFinish() then
						return
					end
				elseif var_138_3 then
					g.core.platform.BuglyProxy:error(var_138_3)
				end
			end
		end
	end
end

function PlatformProxy:resetPatchMd5()
	self._curPatchMd5 = ""
end

function PlatformProxy:getPatchUrl(arg_140_1)
	if not config.PATCH_URL_ENABLED then
		return config.UPGRADE_URL_TEST .. "?t=" .. os.time()
	end

	if g.core.const.ConstMgr.PlatformConst.REGION.CHINA ~= config.PUBLISH_REGION then
		return config.PLATFORM_PATCH_URL
	end

	local var_140_0 = {
		config.PLATFORM_PATCH_URL,
		config.PLATFORM_PATCH_URL,
		config.PLATFORM_PATCH_URL,
		"https://version-cjgame.uuzuonline.net",
		"https://version-cjgame.uuzuonline.net",
		"https://version-cjgame.uuzuonline.net",
		"http://101.34.61.52",
		"http://101.34.61.52",
		"http://110.40.141.77",
		"http://110.40.141.77"
	}

	arg_140_1 = arg_140_1 or 1

	if arg_140_1 <= 0 or arg_140_1 > #var_140_0 then
		arg_140_1 = 1
	end

	return var_140_0[arg_140_1]
end

function PlatformProxy:requestPlatformConfig(arg_141_1, arg_141_2, arg_141_3)
	self._urlIndex = self._urlIndex or 1

	local var_141_0 = config.UPGRADE_URL_TEST .. "?t=" .. os.time()

	if config.PATCH_URL_ENABLED then
		var_141_0 = self:getPatchUrl(self._urlIndex) .. "/opinfo?opGameId=#opgameid#&opId=#opid#&channel=#channelid#&md5=#md5#"

		local var_141_1 = self:getGameId()
		local var_141_2 = config.SPECIFIC_CHANNEL_ID or 0

		var_141_0 = g.core.lang:getByString(var_141_0, {
			opgameid = self:getOpGameId(),
			opid = self:getOpId(),
			channelid = var_141_2,
			md5 = self._curPatchMd5
		})
	end

	g.core.platform.BuglyProxy:removeUserValue("version_url")
	g.core.platform.BuglyProxy:addUserValue("version_url", var_141_0)

	self._reqUrlSuccFunc = arg_141_2
	self._reqUrlFailFunc = arg_141_3

	PlatformProxy.HttpGet(var_141_0, handler(self, self._handleFetchURLOK), handler(self, self._handleFetchURLErr))
end

function PlatformProxy:_handleFetchURLOK(arg_142_1)
	self._urlIndex = 1

	if not arg_142_1 then
		return
	end

	self:_updatePatchMd5(arg_142_1)

	if arg_142_1.config then
		g.core.platform.ServerListProxy:updateServerInfo(arg_142_1.config)
	end

	if type(self._reqUrlSuccFunc) == "function" then
		self._reqUrlSuccFunc(arg_142_1)
	end
end

function PlatformProxy:_handleFetchURLErr(arg_143_1)
	if config.PATCH_URL_ENABLED and g.core.const.ConstMgr.PlatformConst.REGION.CHINA == config.PUBLISH_REGION then
		self._urlIndex = self._urlIndex + 1

		if self._urlIndex < 11 then
			self:requestPlatformConfig(nil, self._reqUrlSuccFunc, self._reqUrlFailFunc)

			return
		end
	end

	if type(self._reqUrlFailFunc) == "function" then
		self._reqUrlFailFunc(arg_143_1)
	end
end

function PlatformProxy:getCurrentVersion()
	local var_144_0 = g.core.common.Storage:load("upgrade_config.json", false) or {}
	local var_144_1 = g.core.utils.Tools.getSilentObbVersion()
	local var_144_2 = var_144_0.local_version or var_144_1

	return var_144_2 < var_144_1 and var_144_1 or var_144_2
end

function PlatformProxy:jumpToReview()
	NativeCallUtils.call("jumpToReview", nil, "void")
end

function PlatformProxy:getExternalStorageDir()
	if not device.isAndroid() then
		return nil
	end

	return NativeCallUtils.call("getExternalStorageDir", nil, "string")
end

function PlatformProxy:getPackageStorageDir()
	if not device.isAndroid() then
		return nil
	end

	return NativeCallUtils.call("getPackageStorageDir", nil, "string")
end

function PlatformProxy:_getPrivPolicyUrl()
	return (g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] or nil) and (g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].PRIVATE_POLICY_URL or "https://m.gtarcade.com/privacy.html")
end

function PlatformProxy:_getUserServiceUrl()
	return (g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] or nil) and (g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].USER_SERVICE_URL or "https://m.gtarcade.com/terms.html")
end

function PlatformProxy:_getGameUserInfo()
	if g.core.model.User:getId() ~= 0 then
		local var_150_0 = g.core.platform.ServerListProxy:getLoginServer()
		local var_150_1 = {
			role_id = tostring(g.core.model.User:getId()),
			role_name = g.core.model.User:getName(),
			level = g.core.model.User:getLevel(),
			vip_grade = g.core.model.User:getVipLevel()
		}

		var_150_1.server_id = var_150_0.sid or 0
		var_150_1.server_name = var_150_0.name
		var_150_1.opSid = var_150_0.opSid
		var_150_1.roleCreateTime = g.core.model.User:getCreateTime()

		return var_150_1
	end

	return nil
end

function PlatformProxy:justGetLinkParamString(arg_151_1)
	local var_151_0 = g.core.platform.ServerListProxy:getSelectedServer()

	arg_151_1 = arg_151_1 or 0

	local var_151_1 = {
		game_id = self:getGameId(),
		account = self:getAccount(),
		op_id = self:getOpId(),
		opgame_id = self:getOpGameId(),
		act_id = tostring(arg_151_1),
		server_id = var_151_0.id,
		server_name = var_151_0.name,
		role_id = g.core.model.User:getId(),
		role_name = g.core.model.User:getName(),
		sign_time = os.time(),
		source_uuid = self:getSdkAccount(),
		lang_key = self:_getLanKey()
	}
	local var_151_2 = {}

	for iter_151_0, iter_151_1 in pairs(var_151_1) do
		var_151_2[#var_151_2 + 1] = iter_151_0
	end

	table.sort(var_151_2)

	local var_151_3 = "?"

	for iter_151_2 = 1, #var_151_2 do
		var_151_3 = iter_151_2 < #var_151_2 and var_151_3 .. var_151_2[iter_151_2] .. "=" .. string.urlencode(tostring(var_151_1[var_151_2[iter_151_2]])) .. "&" or var_151_3 .. var_151_2[iter_151_2] .. "=" .. string.urlencode(tostring(var_151_1[var_151_2[iter_151_2]]))
	end

	return var_151_3
end

function PlatformProxy:getLinkParams(arg_152_1)
	local var_152_0 = g.core.platform.ServerListProxy:getSelectedServer()

	arg_152_1 = arg_152_1 or 0

	local var_152_1 = {
		game_id = self:getGameId(),
		account = self:getAccount(),
		op_id = self:getOpId(),
		opgame_id = self:getOpGameId(),
		act_id = tostring(arg_152_1),
		server_id = var_152_0.id,
		server_name = var_152_0.name,
		role_id = g.core.model.User:getId(),
		role_name = g.core.model.User:getName(),
		sign_time = os.time()
	}
	local var_152_2 = {}

	for iter_152_0, iter_152_1 in pairs(var_152_1) do
		var_152_2[#var_152_2 + 1] = iter_152_0
	end

	table.sort(var_152_2)

	local var_152_3 = "?"

	for iter_152_2 = 1, #var_152_2 do
		var_152_3 = iter_152_2 < #var_152_2 and var_152_3 .. var_152_2[iter_152_2] .. "=" .. string.urlencode(var_152_1[var_152_2[iter_152_2]]) .. "&" or var_152_3 .. var_152_2[iter_152_2] .. "=" .. string.urlencode(var_152_1[var_152_2[iter_152_2]])
	end

	local md5 = require("cocos.framework.extends.md5")
	local var_152_5 = md5.new()

	var_152_5:update(var_152_3)

	return var_152_3 .. "&" .. "sign=" .. md5.tohex(var_152_5:finish())
end

function PlatformProxy:isMajia()
	if tostring((self:getOpGameId())) == "1728" then
		return true
	end

	return false
end

function PlatformProxy:copyToClipboard(arg_154_1)
	return
end

function PlatformProxy:_updateBarInfo(arg_155_1, arg_155_2, arg_155_3)
	self._barInfo = self._barInfo or {}

	if arg_155_1 then
		self._barInfo.battery = tonumber(arg_155_1)
	end

	if arg_155_2 then
		self._barInfo.netState = arg_155_2
	end

	if arg_155_3 then
		self._barInfo.time = arg_155_3
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BAR_INFO_CHANGE, false, self._barInfo)
end

function PlatformProxy:getPhoneBarInfo()
	if not self._barInfo then
		return {
			battery = 100,
			netState = 2
		}
	end

	return self._barInfo
end

function PlatformProxy:checkNewFunctionByVersion1_1_0(arg_157_1)
	return self:checkGameVersion(1010000, arg_157_1)
end

function PlatformProxy:checkNewPrivateFunction(arg_158_1)
	if device.isIOS() then
		if cc.FileUtils:getInstance():isFileExist("icon/activity/for_ios_3020006.png") or config.GAME_VERSION_NO >= 2000048 then
			return true
		end

		if arg_158_1 then
			local var_158_0 = g.core.lang:get(1246) or ""

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				singleButton = true,
				title = g.core.lang:get(111026),
				desc = var_158_0,
				onConfirm = function()
					return
				end
			}), {
				touchDisappear = true
			})
		end
	else
		return self:checkGameVersion(3076000, arg_158_1)
	end
end

function PlatformProxy:checkGameVersion(arg_160_1, arg_160_2)
	local var_160_0 = arg_160_1 <= config.GAME_VERSION_NO

	if arg_160_1 > config.GAME_VERSION_NO and arg_160_2 then
		local var_160_1 = g.core.lang:get(1246) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			singleButton = true,
			title = g.core.lang:get(111026),
			desc = var_160_1,
			onConfirm = function()
				return
			end
		}), {
			touchDisappear = true
		})
	end

	return var_160_0
end

function PlatformProxy:isDmmPC()
	if tostring((self:getOpId())) == "3166" then
		return true
	end

	return false
end

function PlatformProxy:requestRealProductsInfo(arg_163_1)
	local var_163_0 = "$"

	if self:isDmmPC() then
		var_163_0 = "Pt"
	elseif self:isChannelOfChina() then
		var_163_0 = "¥"
	elseif self:isChannelOfKr() then
		var_163_0 = "₩"
	elseif self:isChannelOfJp() then
		var_163_0 = "¥"
	end

	for iter_163_0, iter_163_1 in pairs(arg_163_1) do
		iter_163_1.moneyUnit = var_163_0
		iter_163_1.realMoney = tostring(g.core.model.User.rechargeData:getPriceByNum(iter_163_1.money_local, true))
		iter_163_1.realMoneyMicros = iter_163_1.realMoney * 1000000
	end
end

function PlatformProxy:openLogoutAccountCenter()
	return
end

function PlatformProxy:riskCheck()
	return
end

function PlatformProxy:showRiskWindow(arg_166_1)
	return
end

function PlatformProxy:accountInfoJson()
	return
end

function PlatformProxy:showAccountLinkJson(arg_168_1)
	return
end

function PlatformProxy:getAPPStoreReview()
	if not config.PCSDK_ENABLED then
		local var_169_0 = g.core.lang:get(108458) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			singleButton = true,
			title = g.core.lang:get(111026),
			desc = var_169_0
		}), {
			touchDisappear = true
		})
	end
end

function PlatformProxy:getStoreReview()
	return
end

function PlatformProxy:checkAndSendPayAdEvent(arg_171_1)
	return
end

function PlatformProxy:checkBindPhone()
	return
end

function PlatformProxy:openPhoneBindPop()
	return false
end

function PlatformProxy:checkFlrState()
	return
end

function PlatformProxy:_setFlrState(arg_175_1)
	self._flrState = arg_175_1
end

function PlatformProxy:getFlrState()
	return self._flrState
end

function PlatformProxy:isChannelOfChina()
	return tostring((self:getGameId())) == "2013001"
end

function PlatformProxy:isChannelOfKr()
	return tostring((self:getGameId())) == "2013004"
end

function PlatformProxy:isChannelOfJp()
	return tostring((self:getGameId())) == "2013005"
end

function PlatformProxy:isChannelOfKrPC()
	if not config.PCSDK_ENABLED then
		return false
	end

	return self:isChannelOfKr()
end

function PlatformProxy:isChannelOfEn()
	return tostring((self:getGameId())) == "2013002"
end

function PlatformProxy:isChannelOfEnPC()
	if not config.PCSDK_ENABLED then
		return false
	end

	return self:isChannelOfEn()
end

function PlatformProxy:hasPermission(arg_183_1)
	return NativeCallUtils.call("hasPermission", {
		{
			permission = arg_183_1
		}
	}, "boolean")
end

function PlatformProxy:requestPermission(arg_184_1, arg_184_2)
	NativeCallUtils.call("requestPermission", {
		{
			permission = arg_184_1
		},
		{
			callBack = arg_184_2
		}
	}, "void")
end

function PlatformProxy:jumpToAppPermission()
	if device.isIOS() and config.SUPERSDK_ENABLED then
		self:_invokeString(g.core.const.ConstMgr.SuperSdkConst.MODULE_TOOLS, "openSystemSetting", nil)
	else
		NativeCallUtils.call("jumpMyAppDetail")
	end
end

function PlatformProxy:getCurChannel()
	local var_186_0 = {
		name = ChannelConst.ChannelNames.YOOZOO
	}
	local var_186_1

	if config.SUPERSDK_ENABLED then
		var_186_0.name = ""
		var_186_1 = ChannelConst.ValueConst
	end

	for iter_186_0, iter_186_1 in ipairs({
		self:getGameId(),
		self:getOpId(),
		self:getOpGameId()
	}) do
		var_186_1 = var_186_1[tonumber(iter_186_1)]

		if not var_186_1 then
			break
		end
	end

	if var_186_1 then
		var_186_0 = var_186_1
	end

	if not self:isChannelOfChina() then
		var_186_0 = {
			name = ChannelConst.ChannelNames.YOOZOO,
			sdkChanel = ChannelConst.ChannelNames.YOOZOO
		}
	end

	return var_186_0
end

function PlatformProxy:isYOOZOOPackageEntity()
	local var_187_0 = self:getCurChannel()

	if var_187_0.name == ChannelConst.ChannelNames.YOOZOO or var_187_0.name == ChannelConst.ChannelNames.TAPTAP or var_187_0.name == ChannelConst.ChannelNames.BILI or var_187_0.name == ChannelConst.ChannelNames.HAOYOUKB or var_187_0.name == ChannelConst.ChannelNames.LEIDIAN or var_187_0.name == ChannelConst.ChannelNames.HUANYOU or var_187_0.name == ChannelConst.ChannelNames.GUANFAN1 or var_187_0.name == ChannelConst.ChannelNames.GUANFAN2 or var_187_0.name == ChannelConst.ChannelNames.STELLAR or var_187_0.name == ChannelConst.ChannelNames.DOUYIN or var_187_0.name == ChannelConst.ChannelNames.LENOVO then
		return true
	end

	return false
end

function PlatformProxy:getClientPhoneIpInfo()
	return {}
end

function PlatformProxy:getRegionGroupInfo()
	return g.core.const.ConstMgr.PlatformConst.REGION_CFG[(config.PUBLISH_REGION == 0 or nil) and 1].SERVER_OTHER_GROUP
end

function PlatformProxy:getAndroidPackageName()
	if not device.isAndroid() then
		return ""
	end

	return NativeCallUtils.call("getPackageName", nil, "string") or ""
end

function PlatformProxy:checkHYExchange(arg_191_1)
	local ChannelConst = require("app.core.platform.const.ChannelConst")
	local var_191_1 = g.core.platform.PlatformProxy:getCurChannel()
	local var_191_2 = var_191_1.name == ChannelConst.ChannelNames.COOLPAD
	local var_191_3 = var_191_1.name == ChannelConst.ChannelNames.HUANYOU and var_191_1.debugName ~= "HUANYOU-WEB-ANDROID"
	local var_191_4 = var_191_1.name == ChannelConst.ChannelNames.DREAMFREELY or var_191_3 or var_191_2

	if var_191_1.name == ChannelConst.ChannelNames.DREAMFREELY or var_191_3 or var_191_2 then
		self:sendHYExchangeHttp(arg_191_1)
	end

	return var_191_4
end

function PlatformProxy:sendHYExchangeHttp(arg_192_1)
	if not device.isSdkEnabled() then
		return
	end

	local var_192_0 = "https://sdkcgi.youzu.com/Api/Migrate/GetUserInfo"
	local var_192_2 = {
		{
			key = "game_id",
			value = self:getGameId()
		},
		{
			key = "from_op_id",
			value = self:getOpId()
		},
		{
			key = "to_op_id",
			value = (self:getCurChannel().name == ChannelConst.ChannelNames.DREAMFREELY or nil) and "2843"
		},
		{
			key = "user_id",
			value = self:getSdkAccount()
		},
		{
			key = "randnum",
			value = g.core.common.ServerTime:getTime()
		}
	}

	table.sort(var_192_2, function(arg_193_0, arg_193_1)
		return arg_193_0.key < arg_193_1.key
	end)

	local var_192_3 = ""
	local var_192_4 = ""

	for iter_192_0 = 1, #var_192_2 do
		if iter_192_0 == #var_192_2 then
			var_192_4 = var_192_4 .. var_192_2[iter_192_0].key .. "=" .. var_192_2[iter_192_0].value
			var_192_3 = var_192_3 .. var_192_2[iter_192_0].key .. "=" .. var_192_2[iter_192_0].value
		else
			var_192_4 = var_192_4 .. var_192_2[iter_192_0].key .. "=" .. var_192_2[iter_192_0].value .. "&"
			var_192_3 = var_192_3 .. var_192_2[iter_192_0].key .. "=" .. var_192_2[iter_192_0].value .. "&"
		end
	end

	release_print("signStr = " .. var_192_4 .. "&signKey=5AaudUidWKmnkHJKd2DCG1456KF90")

	local var_192_5 = var_192_3 .. "&sign=" .. string.upper((function(arg_194_0)
		local md5 = require("cocos.framework.extends.md5")
		local var_194_1 = md5.new()

		var_194_1:update(arg_194_0)

		return md5.tohex(var_194_1:finish())
	end)(var_192_4 .. "&signKey=5AaudUidWKmnkHJKd2DCG1456KF90"))

	release_print("paramStr = " .. var_192_5)
	release_print(var_192_0 .. "?" .. var_192_5)
	require("app.core.network.HttpRequest"):new(nil, {
		success = function(self)
			self = var_0_3(self)

			if self and type(self) == "table" then
				if self.code == 200 then
					release_print(self)
					g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.NewAccountConfirmPop").new(self.data, arg_192_1), {
						touchDisappear = false
					})
				else
					g.core.module.ModuleManager:tip("转移失败，请联系客服")
				end
			else
				g.core.module.ModuleManager:tip("转移失败，请联系客服")
			end
		end,
		fail = function(arg_196_0, arg_196_1)
			g.core.module.ModuleManager:tip("转移失败，请联系客服")
		end
	}):send()
end

function PlatformProxy:isShowUnbind(arg_197_1)
	return
end

function PlatformProxy:delayCallCheckAndDoAdActive()
	return
end

function PlatformProxy:openTapTapCommentArea()
	if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.TAPTAP then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.TaptapScorePop").new()))
	end
end

function PlatformProxy:jumpTaptapCommentArea()
	return
end

function PlatformProxy:matchRegionByRegionKeyList(arg_201_1)
	local var_201_0 = false

	for iter_201_0, iter_201_1 in ipairs(arg_201_1) do
		if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION[iter_201_1] then
			var_201_0 = true

			break
		end
	end

	return var_201_0
end

function PlatformProxy:isBuleChannel()
	return ({
		["3223_2971"] = true,
		["3223_2972"] = true
	})[table.concat({
		self:getOpId(),
		(self:getOpGameId())
	}, "_")]
end

function PlatformProxy:isXiaoQiChannel()
	return ({
		["3532_2971"] = true
	})[table.concat({
		self:getOpId(),
		(self:getOpGameId())
	}, "_")]
end

function PlatformProxy:isHasCustomExit()
	return self:isXiaoQiChannel()
end

function PlatformProxy:needMergeServer(arg_205_1, arg_205_2)
	return false
end

function PlatformProxy:getChannelKey()
	return (table.concat({
		self:getOpId(),
		(self:getOpGameId())
	}, "_"))
end

function PlatformProxy:isApplyH5Banner()
	return false
end

function PlatformProxy:jumpToH5Banner()
	return
end

return PlatformProxy
