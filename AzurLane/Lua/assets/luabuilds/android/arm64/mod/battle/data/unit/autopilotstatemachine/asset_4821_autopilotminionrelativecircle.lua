ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
Vector3 = var_0_10001

local var_0_1 = var_0_10001.up

class = var_0_10002

local var_0_2 = var_0_10002("AutoPilotMinionRelativeCircle", var_0.Battle.IPilot)

var_0.Battle.AutoPilotMinionRelativeCircle = var_0_2
var_0_2.__name = "AutoPilotMinionRelativeCircle"

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

	arg_2_0._nextBuffID = arg_2_1.buffID

	return
end

function var_0_2._clockWise(arg_3_0, arg_3_1)
	if arg_3_0:IsExpired() then
		arg_3_0:Finish()

		Vector3 = var_2

		return var_2.zero
	end

	local var_3_0 = arg_3_0._pilot
	local var_3_1 = var_2.GetTarget(var_3_0)
	local var_3_2 = var_2.GetMaster(var_3_1)

	if not var_2.IsAlive(var_3_2) then
		local var_3_3

		if arg_3_0._nextBuffID then
			var_3_3 = var_0.Battle.BattleBuffUnit.New(arg_3_0._nextBuffID)

			local var_3_4 = arg_3_0._pilot
			local var_3_5 = var_4.GetTarget(var_3_4)

			var_4.AddBuff(var_3_5, var_3_3)
		end

		Vector3 = var_3_3

		return var_3_3.zero
	end

	if (arg_3_1 - var_2:GetPosition()).magnitude > arg_3_0._radius then
		return (var_3 - arg_3_1).normalized
	else
		local var_3_6 = -(var_3 - arg_3_1).normalized.z
		local var_3_7 = var_5.x

		Vector3 = var_1_10008

		return var_1_10008(var_3_6, 0, var_3_7)
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
	local var_4_2 = var_2.GetTarget(var_4_1)
	local var_4_3 = var_2.GetMaster(var_4_2)

	if not var_2.IsAlive(var_4_3) then
		local var_4_4

		if arg_4_0._nextBuffID then
			var_4_4 = var_0.Battle.BattleBuffUnit.New(arg_4_0._nextBuffID)

			local var_4_5 = arg_4_0._pilot
			local var_4_6 = var_4.GetTarget(var_4_5)

			var_4.AddBuff(var_4_6, var_4_4)
		end

		Vector3 = var_4_4

		return var_4_4.zero
	end

	if (arg_4_1 - var_2:GetPosition()).magnitude > arg_4_0._radius then
		return (var_3 - arg_4_1).normalized
	else
		local var_4_7 = (var_3 - arg_4_1).normalized.z
		local var_4_8 = -var_5.x

		Vector3 = var_1_10008

		return var_1_10008(var_4_7, 0, var_4_8)
	end

	return
end

return
