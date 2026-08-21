ys = ys or {}

local var_0_1 = class("AutoPilotMinionRelativeCircle", ys.Battle.IPilot)

ys.Battle.AutoPilotMinionRelativeCircle = var_0_1
var_0_1.__name = "AutoPilotMinionRelativeCircle"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._radius = arg_2_1.radius
	arg_2_0.GetDirection = arg_2_1.antiClockWise == true and var_0_1._antiClockWise or var_0_1._clockWise
	arg_2_0._nextBuffID = arg_2_1.buffID

	return
end

function var_0_1._clockWise(arg_3_0, arg_3_1)
	if arg_3_0:IsExpired() then
		arg_3_0:Finish()

		return Vector3.zero
	end

	local var_3_0 = arg_3_0._pilot:GetTarget():GetMaster()

	if not var_3_0:IsAlive() then
		if arg_3_0._nextBuffID then
			arg_3_0._pilot:GetTarget():AddBuff((var_0.Battle.BattleBuffUnit.New(arg_3_0._nextBuffID)))
		end

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

	local var_4_0 = arg_4_0._pilot:GetTarget():GetMaster()

	if not var_4_0:IsAlive() then
		if arg_4_0._nextBuffID then
			arg_4_0._pilot:GetTarget():AddBuff((var_0.Battle.BattleBuffUnit.New(arg_4_0._nextBuffID)))
		end

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
