ys = ys or {}

local var_0_1 = ys.Battle.BattleVariable

ys.Battle.BattleCameraFocusBulet = class("BattleCameraFocusBulet")
ys.Battle.BattleCameraFocusBulet.__name = "BattleCameraFocusBulet"

function ys.Battle.BattleCameraFocusBulet.Ctor(arg_1_0)
	return
end

function ys.Battle.BattleCameraFocusBulet.SetUnit(arg_2_0, arg_2_1)
	arg_2_0._unit = arg_2_1

	return
end

function ys.Battle.BattleCameraFocusBulet:GetCameraPos()
	local var_3_0 = self._unit:GetPosition():Clone()

	var_3_0.y = var_3_0.y + var_0_1.CameraFocusHeight
	var_3_0.z = var_3_0.z - var_3_0.y / var_0_1._camera_radian_x_tan

	return var_3_0
end

function ys.Battle.BattleCameraFocusBulet.Dispose(arg_4_0)
	arg_4_0._unit = nil

	return
end

return
