Vector2 = var_0_10000

local var_0_0 = var_0_10000.zero

rawget = var_0_10001
setmetatable = var_0_10002

local var_0_1 = {
	Stationary = 2,
	Canceled = 4,
	Moved = 1,
	Ended = 3,
	Began = 0
}
local var_0_2 = TouchPhase
local var_0_3 = {
	DeltaPosition = 1,
	Position = 2,
	RawPosition = 4,
	ALL = 7
}

TouchPhase = TouchBits
TouchBits = var_0_10004

local var_0_4 = {}

tolua = var_0_10006

local var_0_5 = var_0_10006.initget(var_0_4)

function var_0_4.__index(arg_1_0, arg_1_1)
	if var_0_10001(var_0_4, arg_1_1) == nil and var_0_10001(var_0_5, arg_1_1) ~= nil then
		return var_2(arg_1_0)
	end

	return var_2
end

function var_0_4.New(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	return var_0_10002({
		fingerId = arg_2_0 or 0,
		position = arg_2_1 or var_0_0,
		rawPosition = arg_2_2 or var_0_0,
		deltaPosition = arg_2_3 or var_0_0,
		deltaTime = arg_2_4 or 0,
		tapCount = arg_2_5 or 0,
		phase = arg_2_6 or 0
	}, var_0_4)
end

function var_0_4.Init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	arg_3_0.fingerId = arg_3_1
	arg_3_0.position = arg_3_2
	arg_3_0.rawPosition = arg_3_3
	arg_3_0.deltaPosition = arg_3_4
	arg_3_0.deltaTime = arg_3_5
	arg_3_0.tapCount = arg_3_6
	arg_3_0.phase = arg_3_7

	return
end

function var_0_4.Destroy(arg_4_0)
	arg_4_0.position = nil
	arg_4_0.rawPosition = nil
	arg_4_0.deltaPosition = nil

	return
end

function var_0_4.GetMask(...)
	local var_5_0 = {
		...
	}
	local var_5_1 = 0

	for iter_5_0 = 1, #var_5_0 do
		local var_5_2

		if not var_0_10004[var_5_0[iter_5_0]] then
			var_5_2 = 0
		end

		if var_5_2 ~= 0 then
			var_5_1 = var_5_1 + var_5_2
		end
	end

	if var_5_1 == 0 then
		var_5_1 = var_0_10004.all
	end

	return var_5_1
end

UnityEngine = var_7
var_7.TouchPhase = var_3
UnityEngine = var_7
var_7.Touch = var_0_4

var_0_10002(var_0_4, var_0_4)

return var_0_4
