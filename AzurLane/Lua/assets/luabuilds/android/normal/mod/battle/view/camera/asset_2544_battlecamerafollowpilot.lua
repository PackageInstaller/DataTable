ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCameraFollowPilot = var_0_10004("BattleCameraFollowPilot")
var_0.Battle.BattleCameraFollowPilot.__name = "BattleCameraFollowPilot"

local var_0_4 = var_0.Battle.BattleCameraFollowPilot

function var_0_4.Ctor(arg_1_0)
	Vector3 = var_1_10001
	arg_1_0.point = var_1_10001.zero

	return
end

function var_0_4.SetFleetVO(arg_2_0, arg_2_1)
	arg_2_0._fleetMotion = arg_2_1:GetMotion()

	return
end

function var_0_4.SetGoldenRation(arg_3_0, arg_3_1)
	arg_3_0._cameraGoldenOffset = arg_3_1

	return
end

function var_0_4.GetCameraPos(arg_4_0)
	local var_4_0 = arg_4_0.point
	local var_4_1 = var_1.Copy
	local var_4_2 = arg_4_0._fleetMotion

	var_1.x = var_4_1(var_4_0, var_3.GetPos(var_4_2)).x + arg_4_0._cameraGoldenOffset
	var_1.y = var_1.y + var_0_2.CameraNormalHeight
	var_1.z = var_1.z - var_1.y / var_0_2._camera_radian_x_tan

	return var_1
end

function var_0_4.Dispose(arg_5_0)
	arg_5_0._fleetMotion = nil

	return
end

return
