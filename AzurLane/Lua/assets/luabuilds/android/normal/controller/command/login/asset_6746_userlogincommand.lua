class = var_0_10000

local var_0_0 = "UserLoginCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	assert = var_1_0
	isa = var_1_10004

	local var_1_2 = var_1_1

	User = var_1_10006

	var_1_0(var_1_10004(var_1_2, var_1_10006), "should be an instance of User")

	originalPrint = var_1_0

	local var_1_3 = "connect to gateway - "

	NetConst = var_5

	local var_1_4 = var_5.GATEWAY_HOST
	local var_1_5 = ":"

	NetConst = var_1_10007

	var_1_0(var_1_3 .. var_1_4 .. var_1_5 .. var_1_10007.GATEWAY_PORT)

	pg = var_1_0

	local var_1_6 = var_1_0.SdkMgr.GetInstance()

	if var_3.GetChannelUID(var_1_6) == "" then
		PLATFORM_LOCAL = var_3
	end

	if not var_1_1.arg4 then
		var_1_1.arg4 = "0"
	end

	local var_1_7

	if var_1_1.arg4 ~= "0" or not var_1_1.arg3 then
		var_1_7 = var_1_1.arg4
	end

	originalPrint = var_1_4

	var_1_4("login type -- : ", var_1_1.type, ", arg3 -- : ", var_1_7, ", sessionid -- : " .. var_1_1.arg4)

	pg = var_1_4

	local var_1_8 = var_1_4.ConnectionMgr.GetInstance()
	local var_1_9 = var_5.SetProxyHost

	NetConst = var_7

	local var_1_10 = var_7.PROXY_GATEWAY_HOST

	NetConst = var_8

	var_1_9(var_1_8, var_1_10, var_8.PROXY_GATEWAY_PORT)

	pg = var_1_9

	local var_1_11 = var_1_9.ConnectionMgr.GetInstance()
	local var_1_12 = var_5.Connect

	NetConst = var_1_10

	local var_1_13 = var_1_10.GATEWAY_HOST

	NetConst = var_8

	var_1_12(var_1_11, var_1_13, var_8.GATEWAY_PORT, function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()
		local var_2_1 = var_0.Send
		local var_2_2 = 10020
		local var_2_3 = {
			login_type = var_1_1.type,
			arg1 = var_1_1.arg1,
			arg2 = var_1_1.arg2,
			arg3 = var_1_7,
			arg4 = var_0
		}

		HashUtil = var_4

		local var_2_4 = var_4.CalcMD5
		local var_2_5 = var_1_1.arg1

		AABBUDUD = var_2_10006
		var_2_3.check_key = var_2_4(var_2_5 .. var_2_10006)
		PLATFORM = var_4
		var_2_3.device = var_4

		var_2_1(var_2_0, var_2_2, var_2_3, 10021, function(arg_3_0)
			originalPrint = var_3_10001

			var_3_10001("disconnect from gateway...")

			pg = var_3_10001

			local var_3_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Disconnect(var_3_0)

			local var_3_1

			if arg_3_0.result == 0 then
				var_3_1 = var_1_1
				var_3_1.id = arg_3_0.account_id
				var_3_1 = var_1_1
				var_3_1.uid = arg_3_0.account_id
				var_3_1 = var_1_1
				var_3_1.token = arg_3_0.server_ticket
				var_3_1 = var_1_1
				var_3_1.limitServerIds = arg_3_0.limit_server_ids
				getProxy = var_3_1
				UserProxy = var_2
				var_3_10003 = var_3_1(var_2)

				var_3_1.setLastLogin(var_3_10003, var_1_1)

				var_3_10003 = var_3_1

				var_3_1.SetLoginedFlag(var_3_10003, true)

				local var_3_2 = {}

				var_3_10003 = {
					"*all gate info :"
				}
				ipairs = var_4

				for iter_3_0, iter_3_1 in var_4(arg_3_0.serverlist) do
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
					var_3_10003[#var_3_10003 + 1] = iter_3_1.proxy_ip .. ":" .. iter_3_1.proxy_port
					var_3_10003[#var_3_10003 + 1] = iter_3_1.ip .. ":" .. iter_3_1.port

					var_3_10009:display()

					table = var_10

					var_10.insert(var_3_2, var_3_10009)
				end

				originalPrint = var_4
				table = var_5

				var_4(var_5.concat(var_3_10003, "\n"))

				getProxy = var_4
				ServerProxy = var_5

				local var_3_3 = var_4(var_5)

				var_4.setServers(var_3_3, var_3_2, var_1_1.uid)

				local var_3_4

				if arg_3_0.limit_server_ids then
					var_3_4 = #arg_3_0.limit_server_ids

					if 0 < var_3_4 then
						var_4.firstServer = nil
					end
				end

				getProxy = var_3_4
				GatewayNoticeProxy = var_3_3

				local var_3_5 = var_3_4(var_3_3)

				var_5.setGatewayNotices(var_3_5, arg_3_0.notice_list)

				local var_3_6 = arg_1_0.facade
				local var_3_7 = var_6.sendNotification

				GAME = var_8

				var_3_7(var_3_6, var_8.USER_LOGIN_SUCCESS, var_1_1)

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

					i18n = var_3_10003

					var_3_12(var_3_11, var_3_10003("login_gate_not_ready"))
				elseif arg_3_0.result == 15 then
					pg = var_1

					local var_3_13 = var_1.TipsMgr.GetInstance()
					local var_3_14 = var_1.ShowTips

					i18n = var_3_10003

					var_3_14(var_3_13, var_3_10003("login_game_rigister_full"))
				elseif arg_3_0.result == 18 then
					pg = var_1

					local var_3_15 = var_1.TipsMgr.GetInstance()
					local var_3_16 = var_1.ShowTips

					i18n = var_3_10003

					var_3_16(var_3_15, var_3_10003("system_database_busy"))
				elseif arg_3_0.result == 6 then
					pg = var_1

					local var_3_17 = var_1.TipsMgr.GetInstance()
					local var_3_18 = var_1.ShowTips

					i18n = var_3_10003

					var_3_18(var_3_17, var_3_10003("login_game_login_full"))
				else
					local var_3_19 = arg_1_0.facade
					local var_3_20 = var_1.sendNotification

					GAME = var_3_10003

					var_3_20(var_3_19, var_3_10003.USER_LOGIN_FAILED, arg_3_0.result)
				end
			end

			return
		end, false)

		return
	end)

	return
end

return var_0_1
