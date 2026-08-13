class = var_0_10000

local var_0_0 = "ServerInterconnectionCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().user
	local var_1_1 = var_2.platform

	getProxy = var_1_10005
	UserProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	var_5.SetDefaultGateway(var_1_2)
	var_5:ActiveGatewaySwitcher()

	local function var_1_3(arg_2_0)
		NetConst = var_2_10001
		var_2_10001.GATEWAY_HOST = arg_2_0.host
		NetConst = var_2_10001
		var_2_10001.GATEWAY_PORT = arg_2_0.port
		NetConst = var_2_10001
		var_2_10001.PROXY_GATEWAY_HOST = arg_2_0.proxyHost
		NetConst = var_2_10001
		var_2_10001.PROXY_GATEWAY_PORT = arg_2_0.proxyPort
		originalPrint = var_2_10001

		local var_2_0 = "switch to:"

		NetConst = var_2_10003

		local var_2_1 = var_2_10003.GATEWAY_HOST

		NetConst = var_2_10004

		var_2_10001(var_2_0, var_2_1, var_2_10004.GATEWAY_PORT)

		pg = var_2_10001

		local var_2_2 = var_2_10001.m02
		local var_2_3 = var_1.sendNotification

		GAME = var_2_1

		var_2_3(var_2_2, var_2_1.PLATFORM_LOGIN_DONE, {
			user = var_1_0
		})

		return
	end

	local var_1_4 = var_5
	local var_1_5 = var_5.ShouldSwitchGateway

	if not var_1_1 then
		::label_1_0::

		PLATFORM = var_1_10009
	end

	local var_1_6

	if var_1_5(var_1_4, var_1_10009, var_1_0.arg2) then
		var_1_6 = var_1_1 or var_5:GetCacheGatewayFlag(var_1_0.arg2)
		var_1_10009 = var_5

		if not var_5.GetGateWayByPlatform(var_1_10009, var_1_6) then
			arg_1_0:GetGateWayByServer(var_1_6, function(arg_3_0)
				local var_3_0 = var_0

				var_1.SetGatewayForPlatform(var_3_0, var_1_6, arg_3_0)

				local var_3_1 = var_0

				var_1.SetCacheGatewayFlag(var_3_1, var_1_6)
				var_1_3(arg_3_0)

				return
			end)
		else
			var_5:SetCacheGatewayFlag(var_1_6)
			var_1_3(var_8)
		end
	else
		pg = var_1_6

		local var_1_7 = var_1_6.m02
		local var_1_8 = var_7.sendNotification

		GAME = var_1_10009

		var_1_8(var_1_7, var_1_10009.PLATFORM_LOGIN_DONE, {
			user = var_1_0
		})
	end

	return
end

function var_0_1.GetGateWayByServer(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.ConnectionMgr.GetInstance()
	local var_4_1 = var_3.Connect

	NetConst = var_1_10005

	local var_4_2 = var_1_10005.GATEWAY_HOST

	NetConst = var_1_10006

	var_4_1(var_4_0, var_4_2, var_1_10006.GATEWAY_PORT, function()
		pg = var_2_10000

		local var_5_0 = var_2_10000.ConnectionMgr.GetInstance()
		local var_5_1 = var_0.Send
		local var_5_2 = 10802
		local var_5_3 = {
			platform = arg_4_1
		}

		NetConst = var_4
		var_5_3.state = var_4.GatewayState

		var_5_1(var_5_0, var_5_2, var_5_3, 10803, function(arg_6_0)
			pg = var_3_10001

			local var_6_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Disconnect(var_6_0)

			local var_6_1 = arg_6_0.gateway_ip
			local var_6_2 = arg_6_0.gateway_port

			System = var_3_10003

			local var_6_3 = var_3_10003.String.IsNullOrEmpty(arg_6_0.proxy_ip) and var_6_1 or arg_6_0.proxy_ip
			local var_6_4 = var_3 and var_6_2 or arg_6_0.proxy_port

			GatewayInfo = var_3_10006

			local var_6_5 = var_3_10006.New(var_6_1, var_6_2, var_6_3, var_6_4)

			arg_4_2(var_6_5)

			return
		end)

		return
	end)

	return
end

return var_0_1
