ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
Vector3 = var_0_10001

local var_0_1 = var_0_10001.up

class = var_0_10002

local var_0_2 = var_0_10002("AutoPilotHiveRelativeCircle", var_0.Battle.IPilot)

var_0.Battle.AutoPilotHiveRelativeCircle = var_0_2
var_0_2.__name = "AutoPilotHiveRelativeCircle"

function var_0_2.Ctor(arg_1_0, ...)
	var_0_2.super.Ctor(arg_1_0, ...)

	return
end

function var_0_2.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_2.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

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

	local var_3_0 = arg_3_0._pilot
	local var_3_1 = var_2.GetHiveUnit(var_3_0)

	if not var_2.IsAlive(var_3_1) then
		local var_3_2 = arg_3_0._pilot

		var_3.OnHiveUnitDead(var_3_2)

		Vector3 = var_3

		return var_3.zero
	end

	if (arg_3_1 - var_2:GetPosition()).magnitude > arg_3_0._radius then
		return (var_3 - arg_3_1).normalized
	else
		local var_3_3 = -(var_3 - arg_3_1).normalized.z
		local var_3_4 = var_5.x

		Vector3 = var_1_10008

		return var_1_10008(var_3_3, 0, var_3_4)
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

	local var_4_1 = arg_4_0._pilot
	local var_4_2 = var_2.GetHiveUnit(var_4_1)

	if not var_2.IsAlive(var_4_2) then
		local var_4_3 = arg_4_0._pilot

		var_3.OnHiveUnitDead(var_4_3)

		Vector3 = var_3

		return var_3.zero
	end

	if (arg_4_1 - var_2:GetPosition()).magnitude > arg_4_0._radius then
		return (var_3 - arg_4_1).normalized
	else
		local var_4_4 = (var_3 - arg_4_1).normalized.z
		local var_4_5 = -var_5.x

		Vector3 = var_1_10008

		return var_1_10008(var_4_4, 0, var_4_5)
	end

	return
end

return
