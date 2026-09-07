local ChallengeInfo = class("ChallengeInfo", import(".BaseVO"))

function ChallengeInfo:Ctor(arg_1_1)
	self:UpdateChallengeInfo(arg_1_1)

	return
end

function ChallengeInfo:UpdateChallengeInfo(arg_2_1)
	self._activityMaxScore = arg_2_1.activity_max_score
	self._activityMaxLevel = arg_2_1.activity_max_level
	self._seasonMaxScore = arg_2_1.season_max_score
	self._seasonMaxLevel = arg_2_1.season_max_level
	self._seasonID = arg_2_1.season_id
	self._dungeonList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.dungeon_id_list) do
		table.insert(self._dungeonList, iter_2_1)
	end

	self._buffList = arg_2_1.buff_list
	self._activityIndex = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE):getConfig("config_id")

	return
end

function ChallengeInfo:checkRecord(arg_3_1)
	local var_3_0 = arg_3_1:getScore()

	if arg_3_1:getMode() == ChallengeProxy.MODE_CASUAL then
		self._activityMaxScore = math.max(var_3_0, self._activityMaxScore)
		self._seasonMaxScore = math.max(var_3_0, self._seasonMaxScore)
	end

	local var_3_1 = arg_3_1:getLevel() - 1

	self._activityMaxLevel = math.max(var_3_1, self._activityMaxLevel)
	self._seasonMaxLevel = math.max(var_3_1, self._seasonMaxLevel)

	return
end

function ChallengeInfo:getGradeList()
	return {
		activityMaxScore = self._activityMaxScore,
		activityMaxLevel = self._activityMaxLevel,
		seasonMaxScore = self._seasonMaxScore,
		seasonMaxLevel = self._seasonMaxLevel
	}
end

function ChallengeInfo:getSeasonID()
	return self._seasonID
end

function ChallengeInfo:getDungeonIDList()
	return Clone(self._dungeonList)
end

function ChallengeInfo:getActivityIndex()
	return self._activityIndex
end

return ChallengeInfo
