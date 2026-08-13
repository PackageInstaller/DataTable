ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCameraFocusChar = var_0_10004("BattleCameraFocusChar")
var_0.Battle.BattleCameraFocusChar.__name = "BattleCameraFocusChar"

local var_0_4 = var_0.Battle.BattleCameraFocusChar

function var_0_4.Ctor(arg_1_0)
	Vector3 = var_1_10001
	arg_1_0._point = var_1_10001.zero

	return
end

function var_0_4.SetUnit(arg_2_0, arg_2_1)
	arg_2_0._unit = arg_2_1

	return
end

function var_0_4.GetCameraPos(arg_3_0)
	local var_3_0 = arg_3_0._unit
	local var_3_1 = var_1.GetPosition(var_3_0)
	local var_3_2 = arg_3_0._point

	var_2.Set(var_3_2, var_3_1.x, var_3_1.y, var_3_1.z)

	arg_3_0._point.y = arg_3_0._point.y + var_0_2.CameraFocusHeight
	arg_3_0._point.z = arg_3_0._point.z - arg_3_0._point.y / var_0_2._camera_radian_x_tan

	local var_3_3 = arg_3_0._unit

	if var_2.GetIFF(var_3_3) == var_0_1.FOE_CODE then
		arg_3_0._point.x = arg_3_0._point.x + 7
	else
		arg_3_0._point.x = arg_3_0._point.x - 7
	end

	return arg_3_0._point
end

function var_0_4.Dispose(arg_4_0)
	arg_4_0._unit = nil

	return
end

return
