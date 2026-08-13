class = var_0_10000

local var_0_0 = "ActivityBossSPEnemy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.extraenemy_challenge_template
end

function var_0_1.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_1.GetScoreTargets(arg_3_0)
	return arg_3_0:getConfig("ex_challenge_target")
end

function var_0_1.GetRewards(arg_4_0)
	return arg_4_0:getConfig("ex_challenge_reward")
end

function var_0_1.GetSelectableBuffs(arg_5_0)
	return arg_5_0:getConfig("ex_challenge_buff")
end

function var_0_1.GetExtraStageId(arg_6_0)
	return arg_6_0:getConfig("ex_challenge_enemy")
end

return var_0_1
