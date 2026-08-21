local var_0_0 = class("BossAward", import("....BaseEntity"))

var_0_0.Fields = {
	bossId = "number",
	duetime = "number",
	rank = "number",
	config = "table",
	acceptTime = "number",
	level = "number"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.bossId = arg_1_1.bossId
	arg_1_0.config = pg.world_joint_boss_template[arg_1_0.bossId]
	arg_1_0.level = arg_1_1.level
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.duetime = arg_1_1.duetime
	arg_1_0.acceptTime = arg_1_1.accept_time or 0

	return
end

function var_0_0.IsReceived(arg_2_0)
	return arg_2_0.acceptTime > 0
end

function var_0_0.GetAwards(arg_3_0)
	return arg_3_0.config.drop_show
end

function var_0_0.IsExpired(arg_4_0)
	local var_4_0 = pg.TimeMgr.GetInstance()

	return var_4_0:GetServerTime() >= arg_4_0.duetime
end

function var_0_0.GetExpiredTime(arg_5_0, ...)
	return arg_5_0.duetime
end

function var_0_0.GetBossName(arg_6_0)
	return arg_6_0.config.name
end

function var_0_0.GetRank(arg_7_0)
	return arg_7_0.rank
end

return var_0_0
