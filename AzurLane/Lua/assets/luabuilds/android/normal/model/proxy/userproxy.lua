class = var_0_10000

local var_0_0 = "UserProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.userIsLogined = false
	arg_1_0.gateways = {}
	arg_1_0.canSwitchGateway = false

	return
end

function var_0_1.setLastLogin(arg_2_0, arg_2_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_2_0 = arg_2_1

	User = var_1_10005

	var_1_10002(var_1_10003(var_2_0, var_1_10005), "should be an instance of User")

	if arg_2_1.type == 1 then
		PlayerPrefs = var_2

		var_2.SetString("user.type", "1")

		PlayerPrefs = var_2

		var_2.SetString("user.arg1", arg_2_1.arg1)

		PlayerPrefs = var_2

		var_2.SetString("user.arg2", arg_2_1.arg2)

		PlayerPrefs = var_2

		var_2.SetString("user.arg3", arg_2_1.arg3)
	elseif arg_2_1.type == 2 then
		PlayerPrefs = var_2

		var_2.SetString("user.type", "1")

		PlayerPrefs = var_2

		var_2.SetString("user.arg1", "yongshi")

		PlayerPrefs = var_2

		var_2.SetString("user.arg2", arg_2_1.arg1)

		PlayerPrefs = var_2

		var_2.SetString("user.arg3", arg_2_1.token)
	elseif arg_2_1.type == 3 then
		PlayerPrefs = var_2

		var_2.SetString("user.type", "3")

		PlayerPrefs = var_2

		var_2.SetString("user.arg1", arg_2_1.arg1)

		PlayerPrefs = var_2

		var_2.SetString("user.arg2", "")

		PlayerPrefs = var_2

		var_2.SetString("user.arg3", "")

		PlayerPrefs = var_2

		var_2.SetString("guest_uuid", arg_2_1.arg1)
	end

	PlayerPrefs = var_2

	var_2.Save()

	arg_2_0.data = arg_2_1:clone()

	local var_2_1 = arg_2_0.data

	var_2.display(var_2_1, "logged in")

	PLATFORM_CODE = var_2
	PLATFORM_JP = var_2_1

	if var_2 == var_2_1 then
		arg_2_0:clearTranscode()
	end

	return
end

function var_0_1.getLastLoginUser()
	tonumber = var_1_10000
	PlayerPrefs = var_1_10001

	local var_3_0 = var_1_10000(var_1_10001.GetString("user.type"))

	PlayerPrefs = var_1

	local var_3_1 = var_1.GetString("user.arg1")

	PlayerPrefs = var_2

	local var_3_2 = var_2.GetString("user.arg2")

	PlayerPrefs = var_3

	local var_3_3 = var_3.GetString("user.arg3")

	print = var_4

	var_4("last login:", var_3_0, " arg1:", var_3_1)

	if var_3_0 ~= "" and var_3_1 ~= "" and var_3_2 ~= "" then
		User = var_4

		return var_4.New({
			type = var_3_0,
			arg1 = var_3_1,
			arg2 = var_3_2,
			arg3 = var_3_3
		})
	end

	return nil
end

function var_0_1.saveTranscode(arg_4_0, arg_4_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetString("transcode", arg_4_1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.getTranscode(arg_5_0)
	PlayerPrefs = var_1_10001

	if var_1_10001.GetString("transcode") then
		return var_1
	end

	return ""
end

function var_0_1.clearTranscode(arg_6_0)
	PlayerPrefs = var_1_10001

	var_1_10001.DeleteKey("transcode")

	return
end

function var_0_1.SetLoginedFlag(arg_7_0, arg_7_1)
	arg_7_0.userIsLogined = arg_7_1

	return
end

function var_0_1.GetLoginedFlag(arg_8_0)
	return arg_8_0.userIsLogined
end

local var_0_2 = "#cacheGatewayFlag#"

function var_0_1.SetDefaultGateway(arg_9_0)
	local var_9_0 = arg_9_0.gateways

	PLATFORM = var_1_10002

	if not var_9_0[var_1_10002] then
		local var_9_1 = arg_9_0.gateways

		PLATFORM = var_1_10002
		GatewayInfo = var_1_10003

		local var_9_2 = var_1_10003.New

		NetConst = var_1_10004

		local var_9_3 = var_1_10004.GATEWAY_HOST

		NetConst = var_1_10005

		local var_9_4 = var_1_10005.GATEWAY_PORT

		NetConst = var_1_10006

		local var_9_5 = var_1_10006.PROXY_GATEWAY_HOST

		NetConst = var_1_10007
		var_9_1[var_1_10002] = var_9_2(var_9_3, var_9_4, var_9_5, var_1_10007.PROXY_GATEWAY_PORT)
	end

	return
end

function var_0_1.ShouldSwitchGateway(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:GetCacheGatewayFlag(arg_10_2) ~= arg_10_1
end

function var_0_1.GetGateWayByPlatform(arg_11_0, arg_11_1)
	return arg_11_0.gateways[arg_11_1]
end

function var_0_1.SetGatewayForPlatform(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.gateways[arg_12_1] = arg_12_2

	return
end

function var_0_1.GetCacheGatewayFlag(arg_13_0, arg_13_1)
	if not arg_13_0.cachePlatform then
		PlayerPrefs = var_2

		local var_13_0 = var_2.GetInt
		local var_13_1 = var_0_2 .. arg_13_1

		PLATFORM = var_4
		arg_13_0.cachePlatform = var_13_0(var_13_1, var_4)
	end

	return arg_13_0.cachePlatform
end

function var_0_1.GetCacheGatewayInServerLogined(arg_14_0)
	if not arg_14_0.cachePlatform then
		PLATFORM = var_1
	end

	return var_1
end

function var_0_1.SetCacheGatewayFlag(arg_15_0, arg_15_1)
	if arg_15_0.cachePlatform ~= arg_15_1 then
		arg_15_0.cachePlatform = arg_15_1
	end

	return
end

function var_0_1.SaveCacheGatewayFlag(arg_16_0, arg_16_1)
	if not arg_16_0.canSwitchGateway then
		return
	end

	PlayerPrefs = var_2

	local var_16_0 = var_2.GetInt
	local var_16_1 = var_0_2 .. arg_16_1

	PLATFORM = var_4

	if var_16_0(var_16_1, var_4) ~= arg_16_0.cachePlatform then
		PlayerPrefs = var_3

		var_3.SetInt(var_0_2 .. arg_16_1, arg_16_0.cachePlatform)

		PlayerPrefs = var_3

		var_3.Save()
	end

	return
end

function var_0_1.GetReversePlatform(arg_17_0)
	local var_17_0 = arg_17_0.cachePlatform

	PLATFORM_IPHONEPLAYER = var_1_10002

	if var_17_0 == var_1_10002 then
		PLATFORM_ANDROID = var_17_0

		if not var_17_0 then
			PLATFORM_IPHONEPLAYER = var_17_0
		end

		return var_17_0
	end
end

function var_0_1.ActiveGatewaySwitcher(arg_18_0)
	arg_18_0.canSwitchGateway = true

	return
end

function var_0_1.ShowGatewaySwitcher(arg_19_0)
	return arg_19_0.canSwitchGateway
end

return var_0_1
