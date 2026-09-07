local CollabrateBossRushSeriesData = class("CollabrateBossRushSeriesData", import("model.vo.baseVO"))
local var_0_1 = pg.activity_series_enemy
local var_0_2 = pg.extraenemy_template

function CollabrateBossRushSeriesData:bindConfigTable()
	return pg.extraenemy_series_template
end

CollabrateBossRushSeriesData.DIFF = {
	NORMAL = 1,
	HARD = 2
}
CollabrateBossRushSeriesData.MODE = {
	MULTIPLE = 2,
	SINGLE = 1
}

function CollabrateBossRushSeriesData:Ctor(arg_2_1)
	CollabrateBossRushSeriesData.super.Ctor(self, arg_2_1)

	self.configId = self.id
	self.stageLevel = 0
	self.battleStatistics = {}
	self.deathTimeStamp = 0
	self.bossHpRate = 0
	self.trafficPerHour = 0
	self.damagePerHour = 0
	self.actId = arg_2_1.actId

	return
end

function CollabrateBossRushSeriesData:UpdateCollabBossData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.bossHpRate = arg_3_1 / 16
	self.deathTimeStamp = arg_3_2
	self.trafficPerHour = arg_3_3
	self.damagePerHour = arg_3_4 / 16

	return
end

function CollabrateBossRushSeriesData:GetBossHpRate()
	return self.bossHpRate
end

function CollabrateBossRushSeriesData:GetDefeated(arg_5_1)
	return arg_5_1:HasPlayerDefeatSeries(self.configId)
end

function CollabrateBossRushSeriesData:GetBossTimeStamp()
	return self.deathTimeStamp
end

function CollabrateBossRushSeriesData:GetTrafficPerH()
	return self.trafficPerHour
end

function CollabrateBossRushSeriesData:GetDamagePerH()
	return self.damagePerHour
end

function CollabrateBossRushSeriesData:PassStage(arg_9_1)
	table.insert(self.battleStatistics, arg_9_1)

	self.stageLevel = self.stageLevel + 1

	return
end

function CollabrateBossRushSeriesData:GetBattleStatistics()
	return self.battleStatistics
end

function CollabrateBossRushSeriesData:GetStaegLevel()
	return self.stageLevel
end

function CollabrateBossRushSeriesData:GetNextStage()
	return {
		stageId = 1
	}
end

function CollabrateBossRushSeriesData:GetMode()
	assert(self.mode)

	return self.mode
end

function CollabrateBossRushSeriesData:AddFinalResults(arg_14_1)
	self.battleResults = arg_14_1

	return
end

function CollabrateBossRushSeriesData:GetFinalResults()
	return self.battleResults
end

function CollabrateBossRushSeriesData:AddEXScore(arg_16_1)
	self.exScores = self.exScores or {}

	table.insert(self.exScores, arg_16_1.score)

	return
end

function CollabrateBossRushSeriesData:GetEXScores()
	return self.exScores or {}
end

function CollabrateBossRushSeriesData:GetFleets()
	return (getProxy(FleetProxy):GetBossRushFleets(self.actId, self:GetFleetIds()))
end

function CollabrateBossRushSeriesData:GetExpeditionIds()
	return var_0_1[self:getConfig("activity_series_enemy_id")[getProxy(ActivityProxy):GetBossRushRuntime(self.actId).diff]].expedition_id
end

function CollabrateBossRushSeriesData:GetFleetIds()
	if self.fleetIds then
		return self.fleetIds
	end

	self.fleetIds = self.StaticCalculateFleetIds(self.id, #self:GetExpeditionIds())

	return self.fleetIds
end

function CollabrateBossRushSeriesData:GetStorys()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self:getConfig("story_worldboss")) do
		if iter_21_1[2] ~= 100 and self.bossHpRate * 100 <= iter_21_1[2] then
			table.insert(var_21_0, iter_21_1[1])
		end
	end

	return var_21_0
end

function CollabrateBossRushSeriesData:GetInitStory()
	for iter_22_0, iter_22_1 in ipairs(self:getConfig("story_worldboss")) do
		if iter_22_1[2] == 100 then
			return iter_22_1[1]
		end
	end

	return
end

function CollabrateBossRushSeriesData:GetType()
	return 1
end

function CollabrateBossRushSeriesData:GetPreSeriesId()
	return self:getConfig("pre_chapter")
end

function CollabrateBossRushSeriesData:IsPlayerUnlock(arg_25_1)
	local var_25_0 = self:GetPreSeriesId()

	if #var_25_0 == 0 or var_25_0[1] == 0 then
		return true
	else
		local var_25_1 = true

		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			var_25_1 = var_25_1 and arg_25_1:HasPassSeries(iter_25_1) and arg_25_1:HasPlayerDefeatSeries(iter_25_1)
		end

		return var_25_1
	end

	return unlock
end

function CollabrateBossRushSeriesData:IsUnlock(arg_26_1)
	local var_26_0 = self:GetPreSeriesId()

	if #var_26_0 == 0 or var_26_0[1] == 0 then
		return true
	else
		local var_26_1 = true

		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			var_26_1 = var_26_1 and arg_26_1:HasPassSeries(iter_26_1)
		end

		return var_26_1
	end

	return unlock
end

function CollabrateBossRushSeriesData:IsPass()
	return self.deathTimeStamp ~= 0
end

function CollabrateBossRushSeriesData:GetCurrentProfile()
	local var_28_0 = self:getConfig("profile_pre")
	local var_28_1 = 1

	while var_28_1 <= #var_28_0 - 1 do
		if self.bossHpRate * 100 <= var_28_0[var_28_1][2] and var_28_0[var_28_1 + 1][2] < self.bossHpRate * 100 then
			break
		end

		var_28_1 = var_28_1 + 1
	end

	return var_28_0[var_28_1][1], var_28_0[var_28_1][3]
end

function CollabrateBossRushSeriesData:SetDifficulty(arg_29_1)
	getProxy(ActivityProxy):GetBossRushRuntime(self.actId).diff = arg_29_1

	return
end

function CollabrateBossRushSeriesData:GetSeriesCode()
	return self:getConfig("chapter_name")
end

function CollabrateBossRushSeriesData:GetSeriesName()
	return self:getConfig("chapter_name2")
end

function CollabrateBossRushSeriesData:GetCollabBossID()
	return self:getConfig("boss_id")[1]
end

function CollabrateBossRushSeriesData:GetActivitySeriesID(arg_33_1)
	local var_33_0

	if not arg_33_1 then
		::label_33_0::

		var_33_0 = getProxy(ActivityProxy):GetBossRushRuntime(self.actId).diff
	end

	return self:getConfig("activity_series_enemy_id")[var_33_0]
end

function CollabrateBossRushSeriesData:GetName(arg_34_1)
	return var_0_1[self:GetActivitySeriesID(arg_34_1)].name
end

function CollabrateBossRushSeriesData:GetReplaceTaskIDList()
	return var_0_2[self:getConfig("boss_id")[1]].replace_task
end

function CollabrateBossRushSeriesData:GetRewardDisplay()
	return var_0_2[self:getConfig("boss_id")[1]].reward_display
end

function CollabrateBossRushSeriesData:GetLimitations()
	return var_0_1[self:GetActivitySeriesID()].limitation
end

function CollabrateBossRushSeriesData:GetOilCost()
	return var_0_1[self:GetActivitySeriesID()].oil
end

function CollabrateBossRushSeriesData:GetDescription()
	return var_0_1[self:GetActivitySeriesID()].profiles
end

function CollabrateBossRushSeriesData:IsSingleFight()
	return var_0_1[self:GetActivitySeriesID()].whether_singlefight == 1
end

function CollabrateBossRushSeriesData:GetBossIcons()
	return var_0_1[self:GetActivitySeriesID()].boss_icon
end

function CollabrateBossRushSeriesData:GetPassAwards()
	return var_0_1[self:GetActivitySeriesID()].pass_awards_display
end

function CollabrateBossRushSeriesData:GetAdditionalAwards()
	return var_0_1[self:GetActivitySeriesID()].additional_awards_display
end

function CollabrateBossRushSeriesData:GetDefeatStories()
	return var_0_1[self:GetActivitySeriesID()].defeat_story
end

function CollabrateBossRushSeriesData:GetDefeatStoriesCount()
	return var_0_1[self:GetActivitySeriesID()].defeat_story_count
end

function CollabrateBossRushSeriesData:GetMaxBonusCount()
	return var_0_1[self:GetActivitySeriesID()].count
end

function CollabrateBossRushSeriesData:GetOilLimit()
	return var_0_1[self:GetActivitySeriesID()].use_oil_limit
end

function CollabrateBossRushSeriesData:GetEXParamater()
	return var_0_1[self:GetActivitySeriesID()].ex_count
end

function CollabrateBossRushSeriesData:StaticCalculateFleetIds(arg_49_1)
	assert(arg_49_1 <= 10, "expedition List Too long")

	return _.map(_.range(arg_49_1 + 1), function(arg_50_0)
		return self * 10 + arg_50_0 - 1
	end)
end

return CollabrateBossRushSeriesData
