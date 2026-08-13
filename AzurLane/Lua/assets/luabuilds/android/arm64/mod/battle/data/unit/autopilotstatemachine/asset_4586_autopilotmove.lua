ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotMove", var_0.Battle.IPilot)

var_0.Battle.AutoPilotMove = var_0_1
var_0_1.__name = "AutoPilotMove"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._distX = arg_2_1.x
	arg_2_0._distZ = arg_2_1.z

	return
end

function var_0_1.Active(arg_3_0, arg_3_1)
	Vector3 = var_1_10002

	local var_3_0 = var_1_10002(arg_3_0._distX, 0, arg_3_0._distZ)

	arg_3_0._targetPos = var_2.Add(var_3_0, arg_3_1:GetPosition())

	var_0_1.super.Active(arg_3_0, arg_3_1)

	return
end

function var_0_1.GetDirection(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._targetPos - arg_4_1

	var_4_0.y = 0

	if var_4_0.magnitude < arg_4_0._valve then
		Vector3 = var_3
		var_4_0 = var_3.zero

		if arg_4_0._duration == -1 or arg_4_0:IsExpired() then
			arg_4_0:Finish()
		end
	end

	return var_4_0:SetNormalize()
end

return
