local var_0_0 = class("MilitaryExerciseProxy", import(".NetProxy"))

var_0_0.SEASON_INFO_ADDED = "MilitaryExerciseProxy SEASON_INFO_ADDED"
var_0_0.SEASON_INFO_UPDATED = "MilitaryExerciseProxy SEASON_INFO_UPDATED"
var_0_0.ARENARANK_UPDATED = "MilitaryExerciseProxy ARENARANK_UPDATED"
var_0_0.EXERCISE_FLEET_UPDATED = "MilitaryExerciseProxy EXERCISE_FLEET_UPDATED"
var_0_0.RIVALS_UPDATED = "MilitaryExerciseProxy RIVALS_UPDATED"

function var_0_0.register(arg_1_0)
	arg_1_0:on(18005, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.target_list) do
			table.insert({}, Rival.New(iter_2_1))
		end

		local var_2_0 = arg_1_0:getSeasonInfo()

		var_2_0:updateScore(arg_2_0.score + SeasonInfo.INIT_POINT)
		var_2_0:updateRank(arg_2_0.rank)
		var_2_0:updateRivals({})
		arg_1_0:updateSeasonInfo(var_2_0)

		local var_2_1 = getProxy(PlayerProxy)
		local var_2_2 = var_2_1:getData()

		var_2_2:updateScoreAndRank(var_2_0.score, var_2_0.rank)
		var_2_1:updatePlayer(var_2_2)

		return
	end)

	arg_1_0.waiting = true

	return
end

function var_0_0.timeCall(arg_3_0)
	return {
		[ProxyRegister.DayCall] = function(arg_4_0)
			local var_4_0 = arg_3_0:getSeasonInfo()

			if var_4_0 then
				var_4_0:resetFlashCount()
				arg_3_0:updateSeasonInfo(var_4_0)
			end

			return
		end,
		[ProxyRegister.SecondCall] = function(arg_5_0)
			if arg_3_0.waiting then
				return
			end

			if arg_3_0.seasonInfo.resetTime <= pg.TimeMgr.GetInstance():GetServerTime() then
				arg_3_0.waiting = true

				arg_3_0:sendNotification(GAME.EXERCISE_COUNT_RECOVER_UP)
			end

			return
		end
	}
end

function var_0_0.addSeasonInfo(arg_6_0, arg_6_1)
	assert(isa(arg_6_1, SeasonInfo), "seasonInfo be an instance of SeasonInfo")

	arg_6_0.seasonInfo = arg_6_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inExercise")
	arg_6_0:sendNotification(var_0_0.SEASON_INFO_ADDED, arg_6_1:clone())

	arg_6_0.waiting = false

	return
end

function var_0_0.setSeasonOver(arg_7_0)
	local var_7_0 = arg_7_0:getSeasonInfo()

	var_7_0:setExerciseCount(0)
	arg_7_0:updateSeasonInfo(var_7_0)

	return
end

function var_0_0.remove(arg_8_0)
	return
end

function var_0_0.updateSeasonInfo(arg_9_0, arg_9_1)
	assert(isa(arg_9_1, SeasonInfo), "seasonInfo be an instance of SeasonInfo")

	arg_9_0.seasonInfo = arg_9_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inExercise")
	arg_9_0:sendNotification(var_0_0.SEASON_INFO_UPDATED, arg_9_1:clone())

	return
end

function var_0_0.getSeasonInfo(arg_10_0)
	return Clone(arg_10_0.seasonInfo)
end

function var_0_0.RawGetSeasonInfo(arg_11_0)
	return arg_11_0.seasonInfo
end

function var_0_0.updateRivals(arg_12_0, arg_12_1)
	arg_12_0.seasonInfo:updateRivals(arg_12_1)
	arg_12_0:sendNotification(var_0_0.RIVALS_UPDATED, Clone(arg_12_1))

	return
end

function var_0_0.getRivals(arg_13_0)
	return Clone(arg_13_0.seasonInfo.rivals)
end

function var_0_0.getRivalById(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0:getRivals()) do
		if iter_14_1.id == arg_14_1 then
			return iter_14_1
		end
	end

	return
end

function var_0_0.getPreRivalById(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.seasonInfo:GetPreRivals()) do
		if arg_15_1 == iter_15_0 then
			return Clone(iter_15_1)
		end
	end

	return
end

function var_0_0.getExerciseFleet(arg_16_0)
	return Clone(arg_16_0.seasonInfo.fleet)
end

function var_0_0.updateExerciseFleet(arg_17_0, arg_17_1)
	arg_17_0.seasonInfo:updateFleet(arg_17_1)
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inExercise")
	arg_17_0:sendNotification(var_0_0.EXERCISE_FLEET_UPDATED, arg_17_1:clone())

	return
end

function var_0_0.increaseExerciseCount(arg_18_0)
	arg_18_0.seasonInfo:increaseExerciseCount()

	return
end

function var_0_0.reduceExerciseCount(arg_19_0)
	arg_19_0.seasonInfo:reduceExerciseCount()

	return
end

function var_0_0.updateArenaRankLsit(arg_20_0, arg_20_1)
	assert(arg_20_1, "should exist arenaRankLsit")

	arg_20_0.arenaRankLsit = arg_20_1

	arg_20_0:sendNotification(var_0_0.ARENARANK_UPDATED, Clone(arg_20_1))

	return
end

function var_0_0.getArenaRankList(arg_21_0)
	return arg_21_0.arenaRankLsit
end

function var_0_0.getData(arg_22_0)
	return Clone(arg_22_0.seasonInfo)
end

return var_0_0
