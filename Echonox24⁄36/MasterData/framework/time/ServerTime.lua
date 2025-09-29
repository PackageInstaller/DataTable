module("framework.time.ServerTime", package.seeall)

local var_0_0 = {}

var_0_0._serverUtcOffset = 0
var_0_0._clientUtcOffset = 0
var_0_0._clientToServerOffset = 0
var_0_0._serverLocalStamp = os.time()
var_0_0._syncClientLocalStamp = 0

function var_0_0.init(arg_1_0)
	var_0_0._serverUtcOffset = arg_1_0

	local var_1_0 = os.time()
	local var_1_1 = os.time(os.date("!*t", os.time()))

	var_0_0._clientUtcOffset = os.difftime(var_1_0, var_1_1)
	var_0_0._clientToServerOffset = var_0_0._serverUtcOffset - var_0_0._clientUtcOffset
end

function var_0_0.clientToServerOffset()
	return var_0_0._clientToServerOffset
end

function var_0_0.sync(arg_3_0)
	var_0_0._serverLocalStamp = arg_3_0
	var_0_0._syncClientLocalStamp = Time.realtimeSinceStartup
end

function var_0_0.now()
	local var_4_0 = Time.realtimeSinceStartup - var_0_0._syncClientLocalStamp

	return var_0_0._serverLocalStamp + math.floor(var_4_0)
end

function var_0_0.nowServerLook()
	return var_0_0.now() + var_0_0._clientToServerOffset + var_0_0.getDst()
end

function var_0_0.timeServerLook(arg_6_0)
	return arg_6_0 + var_0_0._clientToServerOffset + var_0_0.getDst()
end

function var_0_0.serverTimestampOfDate(arg_7_0)
	return arg_7_0 - var_0_0._clientToServerOffset - var_0_0.getDst()
end

function var_0_0.nowDate()
	local var_8_0 = var_0_0.now()

	return (os.date("*t", var_8_0))
end

function var_0_0.nowDateServerLook()
	local var_9_0 = var_0_0.nowServerLook()

	return (os.date("*t", var_9_0))
end

function var_0_0.timeDateServerLook(arg_10_0)
	local var_10_0 = var_0_0.timeServerLook(arg_10_0)

	return (os.date("*t", var_10_0))
end

function var_0_0.formatNow(arg_11_0)
	return os.date(arg_11_0, var_0_0.now())
end

function var_0_0.formatNowServerLook(arg_12_0)
	local var_12_0 = var_0_0.nowServerLook()

	return os.date(arg_12_0, var_12_0)
end

function var_0_0.formatTimeServerLook(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.timeServerLook(arg_13_0)

	return os.date(arg_13_1, var_13_0)
end

function var_0_0.getDst()
	return os.date("*t", os.time()).isdst and -3600 or 0
end

return var_0_0
