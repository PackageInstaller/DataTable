class = var_0_10000

local var_0_0 = "BossAward"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....BaseEntity"))

var_0_1.Fields = {
	bossId = "number",
	duetime = "number",
	rank = "number",
	config = "table",
	acceptTime = "number",
	level = "number"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.bossId = arg_1_1.bossId
	pg = var_2
	arg_1_0.config = var_2.world_joint_boss_template[arg_1_0.bossId]
	arg_1_0.level = arg_1_1.level
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.duetime = arg_1_1.duetime

	local var_1_0

	if not arg_1_1.accept_time then
		var_1_0 = 0
	end

	arg_1_0.acceptTime = var_1_0

	return
end

function var_0_1.IsReceived(arg_2_0)
	return arg_2_0.acceptTime > 0
end

function var_0_1.GetAwards(arg_3_0)
	return arg_3_0.config.drop_show
end

function var_0_1.IsExpired(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_4_0) >= arg_4_0.duetime
end

function var_0_1.GetExpiredTime(arg_5_0, ...)
	return arg_5_0.duetime
end

function var_0_1.GetBossName(arg_6_0)
	return arg_6_0.config.name
end

function var_0_1.GetRank(arg_7_0)
	return arg_7_0.rank
end

return var_0_1
