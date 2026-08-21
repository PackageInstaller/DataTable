local var_0_0 = class("ServerInterconnectionCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.user
	local var_1_2 = getProxy(UserProxy)

	var_1_2:SetDefaultGateway()
	var_1_2:ActiveGatewaySwitcher()

	local function var_1_3(arg_2_0)
		NetConst.GATEWAY_HOST = arg_2_0.host
		NetConst.GATEWAY_PORT = arg_2_0.port
		NetConst.PROXY_GATEWAY_HOST = arg_2_0.proxyHost
		NetConst.PROXY_GATEWAY_PORT = arg_2_0.proxyPort

		originalPrint("switch to:", NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT)
		pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
			user = var_1_1
		})

		return
	end

	if var_1_2:ShouldSwitchGateway(var_1_0.platform or PLATFORM, var_1_0.user.arg2) then
		local var_1_4 = var_1_0.platform or var_1_2:GetCacheGatewayFlag(var_1_0.user.arg2)
		local var_1_5 = var_1_2:GetGateWayByPlatform(var_1_4)

		if not var_1_5 then
			arg_1_0:GetGateWayByServer(var_1_4, function(arg_3_0)
				var_1_2:SetGatewayForPlatform(var_1_4, arg_3_0)
				var_1_2:SetCacheGatewayFlag(var_1_4)
				var_1_3(arg_3_0)

				return
			end)
		else
			var_1_2:SetCacheGatewayFlag(var_1_4)
			;(function(arg_2_0)
				NetConst.GATEWAY_HOST = arg_2_0.host
				NetConst.GATEWAY_PORT = arg_2_0.port
				NetConst.PROXY_GATEWAY_HOST = arg_2_0.proxyHost
				NetConst.PROXY_GATEWAY_PORT = arg_2_0.proxyPort

				originalPrint("switch to:", NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT)
				pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
					user = var_1_1
				})

				return
			end)(var_1_5)
		end
	else
		pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
			user = var_1_0.user
		})
	end

	return
end

function var_0_0.GetGateWayByServer(arg_4_0, arg_4_1, arg_4_2)
	pg.ConnectionMgr.GetInstance():Connect(NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT, function()
		pg.ConnectionMgr.GetInstance():Send(10802, {
			platform = arg_4_1,
			state = NetConst.GatewayState
		}, 10803, function(arg_6_0)
			pg.ConnectionMgr.GetInstance():Disconnect()

			local var_6_0 = arg_6_0.gateway_ip
			local var_6_1 = arg_6_0.gateway_port
			local var_6_2 = System.String.IsNullOrEmpty(arg_6_0.proxy_ip)

			arg_4_2((GatewayInfo.New(arg_6_0.gateway_ip, arg_6_0.gateway_port, var_6_2 and var_6_0 or arg_6_0.proxy_ip, var_6_2 and var_6_1 or arg_6_0.proxy_port)))

			return
		end)

		return
	end)

	return
end

return var_0_0
