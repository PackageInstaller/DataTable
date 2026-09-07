ys = ys or {}

local AutoPilotStay = class("AutoPilotStay", ys.Battle.IPilot)

ys.Battle.AutoPilotStay = AutoPilotStay
AutoPilotStay.__name = "AutoPilotStay"

function AutoPilotStay:Ctor(...)
	AutoPilotStay.super.Ctor(self, ...)

	return
end

function AutoPilotStay:GetDirection()
	if self:IsExpired() then
		self:Finish()
	end

	return Vector3.zero
end

return
