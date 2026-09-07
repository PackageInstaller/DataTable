local MilitaryExerciseProxy = class("MilitaryExerciseProxy", import(".NetProxy"))

MilitaryExerciseProxy.SEASON_INFO_ADDED = "MilitaryExerciseProxy SEASON_INFO_ADDED"
MilitaryExerciseProxy.SEASON_INFO_UPDATED = "MilitaryExerciseProxy SEASON_INFO_UPDATED"
MilitaryExerciseProxy.ARENARANK_UPDATED = "MilitaryExerciseProxy ARENARANK_UPDATED"
MilitaryExerciseProxy.EXERCISE_FLEET_UPDATED = "MilitaryExerciseProxy EXERCISE_FLEET_UPDATED"
MilitaryExerciseProxy.RIVALS_UPDATED = "MilitaryExerciseProxy RIVALS_UPDATED"

function MilitaryExerciseProxy:register()
	self:on(18005, function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.target_list) do
			table.insert(var_2_0, Rival.New(iter_2_1))
		end

		local var_2_1 = self:getSeasonInfo()

		var_2_1:updateScore(arg_2_0.score + SeasonInfo.INIT_POINT)
		var_2_1:updateRank(arg_2_0.rank)
		var_2_1:updateRivals(var_2_0)
		self:updateSeasonInfo(var_2_1)

		local var_2_2 = getProxy(PlayerProxy)
		local var_2_3 = var_2_2:getData()

		var_2_3:updateScoreAndRank(var_2_1.score, var_2_1.rank)
		var_2_2:updatePlayer(var_2_3)

		return
	end)

	self.waiting = true

	return
end

function MilitaryExerciseProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_4_0)
			local var_4_0 = self:getSeasonInfo()

			if var_4_0 then
				var_4_0:resetFlashCount()
				self:updateSeasonInfo(var_4_0)
			end

			return
		end,
		[ProxyRegister.SecondCall] = function(arg_5_0)
			if self.waiting then
				return
			end

			if self.seasonInfo.resetTime <= pg.TimeMgr.GetInstance():GetServerTime() then
				self.waiting = true

				self:sendNotification(GAME.EXERCISE_COUNT_RECOVER_UP)
			end

			return
		end
	}
end

function MilitaryExerciseProxy:addSeasonInfo(arg_6_1)
	assert(isa(arg_6_1, SeasonInfo), "seasonInfo be an instance of SeasonInfo")

	self.seasonInfo = arg_6_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inExercise")
	self:sendNotification(MilitaryExerciseProxy.SEASON_INFO_ADDED, arg_6_1:clone())

	self.waiting = false

	return
end

function MilitaryExerciseProxy:setSeasonOver()
	local var_7_0 = self:getSeasonInfo()

	var_7_0:setExerciseCount(0)
	self:updateSeasonInfo(var_7_0)

	return
end

function MilitaryExerciseProxy:remove()
	return
end

function MilitaryExerciseProxy:updateSeasonInfo(arg_9_1)
	assert(isa(arg_9_1, SeasonInfo), "seasonInfo be an instance of SeasonInfo")

	self.seasonInfo = arg_9_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inExercise")
	self:sendNotification(MilitaryExerciseProxy.SEASON_INFO_UPDATED, arg_9_1:clone())

	return
end

function MilitaryExerciseProxy:getSeasonInfo()
	return Clone(self.seasonInfo)
end

function MilitaryExerciseProxy:RawGetSeasonInfo()
	return self.seasonInfo
end

function MilitaryExerciseProxy:updateRivals(arg_12_1)
	self.seasonInfo:updateRivals(arg_12_1)
	self:sendNotification(MilitaryExerciseProxy.RIVALS_UPDATED, Clone(arg_12_1))

	return
end

function MilitaryExerciseProxy:getRivals()
	return Clone(self.seasonInfo.rivals)
end

function MilitaryExerciseProxy:getRivalById(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self:getRivals()) do
		if iter_14_1.id == arg_14_1 then
			return iter_14_1
		end
	end

	return
end

function MilitaryExerciseProxy:getPreRivalById(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(self.seasonInfo:GetPreRivals()) do
		if arg_15_1 == iter_15_0 then
			return Clone(iter_15_1)
		end
	end

	return
end

function MilitaryExerciseProxy:getExerciseFleet()
	return Clone(self.seasonInfo.fleet)
end

function MilitaryExerciseProxy:updateExerciseFleet(arg_17_1)
	self.seasonInfo:updateFleet(arg_17_1)
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inExercise")
	self:sendNotification(MilitaryExerciseProxy.EXERCISE_FLEET_UPDATED, arg_17_1:clone())

	return
end

function MilitaryExerciseProxy:increaseExerciseCount()
	self.seasonInfo:increaseExerciseCount()

	return
end

function MilitaryExerciseProxy:reduceExerciseCount()
	self.seasonInfo:reduceExerciseCount()

	return
end

function MilitaryExerciseProxy:updateArenaRankLsit(arg_20_1)
	assert(arg_20_1, "should exist arenaRankLsit")

	self.arenaRankLsit = arg_20_1

	self:sendNotification(MilitaryExerciseProxy.ARENARANK_UPDATED, Clone(arg_20_1))

	return
end

function MilitaryExerciseProxy:getArenaRankList()
	return self.arenaRankLsit
end

function MilitaryExerciseProxy:getData()
	return Clone(self.seasonInfo)
end

return MilitaryExerciseProxy
