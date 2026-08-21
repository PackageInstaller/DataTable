ys = ys or {}

local var_0_1 = class("BattleSkillSonar", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillSonar = var_0_1
var_0_1.__name = "BattleSkillSonar"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._range = arg_1_0._tempData.arg_list.range
	arg_1_0._duration = arg_1_0._tempData.arg_list.duration

	return
end

function var_0_1.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_1:GetFleetVO():AppendIndieSonar(arg_2_0._range, arg_2_0._duration)

	return
end

function var_0_1.DataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_1:GetFleetVO():AppendIndieSonar(arg_3_0._range, arg_3_0._duration)

	return
end

return
