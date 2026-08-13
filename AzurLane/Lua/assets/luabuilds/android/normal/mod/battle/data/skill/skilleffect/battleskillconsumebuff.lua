ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillConsumeBuff = var_0_10002("BattleSkillConsumeBuff", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillConsumeBuff.__name = "BattleSkillConsumeBuff"

local var_0_2 = var_0.Battle.BattleSkillConsumeBuff

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._buffID = arg_1_0._tempData.arg_list.buff_id
	arg_1_0._count = arg_1_0._tempData.arg_list.consume_count

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2:IsAlive() then
		arg_2_2:ConsumeBuffStack(arg_2_0._buffID, arg_2_0._count)
	end

	return
end

return
