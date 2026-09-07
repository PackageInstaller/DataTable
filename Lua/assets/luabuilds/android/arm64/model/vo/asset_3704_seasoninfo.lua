local SeasonInfo = class("SeasonInfo", import(".BaseVO"))

SeasonInfo.RECOVER_UP_COUNT = 5
SeasonInfo.MAX_FIGHTCOUNT = 10
SeasonInfo.RECOVER_UP_SIX_HOUR = 6
SeasonInfo.RECOVER_UP_TWELVE_HOUR = 12
SeasonInfo.INIT_POINT = pg.arena_data_rank[1].point
SeasonInfo.ONE_SEASON_TIME = 0
SeasonInfo.preRivals = {}

function SeasonInfo:Ctor(arg_1_1)
	self.score = arg_1_1.score or 0
	self.rank = arg_1_1.rank
	self.fightCount = arg_1_1.fight_count
	self.resetTime = arg_1_1.fight_count_reset_time
	self.flashTargetCount = arg_1_1.flash_target_count
	self.score = self.score + SeasonInfo.INIT_POINT

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.vanguard_ship_id_list) do
		table.insert(var_1_0, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.main_ship_id_list) do
		table.insert(var_1_0, iter_1_3)
	end

	self.fleet = TypedFleet.New({
		saveLastShipFlag = true,
		ship_list = var_1_0,
		fleetType = FleetType.Normal
	})
	self.rivals = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.target_list) do
		local var_1_1 = Rival.New(iter_1_5)

		table.insert(self.rivals, var_1_1)

		SeasonInfo.preRivals[var_1_1.id] = var_1_1
	end

	return
end

function SeasonInfo:getFlashCount()
	return self.flashTargetCount
end

function SeasonInfo:increaseFlashCount()
	self.flashTargetCount = self.flashTargetCount + 1

	return
end

function SeasonInfo:resetFlashCount()
	self.flashTargetCount = 0

	return
end

function SeasonInfo:getconsumeGem()
	local var_5_0 = self.getMilitaryRank(self.score, self.rank)

	return var_5_0.refresh_price[self.flashTargetCount] or var_5_0.refresh_price[#var_5_0.refresh_price]
end

function SeasonInfo:updateRank(arg_6_1)
	self.rank = arg_6_1

	return
end

function SeasonInfo:updateScore(arg_7_1)
	self.score = arg_7_1

	return
end

function SeasonInfo:getRivals()
	return Clone(self.rivals)
end

function SeasonInfo:updateRivals(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.rivals) do
		SeasonInfo.preRivals[iter_9_1.id] = iter_9_1
	end

	self.rivals = arg_9_1

	return
end

function SeasonInfo:GetPreRivals()
	return SeasonInfo.preRivals
end

function SeasonInfo:updateFleet(arg_11_1)
	self.fleet = arg_11_1

	return
end

function SeasonInfo:canExercise()
	return self.fightCount > 0
end

function SeasonInfo:reduceExerciseCount()
	assert(self.fightCount > 0, "演习次数必须大于0")

	self.fightCount = self.fightCount - 1

	return
end

function SeasonInfo:updateExerciseCount(arg_14_1)
	self.fightCount = math.min(self.fightCount + arg_14_1, SeasonInfo.MAX_FIGHTCOUNT)

	return
end

function SeasonInfo:setExerciseCount(arg_15_1)
	self.fightCount = arg_15_1

	return
end

function SeasonInfo:updateResetTime(arg_16_1)
	self.resetTime = arg_16_1

	return
end

function SeasonInfo:getMilitaryRank(arg_17_1)
	local var_17_0

	for iter_17_0 = #pg.arena_data_rank.all, 1, -1 do
		if pg.arena_data_rank[pg.arena_data_rank.all[iter_17_0]].order ~= 0 then
			if arg_17_1 <= pg.arena_data_rank[pg.arena_data_rank.all[iter_17_0]].order and pg.arena_data_rank[pg.arena_data_rank.all[iter_17_0]].point <= self then
				var_17_0 = pg.arena_data_rank[pg.arena_data_rank.all[iter_17_0]]

				break
			end
		elseif pg.arena_data_rank[pg.arena_data_rank.all[iter_17_0]].point <= self then
			var_17_0 = pg.arena_data_rank[pg.arena_data_rank.all[iter_17_0]]

			break
		end
	end

	var_17_0 = var_17_0 or pg.arena_data_rank[pg.arena_data_rank.all[1]]

	return var_17_0
end

function SeasonInfo:getNextMilitaryRank(arg_18_1)
	local var_18_0 = pg.arena_data_rank[SeasonInfo.getMilitaryRank(self, arg_18_1).id + 1] or pg.arena_data_rank[#pg.arena_data_rank.all]

	return var_18_0.name, var_18_0.point, var_18_0.order
end

function SeasonInfo.maxRankScore()
	local var_19_0 = pg.arena_data_rank[pg.arena_data_rank.all[#pg.arena_data_rank.all]]

	return var_19_0.name, var_19_0.point
end

function SeasonInfo:getEmblem(arg_20_1)
	return math.min(math.max(SeasonInfo.getMilitaryRank(self, arg_20_1).id, 1), 14)
end

function SeasonInfo:getMainShipIds()
	return self.fleet.mainShips
end

function SeasonInfo:getVanguardShipIds()
	return self.fleet.vanguardShips
end

function SeasonInfo:getMainFleetShipCount()
	return table.getCount(self.mainShips)
end

function SeasonInfo:getVanguardShipsShipCount()
	return table.getCount(self.vanguardShips)
end

return SeasonInfo
