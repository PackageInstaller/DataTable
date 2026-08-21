local var_0_0 = class("ChallengeInfo", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateChallengeInfo(arg_1_1)

	return
end

function var_0_0.UpdateChallengeInfo(arg_2_0, arg_2_1)
	arg_2_0._activityMaxScore = arg_2_1.activity_max_score
	arg_2_0._activityMaxLevel = arg_2_1.activity_max_level
	arg_2_0._seasonMaxScore = arg_2_1.season_max_score
	arg_2_0._seasonMaxLevel = arg_2_1.season_max_level
	arg_2_0._seasonID = arg_2_1.season_id
	arg_2_0._dungeonList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.dungeon_id_list) do
		table.insert(arg_2_0._dungeonList, iter_2_1)
	end

	arg_2_0._buffList = arg_2_1.buff_list
	arg_2_0._activityIndex = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE):getConfig("config_id")

	return
end

function var_0_0.checkRecord(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getScore()

	if arg_3_1:getMode() == ChallengeProxy.MODE_CASUAL then
		arg_3_0._activityMaxScore = math.max(var_3_0, arg_3_0._activityMaxScore)
		arg_3_0._seasonMaxScore = math.max(var_3_0, arg_3_0._seasonMaxScore)
	end

	local var_3_1 = arg_3_1:getLevel() - 1

	arg_3_0._activityMaxLevel = math.max(var_3_1, arg_3_0._activityMaxLevel)
	arg_3_0._seasonMaxLevel = math.max(var_3_1, arg_3_0._seasonMaxLevel)

	return
end

function var_0_0.getGradeList(arg_4_0)
	return {
		activityMaxScore = arg_4_0._activityMaxScore,
		activityMaxLevel = arg_4_0._activityMaxLevel,
		seasonMaxScore = arg_4_0._seasonMaxScore,
		seasonMaxLevel = arg_4_0._seasonMaxLevel
	}
end

function var_0_0.getSeasonID(arg_5_0)
	return arg_5_0._seasonID
end

function var_0_0.getDungeonIDList(arg_6_0)
	return Clone(arg_6_0._dungeonList)
end

function var_0_0.getActivityIndex(arg_7_0)
	return arg_7_0._activityIndex
end

return var_0_0
