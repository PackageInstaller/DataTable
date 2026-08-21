local var_0_0 = class("BossRushActivity", import("model.vo.Activity"))

function var_0_0.SetSeriesData(arg_1_0, arg_1_1)
	getProxy(ActivityProxy):GetBossRushRuntime(arg_1_0.id).seriesData = arg_1_1

	return
end

function var_0_0.GetSeriesData(arg_2_0)
	return getProxy(ActivityProxy):GetBossRushRuntime(arg_2_0.id).seriesData
end

function var_0_0.HasAwards(arg_3_0)
	return arg_3_0.data1 == 1
end

function var_0_0.GetUsedBonus(arg_4_0)
	return arg_4_0.data1_list
end

function var_0_0.AddUsedBonus(arg_5_0, arg_5_1)
	local var_5_0 = table.indexof(arg_5_0:GetActiveSeriesIds(), arg_5_1)

	if not var_5_0 or var_5_0 < 0 then
		return
	end

	local var_5_1 = arg_5_0:GetUsedBonus()
	local var_5_2 = arg_5_0:GetUsedBonus()[var_5_0] or 0

	var_5_1[var_5_0] = var_5_2 + 1

	return
end

function var_0_0.GetPassCounts(arg_6_0)
	return arg_6_0.data2_list
end

function var_0_0.AddPassSeries(arg_7_0, arg_7_1)
	if arg_7_0:HasPassSeries(arg_7_1) then
		return
	end

	table.insert(arg_7_0:GetPassCounts(), arg_7_1)

	return
end

function var_0_0.HasPassSeries(arg_8_0, arg_8_1)
	return table.contains(arg_8_0:GetPassCounts(), arg_8_1)
end

function var_0_0.GetActiveSeriesIds(arg_9_0)
	return arg_9_0:getConfig("config_data")
end

return var_0_0
