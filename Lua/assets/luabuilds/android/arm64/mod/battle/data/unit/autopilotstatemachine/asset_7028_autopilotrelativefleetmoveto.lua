ys = ys or {}

local var_0_0 = ys
local AutoPilotRelativeFleetMoveTo = class("AutoPilotRelativeFleetMoveTo", ys.Battle.IPilot)

ys.Battle.AutoPilotRelativeFleetMoveTo = AutoPilotRelativeFleetMoveTo
AutoPilotRelativeFleetMoveTo.__name = "AutoPilotRelativeFleetMoveTo"

function AutoPilotRelativeFleetMoveTo:Ctor(...)
	AutoPilotRelativeFleetMoveTo.super.Ctor(self, ...)

	return
end

function AutoPilotRelativeFleetMoveTo:SetParameter(arg_2_1, arg_2_2)
	AutoPilotRelativeFleetMoveTo.super.SetParameter(self, arg_2_1, arg_2_2)

	self._offsetX = arg_2_1.offsetX
	self._offsetZ = arg_2_1.offsetZ
	self._fixX = arg_2_1.X
	self._fixZ = arg_2_1.Z
	self._targetFleetVO = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	return
end

function AutoPilotRelativeFleetMoveTo:GetDirection(arg_3_1)
	if self:IsExpired() then
		self:Finish()

		return Vector3.zero
	end

	local var_3_2 = self._targetFleetVO:GetMotion():GetPos()
	local var_3_3 = Vector3.New(self._offsetX and var_3_2.x + self._offsetX or self._fixX and self._fixX or arg_3_1.x, 0, self._offsetZ and var_3_2.z + self._offsetZ or self._fixZ and self._fixZ or arg_3_1.z) - arg_3_1

	var_3_3.y = 0

	if var_3_3.magnitude < self._valve then
		var_3_3 = Vector3.zero
	end

	return var_3_3.normalized
end

return
