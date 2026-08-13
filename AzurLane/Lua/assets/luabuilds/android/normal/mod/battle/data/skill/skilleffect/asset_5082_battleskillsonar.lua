ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction

class = var_0_10002

local var_0_2 = var_0_10002("BattleSkillSonar", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillSonar = var_0_2
var_0_2.__name = "BattleSkillSonar"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

	arg_1_0._range = arg_1_0._tempData.arg_list.range
	arg_1_0._duration = arg_1_0._tempData.arg_list.duration

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetFleetVO()

	var_2.AppendIndieSonar(var_2_0, arg_2_0._range, arg_2_0._duration)

	return
end

function var_0_2.DataEffectWithoutTarget(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetFleetVO()

	var_2.AppendIndieSonar(var_3_0, arg_3_0._range, arg_3_0._duration)

	return
end

return
