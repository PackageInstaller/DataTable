module("bootstrap.BootstrapUtil", package.seeall)

local var_0_0 = {}
local var_0_1 = require("cjson")

var_0_0.sdkClazz = "com.baitian.wrap.OneSDKWrap"
var_0_0.KEY_INIT = "key_sdk_init"
var_0_0.STATUS_OK = 0
var_0_0.INIT_SUCCESS = 1
var_0_0.INIT_PROGRESS = 0
var_0_0.INIT_FAIL = -1

local var_0_2 = false
local var_0_3 = false

function var_0_0.setSdkClazz(arg_1_0)
	var_0_0.sdkClazz = arg_1_0
end

function var_0_0.getNetworkInfo()
	local var_2_0 = Astral.NativeMgr.Instance
	local var_2_1 = var_0_0.sdkClazz
	local var_2_2 = "getNetworkInfo"
	local var_2_3 = "WIFI"

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		var_2_3 = var_2_0:CallStaticString(var_2_1, var_2_2, "{}")
	end

	return var_2_3
end

function var_0_0.sdkDestroy()
	local var_3_0 = Astral.NativeMgr.Instance
	local var_3_1 = var_0_0.sdkClazz
	local var_3_2 = "destroy"

	var_3_0:CallStatic(var_3_1, var_3_2, "{}")
end

function var_0_0.getDevJson()
	if not var_0_2 then
		local var_4_0 = Astral.NativeMgr.Instance
		local var_4_1 = var_0_0.sdkClazz
		local var_4_2 = "getDevJson"
		local var_4_3 = var_4_0:CallStaticString(var_4_1, var_4_2, "{}")

		if var_4_3 ~= "" then
			var_0_2 = var_0_1.decode(var_4_3)
		else
			var_0_2 = {}
		end
	end

	return var_0_2
end

function var_0_0.getDeviceProperties()
	if not var_0_3 then
		local var_5_0 = Astral.NativeMgr.Instance
		local var_5_1 = var_0_0.sdkClazz
		local var_5_2 = "getDeviceProperties"
		local var_5_3 = var_5_0:CallStaticString(var_5_1, var_5_2, "{}")

		if var_5_3 ~= "" then
			var_0_3 = var_0_1.decode(var_5_3)
		else
			var_0_3 = {}
		end
	end

	return var_0_3
end

function var_0_0.getGameVersionCode()
	devProperties = var_0_0.getDeviceProperties()

	return devProperties and tonumber(devProperties.gameVersionCode) or 0
end

function var_0_0.getGameVersionName()
	devProperties = var_0_0.getDeviceProperties()

	return devProperties and devProperties.gameVersionName or "0.0.0"
end

function var_0_0.getChannelId()
	var_0_2 = var_0_0.getDevJson()

	return var_0_2 and var_0_2.channelId or "0.0.0"
end

function var_0_0.getGameHotUpdateVersionCode()
	return Astral.VersionMgr.Instance.localVersion
end

function var_0_0.getPlatformId()
	local var_10_0 = Astral.NativeMgr.Instance
	local var_10_1 = var_0_0.sdkClazz
	local var_10_2 = "getPlatformId"
	local var_10_3 = var_10_0:CallStaticInt(var_10_1, var_10_2, "{}")

	if var_10_3 < 0 then
		var_10_3 = 0
	end

	return var_10_3
end

function var_0_0.getGamePackageName()
	devProperties = var_0_0.getDeviceProperties()

	return devProperties and devProperties.gamepackageName or "com.baitian.unity.editor"
end

function var_0_0.sensorsTrack(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = Astral.NativeMgr.Instance
	local var_12_1 = var_0_0.sdkClazz
	local var_12_2 = "sensorsTrack"

	arg_12_1 = arg_12_1 or {}

	if arg_12_2 == nil then
		arg_12_2 = true
	end

	local var_12_3 = {
		eventId = arg_12_0,
		properties = var_0_1.encode(arg_12_1),
		isFlush = arg_12_2
	}
	local var_12_4 = var_0_1.encode(var_12_3)

	var_12_0:CallStatic(var_12_1, var_12_2, var_12_4)
end

function var_0_0.hideTransition()
	local var_13_0 = Astral.NativeMgr.Instance
	local var_13_1 = var_0_0.sdkClazz
	local var_13_2 = "hideTransition"

	var_13_0:CallStatic(var_13_1, var_13_2, "{}")
end

function var_0_0.checkSdkInit()
	local var_14_0 = Astral.NativeMgr.Instance
	local var_14_1 = var_0_0.sdkClazz
	local var_14_2 = "checkSdkInit"

	return var_14_0:CallStaticIntDefault(var_14_1, var_14_2, "{}", var_0_0.INIT_SUCCESS)
end

function var_0_0.sdkInit(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Astral.NativeMgr.Instance
	local var_15_1 = var_0_0.sdkClazz
	local var_15_2 = "init"

	arg_15_2 = arg_15_2 or "AstralUnityStarter"
	arg_15_3 = arg_15_3 or false
	arg_15_4 = arg_15_4 or false

	local var_15_3 = {
		isHideSplash = arg_15_0,
		isDebug = not arg_15_1,
		msgGameObject = arg_15_2,
		exitMonitor = arg_15_3,
		winCloseBtnMonitor = arg_15_4
	}
	local var_15_4 = var_0_1.encode(var_15_3)

	var_15_0:CallStatic(var_15_1, var_15_2, var_15_4)
end

function var_0_0.registerInitListener(arg_16_0, arg_16_1)
	Astral.NativeMgr.Instance:SetCallback(function(arg_17_0)
		local var_17_0 = var_0_1.decode(arg_17_0)

		if var_17_0.msgkey == var_0_0.KEY_INIT then
			arg_16_0(arg_16_1, var_17_0.statusCode)
		end
	end, nil)
end

function var_0_0.clearNativeCallback()
	Astral.NativeMgr.Instance:SetCallback(nil, nil)
end

function var_0_0.showWebBrowser(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = Astral.NativeMgr.Instance
	local var_19_1 = "com.baitian.android.webview.bridge.unity.UnityWebBridge"
	local var_19_2 = "openWebView"
	local var_19_3 = {
		url = arg_19_0,
		showToolbar = arg_19_1
	}

	if arg_19_2 ~= nil and arg_19_3 ~= nil and arg_19_4 ~= nil and arg_19_5 ~= nil then
		var_19_3.x = tonumber(arg_19_2)
		var_19_3.y = tonumber(arg_19_3)
		var_19_3.width = tonumber(arg_19_4)
		var_19_3.height = tonumber(arg_19_5)
	end

	local var_19_4 = var_0_1.encode(var_19_3)

	var_19_0:CallStatic(var_19_1, var_19_2, var_19_4)
end

function var_0_0.getHotUpdateDeviceType()
	local var_20_0 = 4

	devProperties = var_0_0.getDeviceProperties()

	return devProperties and devProperties.terminal or var_20_0
end

return var_0_0
