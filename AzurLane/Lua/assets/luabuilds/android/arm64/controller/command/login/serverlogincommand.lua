class = var_0_10000

local var_0_0 = "ServerLoginCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.LoginLastTime = 0
var_0_1.LoginSafeLock = 0

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert = var_1_10003
	isa = var_1_10005

	local var_1_1 = var_1_0

	Server = var_1_10008

	var_1_10003(var_1_10005(var_1_1, var_1_10008), "should be an instance of Server")

	local var_1_2 = var_1_0
	local var_1_3 = var_1_0.getHost(var_1_2)
	local var_1_4 = var_1_0:getPort()

	originalPrint = var_1_2

	var_1_2("connect to game server - " .. var_1_3 .. ":" .. var_1_4)

	getProxy = var_1_2
	UserProxy = var_7

	local var_1_5 = var_1_2(var_7)
	local var_1_6 = var_5.getData(var_1_5)

	pg = var_7

	local var_1_7 = var_7.SdkMgr.GetInstance()

	if var_7.GetChannelUID(var_1_7) == "" then
		PLATFORM_LOCAL = var_7
	end

	local function var_1_8(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.ConnectionMgr.GetInstance()
		local var_2_1 = var_1.Send
		local var_2_2 = 10022
		local var_2_3 = {
			platform = var_0,
			account_id = var_1_6.uid,
			server_ticket = arg_2_0 or var_1_6.token,
			serverid = var_1_0.id
		}

		HashUtil = var_6

		local var_2_4 = var_6.CalcMD5
		local var_2_5 = var_1_6.token

		AABBUDUD = var_2_10009
		var_2_3.check_key = var_2_4(var_2_5 .. var_2_10009)
		pg = var_6

		local var_2_6 = var_6.SdkMgr.GetInstance()

		var_2_3.device_id = var_6.GetDeviceId(var_2_6)

		var_2_1(var_2_0, var_2_2, var_2_3, 10023, function(arg_3_0)
			if arg_3_0.result == 0 then
				originalPrint = var_1

				var_1("connect success: " .. arg_3_0.user_id)

				local var_3_0 = var_1_0.status

				Server = var_3_10002

				if var_3_0 == var_3_10002.STATUS.REGISTER_FULL and arg_3_0.user_id == 0 then
					pg = var_1
					var_3_10003 = var_1.TipsMgr.GetInstance()

					local var_3_1 = var_1.ShowTips

					i18n = var_3_10004

					var_3_1(var_3_10003, var_3_10004("login_register_full"))

					pg = var_3_1
					var_3_10003 = var_3_1.ConnectionMgr.GetInstance()

					var_1.onDisconnected(var_3_10003, true)
				else
					var_1_6.token = arg_3_0.server_ticket
					var_1_6.server = var_1_0.id
					var_3_10003 = var_0

					var_1.setLastLogin(var_3_10003, var_1_6)

					var_3_10003 = var_0

					var_1.SaveCacheGatewayFlag(var_3_10003, var_1_6.arg2)

					getProxy = var_1
					ServerProxy = var_3_10003
					var_3_10004 = var_1(var_3_10003)

					var_1.setLastServer(var_3_10004, var_1_0.id, var_1_6.uid)

					var_3_10004 = arg_1_0

					local var_3_2 = var_2.sendNotification

					GAME = var_5

					var_3_2(var_3_10004, var_5.SERVER_LOGIN_SUCCESS, {
						uid = arg_3_0.user_id
					})

					pg = var_3_2
					var_3_10004 = var_3_2.TrackerMgr.GetInstance()

					local var_3_3 = var_2.Tracking

					TRACKING_ROLE_LOGIN = var_5

					var_3_3(var_3_10004, var_5, nil, arg_3_0.user_id)

					if arg_3_0.user_id == 0 then
						pg = var_2
						var_3_10004 = var_2.SdkMgr.GetInstance()

						local var_3_4 = var_2.ChooseServer

						tostring = var_5

						var_3_4(var_3_10004, var_5(var_1_0.id), var_1_0.name)
					end
				end
			elseif arg_3_0.result == 13 then
				pg = var_1
				var_3_10003 = var_1.TipsMgr.GetInstance()

				local var_3_5 = var_1.ShowTips

				i18n = var_3_10004

				var_3_5(var_3_10003, var_3_10004("login_game_not_ready"))
			elseif arg_3_0.result == 15 then
				pg = var_1
				var_3_10003 = var_1.TipsMgr.GetInstance()

				local var_3_6 = var_1.ShowTips

				i18n = var_3_10004

				var_3_6(var_3_10003, var_3_10004("login_game_rigister_full"))
			elseif arg_3_0.result == 17 then
				var_3_10003 = arg_1_0

				local var_3_7 = var_1.sendNotification

				GAME = var_3_10004

				var_3_7(var_3_10003, var_3_10004.SERVER_LOGIN_FAILED_USER_BANNED, arg_3_0.user_id)
			elseif arg_3_0.result == 6 then
				pg = var_1
				var_3_10003 = var_1.TipsMgr.GetInstance()

				local var_3_8 = var_1.ShowTips

				i18n = var_3_10004

				var_3_8(var_3_10003, var_3_10004("login_game_login_full"))
			elseif arg_3_0.result == 18 then
				local var_3_9 = arg_3_0.db_load
				local var_3_10 = arg_3_0.server_load

				math = var_3_10003

				local var_3_11 = var_3_10003.floor(var_3_9 / 100 + var_3_10 / 1000 + 1)
				local var_3_12 = arg_1_0

				var_3_10004 = var_3_10004.sendNotification
				GAME = var_3_10007

				var_3_10004(var_3_12, var_3_10007.SERVER_LOGIN_WAIT, var_3_11)
			elseif arg_3_0.result == 26 then
				pg = var_1

				local var_3_13 = var_1.TipsMgr.GetInstance()
				local var_3_14 = var_1.ShowTips

				i18n = var_3_10004

				var_3_14(var_3_13, var_3_10004("login_game_midnightpressure"))
			else
				local var_3_15 = arg_1_0
				local var_3_16 = var_1.sendNotification

				GAME = var_3_10004

				var_3_16(var_3_15, var_3_10004.SERVER_LOGIN_FAILED, arg_3_0.result)
			end

			return
		end, false)

		return
	end

	os = var_1_7

	local var_1_9 = var_1_7.time()
	local var_1_10 = var_0_1

	var_1_10.LoginSafeLock = var_0_1.LoginSafeLock + 1
	math = var_1_10

	local var_1_11

	if var_1_10.abs(var_1_9 - var_0_1.LoginLastTime) > 1 or var_0_1.LoginSafeLock >= 5 then
		var_1_11 = var_0_1
		var_1_11.LoginLastTime = var_1_9
		var_1_11 = var_0_1
		var_1_11.LoginSafeLock = 0
		pg = var_1_11

		local var_1_12 = var_1_11.ConnectionMgr.GetInstance()

		if var_1_11.getConnection(var_1_12) then
			pg = var_1_11

			local var_1_13 = var_1_11.ConnectionMgr.GetInstance()

			if var_1_11.isConnected(var_1_13) then
				var_1_8()

				goto label_1_0
			end
		end

		pg = var_1_11

		local var_1_14 = var_1_11.ConnectionMgr.GetInstance()

		var_1_11.SetProxyHost(var_1_14, var_1_0.proxyHost, var_1_0.proxyPort)

		pg = var_1_11

		local var_1_15 = var_1_11.ConnectionMgr.GetInstance()

		var_1_11.Connect(var_1_15, var_1_3, var_1_4, function()
			originalPrint = var_2_10000

			var_2_10000("server: " .. var_1_0.id .. " uid: " .. var_1_6.uid)
			var_1_8()

			return
		end, 6)
	else
		pg = var_1_11

		local var_1_16 = var_1_11.TipsMgr.GetInstance()
		local var_1_17 = var_10.ShowTips

		i18n = var_1_10013

		var_1_17(var_1_16, var_1_10013("login_game_frequence"))
	end

	::label_1_0::

	return
end

return var_0_1
