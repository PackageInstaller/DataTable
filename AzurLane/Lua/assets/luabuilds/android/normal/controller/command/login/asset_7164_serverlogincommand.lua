class = var_0_10000

local var_0_0 = "ServerLoginCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.LoginLastTime = 0
var_0_1.LoginSafeLock = 0

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	assert = var_1_0
	isa = var_1_10004

	local var_1_2 = var_1_1

	Server = var_1_10006

	var_1_0(var_1_10004(var_1_2, var_1_10006), "should be an instance of Server")

	local var_1_3 = var_1_1:getHost()
	local var_1_4 = var_1_1
	local var_1_5 = var_1_1.getPort(var_1_4)

	originalPrint = var_1_4

	var_1_4("connect to game server - " .. var_1_3 .. ":" .. var_1_5)

	getProxy = var_1_4
	UserProxy = var_6

	local var_1_6 = var_1_4(var_6)
	local var_1_7 = var_5.getData(var_1_6)

	pg = var_1_6

	local var_1_8 = var_1_6.SdkMgr.GetInstance()

	if var_7.GetChannelUID(var_1_8) == "" then
		PLATFORM_LOCAL = var_7
	end

	local function var_1_9(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.ConnectionMgr.GetInstance()
		local var_2_1 = var_1.Send
		local var_2_2 = 10022
		local var_2_3 = {
			platform = var_0,
			account_id = var_1_7.uid,
			server_ticket = arg_2_0 or var_1_7.token,
			serverid = var_1_1.id
		}

		HashUtil = var_5

		local var_2_4 = var_5.CalcMD5
		local var_2_5 = var_1_7.token

		AABBUDUD = var_2_10007
		var_2_3.check_key = var_2_4(var_2_5 .. var_2_10007)
		pg = var_5

		local var_2_6 = var_5.SdkMgr.GetInstance()

		var_2_3.device_id = var_5.GetDeviceId(var_2_6)

		var_2_1(var_2_0, var_2_2, var_2_3, 10023, function(arg_3_0)
			if arg_3_0.result == 0 then
				originalPrint = var_1

				var_1("connect success: " .. arg_3_0.user_id)

				local var_3_0 = var_1_1.status

				Server = var_2

				if var_3_0 == var_2.STATUS.REGISTER_FULL and arg_3_0.user_id == 0 then
					pg = var_1

					local var_3_1 = var_1.TipsMgr.GetInstance()
					local var_3_2 = var_1.ShowTips

					i18n = var_3_10003

					var_3_2(var_3_1, var_3_10003("login_register_full"))

					pg = var_3_2

					local var_3_3 = var_3_2.ConnectionMgr.GetInstance()

					var_1.onDisconnected(var_3_3, true)
				else
					var_1_7.token = arg_3_0.server_ticket
					var_1_7.server = var_1_1.id

					local var_3_4 = var_0

					var_1.setLastLogin(var_3_4, var_1_7)

					local var_3_5 = var_0

					var_1.SaveCacheGatewayFlag(var_3_5, var_1_7.arg2)

					getProxy = var_1
					ServerProxy = var_3_5
					var_3_10003 = var_1(var_3_5)

					var_1.setLastServer(var_3_10003, var_1_1.id, var_1_7.uid)

					var_3_10003 = arg_1_0

					local var_3_6 = var_2.sendNotification

					GAME = var_4

					var_3_6(var_3_10003, var_4.SERVER_LOGIN_SUCCESS, {
						uid = arg_3_0.user_id
					})

					pg = var_3_6
					var_3_10003 = var_3_6.TrackerMgr.GetInstance()

					local var_3_7 = var_2.Tracking

					TRACKING_ROLE_LOGIN = var_4

					var_3_7(var_3_10003, var_4, nil, arg_3_0.user_id)

					if arg_3_0.user_id == 0 then
						pg = var_2
						var_3_10003 = var_2.SdkMgr.GetInstance()

						local var_3_8 = var_2.ChooseServer

						tostring = var_4

						var_3_8(var_3_10003, var_4(var_1_1.id), var_1_1.name)
					end
				end
			elseif arg_3_0.result == 13 then
				pg = var_1

				local var_3_9 = var_1.TipsMgr.GetInstance()
				local var_3_10 = var_1.ShowTips

				i18n = var_3_10003

				var_3_10(var_3_9, var_3_10003("login_game_not_ready"))
			elseif arg_3_0.result == 15 then
				pg = var_1

				local var_3_11 = var_1.TipsMgr.GetInstance()
				local var_3_12 = var_1.ShowTips

				i18n = var_3_10003

				var_3_12(var_3_11, var_3_10003("login_game_rigister_full"))
			elseif arg_3_0.result == 17 then
				local var_3_13 = arg_1_0
				local var_3_14 = var_1.sendNotification

				GAME = var_3_10003

				var_3_14(var_3_13, var_3_10003.SERVER_LOGIN_FAILED_USER_BANNED, arg_3_0.user_id)
			elseif arg_3_0.result == 6 then
				pg = var_1

				local var_3_15 = var_1.TipsMgr.GetInstance()
				local var_3_16 = var_1.ShowTips

				i18n = var_3_10003

				var_3_16(var_3_15, var_3_10003("login_game_login_full"))
			elseif arg_3_0.result == 18 then
				local var_3_17 = arg_3_0.db_load
				local var_3_18 = arg_3_0.server_load

				math = var_3_10003
				var_3_10003 = var_3_10003.floor(var_3_17 / 100 + var_3_18 / 1000 + 1)

				local var_3_19 = arg_1_0
				local var_3_20 = var_4.sendNotification

				GAME = var_3_10006

				var_3_20(var_3_19, var_3_10006.SERVER_LOGIN_WAIT, var_3_10003)
			elseif arg_3_0.result == 26 then
				pg = var_1

				local var_3_21 = var_1.TipsMgr.GetInstance()
				local var_3_22 = var_1.ShowTips

				i18n = var_3_10003

				var_3_22(var_3_21, var_3_10003("login_game_midnightpressure"))
			else
				local var_3_23 = arg_1_0
				local var_3_24 = var_1.sendNotification

				GAME = var_3_10003

				var_3_24(var_3_23, var_3_10003.SERVER_LOGIN_FAILED, arg_3_0.result)
			end

			return
		end, false)

		return
	end

	os = var_9

	local var_1_10 = var_9.time()
	local var_1_11 = var_0_1

	var_1_11.LoginSafeLock = var_0_1.LoginSafeLock + 1
	math = var_1_11

	local var_1_12

	if var_1_11.abs(var_1_10 - var_0_1.LoginLastTime) > 1 or var_0_1.LoginSafeLock >= 5 then
		var_1_12 = var_0_1
		var_1_12.LoginLastTime = var_1_10
		var_1_12 = var_0_1
		var_1_12.LoginSafeLock = 0
		pg = var_1_12

		local var_1_13 = var_1_12.ConnectionMgr.GetInstance()

		if var_1_12.getConnection(var_1_13) then
			pg = var_1_12

			local var_1_14 = var_1_12.ConnectionMgr.GetInstance()

			if var_1_12.isConnected(var_1_14) then
				var_1_9()

				goto label_1_0
			end
		end

		pg = var_1_12

		local var_1_15 = var_1_12.ConnectionMgr.GetInstance()

		var_1_12.SetProxyHost(var_1_15, var_1_1.proxyHost, var_1_1.proxyPort)

		pg = var_1_12

		local var_1_16 = var_1_12.ConnectionMgr.GetInstance()

		var_1_12.Connect(var_1_16, var_1_3, var_1_5, function()
			originalPrint = var_2_10000

			var_2_10000("server: " .. var_1_1.id .. " uid: " .. var_1_7.uid)
			var_1_9()

			return
		end, 6)
	else
		pg = var_1_12

		local var_1_17 = var_1_12.TipsMgr.GetInstance()
		local var_1_18 = var_10.ShowTips

		i18n = var_1_10012

		var_1_18(var_1_17, var_1_10012("login_game_frequence"))
	end

	::label_1_0::

	return
end

return var_0_1
