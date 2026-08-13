class = var_0_10000

local var_0_0 = "ActivityBossConfig"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_event_worldboss
end

function var_0_1.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_1.Ctor(arg_3_0, arg_3_1)
	var_0_1.super.Ctor(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0:getConfig("extrachallenge_id")

	if 0 < var_3_0 then
		ActivityBossSPEnemy = var_3
		arg_3_0.spEnemy = var_3.New({
			configId = var_3_0
		})
	end

	return
end

function var_0_1.GetTicketID(arg_4_0)
	return arg_4_0:getConfig("ticket")
end

function var_0_1.GetBattleTime(arg_5_0)
	return arg_5_0:getConfig("time")
end

function var_0_1.GetNormalStageIDs(arg_6_0)
	return arg_6_0:getConfig("normal_expedition")
end

function var_0_1.GetEXStageID(arg_7_0)
	return arg_7_0:getConfig("ex_expedition")
end

function var_0_1.GetOilLimits(arg_8_0)
	return arg_8_0:getConfig("use_oil_limit")
end

function var_0_1.GetBossID(arg_9_0)
	return arg_9_0:getConfig("boss_id")[1]
end

function var_0_1.GetMilestoneRewards(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetBossID(var_10_0)

	AcessWithinNull = var_10_0
	pg = var_1_10003

	local var_10_2

	if not var_10_0(var_1_10003.extraenemy_template[var_10_1], "reward_display") then
		var_10_2 = {}
	end

	return var_10_2
end

function var_0_1.GetInitTicketPools(arg_11_0)
	return arg_11_0:getConfig("normal_expedition_drop_num")
end

function var_0_1.GetSPEnemy(arg_12_0)
	return arg_12_0.spEnemy
end

function var_0_1.GetSPStageID(arg_13_0)
	if not arg_13_0.spEnemy then
		return
	end

	local var_13_0 = arg_13_0.spEnemy

	return var_1.GetExtraStageId(var_13_0)
end

return var_0_1
