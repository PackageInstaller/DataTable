local var_0_0 = class("GuildBossReport", import(".GuildReport"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.guild_boss_event
end

function var_0_0.IsBoss(arg_2_0)
	return true
end

function var_0_0.GetReportDesc(arg_3_0)
	return arg_3_0:getConfig("report")
end

function var_0_0.GetDrop(arg_4_0)
	return arg_4_0:getConfig("award_report"), 0
end

function var_0_0.GetType(arg_5_0)
	return 3
end

return var_0_0
