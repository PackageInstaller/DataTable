ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillGridmanFloat = var_0_10002("BattleSkillGridmanFloat", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillGridmanFloat.__name = "BattleSkillGridmanFloat"

local var_0_2 = var_0.Battle.BattleSkillGridmanFloat

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._iconType = arg_1_0._tempData.arg_list.icon_type

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doGridmanSkillFloat(arg_2_1)

	return
end

function var_0_2.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doGridmanSkillFloat(arg_3_1)

	return
end

function var_0_2.doGridmanSkillFloat(arg_4_0, arg_4_1)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_2.DispatchGridmanSkill(var_4_0, arg_4_0._iconType, arg_4_1:GetIFF())

	return
end

return
