module("bootstrap.BootstrapHelper", package.seeall)

local var_0_0 = {}
local var_0_1 = require("cjson")

function var_0_0.getBoolMetaData(arg_1_0)
	local var_1_0 = Astral.NativeMgr.Instance
	local var_1_1 = {
		key = arg_1_0
	}
	local var_1_2 = var_0_1.encode(var_1_1)
	local var_1_3 = "com.baitian.unity.ManifestUtilWrap"

	return (var_1_0:CallStaticBool(var_1_3, "getBooleanMetaData", var_1_2))
end

function var_0_0.getPadPath(arg_2_0)
	local var_2_0 = Astral.NativeMgr.Instance
	local var_2_1 = {
		assetPackName = arg_2_0
	}
	local var_2_2 = var_0_1.encode(var_2_1)
	local var_2_3 = "com.baitian.wrap.OneSDKWrap"

	return (var_2_0:CallStaticString(var_2_3, "getPadPath", var_2_2))
end

function var_0_0.getGameId()
	local var_3_0 = Astral.NativeMgr.Instance
	local var_3_1 = "com.baitian.wrap.OneSDKWrap"
	local var_3_2 = var_0_0.isMethodExist(var_3_1, "getGameId") and var_3_0:CallStaticString(var_3_1, "getGameId")

	if var_3_2 == nil or var_3_2 == "" then
		var_3_2 = 100304
	end

	return var_3_2
end

function var_0_0.isMethodExist(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = "com.baitian.bridge.NativeManager"
	local var_4_1 = "isMethodExist"
	local var_4_2 = {
		targetClazz = arg_4_1,
		targetMethod = arg_4_2
	}

	return (var_0_0.invokeBool(var_4_0, var_4_1, var_4_2, false))
end

function var_0_0.invokeBool(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Astral.NativeMgr.Instance

	arg_5_2 = arg_5_2 or {}

	local var_5_1 = var_0_1.encode(arg_5_2)

	if arg_5_3 == nil then
		return var_5_0:CallStaticBool(arg_5_0, arg_5_1, var_5_1)
	else
		return var_5_0:CallStaticBoolDefault(arg_5_0, arg_5_1, var_5_1, arg_5_3)
	end
end

function var_0_0.getIsBtChannel()
	local var_6_0 = BootstrapUtil.getPlatformId()

	return var_6_0 == 2 or var_6_0 == 10 or var_6_0 == 300
end

return var_0_0
