ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCameraFollowGesture = var_0_10004("BattleCameraFollowGesture")
var_0.Battle.BattleCameraFollowGesture.__name = "BattleCameraFollowGesture"

local var_0_4 = var_0.Battle.BattleCameraFollowGesture

function var_0_4.Ctor(arg_1_0)
	Vector3 = var_1_10001
	arg_1_0._point = var_1_10001.zero

	return
end

function var_0_4.SetGestureComponent(arg_2_0, arg_2_1)
	arg_2_0._slider = arg_2_1

	return
end

function var_0_4.GetCameraPos(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._slider

	if var_2.IsPress(var_3_0) then
		local var_3_1

		if not arg_3_0._pressPoint then
			var_3_1 = arg_3_1
		end

		arg_3_0._pressPoint = var_3_1

		local var_3_2 = arg_3_0._slider
		local var_3_3, var_3_4 = var_2.IsFirstPress(var_3_2)
		local var_3_5 = arg_3_0._pressPoint.x
		local var_3_6 = arg_3_0._pressPoint.y

		if var_3_3 then
			arg_3_0._pressPoint.x = arg_3_1.x
		end

		if var_3_4 then
			arg_3_0._pressPoint.z = arg_3_1.z
		end

		local var_3_7 = arg_3_0._slider
		local var_3_8, var_3_9 = var_6.GetDistance(var_3_7)
		local var_3_10 = arg_3_0._point

		var_8.Set(var_3_10, arg_3_0._pressPoint.x, arg_3_0._pressPoint.y, arg_3_0._pressPoint.z)

		arg_3_0._point.z = arg_3_0._point.z + var_3_9 * -80
		arg_3_0._point.x = arg_3_0._point.x + var_3_8 * -80

		return arg_3_0._point
	else
		return arg_3_1
	end

	return
end

function var_0_4.Dispose(arg_4_0)
	arg_4_0._slider = nil

	return
end

return
