ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotStay", var_0.Battle.IPilot)

var_0.Battle.AutoPilotStay = var_0_1
var_0_1.__name = "AutoPilotStay"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.GetDirection(arg_2_0)
	if arg_2_0:IsExpired() then
		arg_2_0:Finish()
	end

	Vector3 = var_1

	return var_1.zero
end

return
