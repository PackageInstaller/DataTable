ys = ys or {}

local var_0_0 = ys
local AutoPilotMinionRelativeStay = class("AutoPilotMinionRelativeStay", ys.Battle.IPilot)

ys.Battle.AutoPilotMinionRelativeStay = AutoPilotMinionRelativeStay
AutoPilotMinionRelativeStay.__name = "AutoPilotMinionRelativeStay"

function AutoPilotMinionRelativeStay:Ctor(...)
	AutoPilotMinionRelativeStay.super.Ctor(self, ...)

	return
end

function AutoPilotMinionRelativeStay:SetParameter(arg_2_1, arg_2_2)
	AutoPilotMinionRelativeStay.super.SetParameter(self, arg_2_1, arg_2_2)

	self._distX = arg_2_1.x
	self._distZ = arg_2_1.z
	self._nextBuffID = arg_2_1.buffID

	return
end

function AutoPilotMinionRelativeStay:GetDirection(arg_3_1)
	local var_3_0 = self._pilot:GetTarget():GetMaster()

	if not var_3_0:IsAlive() then
		if self._nextBuffID then
			self._pilot:GetTarget():AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._nextBuffID)))
		end

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
