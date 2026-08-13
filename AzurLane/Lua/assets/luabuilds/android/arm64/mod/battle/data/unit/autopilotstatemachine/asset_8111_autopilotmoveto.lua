ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotMoveTo", var_0.Battle.IPilot)

var_0.Battle.AutoPilotMoveTo = var_0_1
var_0_1.__name = "AutoPilotMoveTo"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	Vector3 = var_3
	arg_2_0._targetPos = var_3(arg_2_1.x, 0, arg_2_1.z)

	return
end

function var_0_1.GetDirection(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._targetPos - arg_3_1

	var_3_0.y = 0

	if var_3_0.magnitude < arg_3_0._valve then
		Vector3 = var_3
		var_3_0 = var_3.zero

		if arg_3_0._duration == -1 or arg_3_0:IsExpired() then
			arg_3_0:Finish()
		end
	end

	return var_3_0.normalized
end

return
