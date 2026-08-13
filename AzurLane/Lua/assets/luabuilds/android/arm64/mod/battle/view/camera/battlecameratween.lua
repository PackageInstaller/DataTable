ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCameraTween = var_0_10004("BattleCameraTween")
var_0.Battle.BattleCameraTween.__name = "BattleCameraTween"

local var_0_4 = var_0.Battle.BattleCameraTween

function var_0_4.Ctor(arg_1_0)
	Vector3 = var_1_10001
	arg_1_0._point = var_1_10001.zero

	return
end

function var_0_4.SetFromTo(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local var_2_0 = arg_2_0._point

	var_8.Set(var_2_0, arg_2_2.x, arg_2_2.y, arg_2_2.z)

	LeanTween = var_8

	local var_2_1 = var_8.value

	go = var_2_0

	local var_2_2 = var_2_1(var_2_0(arg_2_1), arg_2_2, arg_2_3, arg_2_4)
	local var_2_3 = var_8.setOnUpdateVector3

	System = var_11

	local var_2_4 = var_2_3(var_2_2, var_11.Action_UnityEngine_Vector3(function(arg_3_0)
		local var_3_0 = arg_2_0._point

		var_1.Set(var_3_0, arg_3_0.x, arg_3_0.y, arg_3_0.z)

		return
	end))

	if arg_2_5 and arg_2_5 ~= 0 then
		var_2_4:setDelay(arg_2_5)
	end

	if arg_2_6 then
		local var_2_5 = var_2_4
		local var_2_6 = var_2_4.setEase

		LeanTweenType = var_12

		var_2_6(var_2_5, var_12.easeOutExpo)
	end

	if arg_2_7 then
		local var_2_7 = var_2_4
		local var_2_8 = var_2_4.setOnComplete

		System = var_12

		var_2_8(var_2_7, var_12.Action(function()
			arg_2_7()

			return
		end))
	end

	return
end

function var_0_4.GetCameraPos(arg_5_0)
	return arg_5_0._point
end

function var_0_4.Dispose(arg_6_0)
	arg_6_0._point = nil

	return
end

return
