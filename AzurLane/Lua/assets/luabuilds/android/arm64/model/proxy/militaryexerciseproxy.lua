class = var_0_10000

local var_0_0 = "MilitaryExerciseProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.SEASON_INFO_ADDED = "MilitaryExerciseProxy SEASON_INFO_ADDED"
var_0_1.SEASON_INFO_UPDATED = "MilitaryExerciseProxy SEASON_INFO_UPDATED"
var_0_1.ARENARANK_UPDATED = "MilitaryExerciseProxy ARENARANK_UPDATED"
var_0_1.EXERCISE_FLEET_UPDATED = "MilitaryExerciseProxy EXERCISE_FLEET_UPDATED"
var_0_1.RIVALS_UPDATED = "MilitaryExerciseProxy RIVALS_UPDATED"

function var_0_1.register(arg_1_0)
	arg_1_0:on(18005, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.target_list) do
			table = var_2_10007
			var_2_10007 = var_2_10007.insert

			local var_2_1 = var_2_0

			Rival = var_2_10010

			var_2_10007(var_2_1, var_2_10010.New(iter_2_1))
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.getSeasonInfo(var_2_2)
		local var_2_4 = var_2.updateScore
		local var_2_5 = arg_2_0.score

		SeasonInfo = var_2_10007

		var_2_4(var_2_3, var_2_5 + var_2_10007.INIT_POINT)
		var_2:updateRank(arg_2_0.rank)
		var_2:updateRivals(var_2_0)

		local var_2_6 = arg_1_0

		var_3.updateSeasonInfo(var_2_6, var_2)

		getProxy = var_3
		PlayerProxy = var_2_6

		local var_2_7 = var_3(var_2_6)
		local var_2_8 = var_3.getData(var_2_7)

		var_4.updateScoreAndRank(var_2_8, var_2.score, var_2.rank)
		var_3:updatePlayer(var_4)

		return
	end)

	arg_1_0.waiting = true

	return
end

function var_0_1.timeCall(arg_3_0)
	local var_3_0 = {}

	ProxyRegister = var_1_10002
	var_3_0[var_1_10002.DayCall] = function(arg_4_0)
		local var_4_0 = arg_3_0

		if var_1.getSeasonInfo(var_4_0) then
			var_1:resetFlashCount()

			local var_4_1 = arg_3_0

			var_2.updateSeasonInfo(var_4_1, var_1)
		end

		return
	end
	ProxyRegister = var_2
	var_3_0[var_2.SecondCall] = function(arg_5_0)
		if arg_3_0.waiting then
			return
		end

		local var_5_0 = arg_3_0.seasonInfo.resetTime

		pg = var_2_10002

		local var_5_1 = var_2_10002.TimeMgr.GetInstance()

		if var_5_0 <= var_2.GetServerTime(var_5_1) then
			arg_3_0.waiting = true

			local var_5_2 = arg_3_0
			local var_5_3 = var_1.sendNotification

			GAME = var_5_1

			var_5_3(var_5_2, var_5_1.EXERCISE_COUNT_RECOVER_UP)
		end

		return
	end

	return var_3_0
end

function var_0_1.addSeasonInfo(arg_6_0, arg_6_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_6_0 = arg_6_1

	SeasonInfo = var_1_10007

	var_1_10002(var_1_10004(var_6_0, var_1_10007), "seasonInfo be an instance of SeasonInfo")

	arg_6_0.seasonInfo = arg_6_1
	pg = var_1_10002

	local var_6_1 = var_1_10002.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_6_1, "inExercise")
	arg_6_0:sendNotification(var_0_1.SEASON_INFO_ADDED, arg_6_1:clone())

	arg_6_0.waiting = false

	return
end

function var_0_1.setSeasonOver(arg_7_0)
	local var_7_0 = arg_7_0:getSeasonInfo()

	var_1.setExerciseCount(var_7_0, 0)
	arg_7_0:updateSeasonInfo(var_1)

	return
end

function var_0_1.remove(arg_8_0)
	return
end

function var_0_1.updateSeasonInfo(arg_9_0, arg_9_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_9_0 = arg_9_1

	SeasonInfo = var_1_10007

	var_1_10002(var_1_10004(var_9_0, var_1_10007), "seasonInfo be an instance of SeasonInfo")

	arg_9_0.seasonInfo = arg_9_1
	pg = var_1_10002

	local var_9_1 = var_1_10002.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_9_1, "inExercise")
	arg_9_0:sendNotification(var_0_1.SEASON_INFO_UPDATED, arg_9_1:clone())

	return
end

function var_0_1.getSeasonInfo(arg_10_0)
	Clone = var_1_10001

	return var_1_10001(arg_10_0.seasonInfo)
end

function var_0_1.RawGetSeasonInfo(arg_11_0)
	return arg_11_0.seasonInfo
end

function var_0_1.updateRivals(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.seasonInfo

	var_2.updateRivals(var_12_0, arg_12_1)

	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.sendNotification
	local var_12_3 = var_0_1.RIVALS_UPDATED

	Clone = var_1_10006

	var_12_2(var_12_1, var_12_3, var_1_10006(arg_12_1))

	return
end

function var_0_1.getRivals(arg_13_0)
	Clone = var_1_10001

	return var_1_10001(arg_13_0.seasonInfo.rivals)
end

function var_0_1.getRivalById(arg_14_0, arg_14_1)
	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0:getRivals()) do
		if iter_14_1.id == arg_14_1 then
			return iter_14_1
		end
	end

	return
end

function var_0_1.getPreRivalById(arg_15_0, arg_15_1)
	pairs = var_1_10002

	local var_15_0 = arg_15_0.seasonInfo

	for iter_15_0, iter_15_1 in var_1_10002(var_4.GetPreRivals(var_15_0)) do
		if arg_15_1 == iter_15_0 then
			Clone = var_1_10007

			return var_1_10007(iter_15_1)
		end
	end

	return
end

function var_0_1.getExerciseFleet(arg_16_0)
	Clone = var_1_10001

	return var_1_10001(arg_16_0.seasonInfo.fleet)
end

function var_0_1.updateExerciseFleet(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.seasonInfo

	var_2.updateFleet(var_17_0, arg_17_1)

	pg = var_2

	local var_17_1 = var_2.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_17_1, "inExercise")
	arg_17_0:sendNotification(var_0_1.EXERCISE_FLEET_UPDATED, arg_17_1:clone())

	return
end

function var_0_1.increaseExerciseCount(arg_18_0)
	local var_18_0 = arg_18_0.seasonInfo

	var_1.increaseExerciseCount(var_18_0)

	return
end

function var_0_1.reduceExerciseCount(arg_19_0)
	local var_19_0 = arg_19_0.seasonInfo

	var_1.reduceExerciseCount(var_19_0)

	return
end

function var_0_1.updateArenaRankLsit(arg_20_0, arg_20_1)
	assert = var_1_10002

	var_1_10002(arg_20_1, "should exist arenaRankLsit")

	arg_20_0.arenaRankLsit = arg_20_1

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.sendNotification
	local var_20_2 = var_0_1.ARENARANK_UPDATED

	Clone = var_1_10006

	var_20_1(var_20_0, var_20_2, var_1_10006(arg_20_1))

	return
end

function var_0_1.getArenaRankList(arg_21_0)
	return arg_21_0.arenaRankLsit
end

function var_0_1.getData(arg_22_0)
	Clone = var_1_10001

	return var_1_10001(arg_22_0.seasonInfo)
end

return var_0_1
