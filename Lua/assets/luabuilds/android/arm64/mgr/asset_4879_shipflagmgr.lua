pg = pg or {}

local var_0_0 = pg

pg.ShipFlagMgr = singletonClass("ShipFlagMgr")

function pg.ShipFlagMgr:Init(arg_1_1)
	self.flagDic = {}
	self.extraInfo = {}

	for iter_1_0, iter_1_1 in ipairs(ShipStatus.flagList) do
		self.flagDic[iter_1_1] = {}
	end

	print("initializing ShipFlagMgr manager...")
	arg_1_1()

	return
end

local var_0_1 = {
	inChapter = function()
		local var_2_0 = getProxy(ChapterProxy):getActiveChapter()

		return var_2_0 and _.map(var_2_0:getShips(), function(arg_3_0)
			return arg_3_0.id
		end) or {}
	end,
	inFleet = function()
		return getProxy(FleetProxy):getAllShipIds(true)
	end,
	inElite = function()
		local var_5_0 = {}
		local var_5_1 = getProxy(ChapterProxy)
		local var_5_2 = getProxy(ActivityProxy)

		if not var_5_1.mapEliteFleetCache then
			return {}, {}
		end

		for iter_5_0, iter_5_1 in pairs(var_5_1.mapEliteFleetCache) do
			local var_5_3 = checkExist(ChapterProxy.FormationToChapters[iter_5_0], {
				1
			})

			if not (var_5_3 and var_0_0.chapter_template[var_5_3].map) then
				-- block empty
			else
				local var_5_4 = var_0_0.expedition_data_by_map[var_5_3 and var_0_0.chapter_template[var_5_3].map].on_activity or 0

				if var_5_4 == 0 or checkExist(var_5_2:getActivityById(var_5_4), {
					"isEnd"
				}) == false then
					local var_5_5 = {}

					for iter_5_2, iter_5_3 in ipairs({
						iter_5_1[FleetType.Normal],
						iter_5_1[FleetType.Submarine]
					}) do
						for iter_5_4, iter_5_5 in ipairs(iter_5_3) do
							table.insertto(var_5_5, iter_5_5[TeamType.FormShips])
						end
					end

					var_5_0[iter_5_0] = var_5_5
				end
			end
		end

		return _.flatten(_.values(var_5_0)), var_5_0
	end,
	inSupport = function()
		local var_6_0 = {}
		local var_6_1 = getProxy(ChapterProxy)
		local var_6_2 = getProxy(ActivityProxy)

		if not var_6_1.mapEliteFleetCache then
			return {}, {}
		end

		for iter_6_0, iter_6_1 in pairs(var_6_1.mapEliteFleetCache) do
			local var_6_3 = checkExist(ChapterProxy.FormationToChapters[iter_6_0], {
				1
			})

			if not (var_6_3 and var_0_0.chapter_template[var_6_3].map) then
				-- block empty
			else
				local var_6_4 = var_0_0.expedition_data_by_map[var_6_3 and var_0_0.chapter_template[var_6_3].map].on_activity or 0

				if var_6_4 == 0 or checkExist(var_6_2:getActivityById(var_6_4), {
					"isEnd"
				}) == false then
					local var_6_5 = {}

					for iter_6_2, iter_6_3 in ipairs(iter_6_1[FleetType.Support]) do
						table.insertto(var_6_5, iter_6_3[TeamType.FormShips])
					end

					var_6_0[iter_6_0] = var_6_5
				end
			end
		end

		return _.flatten(_.values(var_6_0)), var_6_0
	end,
	inActivity = function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(getProxy(FleetProxy):getActivityFleets()) do
			var_7_0[iter_7_0] = _.flatten(_.map(_.values(iter_7_1), function(arg_8_0)
				return arg_8_0.ships
			end))
		end

		return _.flatten(_.values(var_7_0)), var_7_0
	end,
	inPvP = function()
		local var_9_0 = getProxy(FleetProxy):getFleetById(FleetProxy.PVP_FLEET_ID)

		return var_9_0 and var_9_0:getShipIds() or {}
	end,
	inChallenge = function()
		local var_10_0 = getProxy(FleetProxy)
		local var_10_1 = var_10_0:getFleetById(FleetProxy.CHALLENGE_FLEET_ID):getShipIds()

		table.insertto(var_10_1, var_10_0:getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID):getShipIds())

		return var_10_1
	end,
	inExercise = function()
		return getProxy(MilitaryExerciseProxy):getExerciseFleet():getShipIds()
	end,
	inEvent = function()
		return getProxy(EventProxy):getActiveShipIds()
	end,
	inClass = function()
		return getProxy(NavalAcademyProxy):GetShipIDs()
	end,
	inTactics = function()
		return _.map(underscore.values((getProxy(NavalAcademyProxy):getStudents())), function(arg_15_0)
			return arg_15_0 and arg_15_0.shipId
		end)
	end,
	inBackyard = function()
		return getProxy(DormProxy):getRawData():GetShipIds()
	end,
	inAdmiral = function()
		return getProxy(PlayerProxy):getRawData().characters
	end,
	inWorld = function()
		local var_18_0 = nowWorld()

		if var_18_0.type == World.TypeBase then
			return underscore.rest(var_18_0.baseShipIds, 1)
		else
			return _.map(var_18_0:GetShips(), function(arg_19_0)
				return arg_19_0.id
			end)
		end

		return
	end,
	isActivityNpc = function()
		return getProxy(BayProxy).activityNPCShipIds
	end,
	inGuildEvent = function()
		local var_21_0 = getProxy(GuildProxy):getRawData()

		if var_21_0 then
			return var_21_0:GetMissionAndAssultFleetShips()
		else
			return {}
		end

		return
	end,
	inGuildBossEvent = function()
		local var_22_0 = getProxy(GuildProxy):getRawData()

		if var_22_0 then
			return var_22_0:GetBossMissionShips()
		else
			return {}
		end

		return
	end
}

function pg.ShipFlagMgr:MarkShipsFlag(arg_23_1, arg_23_2, arg_23_3)
	for iter_23_0, iter_23_1 in ipairs(arg_23_2) do
		self.flagDic[arg_23_1][iter_23_1] = true
	end

	if arg_23_3 then
		self.extraInfo[arg_23_1] = arg_23_3
	end

	return
end

function pg.ShipFlagMgr:GetShipFlag(arg_24_1, arg_24_2, arg_24_3)
	arg_24_3 = defaultValue(arg_24_3, true)

	if type(arg_24_3) == "boolean" then
		return self.flagDic[arg_24_2][arg_24_1] == arg_24_3
	elseif type(arg_24_3) == "number" then
		if arg_24_2 == "inElite" then
			return _.any(self.extraInfo[arg_24_2][arg_24_3] or {}, function(arg_25_0)
				return arg_25_0 == arg_24_1
			end)
		elseif arg_24_2 == "inActivity" then
			return _.any(self.extraInfo[arg_24_2][arg_24_3] or {}, function(arg_26_0)
				return arg_26_0 == arg_24_1
			end)
		elseif arg_24_2 == "inSupport" then
			return _.any(self.extraInfo[arg_24_2][arg_24_3] or {}, function(arg_27_0)
				return arg_27_0 == arg_24_1
			end)
		else
			assert(false, "flagName:" .. arg_24_2 .. " type error")
		end
	else
		assert(false, "info type error")
	end

	return
end

function pg.ShipFlagMgr:FilterShips(arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or underscore.keys(getProxy(BayProxy):getRawData())

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_2) do
		for iter_28_2, iter_28_3 in pairs(arg_28_1) do
			if iter_28_3 and self:GetShipFlag(iter_28_1, iter_28_2, iter_28_3) then
				var_28_0[iter_28_1] = true

				break
			end
		end
	end

	return _.keys(var_28_0)
end

function pg.ShipFlagMgr:UpdateFlagShips(arg_29_1)
	self.flagDic[arg_29_1] = {}

	self:MarkShipsFlag(arg_29_1, var_0_1[arg_29_1]())

	return
end

function pg.ShipFlagMgr:ClearShipsFlag(arg_30_1)
	self.flagDic[arg_30_1] = {}

	return
end

function pg.ShipFlagMgr:DebugPrint(arg_31_1)
	warning("id:" .. arg_31_1 .. " flags:")

	for iter_31_0, iter_31_1 in ipairs(ShipStatus.flagList) do
		if self.flagDic[iter_31_1][arg_31_1] then
			warning(iter_31_1)
		end
	end

	return
end

return pg.ShipFlagMgr
