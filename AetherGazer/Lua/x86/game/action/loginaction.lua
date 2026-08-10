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
		if _G.deviceInfo.uuid ~= nil then
			_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.uuid)
		elseif _G.deviceInfo.idfa ~= nil then
			_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.idfa)
		elseif _G.deviceInfo.odid ~= nil then
			_G.TMP_MAC_ADDRESS = tostring(_G.deviceInfo.odid)
		else
			_G.TMP_MAC_ADDRESS = "unknown"
		end

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
					local var_8_0 = {
						gameAppId = _G.ChannelLoginInfo.channelAppId,
						token = _G.ChannelLoginInfo.channelToken
					}

					OperationAction.OpenOperationUrl("FORUM_URL", var_8_0)
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

	JumpTools.OpenPageByJump("banAccount", {
		banReason = var_9_1[var_9_0] or arg_9_0.ban_reason,
		banTimestamp = arg_9_0.unblocking_time
	})
end

function var_0_0.OnGateWayLogin(arg_10_0)
	if isSuccess(arg_10_0.result) then
		print("data.ip, data.port", arg_10_0.ip, arg_10_0.port, arg_10_0.server_id, arg_10_0.user_id)

		_G.TCP_ADDR = arg_10_0.ip
		_G.TCP_PORT = arg_10_0.port
		_G.TMP_SERVER_ID = arg_10_0.server_id
		_G.TMP_TIMESTAMP = arg_10_0.timestamp

		var_0_0.Login(arg_10_0.user_id, arg_10_0.gstoken)

		_G.TMP_IS_NEW_PLAYER = arg_10_0.is_new_player

		print("_G.TMP_IS_NEW_PLAYER", _G.TMP_IS_NEW_PLAYER)
		LuaForUtil.OnLoginSuccess(_G.TMP_CHANNELID, tostring(arg_10_0.user_id), tostring(arg_10_0.user_id), 0)
		NeedGameUserInfo()
		GameToSDK.UpUserInfo(string.format("{\"dataType\" : \"SelectServer\",\"serverId\" : %d}", _G.TMP_SERVER_ID))
	else
		_G.isLogining = false

		if arg_10_0.result == LoginConst.ACCOUNT_BAN then
			var_0_3(arg_10_0)
		elseif arg_10_0.result == LoginConst.SERVER_MAINTAIN then
			var_0_2(arg_10_0)
		else
			ShowTips(arg_10_0.result)
		end
	end
end

local function var_0_4(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if _G.deviceInfo and _G.deviceInfo.system then
		_G.deviceInfo.system = string.gsub(_G.deviceInfo.system, "[^0-9.]", "")
	end

	local var_11_0 = PlayerPrefs.GetString("naive_angle_mode_key", "naive")

	return manager.net:SendSyncNoEnqueue(10042, {
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
		client_vs = tostring(LuaForUtil.GetClientVersion()),
		os_vs = _G.deviceInfo and _G.deviceInfo.system or nil,
		phone = _G.AnalyticsPresetProperties["#manufacturer"],
		mac = _G.deviceInfo and _G.deviceInfo.mac or nil,
		imei = _G.deviceInfo and _G.deviceInfo.imei or nil,
		idfa = _G.deviceInfo and _G.deviceInfo.idfa or nil,
		distinct_id = _G.AnalyticsPresetProperties.distinctId,
		oaid = _G.deviceInfo and _G.deviceInfo.oaid or nil,
		gaid = _G.deviceInfo and _G.deviceInfo.gaid or nil,
		master_channel_id = _G.CHANNEL_MASTER_ID,
		app_id = _G.APP_ID or "channel_internal_app_id",
		sub_id = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil,
		type = arg_11_3 or LoginConst.LOGIN_TYPE.LOGIN,
		resource_vs = tostring(LuaForUtil.GetResourceVersion()),
		device_model = tostring(_G.MODEL),
		zone_offset = _G.AnalyticsPresetProperties["#zone_offset"] or 8,
		ram = tostring(UnityEngine.SystemInfo.systemMemorySize),
		rom = tostring(LuaForUtil.GetFreeDiskSpace()),
		cpu_hardware = tostring(_G.CPUINFO),
		network = tostring(_G.NETTYPE),
		language = SettingData:GetCurrentLanguage(),
		graph_device_id = tostring(UnityEngine.SystemInfo.graphicsDeviceID),
		graph_device_name = tostring(UnityEngine.SystemInfo.graphicsDeviceName),
		graph_memory_size = UnityEngine.SystemInfo.graphicsMemorySize,
		graph_device_vendor = tostring(UnityEngine.SystemInfo.graphicsDeviceVendor),
		graph_device_vendor_id = tostring(UnityEngine.SystemInfo.graphicsDeviceVendorID),
		graph_device_version = tostring(UnityEngine.SystemInfo.graphicsDeviceVersion),
		is_localization = var_11_0 == nil or var_11_0 == "",
		resolution = string.format("%dx%d", _G.SCREEN_WIDTH, _G.SCREEN_HEIGHT)
	}, 10043, arg_11_2, false, false)
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

function var_0_0.OnLogin(arg_15_0, arg_15_1)
	PlayerPrefs.SetString("UserID", arg_15_1.user_id)
	PlayerPrefs.SetString("UserPwd", arg_15_1.gstoken)

	USER_ID = arg_15_1.user_id

	if isSuccess(arg_15_0.result) then
		manager.time:SetServerTime(arg_15_0.timestamp, arg_15_0.verify_timestamp)
		manager.redPoint:InitData()
		InitData()
		PlayerAction.UserBaseInfoInit({
			userID = arg_15_1.user_id,
			register_timestamp = arg_15_0.register_timestamp,
			uid_sign = arg_15_0.uid_sign
		})
		var_0_0.RequestGameData(LoginConst.LOGIN_TYPE.LOGIN)
		manager.net:SetIsPauseSendPacket(true)
	else
		_G.isLogining = false

		ShowTips(arg_15_0.result)
	end

	var_0_0.LoginForSDK(arg_15_0.register_timestamp)
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

function var_0_0.OnReconnect(arg_19_0)
	if isSuccess(arg_19_0.result) then
		var_0_0.RequestGameData(LoginConst.LOGIN_TYPE.RECONNECT)
		manager.net:SetIsPauseSendPacket(true)
	else
		ConnectionHelper.ShowReturnToLoginTip(arg_19_0.result)
	end
end

local var_0_5

function var_0_0.RequestGameData(arg_20_0)
	var_0_5 = arg_20_0

	manager.net:SendSyncNoEnqueue(10200, {}, 10201, var_0_0.OnRequestGameData, false, false)
end

function var_0_0.OnRequestGameData(arg_21_0, arg_21_1)
	manager.net:SetIsPauseSendPacket(false)
	manager.net:AutoDequeueOn()
	PlayerAction.UserLoginTimestampInit({
		timestamp = arg_21_0.timestamp
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
	local var_21_2 = {
		account = var_21_1,
		pwd = GodessPass
	}

	GameLocalData:SaveUserInfoToUserData(var_21_1, var_21_2)
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

	local var_21_3 = gameContext:GetOpenPageHandler("login")

	if var_21_3 then
		var_21_3:PlayOut()
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
		local var_22_3 = var_22_2 + 1

		saveData("SDK", "continueTime", var_22_3)

		if var_22_3 == 1 or var_22_3 == 6 or var_22_3 == 13 then
			SendMessageManagerToSDK("day_retention_return")
		end
	elseif var_22_1 and manager.time:DiffDay2(var_22_1, manager.time:GetServerTime()) > 1 then
		saveData("SDK", "continueTime", 0)
	end

	saveData("SDK", "lastTime", manager.time:GetInstance():GetServerTime())
	SendMessageManagerToSDK("role_login")
end

return var_0_0
