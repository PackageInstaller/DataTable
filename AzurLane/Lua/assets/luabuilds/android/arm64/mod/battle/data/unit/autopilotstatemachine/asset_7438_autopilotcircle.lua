ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
Vector3 = var_0_10001

local var_0_1 = var_0_10001.up

class = var_0_10002

local var_0_2 = var_0_10002("AutoPilotCircle", var_0.Battle.IPilot)

var_0.Battle.AutoPilotCircle = var_0_2
var_0_2.__name = "AutoPilotCircle"

function var_0_2.Ctor(arg_1_0, ...)
	var_0_2.super.Ctor(arg_1_0, ...)

	return
end

function var_0_2.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_2.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	Vector3 = var_3
	arg_2_0._referencePoint = var_3(arg_2_1.x, 0, arg_2_1.z)
	arg_2_0._radius = arg_2_1.radius

	if arg_2_1.antiClockWise == true then
		arg_2_0.GetDirection = var_0_2._antiClockWise
	else
		arg_2_0.GetDirection = var_0_2._clockWise
	end

	return
end

function var_0_2._clockWise(arg_3_0, arg_3_1)
	if arg_3_0:IsExpired() then
		arg_3_0:Finish()

		Vector3 = var_2

		return var_2.zero
	end

	if (arg_3_1 - arg_3_0._referencePoint).magnitude > arg_3_0._radius then
		return (arg_3_0._referencePoint - arg_3_1).normalized
	else
		local var_3_0 = -(arg_3_0._referencePoint - arg_3_1).normalized.z
		local var_3_1 = var_3.x

		Vector3 = var_1_10006

		return var_1_10006(var_3_0, 0, var_3_1)
	end

	return
end

function var_0_2._antiClockWise(arg_4_0, arg_4_1)
	if arg_4_0._duration > 0 then
		pg = var_2

		local var_4_0 = var_2.TimeMgr.GetInstance()

		if var_2.GetCombatTime(var_4_0) - arg_4_0._startTime > arg_4_0._duration then
			arg_4_0:Finish()

			Vector3 = var_2

			return var_2.zero
		end
	end

	if (arg_4_1 - arg_4_0._referencePoint).magnitude > arg_4_0._radius then
		return (arg_4_0._referencePoint - arg_4_1).normalized
	else
		local var_4_1 = (arg_4_0._referencePoint - arg_4_1).normalized.z
		local var_4_2 = -var_3.x

		Vector3 = var_1_10006

		return var_1_10006(var_4_1, 0, var_4_2)
	end

	return
end

return
