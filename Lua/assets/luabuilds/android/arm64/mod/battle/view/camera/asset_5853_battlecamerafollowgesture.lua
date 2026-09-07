ys = ys or {}
ys.Battle.BattleCameraFollowGesture = class("BattleCameraFollowGesture")
ys.Battle.BattleCameraFollowGesture.__name = "BattleCameraFollowGesture"

function ys.Battle.BattleCameraFollowGesture.Ctor(arg_1_0)
	arg_1_0._point = Vector3.zero

	return
end

function ys.Battle.BattleCameraFollowGesture.SetGestureComponent(arg_2_0, arg_2_1)
	arg_2_0._slider = arg_2_1

	return
end

function ys.Battle.BattleCameraFollowGesture:GetCameraPos(arg_3_1)
	if self._slider:IsPress() then
		self._pressPoint = self._pressPoint or arg_3_1

		local var_3_0, var_3_1 = self._slider:IsFirstPress()

		if var_3_0 then
			self._pressPoint.x = arg_3_1.x
		end

		if var_3_1 then
			self._pressPoint.z = arg_3_1.z
		end

		local var_3_4, var_3_5 = self._slider:GetDistance()

		self._point:Set(self._pressPoint.x, self._pressPoint.y, self._pressPoint.z)

		self._point.z = self._point.z + var_3_5 * -80
		self._point.x = self._point.x + var_3_4 * -80

		return self._point
	else
		return arg_3_1
	end

	return
end

function ys.Battle.BattleCameraFollowGesture.Dispose(arg_4_0)
	arg_4_0._slider = nil

	return
end

return
