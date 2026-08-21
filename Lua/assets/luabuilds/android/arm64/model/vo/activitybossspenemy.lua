local var_0_0 = class("ActivityBossSPEnemy", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.extraenemy_challenge_template
end

function var_0_0.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_0.GetScoreTargets(arg_3_0)
	return arg_3_0:getConfig("ex_challenge_target")
end

function var_0_0.GetRewards(arg_4_0)
	return arg_4_0:getConfig("ex_challenge_reward")
end

function var_0_0.GetSelectableBuffs(arg_5_0)
	return arg_5_0:getConfig("ex_challenge_buff")
end

function var_0_0.GetExtraStageId(arg_6_0)
	return arg_6_0:getConfig("ex_challenge_enemy")
end

return var_0_0
