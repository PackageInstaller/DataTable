ys = ys or {}

local AutoPilotHiveRelativeStay = class("AutoPilotHiveRelativeStay", ys.Battle.IPilot)

ys.Battle.AutoPilotHiveRelativeStay = AutoPilotHiveRelativeStay
AutoPilotHiveRelativeStay.__name = "AutoPilotHiveRelativeStay"

function AutoPilotHiveRelativeStay:Ctor(...)
	AutoPilotHiveRelativeStay.super.Ctor(self, ...)

	return
end

function AutoPilotHiveRelativeStay:SetParameter(arg_2_1, arg_2_2)
	AutoPilotHiveRelativeStay.super.SetParameter(self, arg_2_1, arg_2_2)

	self._distX = arg_2_1.x
	self._distZ = arg_2_1.z

	return
end

function AutoPilotHiveRelativeStay:GetDirection(arg_3_1)
	local var_3_0 = self._pilot:GetHiveUnit()

	if not var_3_0:IsAlive() then
		self._pilot:OnHiveUnitDead()

		return Vector3.zero
	end

	local var_3_1 = var_3_0:GetPosition()
	local var_3_2 = Vector3(var_3_1.x + self._distX, arg_3_1.y, var_3_1.z + self._distZ) - arg_3_1

	if self:IsExpired() then
		self:Finish()
	end

	if var_3_2.magnitude < 0.4 then
		return Vector3.zero
	else
		var_3_2.y = 0

		return var_3_2:SetNormalize()
	end

	return
end

return
