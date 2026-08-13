class = var_0_10000

local var_0_0 = "UserLoginCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert = var_1_10003
	isa = var_1_10005

	local var_1_1 = var_1_0

	User = var_1_10008

	var_1_10003(var_1_10005(var_1_1, var_1_10008), "should be an instance of User")

	originalPrint = var_1_10003

	local var_1_2 = "connect to gateway - "

	NetConst = var_6

	local var_1_3 = var_6.GATEWAY_HOST
	local var_1_4 = ":"

	NetConst = var_1_10008

	var_1_10003(var_1_2 .. var_1_3 .. var_1_4 .. var_1_10008.GATEWAY_PORT)

	pg = var_1_10003

	local var_1_5 = var_1_10003.SdkMgr.GetInstance()

	if var_3.GetChannelUID(var_1_5) == "" then
		PLATFORM_LOCAL = var_3
	end

	if not var_1_0.arg4 then
		var_1_0.arg4 = "0"
	end

	local var_1_6

	if var_1_0.arg4 ~= "0" or not var_1_0.arg3 then
		var_1_6 = var_1_0.arg4
	end

	originalPrint = var_1_5

	var_1_5("login type -- : ", var_1_0.type, ", arg3 -- : ", var_1_6, ", sessionid -- : " .. var_1_0.arg4)

	pg = var_1_5

	local var_1_7 = var_1_5.ConnectionMgr.GetInstance()
	local var_1_8 = var_5.SetProxyHost

	NetConst = var_8

	local var_1_9 = var_8.PROXY_GATEWAY_HOST

	NetConst = var_9

	var_1_8(var_1_7, var_1_9, var_9.PROXY_GATEWAY_PORT)

	pg = var_1_8

	local var_1_10 = var_1_8.ConnectionMgr.GetInstance()
	local var_1_11 = var_5.Connect

	NetConst = var_1_9

	local var_1_12 = var_1_9.GATEWAY_HOST

	NetConst = var_9

	var_1_11(var_1_10, var_1_12, var_9.GATEWAY_PORT, function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()
		local var_2_1 = var_0.Send
		local var_2_2 = 10020
		local var_2_3 = {
			login_type = var_1_0.type,
			arg1 = var_1_0.arg1,
			arg2 = var_1_0.arg2,
			arg3 = var_1_6,
			arg4 = var_0
		}

		HashUtil = var_5

		local var_2_4 = var_5.CalcMD5
		local var_2_5 = var_1_0.arg1

		AABBUDUD = var_2_10008
		var_2_3.check_key = var_2_4(var_2_5 .. var_2_10008)
		PLATFORM = var_5
		var_2_3.device = var_5

		var_2_1(var_2_0, var_2_2, var_2_3, 10021, function(arg_3_0)
			originalPrint = var_3_10001

			var_3_10001("disconnect from gateway...")

			pg = var_3_10001

			local var_3_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Disconnect(var_3_0)

			local var_3_1

			if arg_3_0.result == 0 then
				var_3_1 = var_1_0
				var_3_1.id = arg_3_0.account_id
				var_3_1 = var_1_0
				var_3_1.uid = arg_3_0.account_id
				var_3_1 = var_1_0
				var_3_1.token = arg_3_0.server_ticket
				var_3_1 = var_1_0
				var_3_1.limitServerIds = arg_3_0.limit_server_ids
				getProxy = var_3_1
				UserProxy = var_3_0
				var_3_10004 = var_3_1(var_3_0)

				var_3_1.setLastLogin(var_3_10004, var_1_0)

				var_3_10004 = var_3_1

				var_3_1.SetLoginedFlag(var_3_10004, true)

				local var_3_2 = {}
				local var_3_3 = {
					"*all gate info :"
				}

				ipairs = var_3_10004

				for iter_3_0, iter_3_1 in var_3_10004(arg_3_0.serverlist) do
					Server = var_3_10009
					var_3_10009 = var_3_10009.New({
						id = iter_3_1.ids[1],
						host = iter_3_1.ip,
						port = iter_3_1.port,
						proxy_host = iter_3_1.proxy_ip,
						proxy_port = iter_3_1.proxy_port,
						status = iter_3_1.state,
						name = iter_3_1.name,
						tag_state = iter_3_1.tag_state,
						sort = iter_3_1.sort,
						ids = iter_3_1.ids
					})
					var_3_3[#var_3_3 + 1] = iter_3_1.proxy_ip .. ":" .. iter_3_1.proxy_port
					var_3_3[#var_3_3 + 1] = iter_3_1.ip .. ":" .. iter_3_1.port

					var_3_10009:display()

					table = var_10

					var_10.insert(var_3_2, var_3_10009)
				end

				originalPrint = var_3_10004
				table = var_6

				var_3_10004(var_6.concat(var_3_3, "\n"))

				getProxy = var_3_10004
				ServerProxy = var_6

				local var_3_4 = var_3_10004(var_6)

				var_3_10004.setServers(var_3_4, var_3_2, var_1_0.uid)

				if arg_3_0.limit_server_ids and #arg_3_0.limit_server_ids > 0 then
					var_3_10004.firstServer = nil
				end

				getProxy = var_5
				GatewayNoticeProxy = var_3_4

				local var_3_5 = var_5(var_3_4)

				var_5.setGatewayNotices(var_3_5, arg_3_0.notice_list)

				local var_3_6 = arg_1_0.facade
				local var_3_7 = var_6.sendNotification

				GAME = var_9

				var_3_7(var_3_6, var_9.USER_LOGIN_SUCCESS, var_1_0)

				pg = var_3_7

				local var_3_8 = var_3_7.PushNotificationMgr.GetInstance()

				var_6.cancelAll(var_3_8)

				originalPrint = var_6

				var_6("user logined............", #var_3_2)

				pg = var_6

				local var_3_9 = var_6.SdkMgr.GetInstance()

				var_6.SdkGateWayLogined(var_3_9)
			else
				pg = var_3_1

				local var_3_10 = var_3_1.SdkMgr.GetInstance()

				var_1.SdkLoginGetaWayFailed(var_3_10)

				originalPrint = var_1

				var_1("user login failed ............")

				if arg_3_0.result == 13 then
					pg = var_1

					local var_3_11 = var_1.TipsMgr.GetInstance()
					local var_3_12 = var_1.ShowTips

					i18n = var_3_10004

					var_3_12(var_3_11, var_3_10004("login_gate_not_ready"))
				elseif arg_3_0.result == 15 then
					pg = var_1

					local var_3_13 = var_1.TipsMgr.GetInstance()
					local var_3_14 = var_1.ShowTips

					i18n = var_3_10004

					var_3_14(var_3_13, var_3_10004("login_game_rigister_full"))
				elseif arg_3_0.result == 18 then
					pg = var_1

					local var_3_15 = var_1.TipsMgr.GetInstance()
					local var_3_16 = var_1.ShowTips

					i18n = var_3_10004

					var_3_16(var_3_15, var_3_10004("system_database_busy"))
				elseif arg_3_0.result == 6 then
					pg = var_1

					local var_3_17 = var_1.TipsMgr.GetInstance()
					local var_3_18 = var_1.ShowTips

					i18n = var_3_10004

					var_3_18(var_3_17, var_3_10004("login_game_login_full"))
				else
					local var_3_19 = arg_1_0.facade
					local var_3_20 = var_1.sendNotification

					GAME = var_3_10004

					var_3_20(var_3_19, var_3_10004.USER_LOGIN_FAILED, arg_3_0.result)
				end
			end

			return
		end, false)

		return
	end)

	return
end

return var_0_1
