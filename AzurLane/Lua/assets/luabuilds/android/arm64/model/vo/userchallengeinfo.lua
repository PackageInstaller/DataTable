class = var_0_10000

local var_0_0 = "UserChallengeInfo"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateChallengeInfo(arg_1_1)

	return
end

function var_0_1.UpdateChallengeInfo(arg_2_0, arg_2_1)
	arg_2_0._score = arg_2_1.current_score
	arg_2_0._level = arg_2_1.level
	arg_2_0._mode = arg_2_1.mode
	arg_2_0._resetflag = arg_2_1.issl
	arg_2_0._seasonIndex = arg_2_1.season_id
	arg_2_0._dungeonIDList = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.dungeon_id_list) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0._dungeonIDList, iter_2_1)
	end

	getProxy = var_2
	ActivityProxy = var_4

	local var_2_0 = var_2(var_4)
	local var_2_1 = var_2.getActivityByType

	ActivityConst = iter_2_1

	local var_2_2 = var_2_1(var_2_0, iter_2_1.ACTIVITY_TYPE_CHALLENGE)

	arg_2_0._activityIndex = var_3.getConfig(var_2_2, "config_id")

	local var_2_3 = arg_2_0._mode

	ChallengeProxy = var_2_0

	if var_2_3 == var_2_0.MODE_INFINITE then
		arg_2_0:setInfiniteDungeonIDListByLevel()
	end

	arg_2_0._fleetList = {}
	ipairs = var_4

	for iter_2_2, iter_2_3 in var_4(arg_2_1.groupinc_list) do
		arg_2_0:updateChallengeFleet(iter_2_3)
	end

	arg_2_0._buffList = {}
	ipairs = var_4

	for iter_2_4, iter_2_5 in var_4(arg_2_1.buff_list) do
		table = var_1_10009

		var_1_10009.insert(arg_2_0._buffList, iter_2_5)
	end

	arg_2_0._lastScore = 0

	return
end

function var_0_1.updateChallengeFleet(arg_3_0, arg_3_1)
	Challenge2Fleet = var_1_10002

	local var_3_0 = var_1_10002.New(arg_3_1)

	if var_2.isSubmarineFleet(var_3_0) then
		arg_3_0._submarineFleet = var_2
	else
		arg_3_0._fleet = var_2
	end

	return
end

function var_0_1.updateCombatScore(arg_4_0, arg_4_1)
	arg_4_0._lastScore = arg_4_1
	arg_4_0._score = arg_4_0._score + arg_4_1

	return
end

function var_0_1.updateLevelForward(arg_5_0)
	arg_5_0._level = arg_5_0._level + 1

	return
end

function var_0_1.updateShipHP(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._fleet
	local var_6_2

	if not var_3.updateShipsHP(var_6_0, arg_6_1, arg_6_2) then
		local var_6_1 = arg_6_0._submarineFleet

		var_6_2 = var_1_10004.updateShipsHP(var_6_1, arg_6_1, arg_6_2)
	end

	if not var_6_2 then
		assert = var_1_10004

		var_1_10004(false, "challenge unit not exist")
	end

	return
end

function var_0_1.getRegularFleet(arg_7_0)
	return arg_7_0._fleet
end

function var_0_1.getSubmarineFleet(arg_8_0)
	return arg_8_0._submarineFleet
end

function var_0_1.getShipUIDList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0._fleet
	local var_9_2 = var_2.getShips(var_9_1, false)

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_9_2) do
		table = var_1_10008

		var_1_10008.insert(var_9_0, iter_9_1.id)
	end

	local var_9_3 = arg_9_0._submarineFleet
	local var_9_4 = var_3.getShips(var_9_3, false)

	ipairs = var_3

	for iter_9_2, iter_9_3 in var_3(var_9_4) do
		table = var_1_10008

		var_1_10008.insert(var_9_0, iter_9_3.id)
	end

	return var_9_0
end

function var_0_1.getLevel(arg_10_0)
	return arg_10_0._level
end

function var_0_1.getRound(arg_11_0)
	math = var_1_10001

	return var_1_10001.ceil(arg_11_0._level / #arg_11_0._dungeonIDList)
end

function var_0_1.getMode(arg_12_0)
	return arg_12_0._mode
end

function var_0_1.getDungeonIDList(arg_13_0)
	Clone = var_1_10001

	return var_1_10001(arg_13_0._dungeonIDList)
end

function var_0_1.getSeasonID(arg_14_0)
	return arg_14_0._seasonIndex
end

function var_0_1.getResetFlag(arg_15_0)
	return arg_15_0._resetflag
end

function var_0_1.getScore(arg_16_0)
	return arg_16_0._score
end

function var_0_1.getLastScore(arg_17_0)
	return arg_17_0._lastScore
end

function var_0_1.getActivityIndex(arg_18_0)
	return arg_18_0._activityIndex
end

function var_0_1.getNextExpedition(arg_19_0)
	local var_19_0 = arg_19_0._level

	ChallengeConst = var_1_10002

	local var_19_1

	if var_19_0 % var_1_10002.BOSS_NUM == 0 then
		ChallengeConst = var_2
		var_19_1 = var_2.BOSS_NUM
	end

	local var_19_2 = arg_19_0._dungeonIDList[var_19_1]

	pg = var_1_10003

	return var_1_10003.expedition_challenge_template[var_19_2]
end

function var_0_1.setInfiniteDungeonIDListByLevel(arg_20_0)
	local var_20_0 = arg_20_0._level - 1

	math = var_1_10002

	local var_20_1 = var_1_10002.modf

	ChallengeConst = var_1_10004

	local var_20_2 = var_20_1(var_20_0 / var_1_10004.BOSS_NUM) + 1

	pg = var_1_10003

	local var_20_3

	if var_20_2 % #var_1_10003.activity_event_challenge[arg_20_0._activityIndex].infinite_stage[arg_20_0._seasonIndex] == 0 then
		var_20_3 = var_3
	end

	pg = var_1_10005
	arg_20_0._dungeonIDList = var_1_10005.activity_event_challenge[arg_20_0._activityIndex].infinite_stage[arg_20_0._seasonIndex][var_20_3]

	return
end

function var_0_1.getNextInfiniteDungeonIDList(arg_21_0)
	local var_21_0 = arg_21_0._level - 1

	math = var_1_10002

	local var_21_1 = var_1_10002.modf

	ChallengeConst = var_1_10004

	local var_21_2 = var_21_1(var_21_0 / var_1_10004.BOSS_NUM) + 1

	pg = var_1_10003

	local var_21_3 = var_21_2 % #var_1_10003.activity_event_challenge[arg_21_0._activityIndex].infinite_stage[arg_21_0._seasonIndex] + 1

	pg = var_1_10006

	return var_1_10006.activity_event_challenge[arg_21_0._activityIndex].infinite_stage[arg_21_0._seasonIndex][var_21_3]
end

function var_0_1.getNextStageID(arg_22_0)
	return arg_22_0:getNextExpedition().dungeon_id
end

function var_0_1.IsFinish(arg_23_0)
	if arg_23_0._level % #arg_23_0._dungeonIDList == 0 then
		return true
	else
		return false
	end

	return
end

return var_0_1
