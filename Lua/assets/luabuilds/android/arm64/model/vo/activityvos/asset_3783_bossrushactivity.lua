local BossRushActivity = class("BossRushActivity", import("model.vo.Activity"))

function BossRushActivity:SetSeriesData(arg_1_1)
	getProxy(ActivityProxy):GetBossRushRuntime(self.id).seriesData = arg_1_1

	return
end

function BossRushActivity:GetSeriesData()
	return getProxy(ActivityProxy):GetBossRushRuntime(self.id).seriesData
end

function BossRushActivity:HasAwards()
	return self.data1 == 1
end

function BossRushActivity:GetUsedBonus()
	return self.data1_list
end

function BossRushActivity:AddUsedBonus(arg_5_1)
	local var_5_0 = table.indexof(self:GetActiveSeriesIds(), arg_5_1)

	if not var_5_0 or var_5_0 < 0 then
		return
	end

	self:GetUsedBonus()[var_5_0] = (self:GetUsedBonus()[var_5_0] or 0) + 1

	return
end

function BossRushActivity:GetPassCounts()
	return self.data2_list
end

function BossRushActivity:AddPassSeries(arg_7_1)
	if self:HasPassSeries(arg_7_1) then
		return
	end

	table.insert(self:GetPassCounts(), arg_7_1)

	return
end

function BossRushActivity:HasPassSeries(arg_8_1)
	return table.contains(self:GetPassCounts(), arg_8_1)
end

function BossRushActivity:GetActiveSeriesIds()
	return self:getConfig("config_data")
end

return BossRushActivity
