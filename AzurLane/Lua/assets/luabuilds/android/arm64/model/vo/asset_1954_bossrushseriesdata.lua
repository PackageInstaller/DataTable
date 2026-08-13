class = var_0_10000

local var_0_0 = "BossRushSeriesData"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.baseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_series_enemy
end

var_0_1.ENERGY_WARN = 30
var_0_1.TYPE = {
	EXTRA = 3,
	NORMAL = 1,
	SP = 2
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

	return
end

function var_0_1.PassStage(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.insert(arg_3_0.battleStatistics, arg_3_1)

	arg_3_0.stageLevel = arg_3_0.stageLevel + 1

	return
end

function var_0_1.GetBattleStatistics(arg_4_0)
	return arg_4_0.battleStatistics
end

function var_0_1.GetStaegLevel(arg_5_0)
	return arg_5_0.stageLevel
end

function var_0_1.GetNextStage(arg_6_0)
	return {
		stageId = 1
	}
end

function var_0_1.GetMode(arg_7_0)
	assert = var_1_10001

	var_1_10001(arg_7_0.mode)

	return arg_7_0.mode
end

function var_0_1.AddFinalResults(arg_8_0, arg_8_1)
	arg_8_0.battleResults = arg_8_1

	return
end

function var_0_1.GetFinalResults(arg_9_0)
	return arg_9_0.battleResults
end

function var_0_1.AddEXScore(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.exScores then
		var_10_0 = {}
	end

	arg_10_0.exScores = var_10_0
	table = var_10_0

	var_10_0.insert(arg_10_0.exScores, arg_10_1.score)

	return
end

function var_0_1.GetEXScores(arg_11_0)
	local var_11_0

	if not arg_11_0.exScores then
		var_11_0 = {}
	end

	return var_11_0
end

function var_0_1.GetFleets(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_12_0 = var_1_10002(var_1_10004)

	return var_2.GetBossRushFleets(var_12_0, arg_12_0.actId, arg_12_1 or arg_12_0:GetFleetIds())
end

function var_0_1.CopyFleetsByOther(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetFleets()
	local var_13_1 = arg_13_0:GetFleetIds()

	for iter_13_0 = 1, #var_13_0 - 1 do
		assert = var_1_10008

		var_1_10008(var_13_1[iter_13_0])

		TypedFleet = var_1_10008
		var_1_10008 = var_1_10008.New
		setmetatable = var_10

		local var_13_2 = {
			id = var_13_1[iter_13_0]
		}
		local var_13_3 = {}
		local var_13_4 = var_13_0[iter_13_0]

		var_13_3.__index = var_14.SeparateOut(var_13_4)
		var_1_10008 = var_1_10008(var_10(var_13_2, var_13_3))

		if iter_13_0 == 1 then
			var_1_10011 = arg_13_0

			if not arg_13_0.IsSingleFight(var_1_10011) then
				var_1_10011 = var_1_10008

				var_1_10008.allClear(var_1_10011)
			end
		end

		getProxy = var_1_10009
		FleetProxy = var_1_10011
		var_1_10011 = var_1_10009(var_1_10011)

		var_1_10009.updateActivityFleet(var_1_10011, arg_13_0.actId, var_13_1[iter_13_0], var_1_10008)
	end

	getProxy = var_4
	FleetProxy = var_6

	local var_13_5 = var_4(var_6)
	local var_13_6 = var_4.updateActivityFleet
	local var_13_7 = arg_13_0.actId
	local var_13_8 = var_13_1[#var_13_1]

	TypedFleet = var_1_10009

	local var_13_9 = var_1_10009.New

	setmetatable = var_1_10011

	local var_13_10 = {
		id = var_13_1[#var_13_1]
	}
	local var_13_11 = {}
	local var_13_12 = var_13_0[#var_13_0]

	var_13_11.__index = var_15.SeparateOut(var_13_12)

	var_13_6(var_13_5, var_13_7, var_13_8, var_13_9(var_1_10011(var_13_10, var_13_11)))

	getProxy = var_13_6
	FleetProxy = var_13_5

	local var_13_13 = var_13_6(var_13_5)

	var_4.commitActivityFleet(var_13_13, arg_13_0.actId)

	return
end

function var_0_1.IsFleetsEmpty(arg_14_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	return var_1.IsBossRushFleetsEmpty(var_14_0, arg_14_0.actId, arg_14_0:GetFleetIds())
end

function var_0_1.GetExpeditionIds(arg_15_0)
	return arg_15_0:getConfig("expedition_id")
end

function var_0_1.GetFleetIds(arg_16_0)
	if arg_16_0.fleetIds then
		return arg_16_0.fleetIds
	end

	local var_16_0 = arg_16_0:GetExpeditionIds()

	arg_16_0.fleetIds = arg_16_0.StaticCalculateFleetIds(arg_16_0.id, #var_16_0)

	return arg_16_0.fleetIds
end

function var_0_1.GetModeFleetIDs(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetFleetIds()
	local var_17_1
	local var_17_2

	if arg_17_1 == var_0_1.MODE.SINGLE then
		var_17_1 = {
			var_17_0[1]
		}
		var_17_2 = {
			var_17_0[#var_17_0]
		}
	else
		local var_17_3

		if arg_17_1 == var_0_1.MODE.MULTIPLE then
			underscore = var_17_3
			var_17_1 = var_17_3.rest(var_17_0)
			var_17_3 = {}
			table = var_1_10006
			var_17_3[1] = var_1_10006.remove(var_17_1)
			var_17_2 = var_17_3
		else
			assert = var_17_3

			var_17_3(false)
		end
	end

	return var_17_1, var_17_2
end

function var_0_1.GetStageFleets(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = arg_18_0:GetModeFleetIDs(arg_18_1)
	local var_18_2

	if not var_18_0[arg_18_2] then
		var_18_2 = var_18_0[1]
	end

	return var_18_2, var_18_1[1]
end

function var_0_1.GetType(arg_19_0)
	return arg_19_0:getConfig("type")
end

function var_0_1.GetPreSeriesId(arg_20_0)
	return arg_20_0:getConfig("pre_chapter")
end

function var_0_1.IsUnlock(arg_21_0, arg_21_1)
	return arg_21_0:GetPreSeriesId() == 0 or arg_21_1:HasPassSeries(var_2)
end

function var_0_1.GetSeriesCode(arg_22_0)
	return arg_22_0:getConfig("chapter_name")
end

function var_0_1.GetName(arg_23_0)
	return arg_23_0:getConfig("name")
end

function var_0_1.GetLimitations(arg_24_0)
	return arg_24_0:getConfig("limitation")
end

function var_0_1.GetOilCost(arg_25_0)
	return arg_25_0:getConfig("oil")
end

function var_0_1.GetDescription(arg_26_0)
	return arg_26_0:getConfig("profiles")
end

function var_0_1.IsSingleFight(arg_27_0)
	return arg_27_0:getConfig("whether_singlefight") == 1
end

function var_0_1.GetBossIcons(arg_28_0)
	return arg_28_0:getConfig("boss_icon")
end

function var_0_1.GetPassAwards(arg_29_0)
	return arg_29_0:getConfig("pass_awards_display")
end

function var_0_1.GetAdditionalAwards(arg_30_0)
	return arg_30_0:getConfig("additional_awards_display")
end

function var_0_1.GetDefeatStories(arg_31_0)
	return arg_31_0:getConfig("defeat_story")
end

function var_0_1.GetDefeatStoriesCount(arg_32_0)
	return arg_32_0:getConfig("defeat_story_count")
end

function var_0_1.GetMaxBonusCount(arg_33_0)
	return arg_33_0:getConfig("count")
end

function var_0_1.GetOilLimit(arg_34_0)
	return arg_34_0:getConfig("use_oil_limit")
end

function var_0_1.GetEXParamater(arg_35_0)
	return arg_35_0:getConfig("ex_count")
end

function var_0_1.StaticCalculateFleetIds(arg_36_0, arg_36_1)
	assert = var_1_10002

	var_1_10002(arg_36_1 <= 10, "expedition List Too long")

	underscore = var_1_10002

	local var_36_0 = var_1_10002.map

	_ = var_4

	return var_36_0(var_4.range(0, arg_36_1 + 1), function(arg_37_0)
		return arg_36_0 * 10 + arg_37_0
	end)
end

return var_0_1
