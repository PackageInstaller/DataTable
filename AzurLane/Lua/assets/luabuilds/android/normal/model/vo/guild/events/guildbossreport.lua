class = var_0_10000

local var_0_0 = "GuildBossReport"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildReport"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.guild_boss_event
end

function var_0_1.IsBoss(arg_2_0)
	return true
end

function var_0_1.GetReportDesc(arg_3_0)
	return arg_3_0:getConfig("report")
end

function var_0_1.GetDrop(arg_4_0)
	return arg_4_0:getConfig("award_report"), 0
end

function var_0_1.GetType(arg_5_0)
	return 3
end

return var_0_1
