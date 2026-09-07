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

		return
	end,
	maximumDeltaTime = function(arg_2_0)
		var_0_3.maximumDeltaTime = arg_2_0
		var_0_1.maximumDeltaTime = arg_2_0

		return
	end,
	timeScale = function(arg_3_0)
		var_0_3.timeScale = arg_3_0
		var_0_1.timeScale = arg_3_0

		return
	end,
	captureFramerate = function(arg_4_0)
		var_0_3.captureFramerate = arg_4_0
		var_0_1.captureFramerate = arg_4_0

		return
	end,
	timeSinceLevelLoad = function(arg_5_0)
		var_0_3.timeSinceLevelLoad = arg_5_0

		return
	end
}

function var_0_3.__index(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0(var_0_3, arg_6_1)

	if var_6_0 then
		return var_6_0
	end

	return var_0_1:__index(arg_6_1)
end

function var_0_3.__newindex(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_0(var_0_4, arg_7_1)

	if var_7_0 then
		return var_7_0(arg_7_2)
	end

	error(string.format("Property or indexer `UnityEngine.Time.%s' cannot be assigned to (it is read only)", arg_7_1))

	return
end

local var_0_5 = {}
local var_0_6 = 1

function var_0_5.SetDeltaTime(arg_8_0, arg_8_1, arg_8_2)
	var_0_3.deltaTime = arg_8_1
	var_0_3.unscaledDeltaTime = arg_8_2
	var_0_6 = var_0_6 - 1

	if var_0_6 == 0 and var_0_1 then
		var_0_3.time = var_0_1.time
		var_0_3.timeSinceLevelLoad = var_0_1.timeSinceLevelLoad
		var_0_3.unscaledTime = var_0_1.unscaledTime
		var_0_3.realtimeSinceStartup = var_0_1.realtimeSinceStartup
		var_0_3.frameCount = var_0_1.frameCount
		var_0_6 = 1000000
	else
		var_0_3.time = var_0_3.time + arg_8_1
		var_0_3.realtimeSinceStartup = var_0_3.realtimeSinceStartup + arg_8_2
		var_0_3.timeSinceLevelLoad = var_0_3.timeSinceLevelLoad + arg_8_1
		var_0_3.unscaledTime = var_0_3.unscaledTime + arg_8_2
	end

	return
end

function var_0_5.SetFixedDelta(arg_9_0, arg_9_1)
	var_0_3.deltaTime = arg_9_1
	var_0_3.fixedDeltaTime = arg_9_1
	var_0_3.fixedTime = var_0_3.fixedTime + arg_9_1

	return
end

function var_0_5.SetFrameCount(arg_10_0)
	var_0_3.frameCount = var_0_3.frameCount + 1

	return
end

function var_0_5.SetTimeScale(arg_11_0, arg_11_1)
	var_0_3.timeScale = arg_11_1
	var_0_1.timeScale = arg_11_1

	return var_0_3.timeScale
end

function var_0_5.GetTimestamp(arg_12_0)
	return var_0_2()
end

UnityEngine.Time = var_0_5

setmetatable(var_0_5, var_0_3)

if UnityEngine.Time ~= nil then
	var_0_3.maximumDeltaTime = UnityEngine.Time.maximumDeltaTime
	var_0_3.timeScale = UnityEngine.Time.timeScale
end

return var_0_5
