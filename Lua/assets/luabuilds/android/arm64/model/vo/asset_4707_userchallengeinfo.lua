local UserChallengeInfo = class("UserChallengeInfo", import(".BaseVO"))

function UserChallengeInfo:Ctor(arg_1_1)
	self:UpdateChallengeInfo(arg_1_1)

	return
end

function UserChallengeInfo:UpdateChallengeInfo(arg_2_1)
	self._score = arg_2_1.current_score
	self._level = arg_2_1.level
	self._mode = arg_2_1.mode
	self._resetflag = arg_2_1.issl
	self._seasonIndex = arg_2_1.season_id
	self._dungeonIDList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.dungeon_id_list) do
		table.insert(self._dungeonIDList, iter_2_1)
	end

	self._activityIndex = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE):getConfig("config_id")

	if self._mode == ChallengeProxy.MODE_INFINITE then
		self:setInfiniteDungeonIDListByLevel()
	end

	self._fleetList = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.groupinc_list) do
		self:updateChallengeFleet(iter_2_3)
	end

	self._buffList = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.buff_list) do
		table.insert(self._buffList, iter_2_5)
	end

	self._lastScore = 0

	return
end

function UserChallengeInfo:updateChallengeFleet(arg_3_1)
	local var_3_0 = Challenge2Fleet.New(arg_3_1)

	if var_3_0:isSubmarineFleet() then
		self._submarineFleet = var_3_0
	else
		self._fleet = var_3_0
	end

	return
end

function UserChallengeInfo:updateCombatScore(arg_4_1)
	self._lastScore = arg_4_1
	self._score = self._score + arg_4_1

	return
end

function UserChallengeInfo:updateLevelForward()
	self._level = self._level + 1

	return
end

function UserChallengeInfo:updateShipHP(arg_6_1, arg_6_2)
	if not (self._fleet:updateShipsHP(arg_6_1, arg_6_2) or self._submarineFleet:updateShipsHP(arg_6_1, arg_6_2)) then
		assert(false, "challenge unit not exist")
	end

	return
end

function UserChallengeInfo:getRegularFleet()
	return self._fleet
end

function UserChallengeInfo:getSubmarineFleet()
	return self._submarineFleet
end

function UserChallengeInfo:getShipUIDList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs((self._fleet:getShips(false))) do
		table.insert(var_9_0, iter_9_1.id)
	end

	for iter_9_2, iter_9_3 in ipairs((self._submarineFleet:getShips(false))) do
		table.insert(var_9_0, iter_9_3.id)
	end

	return var_9_0
end

function UserChallengeInfo:getLevel()
	return self._level
end

function UserChallengeInfo:getRound()
	return math.ceil(self._level / #self._dungeonIDList)
end

function UserChallengeInfo:getMode()
	return self._mode
end

function UserChallengeInfo:getDungeonIDList()
	return Clone(self._dungeonIDList)
end

function UserChallengeInfo:getSeasonID()
	return self._seasonIndex
end

function UserChallengeInfo:getResetFlag()
	return self._resetflag
end

function UserChallengeInfo:getScore()
	return self._score
end

function UserChallengeInfo:getLastScore()
	return self._lastScore
end

function UserChallengeInfo:getActivityIndex()
	return self._activityIndex
end

function UserChallengeInfo:getNextExpedition()
	return pg.expedition_challenge_template[self._dungeonIDList[(self._level % ChallengeConst.BOSS_NUM == 0 or nil) and ChallengeConst.BOSS_NUM]]
end

function UserChallengeInfo:setInfiniteDungeonIDListByLevel()
	local var_20_0 = (math.modf((self._level - 1) / ChallengeConst.BOSS_NUM) + 1) % #pg.activity_event_challenge[self._activityIndex].infinite_stage[self._seasonIndex]

	if var_20_0 == 0 then
		var_20_0 = #pg.activity_event_challenge[self._activityIndex].infinite_stage[self._seasonIndex]
	end

	self._dungeonIDList = pg.activity_event_challenge[self._activityIndex].infinite_stage[self._seasonIndex][var_20_0]

	return
end

function UserChallengeInfo:getNextInfiniteDungeonIDList()
	return pg.activity_event_challenge[self._activityIndex].infinite_stage[self._seasonIndex][(math.modf((self._level - 1) / ChallengeConst.BOSS_NUM) + 1) % #pg.activity_event_challenge[self._activityIndex].infinite_stage[self._seasonIndex] + 1]
end

function UserChallengeInfo:getNextStageID()
	return self:getNextExpedition().dungeon_id
end

function UserChallengeInfo:IsFinish()
	if self._level % #self._dungeonIDList == 0 then
		return true
	else
		return false
	end

	return
end

return UserChallengeInfo
