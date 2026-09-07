ys = ys or {}

local var_0_0 = ys
local AutoPilotMinionRelativeCircle = class("AutoPilotMinionRelativeCircle", ys.Battle.IPilot)

ys.Battle.AutoPilotMinionRelativeCircle = AutoPilotMinionRelativeCircle
AutoPilotMinionRelativeCircle.__name = "AutoPilotMinionRelativeCircle"

function AutoPilotMinionRelativeCircle:Ctor(...)
	AutoPilotMinionRelativeCircle.super.Ctor(self, ...)

	return
end

function AutoPilotMinionRelativeCircle:SetParameter(arg_2_1, arg_2_2)
	AutoPilotMinionRelativeCircle.super.SetParameter(self, arg_2_1, arg_2_2)

	self._radius = arg_2_1.radius
	self.GetDirection = arg_2_1.antiClockWise == true and AutoPilotMinionRelativeCircle._antiClockWise or AutoPilotMinionRelativeCircle._clockWise
	self._nextBuffID = arg_2_1.buffID

	return
end

function AutoPilotMinionRelativeCircle:_clockWise(arg_3_1)
	if self:IsExpired() then
		self:Finish()

		return Vector3.zero
	end

	local var_3_0 = self._pilot:GetTarget():GetMaster()

	if not var_3_0:IsAlive() then
		if self._nextBuffID then
			self._pilot:GetTarget():AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._nextBuffID)))
		end

		return Vector3.zero
	end

	local var_3_1 = var_3_0:GetPosition()

	if (arg_3_1 - var_3_1).magnitude > self._radius then
		return (var_3_1 - arg_3_1).normalized
	else
		local var_3_2, var_3_3 = -(var_3_1 - arg_3_1).normalized.z, Vector3

		return var_3_3(var_3_2, 0, (var_3_1 - arg_3_1).normalized.x)
	end

	return
end

function AutoPilotMinionRelativeCircle:_antiClockWise(arg_4_1)
	if self._duration > 0 then
		if pg.TimeMgr.GetInstance():GetCombatTime() - self._startTime > self._duration then
			self:Finish()

			return Vector3.zero
		end
	end

	local var_4_0 = self._pilot:GetTarget():GetMaster()

	if not var_4_0:IsAlive() then
		if self._nextBuffID then
			self._pilot:GetTarget():AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._nextBuffID)))
		end

		return Vector3.zero
	end

	local var_4_1 = var_4_0:GetPosition()

	if (arg_4_1 - var_4_1).magnitude > self._radius then
		return (var_4_1 - arg_4_1).normalized
	else
		local var_4_2, var_4_3 = (var_4_1 - arg_4_1).normalized.z, Vector3

		return var_4_3(var_4_2, 0, -(var_4_1 - arg_4_1).normalized.x)
	end

	return
end

return
