class = var_0_10000

local var_0_0 = "BossRushActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.SetSeriesData(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	var_2.GetBossRushRuntime(var_1_0, arg_1_0.id).seriesData = arg_1_1

	return
end

function var_0_1.GetSeriesData(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	return var_1.GetBossRushRuntime(var_2_0, arg_2_0.id).seriesData
end

function var_0_1.HasAwards(arg_3_0)
	return arg_3_0.data1 == 1
end

function var_0_1.GetUsedBonus(arg_4_0)
	return arg_4_0.data1_list
end

function var_0_1.AddUsedBonus(arg_5_0, arg_5_1)
	table = var_1_10002

	if not var_1_10002.indexof(arg_5_0:GetActiveSeriesIds(), arg_5_1) or var_2 < 0 then
		return
	end

	local var_5_0 = arg_5_0:GetUsedBonus()
	local var_5_1

	if not arg_5_0:GetUsedBonus()[var_2] then
		var_5_1 = 0
	end

	var_5_0[var_2] = var_5_1 + 1

	return
end

function var_0_1.GetPassCounts(arg_6_0)
	return arg_6_0.data2_list
end

function var_0_1.AddPassSeries(arg_7_0, arg_7_1)
	if arg_7_0:HasPassSeries(arg_7_1) then
		return
	end

	table = var_2

	var_2.insert(arg_7_0:GetPassCounts(), arg_7_1)

	return
end

function var_0_1.HasPassSeries(arg_8_0, arg_8_1)
	table = var_1_10002

	return var_1_10002.contains(arg_8_0:GetPassCounts(), arg_8_1)
end

function var_0_1.GetActiveSeriesIds(arg_9_0)
	return arg_9_0:getConfig("config_data")
end

return var_0_1
