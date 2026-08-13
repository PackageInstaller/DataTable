rawget = var_0_10000
UnityEngine = var_0_10001

local var_0_0 = var_0_10001.Time

tolua = var_0_10002

local var_0_1 = var_0_10002.gettime
local var_0_2 = {
	maximumDeltaTime = 0.3333333,
	frameCount = 1,
	time = 0,
	fixedDeltaTime = 0,
	timeScale = 1,
	unscaledTime = 0,
	timeSinceLevelLoad = 0,
	realtimeSinceStartup = 0,
	unscaledDeltaTime = 0,
	deltaTime = 0,
	fixedTime = 0
}
local var_0_3 = {
	fixedDeltaTime = function(arg_1_0)
		var_0_2.fixedDeltaTime = arg_1_0
		var_0_0.fixedDeltaTime = arg_1_0

		return
	end,
	maximumDeltaTime = function(arg_2_0)
		var_0_2.maximumDeltaTime = arg_2_0
		var_0_0.maximumDeltaTime = arg_2_0

		return
	end,
	timeScale = function(arg_3_0)
		var_0_2.timeScale = arg_3_0
		var_0_0.timeScale = arg_3_0

		return
	end,
	captureFramerate = function(arg_4_0)
		var_0_2.captureFramerate = arg_4_0
		var_0_0.captureFramerate = arg_4_0

		return
	end,
	timeSinceLevelLoad = function(arg_5_0)
		var_0_2.timeSinceLevelLoad = arg_5_0

		return
	end
}

function var_0_2.__index(arg_6_0, arg_6_1)
	if var_0_10000(var_0_2, arg_6_1) then
		return var_2
	end

	return var_0_0.__index(var_0_0, arg_6_1)
end

function var_0_2.__newindex(arg_7_0, arg_7_1, arg_7_2)
	if var_0_10000(var_0_3, arg_7_1) then
		return var_3(arg_7_2)
	end

	error = var_1_10004
	string = var_6

	var_1_10004(var_6.format("Property or indexer `UnityEngine.Time.%s' cannot be assigned to (it is read only)", arg_7_1))

	return
end

local var_0_4 = {}
local var_0_5 = 1

function var_0_4.SetDeltaTime(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_2

	var_8_0.deltaTime = arg_8_1
	var_8_0.unscaledDeltaTime = arg_8_2
	var_0_5 = var_0_5 - 1

	if var_0_5 == 0 and var_0_0 then
		var_8_0.time = var_0_0.time
		var_8_0.timeSinceLevelLoad = var_0_0.timeSinceLevelLoad
		var_8_0.unscaledTime = var_0_0.unscaledTime
		var_8_0.realtimeSinceStartup = var_0_0.realtimeSinceStartup
		var_8_0.frameCount = var_0_0.frameCount
		var_0_5 = 1000000
	else
		var_8_0.time = var_8_0.time + arg_8_1
		var_8_0.realtimeSinceStartup = var_8_0.realtimeSinceStartup + arg_8_2
		var_8_0.timeSinceLevelLoad = var_8_0.timeSinceLevelLoad + arg_8_1
		var_8_0.unscaledTime = var_8_0.unscaledTime + arg_8_2
	end

	return
end

function var_0_4.SetFixedDelta(arg_9_0, arg_9_1)
	var_0_2.deltaTime = arg_9_1
	var_0_2.fixedDeltaTime = arg_9_1
	var_0_2.fixedTime = var_0_2.fixedTime + arg_9_1

	return
end

function var_0_4.SetFrameCount(arg_10_0)
	var_0_2.frameCount = var_0_2.frameCount + 1

	return
end

function var_0_4.SetTimeScale(arg_11_0, arg_11_1)
	local var_11_0 = var_0_2.timeScale

	var_0_2.timeScale = arg_11_1
	var_0_0.timeScale = arg_11_1

	return var_11_0
end

function var_0_4.GetTimestamp(arg_12_0)
	return var_0_1()
end

UnityEngine = var_7
var_7.Time = var_0_4
setmetatable = var_7

var_7(var_0_4, var_0_2)

if var_0_0 ~= nil then
	var_0_2.maximumDeltaTime = var_0_0.maximumDeltaTime
	var_0_2.timeScale = var_0_0.timeScale
end

return var_0_4
