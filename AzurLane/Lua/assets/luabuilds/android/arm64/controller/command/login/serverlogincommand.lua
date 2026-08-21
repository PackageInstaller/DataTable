local var_0_0 = class("ServerLoginCommand", pm.SimpleCommand)

var_0_0.LoginLastTime = 0
var_0_0.LoginSafeLock = 0

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert(isa(var_1_0, Server), "should be an instance of Server")

	local var_1_1 = var_1_0:getHost()
	local var_1_2 = var_1_0:getPort()

	originalPrint("connect to game server - " .. var_1_1 .. ":" .. var_1_2)

	local var_1_3 = getProxy(UserProxy)
	local var_1_4 = getProxy(UserProxy):getData()
	local var_1_5

	if pg.SdkMgr.GetInstance():GetChannelUID() == "" then
		var_1_5 = PLATFORM_LOCAL
	end

	local function var_1_6(arg_2_0)
		local var_2_0 = {
			platform = var_1_5,
			account_id = var_1_4.uid,
			server_ticket = arg_2_0 or var_1_4.token,
			serverid = var_1_0.id,
			check_key = HashUtil.CalcMD5(var_1_4.token .. AABBUDUD)
		}

		var_2_0.device_id = pg.SdkMgr.GetInstance():GetDeviceId()

		pg.ConnectionMgr.GetInstance():Send(10022, var_2_0, 10023, function(arg_3_0)
			if arg_3_0.result == 0 then
				originalPrint("connect success: " .. arg_3_0.user_id)

				if var_1_0.status == Server.STATUS.REGISTER_FULL and arg_3_0.user_id == 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("login_register_full"))
					pg.ConnectionMgr.GetInstance():onDisconnected(true)
				else
					var_1_4.token = arg_3_0.server_ticket
					var_1_4.server = var_1_0.id

					var_1_3:setLastLogin(var_1_4)
					var_1_3:SaveCacheGatewayFlag(var_1_4.arg2)
					getProxy(ServerProxy):setLastServer(var_1_0.id, var_1_4.uid)
					arg_1_0:sendNotification(GAME.SERVER_LOGIN_SUCCESS, {
						uid = arg_3_0.user_id
					})
					pg.TrackerMgr.GetInstance():Tracking(TRACKING_ROLE_LOGIN, nil, arg_3_0.user_id)

					if arg_3_0.user_id == 0 then
						pg.SdkMgr.GetInstance():ChooseServer(tostring(var_1_0.id), var_1_0.name)
					end
				end
			elseif arg_3_0.result == 13 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("login_game_not_ready"))
			elseif arg_3_0.result == 15 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("login_game_rigister_full"))
			elseif arg_3_0.result == 17 then
				arg_1_0:sendNotification(GAME.SERVER_LOGIN_FAILED_USER_BANNED, arg_3_0.user_id)
			elseif arg_3_0.result == 6 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("login_game_login_full"))
			elseif arg_3_0.result == 18 then
				arg_1_0:sendNotification(GAME.SERVER_LOGIN_WAIT, (math.floor(arg_3_0.db_load / 100 + arg_3_0.server_load / 1000 + 1)))
			elseif arg_3_0.result == 26 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("login_game_midnightpressure"))
			else
				arg_1_0:sendNotification(GAME.SERVER_LOGIN_FAILED, arg_3_0.result)
			end

			return
		end, false)

		return
	end

	local var_1_7 = os.time()

	var_0_0.LoginSafeLock = var_0_0.LoginSafeLock + 1

	if math.abs(var_1_7 - var_0_0.LoginLastTime) > 1 or var_0_0.LoginSafeLock >= 5 then
		var_0_0.LoginLastTime = var_1_7
		var_0_0.LoginSafeLock = 0

		if pg.ConnectionMgr.GetInstance():getConnection() then
			if pg.ConnectionMgr.GetInstance():isConnected() then
				var_1_6()

				goto label_1_0
			end
		end

		pg.ConnectionMgr.GetInstance():SetProxyHost(var_1_0.proxyHost, var_1_0.proxyPort)
		pg.ConnectionMgr.GetInstance():Connect(var_1_1, var_1_2, function()
			originalPrint("server: " .. var_1_0.id .. " uid: " .. var_1_4.uid)
			var_1_6()

			return
		end, 6)
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("login_game_frequence"))
	end

	::label_1_0::

	return
end

return var_0_0
