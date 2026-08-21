local var_0_0 = class("BossRushSeriesData", import("model.vo.baseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_series_enemy
end

var_0_0.ENERGY_WARN = 30
var_0_0.TYPE = {
	EXTRA = 3,
	NORMAL = 1,
	SP = 2
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

	return
end

function var_0_0.PassStage(arg_3_0, arg_3_1)
	table.insert(arg_3_0.battleStatistics, arg_3_1)

	arg_3_0.stageLevel = arg_3_0.stageLevel + 1

	return
end

function var_0_0.GetBattleStatistics(arg_4_0)
	return arg_4_0.battleStatistics
end

function var_0_0.GetStaegLevel(arg_5_0)
	return arg_5_0.stageLevel
end

function var_0_0.GetNextStage(arg_6_0)
	return {
		stageId = 1
	}
end

function var_0_0.GetMode(arg_7_0)
	assert(arg_7_0.mode)

	return arg_7_0.mode
end

function var_0_0.AddFinalResults(arg_8_0, arg_8_1)
	arg_8_0.battleResults = arg_8_1

	return
end

function var_0_0.GetFinalResults(arg_9_0)
	return arg_9_0.battleResults
end

function var_0_0.AddEXScore(arg_10_0, arg_10_1)
	arg_10_0.exScores = arg_10_0.exScores or {}

	table.insert(arg_10_0.exScores, arg_10_1.score)

	return
end

function var_0_0.GetEXScores(arg_11_0)
	return arg_11_0.exScores or {}
end

function var_0_0.GetFleets(arg_12_0, arg_12_1)
	return getProxy(FleetProxy):GetBossRushFleets(arg_12_0.actId, arg_12_1 or arg_12_0:GetFleetIds())
end

function var_0_0.CopyFleetsByOther(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetFleets()
	local var_13_1 = arg_13_0:GetFleetIds()

	for iter_13_0 = 1, #var_13_0 - 1 do
		assert(var_13_1[iter_13_0])

		local var_13_2 = TypedFleet.New(setmetatable({
			id = var_13_1[iter_13_0]
		}, {
			__index = var_13_0[iter_13_0]:SeparateOut()
		}))

		if iter_13_0 == 1 and not arg_13_0:IsSingleFight() then
			var_13_2:allClear()
		end

		getProxy(FleetProxy):updateActivityFleet(arg_13_0.actId, var_13_1[iter_13_0], var_13_2)
	end

	getProxy(FleetProxy):updateActivityFleet(arg_13_0.actId, var_13_1[#var_13_1], TypedFleet.New(setmetatable({
		id = var_13_1[#var_13_1]
	}, {
		__index = var_13_0[#var_13_0]:SeparateOut()
	})))
	getProxy(FleetProxy):commitActivityFleet(arg_13_0.actId)

	return
end

function var_0_0.IsFleetsEmpty(arg_14_0)
	return getProxy(FleetProxy):IsBossRushFleetsEmpty(arg_14_0.actId, arg_14_0:GetFleetIds())
end

function var_0_0.GetExpeditionIds(arg_15_0)
	return arg_15_0:getConfig("expedition_id")
end

function var_0_0.GetFleetIds(arg_16_0)
	if arg_16_0.fleetIds then
		return arg_16_0.fleetIds
	end

	arg_16_0.fleetIds = arg_16_0.StaticCalculateFleetIds(arg_16_0.id, #arg_16_0:GetExpeditionIds())

	return arg_16_0.fleetIds
end

function var_0_0.GetModeFleetIDs(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetFleetIds()
	local var_17_1
	local var_17_2

	if arg_17_1 == var_0_0.MODE.SINGLE then
		var_17_1 = {
			var_17_0[1]
		}
		var_17_2 = {
			var_17_0[#var_17_0]
		}
	elseif arg_17_1 == var_0_0.MODE.MULTIPLE then
		var_17_1 = underscore.rest(var_17_0)
		var_17_2 = {
			table.remove(var_17_1)
		}
	else
		assert(false)
	end

	return var_17_1, var_17_2
end

function var_0_0.GetStageFleets(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = arg_18_0:GetModeFleetIDs(arg_18_1)
	local var_18_2 = var_18_0[arg_18_2] or var_18_0[1]

	return var_18_2, var_18_1[1]
end

function var_0_0.GetType(arg_19_0)
	return arg_19_0:getConfig("type")
end

function var_0_0.GetPreSeriesId(arg_20_0)
	return arg_20_0:getConfig("pre_chapter")
end

function var_0_0.IsUnlock(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:GetPreSeriesId()

	return var_21_0 == 0 or arg_21_1:HasPassSeries(var_21_0)
end

function var_0_0.GetSeriesCode(arg_22_0)
	return arg_22_0:getConfig("chapter_name")
end

function var_0_0.GetName(arg_23_0)
	return arg_23_0:getConfig("name")
end

function var_0_0.GetLimitations(arg_24_0)
	return arg_24_0:getConfig("limitation")
end

function var_0_0.GetOilCost(arg_25_0)
	return arg_25_0:getConfig("oil")
end

function var_0_0.GetDescription(arg_26_0)
	return arg_26_0:getConfig("profiles")
end

function var_0_0.IsSingleFight(arg_27_0)
	return arg_27_0:getConfig("whether_singlefight") == 1
end

function var_0_0.GetBossIcons(arg_28_0)
	return arg_28_0:getConfig("boss_icon")
end

function var_0_0.GetPassAwards(arg_29_0)
	return arg_29_0:getConfig("pass_awards_display")
end

function var_0_0.GetAdditionalAwards(arg_30_0)
	return arg_30_0:getConfig("additional_awards_display")
end

function var_0_0.GetDefeatStories(arg_31_0)
	return arg_31_0:getConfig("defeat_story")
end

function var_0_0.GetDefeatStoriesCount(arg_32_0)
	return arg_32_0:getConfig("defeat_story_count")
end

function var_0_0.GetMaxBonusCount(arg_33_0)
	return arg_33_0:getConfig("count")
end

function var_0_0.GetOilLimit(arg_34_0)
	return arg_34_0:getConfig("use_oil_limit")
end

function var_0_0.GetEXParamater(arg_35_0)
	return arg_35_0:getConfig("ex_count")
end

function var_0_0.StaticCalculateFleetIds(arg_36_0, arg_36_1)
	assert(arg_36_1 <= 10, "expedition List Too long")

	return underscore.map(_.range(0, arg_36_1 + 1), function(arg_37_0)
		return arg_36_0 * 10 + arg_37_0
	end)
end

return var_0_0
