ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("IPilot")

var_0.Battle.IPilot = var_0_1
var_0_1.__name = "IPilot"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._index = arg_1_1
	arg_1_0._pilot = arg_1_2

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._paramList = arg_2_1

	local var_2_0

	if not arg_2_1.valve then
		var_2_0 = var_0.Battle.AutoPilot.PILOT_VALVE
	end

	arg_2_0._valve = var_2_0
	arg_2_0._toIndex = arg_2_2

	local var_2_1

	if not arg_2_1.duration then
		var_2_1 = -1
	end

	arg_2_0._duration = var_2_1

	return
end

function var_0_1.GetIndex(arg_3_0)
	return arg_3_0._index
end

function var_0_1.GetToIndex(arg_4_0)
	return arg_4_0._toIndex
end

function var_0_1.Active(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.TimeMgr.GetInstance()

	arg_5_0._startTime = var_2.GetCombatTime(var_5_0)

	return
end

function var_0_1.IsExpired(arg_6_0)
	if arg_6_0._duration > 0 then
		pg = var_1

		local var_6_0 = var_1.TimeMgr.GetInstance()

		if var_1.GetCombatTime(var_6_0) - arg_6_0._startTime > arg_6_0._duration then
			do return true end

			goto label_6_0
		end
	end

	do return false end

	::label_6_0::

	return
end

function var_0_1.GetDirection(arg_7_0, arg_7_1)
	return
end

function var_0_1.Finish(arg_8_0)
	local var_8_0 = arg_8_0._pilot

	var_1.NextStep(var_8_0)

	return
end

return
