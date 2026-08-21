local var_0_0 = class("UserProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.userIsLogined = false
	arg_1_0.gateways = {}
	arg_1_0.canSwitchGateway = false

	return
end

function var_0_0.setLastLogin(arg_2_0, arg_2_1)
	assert(isa(arg_2_1, User), "should be an instance of User")

	if arg_2_1.type == 1 then
		PlayerPrefs.SetString("user.type", "1")
		PlayerPrefs.SetString("user.arg1", arg_2_1.arg1)
		PlayerPrefs.SetString("user.arg2", arg_2_1.arg2)
		PlayerPrefs.SetString("user.arg3", arg_2_1.arg3)
	elseif arg_2_1.type == 2 then
		PlayerPrefs.SetString("user.type", "1")
		PlayerPrefs.SetString("user.arg1", "yongshi")
		PlayerPrefs.SetString("user.arg2", arg_2_1.arg1)
		PlayerPrefs.SetString("user.arg3", arg_2_1.token)
	elseif arg_2_1.type == 3 then
		PlayerPrefs.SetString("user.type", "3")
		PlayerPrefs.SetString("user.arg1", arg_2_1.arg1)
		PlayerPrefs.SetString("user.arg2", "")
		PlayerPrefs.SetString("user.arg3", "")
		PlayerPrefs.SetString("guest_uuid", arg_2_1.arg1)
	end

	PlayerPrefs.Save()

	arg_2_0.data = arg_2_1:clone()

	arg_2_0.data:display("logged in")

	if PLATFORM_CODE == PLATFORM_JP then
		arg_2_0:clearTranscode()
	end

	return
end

function var_0_0.getLastLoginUser()
	local var_3_0 = tonumber(PlayerPrefs.GetString("user.type"))
	local var_3_1 = PlayerPrefs.GetString("user.arg1")
	local var_3_2 = PlayerPrefs.GetString("user.arg2")

	print("last login:", var_3_0, " arg1:", var_3_1)

	if var_3_0 ~= "" and var_3_1 ~= "" and var_3_2 ~= "" then
		return User.New({
			type = var_3_0,
			arg1 = var_3_1,
			arg2 = var_3_2,
			arg3 = PlayerPrefs.GetString("user.arg3")
		})
	end

	return nil
end

function var_0_0.saveTranscode(arg_4_0, arg_4_1)
	PlayerPrefs.SetString("transcode", arg_4_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.getTranscode(arg_5_0)
	local var_5_0 = PlayerPrefs.GetString("transcode")

	if var_5_0 then
		return var_5_0
	end

	return ""
end

function var_0_0.clearTranscode(arg_6_0)
	PlayerPrefs.DeleteKey("transcode")

	return
end

function var_0_0.SetLoginedFlag(arg_7_0, arg_7_1)
	arg_7_0.userIsLogined = arg_7_1

	return
end

function var_0_0.GetLoginedFlag(arg_8_0)
	return arg_8_0.userIsLogined
end

local var_0_1 = "#cacheGatewayFlag#"

function var_0_0.SetDefaultGateway(arg_9_0)
	arg_9_0.gateways[PLATFORM] = arg_9_0.gateways[PLATFORM] or GatewayInfo.New(NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT, NetConst.PROXY_GATEWAY_HOST, NetConst.PROXY_GATEWAY_PORT)

	return
end

function var_0_0.ShouldSwitchGateway(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:GetCacheGatewayFlag(arg_10_2) ~= arg_10_1
end

function var_0_0.GetGateWayByPlatform(arg_11_0, arg_11_1)
	return arg_11_0.gateways[arg_11_1]
end

function var_0_0.SetGatewayForPlatform(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.gateways[arg_12_1] = arg_12_2

	return
end

function var_0_0.GetCacheGatewayFlag(arg_13_0, arg_13_1)
	arg_13_0.cachePlatform = arg_13_0.cachePlatform or PlayerPrefs.GetInt(var_0_1 .. arg_13_1, PLATFORM)

	return arg_13_0.cachePlatform
end

function var_0_0.GetCacheGatewayInServerLogined(arg_14_0)
	return arg_14_0.cachePlatform or PLATFORM
end

function var_0_0.SetCacheGatewayFlag(arg_15_0, arg_15_1)
	if arg_15_0.cachePlatform ~= arg_15_1 then
		arg_15_0.cachePlatform = arg_15_1
	end

	return
end

function var_0_0.SaveCacheGatewayFlag(arg_16_0, arg_16_1)
	if not arg_16_0.canSwitchGateway then
		return
	end

	if PlayerPrefs.GetInt(var_0_1 .. arg_16_1, PLATFORM) ~= arg_16_0.cachePlatform then
		PlayerPrefs.SetInt(var_0_1 .. arg_16_1, arg_16_0.cachePlatform)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.GetReversePlatform(arg_17_0)
	if arg_17_0.cachePlatform == PLATFORM_IPHONEPLAYER then
		return PLATFORM_ANDROID or PLATFORM_IPHONEPLAYER
	end
end

function var_0_0.ActiveGatewaySwitcher(arg_18_0)
	arg_18_0.canSwitchGateway = true

	return
end

function var_0_0.ShowGatewaySwitcher(arg_19_0)
	return arg_19_0.canSwitchGateway
end

return var_0_0
