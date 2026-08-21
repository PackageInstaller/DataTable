ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local var_0_1 = ys.Battle.BattleVariable

ys.Battle.BattleCameraBoundFixDecorate = class("BattleCameraBoundFixDecorate")
ys.Battle.BattleCameraBoundFixDecorate.__name = "BattleCameraBoundFixDecorate"

function ys.Battle.BattleCameraBoundFixDecorate.Ctor(arg_1_0)
	return
end

function ys.Battle.BattleCameraBoundFixDecorate.SetMapData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._cameraUpperBound = arg_2_1 + 30
	arg_2_0._cameraLowerBound = arg_2_2 - 5
	arg_2_0._cameraLeftBound = arg_2_3 - 3
	arg_2_0._cameraRightBound = arg_2_4 + 3
	arg_2_0._cameraHalfWidth = var_0_0.CAMERA_SIZE * pg.CameraFixMgr.GetInstance().targetRatio
	arg_2_0._cameraLeftBoundPoint = arg_2_0._cameraLeftBound + arg_2_0._cameraHalfWidth
	arg_2_0._cameraRightBoundPoint = arg_2_0._cameraRightBound - arg_2_0._cameraHalfWidth
	arg_2_0._projectionConst = var_0_0.CAMERA_SIZE / var_0_1._camera_radian_x_sin

	return arg_2_0._cameraUpperBound, arg_2_0._cameraLowerBound, arg_2_0._cameraLeftBound, arg_2_0._cameraRightBound
end

function ys.Battle.BattleCameraBoundFixDecorate.GetCameraPos(arg_3_0, arg_3_1)
	if arg_3_1.z < arg_3_0._cameraLowerBound then
		arg_3_1.z = arg_3_0._cameraLowerBound
	elseif arg_3_1.z > arg_3_0._cameraUpperBound - (arg_3_1.y / var_0_1._camera_radian_x_tan + arg_3_0._projectionConst) then
		arg_3_1.z = arg_3_0._cameraUpperBound - (arg_3_1.y / var_0_1._camera_radian_x_tan + arg_3_0._projectionConst)
	end

	if arg_3_1.x < arg_3_0._cameraLeftBoundPoint then
		arg_3_1.x = arg_3_0._cameraLeftBoundPoint
	elseif arg_3_1.x > arg_3_0._cameraRightBoundPoint then
		arg_3_1.x = arg_3_0._cameraRightBoundPoint
	end

	return arg_3_1
end

function ys.Battle.BattleCameraBoundFixDecorate.Dispose(arg_4_0)
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
