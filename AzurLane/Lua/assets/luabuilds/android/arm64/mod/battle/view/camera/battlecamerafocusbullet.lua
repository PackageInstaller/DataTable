ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCameraFocusBulet = var_0_10004("BattleCameraFocusBulet")
var_0.Battle.BattleCameraFocusBulet.__name = "BattleCameraFocusBulet"

local var_0_4 = var_0.Battle.BattleCameraFocusBulet

function var_0_4.Ctor(arg_1_0)
	return
end

function var_0_4.SetUnit(arg_2_0, arg_2_1)
	arg_2_0._unit = arg_2_1

	return
end

function var_0_4.GetCameraPos(arg_3_0)
	local var_3_0 = arg_3_0._unit
	local var_3_1 = var_1.GetPosition(var_3_0)

	var_1.y = var_1.Clone(var_3_1).y + var_0_2.CameraFocusHeight
	var_1.z = var_1.z - var_1.y / var_0_2._camera_radian_x_tan

	return var_1
end

function var_0_4.Dispose(arg_4_0)
	arg_4_0._unit = nil

	return
end

return
