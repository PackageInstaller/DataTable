module("logic.common.netkit.Netkit", package.seeall)

local var_0_0 = {}
local var_0_1 = require("cjson")

var_0_0.EventId = {
	Socket = {
		"701",
		"Socket"
	},
	SocketFail = {
		"702",
		"SocketFail"
	},
	Patch = {
		"801",
		"Patch"
	},
	PatchFail = {
		"802",
		"PatchFail"
	},
	GetManifest = {
		"803",
		"GetManifest"
	},
	GetManifestFail = {
		"804",
		"GetManifestFail"
	}
}
var_0_0.GameId = "100304"

function var_0_0.SetConnectClock()
	var_0_0._startConnectSocketTime = os.clock()
end

function var_0_0.trackSocketData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	if Astral.OSDef.RunOS ~= Astral.OSDef.Android and Astral.OSDef.RunOS ~= Astral.OSDef.IOS then
		return
	end

	arg_2_6 = (os.clock() - var_0_0._startConnectSocketTime) * 1000
	arg_2_6 = math.ceil(arg_2_6)

	print("socket连接", arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)

	arg_2_3 = arg_2_3 or var_0_0.GameId

	local var_2_0 = {
		data_length = arg_2_0,
		eventId = arg_2_1,
		eventName = arg_2_2,
		gameId = tostring(arg_2_3),
		userId = arg_2_4,
		host_ip = arg_2_5,
		spend_time = arg_2_6,
		start_timestamp = arg_2_7
	}

	var_0_0.invoke("trackSocketData", var_2_0)
end

function var_0_0.trackPatchData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	if Astral.OSDef.RunOS ~= Astral.OSDef.Android and Astral.OSDef.RunOS ~= Astral.OSDef.IOS then
		return
	end

	arg_3_5 = math.ceil(arg_3_5)

	print("热更数据上报", arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)

	arg_3_3 = arg_3_3 or var_0_0.GameId

	local var_3_0 = {
		data_length = arg_3_0,
		eventId = arg_3_1,
		eventName = arg_3_2,
		gameId = tostring(arg_3_3),
		url = arg_3_4,
		spend_time = arg_3_5,
		start_timestamp = arg_3_6
	}

	var_0_0.invoke("trackPatchData", var_3_0)
end

function var_0_0.trackHttpData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if Astral.OSDef.RunOS ~= Astral.OSDef.Android and Astral.OSDef.RunOS ~= Astral.OSDef.IOS then
		return
	end

	arg_4_3 = math.ceil(arg_4_3)

	print("热更配置时数据上报", arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)

	arg_4_2 = arg_4_2 or var_0_0.GameId

	local var_4_0 = {
		eventId = arg_4_0,
		eventName = arg_4_1,
		gameId = tostring(arg_4_2),
		spend_time = arg_4_3,
		start_timestamp = arg_4_4
	}

	var_0_0.invoke("trackHttpData", var_4_0)
end

function var_0_0.invoke(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or {}

	local var_5_0 = var_0_1.encode(arg_5_1)

	if not var_0_0._nativeMgr then
		var_0_0._nativeMgr = Astral.NativeMgr.Instance
	end

	var_0_0._nativeMgr:CallStatic("com.baitian.netkitWrap.NetkitWrap", arg_5_0, var_5_0)
end

return var_0_0
