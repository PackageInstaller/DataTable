class = var_0_10000

local var_0_0 = "CollabrateBossRushSeriesData"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.baseVO"))

pg = var_0_0

local var_0_2 = var_0_0.activity_series_enemy

pg = var_2

local var_0_3 = var_2.extraenemy_template

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.extraenemy_series_template
end

var_0_1.DIFF = {
	NORMAL = 1,
	HARD = 2
}
var_0_1.MODE = {
	MULTIPLE = 2,
	SINGLE = 1
}

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1)

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

function var_0_1.UpdateCollabBossData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.bossHpRate = arg_3_1 / 16
	arg_3_0.deathTimeStamp = arg_3_2
	arg_3_0.trafficPerHour = arg_3_3
	arg_3_0.damagePerHour = arg_3_4 / 16

	return
end

function var_0_1.GetBossHpRate(arg_4_0)
	return arg_4_0.bossHpRate
end

function var_0_1.GetDefeated(arg_5_0, arg_5_1)
	return arg_5_1:HasPlayerDefeatSeries(arg_5_0.configId)
end

function var_0_1.GetBossTimeStamp(arg_6_0)
	return arg_6_0.deathTimeStamp
end

function var_0_1.GetTrafficPerH(arg_7_0)
	return arg_7_0.trafficPerHour
end

function var_0_1.GetDamagePerH(arg_8_0)
	return arg_8_0.damagePerHour
end

function var_0_1.PassStage(arg_9_0, arg_9_1)
	table = var_1_10002

	var_1_10002.insert(arg_9_0.battleStatistics, arg_9_1)

	arg_9_0.stageLevel = arg_9_0.stageLevel + 1

	return
end

function var_0_1.GetBattleStatistics(arg_10_0)
	return arg_10_0.battleStatistics
end

function var_0_1.GetStaegLevel(arg_11_0)
	return arg_11_0.stageLevel
end

function var_0_1.GetNextStage(arg_12_0)
	return {
		stageId = 1
	}
end

function var_0_1.GetMode(arg_13_0)
	assert = var_1_10001

	var_1_10001(arg_13_0.mode)

	return arg_13_0.mode
end

function var_0_1.AddFinalResults(arg_14_0, arg_14_1)
	arg_14_0.battleResults = arg_14_1

	return
end

function var_0_1.GetFinalResults(arg_15_0)
	return arg_15_0.battleResults
end

function var_0_1.AddEXScore(arg_16_0, arg_16_1)
	local var_16_0

	if not arg_16_0.exScores then
		var_16_0 = {}
	end

	arg_16_0.exScores = var_16_0
	table = var_16_0

	var_16_0.insert(arg_16_0.exScores, arg_16_1.score)

	return
end

function var_0_1.GetEXScores(arg_17_0)
	local var_17_0

	if not arg_17_0.exScores then
		var_17_0 = {}
	end

	return var_17_0
end

function var_0_1.GetFleets(arg_18_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)

	return (var_1.GetBossRushFleets(var_18_0, arg_18_0.actId, arg_18_0:GetFleetIds()))
end

function var_0_1.GetExpeditionIds(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.GetBossRushRuntime(var_19_0, arg_19_0.actId).diff
	local var_19_2 = arg_19_0:getConfig("activity_series_enemy_id")[var_19_1]

	return var_0_2[var_19_2].expedition_id
end

function var_0_1.GetFleetIds(arg_20_0)
	if arg_20_0.fleetIds then
		return arg_20_0.fleetIds
	end

	local var_20_0 = arg_20_0:GetExpeditionIds()

	arg_20_0.fleetIds = arg_20_0.StaticCalculateFleetIds(arg_20_0.id, #var_20_0)

	return arg_20_0.fleetIds
end

function var_0_1.GetStorys(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = arg_21_0.bossHpRate * 100

	ipairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(arg_21_0:getConfig("story_worldboss")) do
		if iter_21_1[2] ~= 100 and var_21_1 <= iter_21_1[2] then
			table = var_8

			var_8.insert(var_21_0, iter_21_1[1])
		end
	end

	return var_21_0
end

function var_0_1.GetInitStory(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0:getConfig("story_worldboss")) do
		if iter_22_1[2] == 100 then
			return iter_22_1[1]
		end
	end

	return
end

function var_0_1.GetType(arg_23_0)
	return 1
end

function var_0_1.GetPreSeriesId(arg_24_0)
	return arg_24_0:getConfig("pre_chapter")
end

function var_0_1.IsPlayerUnlock(arg_25_0, arg_25_1)
	local var_25_0

	if #arg_25_0:GetPreSeriesId() == 0 or var_2[1] == 0 then
		return true
	else
		var_25_0 = true
		ipairs = var_1_10004

		for iter_25_0, iter_25_1 in var_1_10004(var_2) do
			var_25_0 = var_25_0 and arg_25_1:HasPassSeries(iter_25_1) and arg_25_1:HasPlayerDefeatSeries(iter_25_1)
		end

		return var_25_0
	end

	unlock = var_25_0

	return var_25_0
end

function var_0_1.IsUnlock(arg_26_0, arg_26_1)
	local var_26_0

	if #arg_26_0:GetPreSeriesId() == 0 or var_2[1] == 0 then
		return true
	else
		var_26_0 = true
		ipairs = var_1_10004

		for iter_26_0, iter_26_1 in var_1_10004(var_2) do
			var_26_0 = var_26_0 and arg_26_1:HasPassSeries(iter_26_1)
		end

		return var_26_0
	end

	unlock = var_26_0

	return var_26_0
end

function var_0_1.IsPass(arg_27_0)
	return arg_27_0.deathTimeStamp ~= 0
end

function var_0_1.GetCurrentProfile(arg_28_0)
	local var_28_0 = arg_28_0:getConfig("profile_pre")
	local var_28_1 = arg_28_0.bossHpRate * 100
	local var_28_2 = 1
	local var_28_3 = #var_28_0 - 1

	while var_28_2 <= var_28_3 do
		local var_28_4 = var_28_0[var_28_2]
		local var_28_5 = var_28_0[var_28_2 + 1]
		local var_28_6 = var_28_4[2]
		local var_28_7 = var_28_5[2]

		if var_28_1 <= var_28_6 and var_28_7 < var_28_1 then
			break
		end

		var_28_2 = var_28_2 + 1
	end

	return var_28_0[var_28_2][1], var_28_0[var_28_2][3]
end

function var_0_1.SetDifficulty(arg_29_0, arg_29_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_29_0 = var_1_10002(var_1_10003)

	var_2.GetBossRushRuntime(var_29_0, arg_29_0.actId).diff = arg_29_1

	return
end

function var_0_1.GetSeriesCode(arg_30_0)
	return arg_30_0:getConfig("chapter_name")
end

function var_0_1.GetSeriesName(arg_31_0)
	return arg_31_0:getConfig("chapter_name2")
end

function var_0_1.GetCollabBossID(arg_32_0)
	return arg_32_0:getConfig("boss_id")[1]
end

function var_0_1.GetActivitySeriesID(arg_33_0, arg_33_1)
	local var_33_1

	if not arg_33_1 then
		::label_33_0::

		getProxy = var_33_1
		ActivityProxy = var_1_10003

		local var_33_0 = var_33_1(var_1_10003)

		var_33_1 = var_33_1.GetBossRushRuntime(var_33_0, arg_33_0.actId).diff
	end

	return arg_33_0:getConfig("activity_series_enemy_id")[var_33_1]
end

function var_0_1.GetName(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetActivitySeriesID(arg_34_1)

	return var_0_2[var_34_0].name
end

function var_0_1.GetReplaceTaskIDList(arg_35_0)
	local var_35_0 = arg_35_0:getConfig("boss_id")[1]

	return var_0_3[var_35_0].replace_task
end

function var_0_1.GetRewardDisplay(arg_36_0)
	local var_36_0 = arg_36_0:getConfig("boss_id")[1]

	return var_0_3[var_36_0].reward_display
end

function var_0_1.GetLimitations(arg_37_0)
	local var_37_0 = arg_37_0:GetActivitySeriesID()

	return var_0_2[var_37_0].limitation
end

function var_0_1.GetOilCost(arg_38_0)
	local var_38_0 = arg_38_0:GetActivitySeriesID()

	return var_0_2[var_38_0].oil
end

function var_0_1.GetDescription(arg_39_0)
	local var_39_0 = arg_39_0:GetActivitySeriesID()

	return var_0_2[var_39_0].profiles
end

function var_0_1.IsSingleFight(arg_40_0)
	local var_40_0 = arg_40_0:GetActivitySeriesID()

	return var_0_2[var_40_0].whether_singlefight == 1
end

function var_0_1.GetBossIcons(arg_41_0)
	local var_41_0 = arg_41_0:GetActivitySeriesID()

	return var_0_2[var_41_0].boss_icon
end

function var_0_1.GetPassAwards(arg_42_0)
	local var_42_0 = arg_42_0:GetActivitySeriesID()

	return var_0_2[var_42_0].pass_awards_display
end

function var_0_1.GetAdditionalAwards(arg_43_0)
	local var_43_0 = arg_43_0:GetActivitySeriesID()

	return var_0_2[var_43_0].additional_awards_display
end

function var_0_1.GetDefeatStories(arg_44_0)
	local var_44_0 = arg_44_0:GetActivitySeriesID()

	return var_0_2[var_44_0].defeat_story
end

function var_0_1.GetDefeatStoriesCount(arg_45_0)
	local var_45_0 = arg_45_0:GetActivitySeriesID()

	return var_0_2[var_45_0].defeat_story_count
end

function var_0_1.GetMaxBonusCount(arg_46_0)
	local var_46_0 = arg_46_0:GetActivitySeriesID()

	return var_0_2[var_46_0].count
end

function var_0_1.GetOilLimit(arg_47_0)
	local var_47_0 = arg_47_0:GetActivitySeriesID()

	return var_0_2[var_47_0].use_oil_limit
end

function var_0_1.GetEXParamater(arg_48_0)
	local var_48_0 = arg_48_0:GetActivitySeriesID()

	return var_0_2[var_48_0].ex_count
end

function var_0_1.StaticCalculateFleetIds(arg_49_0, arg_49_1)
	assert = var_1_10002

	var_1_10002(arg_49_1 <= 10, "expedition List Too long")

	_ = var_1_10002

	local var_49_0 = var_1_10002.map

	_ = var_3

	return var_49_0(var_3.range(arg_49_1 + 1), function(arg_50_0)
		return arg_49_0 * 10 + arg_50_0 - 1
	end)
end

return var_0_1
