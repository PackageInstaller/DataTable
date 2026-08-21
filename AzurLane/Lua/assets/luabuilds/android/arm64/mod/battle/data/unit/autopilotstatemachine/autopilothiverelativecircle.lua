ys = ys or {}

local var_0_1 = class("AutoPilotHiveRelativeCircle", ys.Battle.IPilot)

ys.Battle.AutoPilotHiveRelativeCircle = var_0_1
var_0_1.__name = "AutoPilotHiveRelativeCircle"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._radius = arg_2_1.radius
	arg_2_0.GetDirection = arg_2_1.antiClockWise == true and var_0_1._antiClockWise or var_0_1._clockWise

	return
end

function var_0_1._clockWise(arg_3_0, arg_3_1)
	if arg_3_0:IsExpired() then
		arg_3_0:Finish()

		return Vector3.zero
	end

	local var_3_0 = arg_3_0._pilot:GetHiveUnit()

	if not var_3_0:IsAlive() then
		arg_3_0._pilot:OnHiveUnitDead()

		return Vector3.zero
	end

	local var_3_1 = var_3_0:GetPosition()
	local var_3_2, var_3_3

	if (arg_3_1 - var_3_1).magnitude > arg_3_0._radius then
		do return (var_3_1 - arg_3_1).normalized end

		goto label_3_0

		var_3_2, var_3_3 = -(var_3_1 - arg_3_1).normalized.z, Vector3
	end

	do return var_3_3(var_3_2, 0, (var_3_1 - arg_3_1).normalized.x) end

	::label_3_0::

	return
end

function var_0_1._antiClockWise(arg_4_0, arg_4_1)
	if arg_4_0._duration > 0 then
		if pg.TimeMgr.GetInstance():GetCombatTime() - arg_4_0._startTime > arg_4_0._duration then
			arg_4_0:Finish()

			return Vector3.zero
		end
	end

	local var_4_0 = arg_4_0._pilot:GetHiveUnit()

	if not var_4_0:IsAlive() then
		arg_4_0._pilot:OnHiveUnitDead()

		return Vector3.zero
	end

	local var_4_1 = var_4_0:GetPosition()
	local var_4_2, var_4_3

	if (arg_4_1 - var_4_1).magnitude > arg_4_0._radius then
		do return (var_4_1 - arg_4_1).normalized end

		goto label_4_0

		var_4_2, var_4_3 = (var_4_1 - arg_4_1).normalized.z, Vector3
	end

	do return var_4_3(var_4_2, 0, -(var_4_1 - arg_4_1).normalized.x) end

	::label_4_0::

	return
end

return
