local var_0_0 = class("CollabrateBossRushActivity", import("model.vo.Activity"))

function var_0_0.SetSeriesData(arg_1_0, arg_1_1)
	getProxy(ActivityProxy):GetBossRushRuntime(arg_1_0.id).seriesData = arg_1_1

	return
end

function var_0_0.GetSeriesData(arg_2_0)
	return getProxy(ActivityProxy):GetBossRushRuntime(arg_2_0.id).seriesData
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	var_0_0.super.Ctor(arg_3_0, arg_3_1)

	arg_3_0.collabrateBossList = {}

	for iter_3_0, iter_3_1 in ipairs((arg_3_0:getConfig("config_data"))) do
		arg_3_0.collabrateBossList[iter_3_1] = CollabrateBossRushSeriesData.New({
			id = iter_3_1,
			index = iter_3_0,
			actId = arg_3_0.id
		})
	end

	return
end

function var_0_0.UpdateCollabrateBossData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.collabrateBossList) do
		local var_4_0 = arg_4_1[iter_4_1:GetCollabBossID()]

		iter_4_1:UpdateCollabBossData(var_4_0.hpRate, var_4_0.deathTimeStamp, var_4_0.trafficPerHour, var_4_0.damagePerHour)
	end

	return
end

function var_0_0.GetCollabSeriesData(arg_5_0, arg_5_1)
	return arg_5_0.collabrateBossList[arg_5_1]
end

function var_0_0.GetCollabSeriesDataList(arg_6_0)
	return arg_6_0.collabrateBossList
end

function var_0_0.HasAwards(arg_7_0)
	return arg_7_0.data2 == 1
end

function var_0_0.GetPassCounts(arg_8_0)
	return arg_8_0.data1_list or {}
end

function var_0_0.AddPassSeries(arg_9_0, arg_9_1)
	table.insert(arg_9_0:GetPassCounts(), arg_9_1)

	return
end

function var_0_0.HasPassSeries(arg_10_0, arg_10_1)
	return arg_10_0.collabrateBossList[arg_10_1]:IsPass()
end

function var_0_0.HasPlayerDefeatSeries(arg_11_0, arg_11_1)
	return table.contains(arg_11_0:GetPassCounts(), arg_11_1)
end

function var_0_0.GetActiveSeriesIds(arg_12_0)
	return arg_12_0:getConfig("config_data")
end

return var_0_0
