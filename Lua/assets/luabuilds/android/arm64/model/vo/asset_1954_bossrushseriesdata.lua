local BossRushSeriesData = class("BossRushSeriesData", import("model.vo.baseVO"))

function BossRushSeriesData:bindConfigTable()
	return pg.activity_series_enemy
end

BossRushSeriesData.ENERGY_WARN = 30
BossRushSeriesData.TYPE = {
	EXTRA = 3,
	NORMAL = 1,
	SP = 2
}
BossRushSeriesData.MODE = {
	MULTIPLE = 2,
	SINGLE = 1
}

function BossRushSeriesData:Ctor(arg_2_1)
	BossRushSeriesData.super.Ctor(self, arg_2_1)

	self.configId = self.id
	self.stageLevel = 0
	self.battleStatistics = {}

	return
end

function BossRushSeriesData:PassStage(arg_3_1)
	table.insert(self.battleStatistics, arg_3_1)

	self.stageLevel = self.stageLevel + 1

	return
end

function BossRushSeriesData:GetBattleStatistics()
	return self.battleStatistics
end

function BossRushSeriesData:GetStaegLevel()
	return self.stageLevel
end

function BossRushSeriesData:GetNextStage()
	return {
		stageId = 1
	}
end

function BossRushSeriesData:GetMode()
	assert(self.mode)

	return self.mode
end

function BossRushSeriesData:AddFinalResults(arg_8_1)
	self.battleResults = arg_8_1

	return
end

function BossRushSeriesData:GetFinalResults()
	return self.battleResults
end

function BossRushSeriesData:AddEXScore(arg_10_1)
	self.exScores = self.exScores or {}

	table.insert(self.exScores, arg_10_1.score)

	return
end

function BossRushSeriesData:GetEXScores()
	return self.exScores or {}
end

function BossRushSeriesData:GetFleets(arg_12_1)
	return getProxy(FleetProxy):GetBossRushFleets(self.actId, arg_12_1 or self:GetFleetIds())
end

function BossRushSeriesData:CopyFleetsByOther(arg_13_1)
	local var_13_0 = arg_13_1:GetFleets()
	local var_13_1 = self:GetFleetIds()

	for iter_13_0 = 1, #var_13_0 - 1 do
		assert(var_13_1[iter_13_0])

		local var_13_2 = TypedFleet.New(setmetatable({
			id = var_13_1[iter_13_0]
		}, {
			__index = var_13_0[iter_13_0]:SeparateOut()
		}))

		if iter_13_0 == 1 and not self:IsSingleFight() then
			var_13_2:allClear()
		end

		getProxy(FleetProxy):updateActivityFleet(self.actId, var_13_1[iter_13_0], var_13_2)
	end

	getProxy(FleetProxy):updateActivityFleet(self.actId, var_13_1[#var_13_1], TypedFleet.New(setmetatable({
		id = var_13_1[#var_13_1]
	}, {
		__index = var_13_0[#var_13_0]:SeparateOut()
	})))
	getProxy(FleetProxy):commitActivityFleet(self.actId)

	return
end

function BossRushSeriesData:IsFleetsEmpty()
	return getProxy(FleetProxy):IsBossRushFleetsEmpty(self.actId, self:GetFleetIds())
end

function BossRushSeriesData:GetExpeditionIds()
	return self:getConfig("expedition_id")
end

function BossRushSeriesData:GetFleetIds()
	if self.fleetIds then
		return self.fleetIds
	end

	self.fleetIds = self.StaticCalculateFleetIds(self.id, #self:GetExpeditionIds())

	return self.fleetIds
end

function BossRushSeriesData:GetModeFleetIDs(arg_17_1)
	local var_17_0 = self:GetFleetIds()
	local var_17_1
	local var_17_2

	if arg_17_1 == BossRushSeriesData.MODE.SINGLE then
		var_17_1 = {
			var_17_0[1]
		}
		var_17_2 = {
			var_17_0[#var_17_0]
		}
	elseif arg_17_1 == BossRushSeriesData.MODE.MULTIPLE then
		var_17_1 = underscore.rest(var_17_0)
		var_17_2 = {
			table.remove(var_17_1)
		}
	else
		assert(false)
	end

	return var_17_1, var_17_2
end

function BossRushSeriesData:GetStageFleets(arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = self:GetModeFleetIDs(arg_18_1)

	return var_18_0[arg_18_2] or var_18_0[1], var_18_1[1]
end

function BossRushSeriesData:GetType()
	return self:getConfig("type")
end

function BossRushSeriesData:GetPreSeriesId()
	return self:getConfig("pre_chapter")
end

function BossRushSeriesData:IsUnlock(arg_21_1)
	local var_21_0 = self:GetPreSeriesId()

	return var_21_0 == 0 or arg_21_1:HasPassSeries(var_21_0)
end

function BossRushSeriesData:GetSeriesCode()
	return self:getConfig("chapter_name")
end

function BossRushSeriesData:GetName()
	return self:getConfig("name")
end

function BossRushSeriesData:GetLimitations()
	return self:getConfig("limitation")
end

function BossRushSeriesData:GetOilCost()
	return self:getConfig("oil")
end

function BossRushSeriesData:GetDescription()
	return self:getConfig("profiles")
end

function BossRushSeriesData:IsSingleFight()
	return self:getConfig("whether_singlefight") == 1
end

function BossRushSeriesData:GetBossIcons()
	return self:getConfig("boss_icon")
end

function BossRushSeriesData:GetPassAwards()
	return self:getConfig("pass_awards_display")
end

function BossRushSeriesData:GetAdditionalAwards()
	return self:getConfig("additional_awards_display")
end

function BossRushSeriesData:GetDefeatStories()
	return self:getConfig("defeat_story")
end

function BossRushSeriesData:GetDefeatStoriesCount()
	return self:getConfig("defeat_story_count")
end

function BossRushSeriesData:GetMaxBonusCount()
	return self:getConfig("count")
end

function BossRushSeriesData:GetOilLimit()
	return self:getConfig("use_oil_limit")
end

function BossRushSeriesData:GetEXParamater()
	return self:getConfig("ex_count")
end

function BossRushSeriesData:StaticCalculateFleetIds(arg_36_1)
	assert(arg_36_1 <= 10, "expedition List Too long")

	return underscore.map(_.range(0, arg_36_1 + 1), function(arg_37_0)
		return self * 10 + arg_37_0
	end)
end

return BossRushSeriesData
