class = var_0_10000

local var_0_0 = "SeasonInfo"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.RECOVER_UP_COUNT = 5
var_0_1.MAX_FIGHTCOUNT = 10
var_0_1.RECOVER_UP_SIX_HOUR = 6
var_0_1.RECOVER_UP_TWELVE_HOUR = 12
pg = var_1
var_0_1.INIT_POINT = var_1.arena_data_rank[1].point
var_0_1.ONE_SEASON_TIME = 0
var_0_1.preRivals = {}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.score then
		var_1_0 = 0
	end

	arg_1_0.score = var_1_0
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.fightCount = arg_1_1.fight_count
	arg_1_0.resetTime = arg_1_1.fight_count_reset_time
	arg_1_0.flashTargetCount = arg_1_1.flash_target_count
	arg_1_0.score = arg_1_0.score + var_0_1.INIT_POINT

	local var_1_1 = {}

	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_1.vanguard_ship_id_list) do
		table = var_1_10008

		var_1_10008.insert(var_1_1, iter_1_1)
	end

	ipairs = var_3

	for iter_1_2, iter_1_3 in var_3(arg_1_1.main_ship_id_list) do
		table = var_1_10008

		var_1_10008.insert(var_1_1, iter_1_3)
	end

	TypedFleet = var_3

	local var_1_2 = var_3.New
	local var_1_3 = {
		saveLastShipFlag = true,
		ship_list = var_1_1
	}

	FleetType = var_5
	var_1_3.fleetType = var_5.Normal
	arg_1_0.fleet = var_1_2(var_1_3)
	arg_1_0.rivals = {}
	ipairs = var_3

	for iter_1_4, iter_1_5 in var_3(arg_1_1.target_list) do
		Rival = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_5)
		table = var_9

		var_9.insert(arg_1_0.rivals, var_1_10008)

		var_0_1.preRivals[var_1_10008.id] = var_1_10008
	end

	return
end

function var_0_1.getFlashCount(arg_2_0)
	return arg_2_0.flashTargetCount
end

function var_0_1.increaseFlashCount(arg_3_0)
	arg_3_0.flashTargetCount = arg_3_0.flashTargetCount + 1

	return
end

function var_0_1.resetFlashCount(arg_4_0)
	arg_4_0.flashTargetCount = 0

	return
end

function var_0_1.getconsumeGem(arg_5_0)
	local var_5_0

	if not arg_5_0.getMilitaryRank(arg_5_0.score, arg_5_0.rank).refresh_price[arg_5_0.flashTargetCount] then
		var_5_0 = var_1.refresh_price[#var_1.refresh_price]
	end

	return var_5_0
end

function var_0_1.updateRank(arg_6_0, arg_6_1)
	arg_6_0.rank = arg_6_1

	return
end

function var_0_1.updateScore(arg_7_0, arg_7_1)
	arg_7_0.score = arg_7_1

	return
end

function var_0_1.getRivals(arg_8_0)
	Clone = var_1_10001

	return var_1_10001(arg_8_0.rivals)
end

function var_0_1.updateRivals(arg_9_0, arg_9_1)
	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.rivals) do
		var_0_1.preRivals[iter_9_1.id] = iter_9_1
	end

	arg_9_0.rivals = arg_9_1

	return
end

function var_0_1.GetPreRivals(arg_10_0)
	return var_0_1.preRivals
end

function var_0_1.updateFleet(arg_11_0, arg_11_1)
	arg_11_0.fleet = arg_11_1

	return
end

function var_0_1.canExercise(arg_12_0)
	return arg_12_0.fightCount > 0
end

function var_0_1.reduceExerciseCount(arg_13_0)
	assert = var_1_10001

	var_1_10001(arg_13_0.fightCount > 0, "演习次数必须大于0")

	arg_13_0.fightCount = arg_13_0.fightCount - 1

	return
end

function var_0_1.updateExerciseCount(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.fightCount + arg_14_1

	math = var_1_10003
	arg_14_0.fightCount = var_1_10003.min(var_14_0, var_0_1.MAX_FIGHTCOUNT)

	return
end

function var_0_1.setExerciseCount(arg_15_0, arg_15_1)
	arg_15_0.fightCount = arg_15_1

	return
end

function var_0_1.updateResetTime(arg_16_0, arg_16_1)
	arg_16_0.resetTime = arg_16_1

	return
end

function var_0_1.getMilitaryRank(arg_17_0, arg_17_1)
	local var_17_0

	pg = var_1_10003

	for iter_17_0 = #var_1_10003.arena_data_rank.all, 1, -1 do
		local var_17_1 = var_3[var_3.all[iter_17_0]].point
		local var_17_2 = var_3[var_8].order

		if var_3[var_8].order ~= 0 then
			if arg_17_1 <= var_17_2 and var_17_1 <= arg_17_0 then
				var_17_0 = var_3[var_8]

				break
			end
		elseif var_17_1 <= arg_17_0 then
			var_17_0 = var_3[var_8]

			break
		end
	end

	var_17_0 = var_17_0 or var_3[var_3.all[1]]

	return var_17_0
end

function var_0_1.getNextMilitaryRank(arg_18_0, arg_18_1)
	local var_18_0 = var_0_1.getMilitaryRank(arg_18_0, arg_18_1)

	pg = var_3

	local var_18_2

	if not var_3.arena_data_rank[var_18_0.id + 1] then
		pg = var_4

		local var_18_1 = var_4.arena_data_rank

		pg = var_1_10005
		var_18_2 = var_18_1[#var_1_10005.arena_data_rank.all]
	end

	return var_18_2.name, var_18_2.point, var_18_2.order
end

function var_0_1.maxRankScore()
	pg = var_1_10000

	return var_0[var_1_10000.arena_data_rank.all[#var_0.all]].name, var_1.point
end

function var_0_1.getEmblem(arg_20_0, arg_20_1)
	local var_20_0 = var_0_1.getMilitaryRank(arg_20_0, arg_20_1)

	math = var_3

	local var_20_1 = var_3.min

	math = var_4

	return var_20_1(var_4.max(var_20_0.id, 1), 14)
end

function var_0_1.getMainShipIds(arg_21_0)
	return arg_21_0.fleet.mainShips
end

function var_0_1.getVanguardShipIds(arg_22_0)
	return arg_22_0.fleet.vanguardShips
end

function var_0_1.getMainFleetShipCount(arg_23_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_23_0.mainShips)
end

function var_0_1.getVanguardShipsShipCount(arg_24_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_24_0.vanguardShips)
end

return var_0_1
