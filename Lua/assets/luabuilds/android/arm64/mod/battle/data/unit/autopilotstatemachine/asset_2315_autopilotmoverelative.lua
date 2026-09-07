ys = ys or {}

local AutoPilotMoveRelative = class("AutoPilotMoveRelative", ys.Battle.IPilot)

ys.Battle.AutoPilotMoveRelative = AutoPilotMoveRelative
AutoPilotMoveRelative.__name = "AutoPilotMoveRelative"

function AutoPilotMoveRelative:Ctor(...)
	AutoPilotMoveRelative.super.Ctor(self, ...)

	return
end

function AutoPilotMoveRelative:SetParameter(arg_2_1, arg_2_2)
	AutoPilotMoveRelative.super.SetParameter(self, arg_2_1, arg_2_2)

	self._distX = arg_2_1.x
	self._distZ = arg_2_1.z

	return
end

function AutoPilotMoveRelative:Active(arg_3_1)
	self._targetPos = Vector3(self._distX * arg_3_1:GetDirection(), 0, self._distZ):Add(arg_3_1:GetPosition())

	AutoPilotMoveRelative.super.Active(self, arg_3_1)

	return
end

function AutoPilotMoveRelative:GetDirection(arg_4_1)
	local var_4_0 = self._targetPos - arg_4_1

	var_4_0.y = 0

	if var_4_0.magnitude < self._valve then
		var_4_0 = Vector3.zero

		if self._duration == -1 or self:IsExpired() then
			self:Finish()
		end
	end

	return var_4_0:SetNormalize()
end

return
