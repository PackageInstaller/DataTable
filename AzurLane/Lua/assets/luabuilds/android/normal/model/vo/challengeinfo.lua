class = var_0_10000

local var_0_0 = "ChallengeInfo"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateChallengeInfo(arg_1_1)

	return
end

function var_0_1.UpdateChallengeInfo(arg_2_0, arg_2_1)
	arg_2_0._activityMaxScore = arg_2_1.activity_max_score
	arg_2_0._activityMaxLevel = arg_2_1.activity_max_level
	arg_2_0._seasonMaxScore = arg_2_1.season_max_score
	arg_2_0._seasonMaxLevel = arg_2_1.season_max_level
	arg_2_0._seasonID = arg_2_1.season_id
	arg_2_0._dungeonList = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.dungeon_id_list) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0._dungeonList, iter_2_1)
	end

	arg_2_0._buffList = arg_2_1.buff_list
	getProxy = var_2
	ActivityProxy = var_3

	local var_2_0 = var_2(var_3)
	local var_2_1 = var_2.getActivityByType

	ActivityConst = iter_2_0

	local var_2_2 = var_2_1(var_2_0, iter_2_0.ACTIVITY_TYPE_CHALLENGE)

	arg_2_0._activityIndex = var_3.getConfig(var_2_2, "config_id")

	return
end

function var_0_1.checkRecord(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getMode()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getScore(var_3_1)

	ChallengeProxy = var_3_1

	if var_3_0 == var_3_1.MODE_CASUAL then
		math = var_4
		arg_3_0._activityMaxScore = var_4.max(var_3_2, arg_3_0._activityMaxScore)
		math = var_4
		arg_3_0._seasonMaxScore = var_4.max(var_3_2, arg_3_0._seasonMaxScore)
	end

	local var_3_3 = arg_3_1
	local var_3_4 = arg_3_1.getLevel(var_3_3) - 1

	math = var_3_3
	arg_3_0._activityMaxLevel = var_3_3.max(var_3_4, arg_3_0._activityMaxLevel)
	math = var_5
	arg_3_0._seasonMaxLevel = var_5.max(var_3_4, arg_3_0._seasonMaxLevel)

	return
end

function var_0_1.getGradeList(arg_4_0)
	return {
		activityMaxScore = arg_4_0._activityMaxScore,
		activityMaxLevel = arg_4_0._activityMaxLevel,
		seasonMaxScore = arg_4_0._seasonMaxScore,
		seasonMaxLevel = arg_4_0._seasonMaxLevel
	}
end

function var_0_1.getSeasonID(arg_5_0)
	return arg_5_0._seasonID
end

function var_0_1.getDungeonIDList(arg_6_0)
	Clone = var_1_10001

	return var_1_10001(arg_6_0._dungeonList)
end

function var_0_1.getActivityIndex(arg_7_0)
	return arg_7_0._activityIndex
end

return var_0_1
