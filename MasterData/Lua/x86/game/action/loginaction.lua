local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	_G.isLogining = true
	TMP_TIMESTAMP = os.time()
	_G.TMP_ACCOUNT_ID = tostring(arg_1_0)
	_G.TMP_CHANNELID = arg_1_2 or 0

	if _G.deviceInfo and _G.deviceInfo.androidId then
		_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.androidId)
		_G.BRAND = _G.deviceInfo.brand
		_G.MODEL = _G.deviceInfo.model
		_G.SYSTEM = _G.deviceInfo.system
	elseif _G.deviceInfo then
		_G.TMP_MAC_ADDRESS = _G.deviceInfo.uuid ~= nil and tostring(_G.deviceInfo.uuid) or _G.deviceInfo.idfa ~= nil and tostring(_G.deviceInfo.idfa) or _G.deviceInfo.odid ~= nil and tostring(_G.deviceInfo.odid) or "unknown"
		_G.MODEL = _G.deviceInfo.model
		_G.BRAND = _G.deviceInfo.brand
		_G.SYSTEM = _G.deviceInfo.system
	else
		_G.TMP_MAC_ADDRESS = "unknown"
		_G.BRAND = "unknown"
		_G.SYSTEM = "unknown"
	end

	print("#gs_login# , 10038 _G.TMP_MAC_ADDRESS = " .. tostring(_G.TMP_MAC_ADDRESS))
	manager.net:GateWaySend(10038, {
		channel_id = arg_1_2 or 0,
		account = _G.TMP_ACCOUNT_ID,
		token = arg_1_1,
		timestamp = TMP_TIMESTAMP,
		device_id = _G.TMP_MAC_ADDRESS,
		app_id = arg_1_3 or "channel_internal_app_id",
		platform_type = GameToSDK.PLATFORM_ID
	}, 10039, arg_1_4, false, false)
end

function var_0_0.GateWayLogin(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if _G.isLogining then
		return
	end

	local var_2_0 = manager.net:GetTCPState("gateway")
	local var_2_1, var_2_2 = manager.net:GetConnectHostAndPort("gateway")

	if var_2_1 ~= GATEWAY_ADDR or GATEWAY_PORT ~= var_2_2 then
		manager.net:Disconnect()

		var_2_0 = "init"
	end

	if var_2_0 == "init" or var_2_0 == "none" then
		manager.net:GateWayConnect(GATEWAY_ADDR, GATEWAY_PORT, function(arg_3_0)
			if arg_3_0 == SocketError.Success then
				var_0_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, var_0_0.OnGateWayLogin)
			else
				ShowTips("ERROR_CONNECT_SERVER")
			end
		end)
	elseif var_2_0 == "disconnected" then
		manager.net:GateWayReconnect(function(arg_4_0)
			if arg_4_0 == SocketError.Success then
				var_0_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, var_0_0.OnGateWayLogin)
			else
				ShowTips("ERROR_CONNECT_SERVER")
			end
		end)
	elseif var_2_0 == "connected" then
		var_0_1(arg_2_0, arg_2_1, arg_2_2, arg_2_3, var_0_0.OnGateWayLogin)
	end
end

local function var_0_2(arg_5_0)
	if arg_5_0.countdown_info and arg_5_0.countdown_info.is_countdown then
		JumpTools.OpenPageByJump("serveropencountdown", {
			countdown = arg_5_0.countdown_info.open_time,
			content = arg_5_0.countdown_info.content,
			now = arg_5_0.countdown_info.timestamp
		})
	elseif _G.CHANNEL_MASTER_ID ~= 1 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("SERVER_MAINTENANCE"),
			OkCallback = function()
				return
			end
		})
	else
		ShowMessageBox({
			isTop = true,
			content = GetTips("SERVER_MAINTENANCE"),
			BtnText = {
				[2] = GetTips("OPEN_FORUM")
			},
			OkCallback = function()
				return
			end,
			CancelCallback = function()
				if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
					OperationAction.OpenOperationUrl("FORUM_URL", {
						gameAppId = _G.ChannelLoginInfo.channelAppId,
						token = _G.ChannelLoginInfo.channelToken
					})
				else
					OperationAction.OpenOperationUrl("FORUM_URL_HOME")
				end

				SDKTools.SendMessageToSDK("direction", {
					direction_type = 8,
					direction_channel = 2
				})
			end
		})
	end
end

local function var_0_3(arg_9_0)
	local var_9_0 = SettingData:GetCurrentLanguage()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.i18n_info) do
		var_9_1[iter_9_1.language] = iter_9_1.string
	end

	local var_9_2 = {}

	var_9_2.banReason = var_9_1[var_9_0] or arg_9_0.ban_reason
	var_9_2.banTimestamp = arg_9_0.unblocking_time

	JumpTools.OpenPageByJump("banAccount", var_9_2)
end

function var_0_0:OnGateWayLogin()
	if isSuccess(self.result) then
		print("data.ip, data.port", self.ip, self.port, self.server_id, self.user_id)

		_G.TCP_ADDR = self.ip
		_G.TCP_PORT = self.port
		_G.TMP_SERVER_ID = self.server_id
		_G.TMP_TIMESTAMP = self.timestamp

		var_0_0.Login(self.user_id, self.gstoken)

		_G.TMP_IS_NEW_PLAYER = self.is_new_player

		print("_G.TMP_IS_NEW_PLAYER", _G.TMP_IS_NEW_PLAYER)
		LuaForUtil.OnLoginSuccess(_G.TMP_CHANNELID, tostring(self.user_id), tostring(self.user_id), 0)
		NeedGameUserInfo()
		GameToSDK.UpUserInfo(string.format("{\"dataType\" : \"SelectServer\",\"serverId\" : %d}", _G.TMP_SERVER_ID))
	else
		_G.isLogining = false

		if self.result == LoginConst.ACCOUNT_BAN then
			var_0_3(self)
		elseif self.result == LoginConst.SERVER_MAINTAIN then
			var_0_2(self)
		else
			ShowTips(self.result)
		end
	end
end

local function var_0_4(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if _G.deviceInfo and _G.deviceInfo.system then
		_G.deviceInfo.system = string.gsub(_G.deviceInfo.system, "[^0-9.]", "")
	end

	local var_11_0 = PlayerPrefs.GetString("naive_angle_mode_key", "naive")
	local var_11_1 = 10042
	local var_11_2 = {
		b_game_base_id = 109036,
		channel_id = _G.TMP_CHANNELID,
		server_id = _G.TMP_SERVER_ID,
		account = _G.TMP_ACCOUNT_ID,
		user_id = arg_11_0,
		b_sdk_udid = _G.CHANNEL_UDID,
		b_sdk_uid = _G.CHANNEL_USERID,
		b_tour_indicator = tonumber(_G.LOGIN_TYPE),
		b_game_id = tonumber(_G.B_SDK_ID),
		timestamp = TMP_TIMESTAMP,
		gstoken = arg_11_1,
		platform_type = GameToSDK.PLATFORM_ID,
		device_id = _G.TMP_MAC_ADDRESS,
		client_vs = tostring(LuaForUtil.GetClientVersion())
	}

	if _G.deviceInfo then
		var_11_2.os_vs = _G.deviceInfo.system or nil
	end

	var_11_2.phone = _G.AnalyticsPresetProperties["#manufacturer"]

	if _G.deviceInfo then
		var_11_2.mac = _G.deviceInfo.mac or nil
	end

	if _G.deviceInfo then
		var_11_2.imei = _G.deviceInfo.imei or nil
	end

	if _G.deviceInfo then
		var_11_2.idfa = _G.deviceInfo.idfa or nil
	end

	var_11_2.distinct_id = _G.AnalyticsPresetProperties.distinctId

	if _G.deviceInfo then
		var_11_2.oaid = _G.deviceInfo.oaid or nil
	end

	if _G.deviceInfo then
		var_11_2.gaid = _G.deviceInfo.gaid or nil
	end

	var_11_2.master_channel_id = _G.CHANNEL_MASTER_ID
	var_11_2.app_id = _G.APP_ID or "channel_internal_app_id"
	var_11_2.sub_id = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil
	var_11_2.type = arg_11_3 or LoginConst.LOGIN_TYPE.LOGIN
	var_11_2.resource_vs = tostring(LuaForUtil.GetResourceVersion())
	var_11_2.device_model = tostring(_G.MODEL)
	var_11_2.zone_offset = _G.AnalyticsPresetProperties["#zone_offset"] or 8
	var_11_2.ram = tostring(UnityEngine.SystemInfo.systemMemorySize)
	var_11_2.rom = tostring(LuaForUtil.GetFreeDiskSpace())
	var_11_2.cpu_hardware = tostring(_G.CPUINFO)
	var_11_2.network = tostring(_G.NETTYPE)
	var_11_2.language = SettingData:GetCurrentLanguage()
	var_11_2.graph_device_id = tostring(UnityEngine.SystemInfo.graphicsDeviceID)
	var_11_2.graph_device_name = tostring(UnityEngine.SystemInfo.graphicsDeviceName)
	var_11_2.graph_memory_size = UnityEngine.SystemInfo.graphicsMemorySize
	var_11_2.graph_device_vendor = tostring(UnityEngine.SystemInfo.graphicsDeviceVendor)
	var_11_2.graph_device_vendor_id = tostring(UnityEngine.SystemInfo.graphicsDeviceVendorID)
	var_11_2.graph_device_version = tostring(UnityEngine.SystemInfo.graphicsDeviceVersion)
	var_11_2.is_localization = var_11_0 == nil or var_11_0 == ""
	var_11_2.resolution = string.format("%dx%d", _G.SCREEN_WIDTH, _G.SCREEN_HEIGHT)

	return manager.net:SendSyncNoEnqueue(var_11_1, var_11_2, 10043, arg_11_2, false, false)
end

function var_0_0.Login(arg_12_0, arg_12_1)
	local var_12_0 = manager.net:GetTCPState("game")
	local var_12_1, var_12_2 = manager.net:GetConnectHostAndPort("game")

	if var_12_1 ~= _G.TCP_ADDR or _G.TCP_PORT ~= var_12_2 then
		manager.net:Disconnect()

		var_12_0 = "init"
	end

	print(var_12_1, var_12_2, var_12_0)

	if var_12_0 == "init" or var_12_0 == "none" then
		manager.net:Connect(_G.TCP_ADDR, _G.TCP_PORT, function(arg_13_0)
			if arg_13_0 == SocketError.Success then
				var_0_4(arg_12_0, arg_12_1, var_0_0.OnLogin, LoginConst.LOGIN_TYPE.LOGIN)
			end
		end)
	elseif var_12_0 == "disconnected" then
		manager.net:Reconnect(function(arg_14_0)
			if arg_14_0 == SocketError.Success then
				var_0_4(arg_12_0, arg_12_1, var_0_0.OnLogin, LoginConst.LOGIN_TYPE.LOGIN)
			end
		end)
	elseif var_12_0 == "connected" then
		var_0_4(arg_12_0, arg_12_1, var_0_0.OnLogin, LoginConst.LOGIN_TYPE.LOGIN)
	end
end

function var_0_0:OnLogin(arg_15_1)
	PlayerPrefs.SetString("UserID", arg_15_1.user_id)
	PlayerPrefs.SetString("UserPwd", arg_15_1.gstoken)

	USER_ID = arg_15_1.user_id

	if isSuccess(self.result) then
		manager.time:SetServerTime(self.timestamp, self.verify_timestamp)
		manager.redPoint:InitData()
		InitData()
		PlayerAction.UserBaseInfoInit({
			userID = arg_15_1.user_id,
			register_timestamp = self.register_timestamp,
			uid_sign = self.uid_sign
		})
		var_0_0.RequestGameData(LoginConst.LOGIN_TYPE.LOGIN)
		manager.net:SetIsPauseSendPacket(true)
	else
		_G.isLogining = false

		ShowTips(self.result)
	end

	var_0_0.LoginForSDK(self.register_timestamp)
end

function var_0_0.Reconnect()
	local var_16_0 = PlayerPrefs.GetString("UserID")
	local var_16_1 = PlayerPrefs.GetString("UserPwd")
	local var_16_2 = manager.net:GetTCPState("game")

	if var_16_2 == "init" or var_16_2 == "none" then
		manager.net:Connect(_G.TCP_ADDR, _G.TCP_PORT, function()
			var_0_4(var_16_0, var_16_1, var_0_0.OnReconnect, LoginConst.LOGIN_TYPE.RECONNECT)
		end)
	elseif var_16_2 == "disconnected" then
		manager.net:Reconnect(function(arg_18_0)
			if arg_18_0 == SocketError.Success then
				var_0_4(var_16_0, var_16_1, var_0_0.OnReconnect, LoginConst.LOGIN_TYPE.RECONNECT)
			end
		end)
	elseif var_16_2 == "connected" then
		var_0_4(var_16_0, var_16_1, var_0_0.OnReconnect, LoginConst.LOGIN_TYPE.RECONNECT)
	end
end

function var_0_0:OnReconnect()
	if isSuccess(self.result) then
		var_0_0.RequestGameData(LoginConst.LOGIN_TYPE.RECONNECT)
		manager.net:SetIsPauseSendPacket(true)
	else
		ConnectionHelper.ShowReturnToLoginTip(self.result)
	end
end

local var_0_5

function var_0_0.RequestGameData(arg_20_0)
	var_0_5 = arg_20_0

	manager.net:SendSyncNoEnqueue(10200, {}, 10201, var_0_0.OnRequestGameData, false, false)
end

function var_0_0:OnRequestGameData(arg_21_1)
	manager.net:SetIsPauseSendPacket(false)
	manager.net:AutoDequeueOn()
	PlayerAction.UserLoginTimestampInit({
		timestamp = self.timestamp
	})
	GameToSDK.UpUserEvent("{\"eventType\" : \"Begin\"}")
	SDKTools.SetSignInAttribute()

	local var_21_0 = PlayerData:GetPlayerInfo().userID

	manager.ui:SetUIDText("ID:" .. var_21_0, var_21_0)
	GameToSDK.SendMessage(string.format("{\"messageType\" : \"SetPushNotificationAlias\", \"alias\" : \"%s\"}", PlayerData:GetPlayerInfo().userID))

	if var_0_5 == LoginConst.LOGIN_TYPE.RECONNECT then
		print("On Reconnect Login")
		ActivityAction.OnLogin()

		return
	else
		print("LoginType:" .. var_0_5)
	end

	local var_21_1 = PlayerPrefs.GetString("UserID")

	GameLocalData:SaveUserInfoToUserData(var_21_1, {
		account = var_21_1,
		pwd = GodessPass
	})
	gameContext:SetSystemLayer("home")

	BattleCallLuaCallBackWait = false

	LateInitData()
	_G.gameListener:StartListen()
	PlayerAction.LevelUpFinish()
	HeroAction.RefreshHeroRedPointAfterSeverSendData()
	NeedGameUserInfo()

	if _G.TMP_IS_NEW_PLAYER and _G.TMP_IS_NEW_PLAYER == 1 then
		GameLocalData:ClearTargetUser(var_21_1)
		GameToSDK.UpUserInfo(PlayerTools.PackUserData("CreateRole"))
	end

	GameToSDK.UpUserInfo(PlayerTools.PackUserData("EnterGame"))

	if GameToSDK.CURRENT_SERVER == "zh_cn" then
		OperationAction.GetUnreadMsgResult()
	end

	local var_21_2 = gameContext:GetOpenPageHandler("login")

	if var_21_2 then
		var_21_2:PlayOut()
	end
end

function var_0_0.LoginForSDK(arg_22_0)
	if _G.TMP_IS_NEW_PLAYER and _G.TMP_IS_NEW_PLAYER == 1 then
		SendMessageManagerToSDK("account_create_ys")
	end

	saveData("SDK", "register_timestamp", arg_22_0)

	local var_22_0 = manager.time:DiffDay2(arg_22_0, manager.time:GetServerTime())

	if var_22_0 == 1 or var_22_0 == 6 or var_22_0 == 13 then
		SendMessageManagerToSDK("day_retention", {
			diff = var_22_0
		})
	end

	local var_22_1 = getData("SDK", "lastTime")

	if var_22_1 == nil then
		var_22_1 = 0
	end

	local var_22_2 = getData("SDK", "continueTime")

	if var_22_2 == nil then
		var_22_2 = 0
	end

	if var_22_1 and manager.time:DiffDay2(var_22_1, manager.time:GetServerTime()) == 1 then
		saveData("SDK", "continueTime", var_22_2 + 1)

		if var_22_2 + 1 == 1 or var_22_2 + 1 == 6 or var_22_2 + 1 == 13 then
			SendMessageManagerToSDK("day_retention_return")
		end
	elseif var_22_1 and manager.time:DiffDay2(var_22_1, manager.time:GetServerTime()) > 1 then
		saveData("SDK", "continueTime", 0)
	end

	saveData("SDK", "lastTime", manager.time:GetInstance():GetServerTime())
	SendMessageManagerToSDK("role_login")
end

return var_0_0
