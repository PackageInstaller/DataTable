ys = ys or {}

local var_0_0 = class("AutoPilotStay", ys.Battle.IPilot)

ys.Battle.AutoPilotStay = var_0_0
var_0_0.__name = "AutoPilotStay"

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	return
end

function var_0_0.GetDirection(arg_2_0)
	if arg_2_0:IsExpired() then
		arg_2_0:Finish()
	end

	return Vector3.zero
end

return
