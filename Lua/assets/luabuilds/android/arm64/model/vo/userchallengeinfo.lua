local var_0_0 = class("UserChallengeInfo", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateChallengeInfo(arg_1_1)

	return
end

function var_0_0.UpdateChallengeInfo(arg_2_0, arg_2_1)
	arg_2_0._score = arg_2_1.current_score
	arg_2_0._level = arg_2_1.level
	arg_2_0._mode = arg_2_1.mode
	arg_2_0._resetflag = arg_2_1.issl
	arg_2_0._seasonIndex = arg_2_1.season_id
	arg_2_0._dungeonIDList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.dungeon_id_list) do
		table.insert(arg_2_0._dungeonIDList, iter_2_1)
	end

	arg_2_0._activityIndex = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE):getConfig("config_id")

	if arg_2_0._mode == ChallengeProxy.MODE_INFINITE then
		arg_2_0:setInfiniteDungeonIDListByLevel()
	end

	arg_2_0._fleetList = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.groupinc_list) do
		arg_2_0:updateChallengeFleet(iter_2_3)
	end

	arg_2_0._buffList = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.buff_list) do
		table.insert(arg_2_0._buffList, iter_2_5)
	end

	arg_2_0._lastScore = 0

	return
end

function var_0_0.updateChallengeFleet(arg_3_0, arg_3_1)
	local var_3_0 = Challenge2Fleet.New(arg_3_1)

	if var_3_0:isSubmarineFleet() then
		arg_3_0._submarineFleet = var_3_0
	else
		arg_3_0._fleet = var_3_0
	end

	return
end

function var_0_0.updateCombatScore(arg_4_0, arg_4_1)
	arg_4_0._lastScore = arg_4_1
	arg_4_0._score = arg_4_0._score + arg_4_1

	return
end

function var_0_0.updateLevelForward(arg_5_0)
	arg_5_0._level = arg_5_0._level + 1

	return
end

function var_0_0.updateShipHP(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._fleet:updateShipsHP(arg_6_1, arg_6_2) or arg_6_0._submarineFleet:updateShipsHP(arg_6_1, arg_6_2)

	if not var_6_0 then
		assert(false, "challenge unit not exist")
	end

	return
end

function var_0_0.getRegularFleet(arg_7_0)
	return arg_7_0._fleet
end

function var_0_0.getSubmarineFleet(arg_8_0)
	return arg_8_0._submarineFleet
end

function var_0_0.getShipUIDList(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs((arg_9_0._fleet:getShips(false))) do
		table.insert({}, iter_9_1.id)
	end

	for iter_9_2, iter_9_3 in ipairs((arg_9_0._submarineFleet:getShips(false))) do
		table.insert({}, iter_9_3.id)
	end

	return {}
end

function var_0_0.getLevel(arg_10_0)
	return arg_10_0._level
end

function var_0_0.getRound(arg_11_0)
	return math.ceil(arg_11_0._level / #arg_11_0._dungeonIDList)
end

function var_0_0.getMode(arg_12_0)
	return arg_12_0._mode
end

function var_0_0.getDungeonIDList(arg_13_0)
	return Clone(arg_13_0._dungeonIDList)
end

function var_0_0.getSeasonID(arg_14_0)
	return arg_14_0._seasonIndex
end

function var_0_0.getResetFlag(arg_15_0)
	return arg_15_0._resetflag
end

function var_0_0.getScore(arg_16_0)
	return arg_16_0._score
end

function var_0_0.getLastScore(arg_17_0)
	return arg_17_0._lastScore
end

function var_0_0.getActivityIndex(arg_18_0)
	return arg_18_0._activityIndex
end

function var_0_0.getNextExpedition(arg_19_0)
	local var_19_0 = arg_19_0._level % ChallengeConst.BOSS_NUM

	if arg_19_0._level % ChallengeConst.BOSS_NUM == 0 then
		var_19_0 = ChallengeConst.BOSS_NUM
	end

	return pg.expedition_challenge_template[arg_19_0._dungeonIDList[var_19_0]]
end

function var_0_0.setInfiniteDungeonIDListByLevel(arg_20_0)
	local var_20_0 = (math.modf((arg_20_0._level - 1) / ChallengeConst.BOSS_NUM) + 1) % #pg.activity_event_challenge[arg_20_0._activityIndex].infinite_stage[arg_20_0._seasonIndex]

	if var_20_0 == 0 then
		var_20_0 = #pg.activity_event_challenge[arg_20_0._activityIndex].infinite_stage[arg_20_0._seasonIndex]
	end

	arg_20_0._dungeonIDList = pg.activity_event_challenge[arg_20_0._activityIndex].infinite_stage[arg_20_0._seasonIndex][var_20_0]

	return
end

function var_0_0.getNextInfiniteDungeonIDList(arg_21_0)
	return pg.activity_event_challenge[arg_21_0._activityIndex].infinite_stage[arg_21_0._seasonIndex][(math.modf((arg_21_0._level - 1) / ChallengeConst.BOSS_NUM) + 1) % #pg.activity_event_challenge[arg_21_0._activityIndex].infinite_stage[arg_21_0._seasonIndex] + 1]
end

function var_0_0.getNextStageID(arg_22_0)
	return arg_22_0:getNextExpedition().dungeon_id
end

function var_0_0.IsFinish(arg_23_0)
	if arg_23_0._level % #arg_23_0._dungeonIDList == 0 then
		return true
	else
		return false
	end

	return
end

return var_0_0
