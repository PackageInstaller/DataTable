ys = ys or {}

local AutoPilotCircle = class("AutoPilotCircle", ys.Battle.IPilot)

ys.Battle.AutoPilotCircle = AutoPilotCircle
AutoPilotCircle.__name = "AutoPilotCircle"

function AutoPilotCircle:Ctor(...)
	AutoPilotCircle.super.Ctor(self, ...)

	return
end

function AutoPilotCircle:SetParameter(arg_2_1, arg_2_2)
	AutoPilotCircle.super.SetParameter(self, arg_2_1, arg_2_2)

	self._referencePoint = Vector3(arg_2_1.x, 0, arg_2_1.z)
	self._radius = arg_2_1.radius
	self.GetDirection = arg_2_1.antiClockWise == true and AutoPilotCircle._antiClockWise or AutoPilotCircle._clockWise

	return
end

function AutoPilotCircle:_clockWise(arg_3_1)
	if self:IsExpired() then
		self:Finish()

		return Vector3.zero
	end

	if (arg_3_1 - self._referencePoint).magnitude > self._radius then
		return (self._referencePoint - arg_3_1).normalized
	else
		local var_3_0, var_3_1 = -(self._referencePoint - arg_3_1).normalized.z, Vector3

		return var_3_1(var_3_0, 0, (self._referencePoint - arg_3_1).normalized.x)
	end

	return
end

function AutoPilotCircle:_antiClockWise(arg_4_1)
	if self._duration > 0 then
		if pg.TimeMgr.GetInstance():GetCombatTime() - self._startTime > self._duration then
			self:Finish()

			return Vector3.zero
		end
	end

	if (arg_4_1 - self._referencePoint).magnitude > self._radius then
		return (self._referencePoint - arg_4_1).normalized
	else
		local var_4_0, var_4_1 = (self._referencePoint - arg_4_1).normalized.z, Vector3

		return var_4_1(var_4_0, 0, -(self._referencePoint - arg_4_1).normalized.x)
	end

	return
end

return
