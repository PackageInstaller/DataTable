local CollabrateBossRushActivity = class("CollabrateBossRushActivity", import("model.vo.Activity"))

function CollabrateBossRushActivity:SetSeriesData(arg_1_1)
	getProxy(ActivityProxy):GetBossRushRuntime(self.id).seriesData = arg_1_1

	return
end

function CollabrateBossRushActivity:GetSeriesData()
	return getProxy(ActivityProxy):GetBossRushRuntime(self.id).seriesData
end

function CollabrateBossRushActivity:Ctor(arg_3_1)
	CollabrateBossRushActivity.super.Ctor(self, arg_3_1)

	self.collabrateBossList = {}

	for iter_3_0, iter_3_1 in ipairs((self:getConfig("config_data"))) do
		self.collabrateBossList[iter_3_1] = CollabrateBossRushSeriesData.New({
			id = iter_3_1,
			index = iter_3_0,
			actId = self.id
		})
	end

	return
end

function CollabrateBossRushActivity:UpdateCollabrateBossData(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.collabrateBossList) do
		local var_4_0 = arg_4_1[iter_4_1:GetCollabBossID()]

		iter_4_1:UpdateCollabBossData(var_4_0.hpRate, var_4_0.deathTimeStamp, var_4_0.trafficPerHour, var_4_0.damagePerHour)
	end

	return
end

function CollabrateBossRushActivity:GetCollabSeriesData(arg_5_1)
	return self.collabrateBossList[arg_5_1]
end

function CollabrateBossRushActivity:GetCollabSeriesDataList()
	return self.collabrateBossList
end

function CollabrateBossRushActivity:HasAwards()
	return self.data2 == 1
end

function CollabrateBossRushActivity:GetPassCounts()
	return self.data1_list or {}
end

function CollabrateBossRushActivity:AddPassSeries(arg_9_1)
	table.insert(self:GetPassCounts(), arg_9_1)

	return
end

function CollabrateBossRushActivity:HasPassSeries(arg_10_1)
	return self.collabrateBossList[arg_10_1]:IsPass()
end

function CollabrateBossRushActivity:HasPlayerDefeatSeries(arg_11_1)
	return table.contains(self:GetPassCounts(), arg_11_1)
end

function CollabrateBossRushActivity:GetActiveSeriesIds()
	return self:getConfig("config_data")
end

return CollabrateBossRushActivity
