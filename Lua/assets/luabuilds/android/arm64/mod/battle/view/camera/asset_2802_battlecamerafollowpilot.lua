ys = ys or {}

local var_0_1 = ys.Battle.BattleVariable

ys.Battle.BattleCameraFollowPilot = class("BattleCameraFollowPilot")
ys.Battle.BattleCameraFollowPilot.__name = "BattleCameraFollowPilot"

function ys.Battle.BattleCameraFollowPilot.Ctor(arg_1_0)
	arg_1_0.point = Vector3.zero

	return
end

function ys.Battle.BattleCameraFollowPilot.SetFleetVO(arg_2_0, arg_2_1)
	arg_2_0._fleetMotion = arg_2_1:GetMotion()

	return
end

function ys.Battle.BattleCameraFollowPilot.SetGoldenRation(arg_3_0, arg_3_1)
	arg_3_0._cameraGoldenOffset = arg_3_1

	return
end

function ys.Battle.BattleCameraFollowPilot:GetCameraPos()
	local var_4_0 = self.point:Copy(self._fleetMotion:GetPos())

	var_4_0.x = var_4_0.x + self._cameraGoldenOffset
	var_4_0.y = var_4_0.y + var_0_1.CameraNormalHeight
	var_4_0.z = var_4_0.z - var_4_0.y / var_0_1._camera_radian_x_tan

	return var_4_0
end

function ys.Battle.BattleCameraFollowPilot.Dispose(arg_5_0)
	arg_5_0._fleetMotion = nil

	return
end

return
