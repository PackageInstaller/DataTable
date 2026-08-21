local var_0_0 = Vector2.zero
local var_0_1 = rawget
local var_0_2 = setmetatable

TouchPhase = {
	Stationary = 2,
	Canceled = 4,
	Moved = 1,
	Ended = 3,
	Began = 0
}
TouchBits = {
	DeltaPosition = 1,
	Position = 2,
	RawPosition = 4,
	ALL = 7
}

local var_0_3 = TouchPhase
local var_0_4 = TouchBits
local var_0_5 = {}
local var_0_6 = tolua.initget(var_0_5)

function var_0_5.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1(var_0_5, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_1(var_0_6, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_5.New(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	return var_0_2({
		fingerId = arg_2_0 or 0,
		position = arg_2_1 or var_0_0,
		rawPosition = arg_2_2 or var_0_0,
		deltaPosition = arg_2_3 or var_0_0,
		deltaTime = arg_2_4 or 0,
		tapCount = arg_2_5 or 0,
		phase = arg_2_6 or 0
	}, var_0_5)
end

function var_0_5.OnCtor(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	arg_3_0.fingerId = arg_3_1
	arg_3_0.position = arg_3_2
	arg_3_0.rawPosition = arg_3_3
	arg_3_0.deltaPosition = arg_3_4
	arg_3_0.deltaTime = arg_3_5
	arg_3_0.tapCount = arg_3_6
	arg_3_0.phase = arg_3_7
end

function var_0_5.Destroy(arg_4_0)
	arg_4_0.position = nil
	arg_4_0.rawPosition = nil
	arg_4_0.deltaPosition = nil
end

function var_0_5.GetMask(...)
	local var_5_0 = {
		...
	}
	local var_5_1 = 0

	for iter_5_0 = 1, #var_5_0 do
		local var_5_2 = var_0_4[var_5_0[iter_5_0]] or 0

		if var_5_2 ~= 0 then
			var_5_1 = var_5_1 + var_5_2
		end
	end

	if var_5_1 == 0 then
		var_5_1 = var_0_4.all
	end

	return var_5_1
end

UnityEngine.TouchPhase = var_0_3
UnityEngine.Touch = var_0_5

var_0_2(var_0_5, var_0_5)

return var_0_5
