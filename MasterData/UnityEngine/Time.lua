local var_0_0 = rawget
local var_0_1 = UnityEngine.Time
local var_0_2 = tolua.gettime
local var_0_3 = {
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
local var_0_4 = {
	fixedDeltaTime = function(arg_1_0)
		var_0_3.fixedDeltaTime = arg_1_0
		var_0_1.fixedDeltaTime = arg_1_0
	end,
	maximumDeltaTime = function(arg_2_0)
		var_0_3.maximumDeltaTime = arg_2_0
		var_0_1.maximumDeltaTime = arg_2_0
	end,
	timeScale = function(arg_3_0)
		var_0_3.timeScale = arg_3_0
		var_0_1.timeScale = arg_3_0
	end,
	captureFramerate = function(arg_4_0)
		var_0_3.captureFramerate = arg_4_0
		var_0_1.captureFramerate = arg_4_0
	end,
	timeSinceLevelLoad = function(arg_5_0)
		var_0_3.timeSinceLevelLoad = arg_5_0
	end
}

function var_0_3.__index(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0(var_0_3, arg_6_1)

	if var_6_0 then
		return var_6_0
	end

	return var_0_1.__index(var_0_1, arg_6_1)
end

function var_0_3.__newindex(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_0(var_0_4, arg_7_1)

	if var_7_0 then
		return var_7_0(arg_7_2)
	end

	error(string.format("Property or indexer `UnityEngine.Time.%s' cannot be assigned to (it is read only)", arg_7_1))
end

local var_0_5 = {}
local var_0_6 = 1

function var_0_5.SetDeltaTime(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_3

	var_8_0.deltaTime = arg_8_1
	var_8_0.unscaledDeltaTime = arg_8_2
	var_0_6 = var_0_6 - 1

	if var_0_6 == 0 and var_0_1 then
		var_8_0.time = var_0_1.time
		var_8_0.timeSinceLevelLoad = var_0_1.timeSinceLevelLoad
		var_8_0.unscaledTime = var_0_1.unscaledTime
		var_8_0.realtimeSinceStartup = var_0_1.realtimeSinceStartup
		var_8_0.frameCount = var_0_1.frameCount
		var_0_6 = 1000000
	else
		var_8_0.time = var_8_0.time + arg_8_1
		var_8_0.realtimeSinceStartup = var_8_0.realtimeSinceStartup + arg_8_2
		var_8_0.timeSinceLevelLoad = var_8_0.timeSinceLevelLoad + arg_8_1
		var_8_0.unscaledTime = var_8_0.unscaledTime + arg_8_2
	end
end

function var_0_5.SetFixedDelta(arg_9_0, arg_9_1)
	var_0_3.deltaTime = arg_9_1
	var_0_3.fixedDeltaTime = arg_9_1
	var_0_3.fixedTime = var_0_3.fixedTime + arg_9_1
end

function var_0_5.SetFrameCount(arg_10_0)
	var_0_3.frameCount = var_0_3.frameCount + 1
end

function var_0_5.SetTimeScale(arg_11_0, arg_11_1)
	local var_11_0 = var_0_3.timeScale

	var_0_3.timeScale = arg_11_1
	var_0_1.timeScale = arg_11_1

	return var_11_0
end

function var_0_5.GetTimestamp(arg_12_0)
	return var_0_2()
end

UnityEngine.Time = var_0_5

setmetatable(var_0_5, var_0_3)

if var_0_1 ~= nil then
	var_0_3.maximumDeltaTime = var_0_1.maximumDeltaTime
	var_0_3.timeScale = var_0_1.timeScale
end

return var_0_5
