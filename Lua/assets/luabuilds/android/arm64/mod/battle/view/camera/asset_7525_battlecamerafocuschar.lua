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

function ys.Battle.BattleCameraFocusChar:GetCameraPos()
	local var_3_0 = self._unit:GetPosition()

	self._point:Set(var_3_0.x, var_3_0.y, var_3_0.z)

	self._point.y = self._point.y + var_0_1.CameraFocusHeight
	self._point.z = self._point.z - self._point.y / var_0_1._camera_radian_x_tan
	self._point.x = self._unit:GetIFF() == var_0_0.FOE_CODE and self._point.x + 7 or self._point.x - 7

	return self._point
end

function ys.Battle.BattleCameraFocusChar.Dispose(arg_4_0)
	arg_4_0._unit = nil

	return
end

return
