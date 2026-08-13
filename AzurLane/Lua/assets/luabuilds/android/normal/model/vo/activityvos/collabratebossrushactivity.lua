class = var_0_10000

local var_0_0 = "CollabrateBossRushActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.SetSeriesData(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	var_2.GetBossRushRuntime(var_1_0, arg_1_0.id).seriesData = arg_1_1

	return
end

function var_0_1.GetSeriesData(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	return var_1.GetBossRushRuntime(var_2_0, arg_2_0.id).seriesData
end

function var_0_1.Ctor(arg_3_0, arg_3_1)
	var_0_1.super.Ctor(arg_3_0, arg_3_1)

	arg_3_0.collabrateBossList = {}

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getConfig(var_3_0, "config_data")

	ipairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_1) do
		CollabrateBossRushSeriesData = var_1_10008
		var_1_10008 = var_1_10008.New({
			id = iter_3_1,
			index = iter_3_0,
			actId = arg_3_0.id
		})
		arg_3_0.collabrateBossList[iter_3_1] = var_1_10008
	end

	return
end

function var_0_1.UpdateCollabrateBossData(arg_4_0, arg_4_1)
	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.collabrateBossList) do
		local var_4_0 = arg_4_1[iter_4_1:GetCollabBossID()]

		iter_4_1:UpdateCollabBossData(var_4_0.hpRate, var_4_0.deathTimeStamp, var_4_0.trafficPerHour, var_4_0.damagePerHour)
	end

	return
end

function var_0_1.GetCollabSeriesData(arg_5_0, arg_5_1)
	return arg_5_0.collabrateBossList[arg_5_1]
end

function var_0_1.GetCollabSeriesDataList(arg_6_0)
	return arg_6_0.collabrateBossList
end

function var_0_1.HasAwards(arg_7_0)
	return arg_7_0.data2 == 1
end

function var_0_1.GetPassCounts(arg_8_0)
	local var_8_0

	if not arg_8_0.data1_list then
		var_8_0 = {}
	end

	return var_8_0
end

function var_0_1.AddPassSeries(arg_9_0, arg_9_1)
	table = var_1_10002

	var_1_10002.insert(arg_9_0:GetPassCounts(), arg_9_1)

	return
end

function var_0_1.HasPassSeries(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.collabrateBossList[arg_10_1]

	return var_2.IsPass(var_10_0)
end

function var_0_1.HasPlayerDefeatSeries(arg_11_0, arg_11_1)
	table = var_1_10002

	return var_1_10002.contains(arg_11_0:GetPassCounts(), arg_11_1)
end

function var_0_1.GetActiveSeriesIds(arg_12_0)
	return arg_12_0:getConfig("config_data")
end

return var_0_1
