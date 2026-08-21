local var_0_0 = class("ActivityBossConfig", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_event_worldboss
end

function var_0_0.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	var_0_0.super.Ctor(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0:getConfig("extrachallenge_id")

	if var_3_0 > 0 then
		arg_3_0.spEnemy = ActivityBossSPEnemy.New({
			configId = var_3_0
		})
	end

	return
end

function var_0_0.GetTicketID(arg_4_0)
	return arg_4_0:getConfig("ticket")
end

function var_0_0.GetBattleTime(arg_5_0)
	return arg_5_0:getConfig("time")
end

function var_0_0.GetNormalStageIDs(arg_6_0)
	return arg_6_0:getConfig("normal_expedition")
end

function var_0_0.GetEXStageID(arg_7_0)
	return arg_7_0:getConfig("ex_expedition")
end

function var_0_0.GetOilLimits(arg_8_0)
	return arg_8_0:getConfig("use_oil_limit")
end

function var_0_0.GetBossID(arg_9_0)
	return arg_9_0:getConfig("boss_id")[1]
end

function var_0_0.GetMilestoneRewards(arg_10_0)
	return AcessWithinNull(pg.extraenemy_template[arg_10_0:GetBossID()], "reward_display") or {}
end

function var_0_0.GetInitTicketPools(arg_11_0)
	return arg_11_0:getConfig("normal_expedition_drop_num")
end

function var_0_0.GetSPEnemy(arg_12_0)
	return arg_12_0.spEnemy
end

function var_0_0.GetSPStageID(arg_13_0)
	if not arg_13_0.spEnemy then
		return
	end

	return arg_13_0.spEnemy:GetExtraStageId()
end

return var_0_0
