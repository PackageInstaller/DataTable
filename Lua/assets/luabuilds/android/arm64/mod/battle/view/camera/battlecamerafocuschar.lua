ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local var_0_1 = ys.Battle.BattleVariable

ys.Battle.BattleCameraFocusChar = class("BattleCameraFocusChar")
ys.Battle.BattleCameraFocusChar.__name = "BattleCameraFocusChar"

function ys.Battle.BattleCameraFocusChar.Ctor(arg_1_0)
	arg_1_0._point = Vector3.zero

	return
end

function ys.Battle.BattleCameraFocusChar.SetUnit(arg_2_0, arg_2_1)
	arg_2_0._unit = arg_2_1

	return
end

function ys.Battle.BattleCameraFocusChar.GetCameraPos(arg_3_0)
	local var_3_0 = arg_3_0._unit:GetPosition()

	arg_3_0._point:Set(var_3_0.x, var_3_0.y, var_3_0.z)

	arg_3_0._point.y = arg_3_0._point.y + var_0_1.CameraFocusHeight
	arg_3_0._point.z = arg_3_0._point.z - arg_3_0._point.y / var_0_1._camera_radian_x_tan
	arg_3_0._point.x = arg_3_0._unit:GetIFF() == var_0_0.FOE_CODE and arg_3_0._point.x + 7 or arg_3_0._point.x - 7

	return arg_3_0._point
end

function ys.Battle.BattleCameraFocusChar.Dispose(arg_4_0)
	arg_4_0._unit = nil

	return
end

return
