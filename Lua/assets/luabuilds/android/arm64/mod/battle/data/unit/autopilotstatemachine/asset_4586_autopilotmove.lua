ys = ys or {}

local AutoPilotMove = class("AutoPilotMove", ys.Battle.IPilot)

ys.Battle.AutoPilotMove = AutoPilotMove
AutoPilotMove.__name = "AutoPilotMove"

function AutoPilotMove:Ctor(...)
	AutoPilotMove.super.Ctor(self, ...)

	return
end

function AutoPilotMove:SetParameter(arg_2_1, arg_2_2)
	AutoPilotMove.super.SetParameter(self, arg_2_1, arg_2_2)

	self._distX = arg_2_1.x
	self._distZ = arg_2_1.z

	return
end

function AutoPilotMove:Active(arg_3_1)
	self._targetPos = Vector3(self._distX, 0, self._distZ):Add(arg_3_1:GetPosition())

	AutoPilotMove.super.Active(self, arg_3_1)

	return
end

function AutoPilotMove:GetDirection(arg_4_1)
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
