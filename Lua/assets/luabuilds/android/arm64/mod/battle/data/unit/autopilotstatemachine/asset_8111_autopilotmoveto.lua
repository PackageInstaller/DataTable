ys = ys or {}

local AutoPilotMoveTo = class("AutoPilotMoveTo", ys.Battle.IPilot)

ys.Battle.AutoPilotMoveTo = AutoPilotMoveTo
AutoPilotMoveTo.__name = "AutoPilotMoveTo"

function AutoPilotMoveTo:Ctor(...)
	AutoPilotMoveTo.super.Ctor(self, ...)

	return
end

function AutoPilotMoveTo:SetParameter(arg_2_1, arg_2_2)
	AutoPilotMoveTo.super.SetParameter(self, arg_2_1, arg_2_2)

	self._targetPos = Vector3(arg_2_1.x, 0, arg_2_1.z)

	return
end

function AutoPilotMoveTo:GetDirection(arg_3_1)
	local var_3_0 = self._targetPos - arg_3_1

	var_3_0.y = 0

	if var_3_0.magnitude < self._valve then
		var_3_0 = Vector3.zero

		if self._duration == -1 or self:IsExpired() then
			self:Finish()
		end
	end

	return var_3_0.normalized
end

return
