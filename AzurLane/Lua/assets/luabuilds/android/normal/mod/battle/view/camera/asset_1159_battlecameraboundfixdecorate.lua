ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCameraBoundFixDecorate = var_0_10004("BattleCameraBoundFixDecorate")
var_0.Battle.BattleCameraBoundFixDecorate.__name = "BattleCameraBoundFixDecorate"

local var_0_4 = var_0.Battle.BattleCameraBoundFixDecorate

function var_0_4.Ctor(arg_1_0)
	return
end

function var_0_4.SetMapData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._cameraUpperBound = arg_2_1 + 30
	arg_2_0._cameraLowerBound = arg_2_2 - 5
	arg_2_0._cameraLeftBound = arg_2_3 - 3
	arg_2_0._cameraRightBound = arg_2_4 + 3

	local var_2_0 = var_0_1.CAMERA_SIZE

	pg = var_1_10006
	arg_2_0._cameraHalfWidth = var_2_0 * var_1_10006.CameraFixMgr.GetInstance().targetRatio
	arg_2_0._cameraLeftBoundPoint = arg_2_0._cameraLeftBound + arg_2_0._cameraHalfWidth
	arg_2_0._cameraRightBoundPoint = arg_2_0._cameraRightBound - arg_2_0._cameraHalfWidth
	arg_2_0._projectionConst = var_0_1.CAMERA_SIZE / var_0_2._camera_radian_x_sin

	return arg_2_0._cameraUpperBound, arg_2_0._cameraLowerBound, arg_2_0._cameraLeftBound, arg_2_0._cameraRightBound
end

function var_0_4.GetCameraPos(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.y / var_0_2._camera_radian_x_tan + arg_3_0._projectionConst

	if arg_3_1.z < arg_3_0._cameraLowerBound then
		arg_3_1.z = arg_3_0._cameraLowerBound
	elseif arg_3_1.z > arg_3_0._cameraUpperBound - var_3_0 then
		arg_3_1.z = arg_3_0._cameraUpperBound - var_3_0
	end

	if arg_3_1.x < arg_3_0._cameraLeftBoundPoint then
		arg_3_1.x = arg_3_0._cameraLeftBoundPoint
	elseif arg_3_1.x > arg_3_0._cameraRightBoundPoint then
		arg_3_1.x = arg_3_0._cameraRightBoundPoint
	end

	return arg_3_1
end

function var_0_4.Dispose(arg_4_0)
	arg_4_0._cameraUpperBound = nil
	arg_4_0._cameraLowerBound = nil
	arg_4_0._cameraLeftBound = nil
	arg_4_0._cameraRightBound = nil
	arg_4_0._cameraHalfWidth = nil
	arg_4_0._cameraLeftBoundPoint = nil
	arg_4_0._cameraRightBoundPoint = nil
	arg_4_0._projectionConst = nil

	return
end

return
