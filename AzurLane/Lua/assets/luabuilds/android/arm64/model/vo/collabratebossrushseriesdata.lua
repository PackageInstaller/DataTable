local var_0_0 = class("CollabrateBossRushSeriesData", import("model.vo.baseVO"))
local var_0_1 = pg.activity_series_enemy
local var_0_2 = pg.extraenemy_template

function var_0_0.bindConfigTable(arg_1_0)
	return pg.extraenemy_series_template
end

var_0_0.DIFF = {
	NORMAL = 1,
	HARD = 2
}
var_0_0.MODE = {
	MULTIPLE = 2,
	SINGLE = 1
}

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.configId = arg_2_0.id
	arg_2_0.stageLevel = 0
	arg_2_0.battleStatistics = {}
	arg_2_0.deathTimeStamp = 0
	arg_2_0.bossHpRate = 0
	arg_2_0.trafficPerHour = 0
	arg_2_0.damagePerHour = 0
	arg_2_0.actId = arg_2_1.actId

	return
end

function var_0_0.UpdateCollabBossData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.bossHpRate = arg_3_1 / 16
	arg_3_0.deathTimeStamp = arg_3_2
	arg_3_0.trafficPerHour = arg_3_3
	arg_3_0.damagePerHour = arg_3_4 / 16

	return
end

function var_0_0.GetBossHpRate(arg_4_0)
	return arg_4_0.bossHpRate
end

function var_0_0.GetDefeated(arg_5_0, arg_5_1)
	return arg_5_1:HasPlayerDefeatSeries(arg_5_0.configId)
end

function var_0_0.GetBossTimeStamp(arg_6_0)
	return arg_6_0.deathTimeStamp
end

function var_0_0.GetTrafficPerH(arg_7_0)
	return arg_7_0.trafficPerHour
end

function var_0_0.GetDamagePerH(arg_8_0)
	return arg_8_0.damagePerHour
end

function var_0_0.PassStage(arg_9_0, arg_9_1)
	table.insert(arg_9_0.battleStatistics, arg_9_1)

	arg_9_0.stageLevel = arg_9_0.stageLevel + 1

	return
end

function var_0_0.GetBattleStatistics(arg_10_0)
	return arg_10_0.battleStatistics
end

function var_0_0.GetStaegLevel(arg_11_0)
	return arg_11_0.stageLevel
end

function var_0_0.GetNextStage(arg_12_0)
	return {
		stageId = 1
	}
end

function var_0_0.GetMode(arg_13_0)
	assert(arg_13_0.mode)

	return arg_13_0.mode
end

function var_0_0.AddFinalResults(arg_14_0, arg_14_1)
	arg_14_0.battleResults = arg_14_1

	return
end

function var_0_0.GetFinalResults(arg_15_0)
	return arg_15_0.battleResults
end

function var_0_0.AddEXScore(arg_16_0, arg_16_1)
	arg_16_0.exScores = arg_16_0.exScores or {}

	table.insert(arg_16_0.exScores, arg_16_1.score)

	return
end

function var_0_0.GetEXScores(arg_17_0)
	return arg_17_0.exScores or {}
end

function var_0_0.GetFleets(arg_18_0)
	return (getProxy(FleetProxy):GetBossRushFleets(arg_18_0.actId, arg_18_0:GetFleetIds()))
end

function var_0_0.GetExpeditionIds(arg_19_0)
	return var_0_1[arg_19_0:getConfig("activity_series_enemy_id")[getProxy(ActivityProxy):GetBossRushRuntime(arg_19_0.actId).diff]].expedition_id
end

function var_0_0.GetFleetIds(arg_20_0)
	if arg_20_0.fleetIds then
		return arg_20_0.fleetIds
	end

	arg_20_0.fleetIds = arg_20_0.StaticCalculateFleetIds(arg_20_0.id, #arg_20_0:GetExpeditionIds())

	return arg_20_0.fleetIds
end

function var_0_0.GetStorys(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0:getConfig("story_worldboss")) do
		if iter_21_1[2] ~= 100 and arg_21_0.bossHpRate * 100 <= iter_21_1[2] then
			table.insert({}, iter_21_1[1])
		end
	end

	return {}
end

function var_0_0.GetInitStory(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0:getConfig("story_worldboss")) do
		if iter_22_1[2] == 100 then
			return iter_22_1[1]
		end
	end

	return
end

function var_0_0.GetType(arg_23_0)
	return 1
end

function var_0_0.GetPreSeriesId(arg_24_0)
	return arg_24_0:getConfig("pre_chapter")
end

function var_0_0.IsPlayerUnlock(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetPreSeriesId()

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

function var_0_0.IsUnlock(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetPreSeriesId()

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

function var_0_0.IsPass(arg_27_0)
	return arg_27_0.deathTimeStamp ~= 0
end

function var_0_0.GetCurrentProfile(arg_28_0)
	local var_28_0 = arg_28_0:getConfig("profile_pre")
	local var_28_1 = 1

	while var_28_1 <= #var_28_0 - 1 do
		if arg_28_0.bossHpRate * 100 <= var_28_0[var_28_1][2] and var_28_0[var_28_1 + 1][2] < arg_28_0.bossHpRate * 100 then
			break
		end

		var_28_1 = var_28_1 + 1
	end

	return var_28_0[var_28_1][1], var_28_0[var_28_1][3]
end

function var_0_0.SetDifficulty(arg_29_0, arg_29_1)
	getProxy(ActivityProxy):GetBossRushRuntime(arg_29_0.actId).diff = arg_29_1

	return
end

function var_0_0.GetSeriesCode(arg_30_0)
	return arg_30_0:getConfig("chapter_name")
end

function var_0_0.GetSeriesName(arg_31_0)
	return arg_31_0:getConfig("chapter_name2")
end

function var_0_0.GetCollabBossID(arg_32_0)
	return arg_32_0:getConfig("boss_id")[1]
end

function var_0_0.GetActivitySeriesID(arg_33_0, arg_33_1)
	local var_33_1

	if not arg_33_1 then
		::label_33_0::

		local var_33_0 = getProxy(ActivityProxy)

		var_33_1 = var_33_0:GetBossRushRuntime(arg_33_0.actId).diff
	end

	return arg_33_0:getConfig("activity_series_enemy_id")[var_33_1]
end

function var_0_0.GetName(arg_34_0, arg_34_1)
	return var_0_1[arg_34_0:GetActivitySeriesID(arg_34_1)].name
end

function var_0_0.GetReplaceTaskIDList(arg_35_0)
	return var_0_2[arg_35_0:getConfig("boss_id")[1]].replace_task
end

function var_0_0.GetRewardDisplay(arg_36_0)
	return var_0_2[arg_36_0:getConfig("boss_id")[1]].reward_display
end

function var_0_0.GetLimitations(arg_37_0)
	return var_0_1[arg_37_0:GetActivitySeriesID()].limitation
end

function var_0_0.GetOilCost(arg_38_0)
	return var_0_1[arg_38_0:GetActivitySeriesID()].oil
end

function var_0_0.GetDescription(arg_39_0)
	return var_0_1[arg_39_0:GetActivitySeriesID()].profiles
end

function var_0_0.IsSingleFight(arg_40_0)
	return var_0_1[arg_40_0:GetActivitySeriesID()].whether_singlefight == 1
end

function var_0_0.GetBossIcons(arg_41_0)
	return var_0_1[arg_41_0:GetActivitySeriesID()].boss_icon
end

function var_0_0.GetPassAwards(arg_42_0)
	return var_0_1[arg_42_0:GetActivitySeriesID()].pass_awards_display
end

function var_0_0.GetAdditionalAwards(arg_43_0)
	return var_0_1[arg_43_0:GetActivitySeriesID()].additional_awards_display
end

function var_0_0.GetDefeatStories(arg_44_0)
	return var_0_1[arg_44_0:GetActivitySeriesID()].defeat_story
end

function var_0_0.GetDefeatStoriesCount(arg_45_0)
	return var_0_1[arg_45_0:GetActivitySeriesID()].defeat_story_count
end

function var_0_0.GetMaxBonusCount(arg_46_0)
	return var_0_1[arg_46_0:GetActivitySeriesID()].count
end

function var_0_0.GetOilLimit(arg_47_0)
	return var_0_1[arg_47_0:GetActivitySeriesID()].use_oil_limit
end

function var_0_0.GetEXParamater(arg_48_0)
	return var_0_1[arg_48_0:GetActivitySeriesID()].ex_count
end

function var_0_0.StaticCalculateFleetIds(arg_49_0, arg_49_1)
	assert(arg_49_1 <= 10, "expedition List Too long")

	return _.map(_.range(arg_49_1 + 1), function(arg_50_0)
		return arg_49_0 * 10 + arg_50_0 - 1
	end)
end

return var_0_0
