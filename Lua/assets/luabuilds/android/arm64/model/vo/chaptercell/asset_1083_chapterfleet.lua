local ChapterFleet = class("ChapterFleet", import(".LevelCellData"))

ChapterFleet.DUTY_CLEANPATH = 1
ChapterFleet.DUTY_KILLBOSS = 2
ChapterFleet.DUTY_KILLALL = 3
ChapterFleet.DUTY_IDLE = 4

function ChapterFleet:Ctor(arg_1_1, arg_1_2)
	self:updateNpcShipList(arg_1_2)

	self.id = arg_1_1.id
	self.name = nil
	self.fleetId = arg_1_1.fleet_id
	self.fleetType = arg_1_1.fleetType

	if arg_1_1.fleet_id then
		local var_1_0 = getProxy(FleetProxy):getFleetById(arg_1_1.fleet_id)

		self.name = var_1_0 and var_1_0:GetName() or Fleet.DEFAULT_NAME[arg_1_1.fleet_id]
	end

	self.name = self.name or Fleet.DEFAULT_NAME[self.id]

	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	_.each(arg_1_1.box_strategy_list, function(arg_2_0)
		var_1_1[arg_2_0.id] = arg_2_0.count

		return
	end)
	_.each(arg_1_1.ship_strategy_list, function(arg_3_0)
		var_1_2[arg_3_0.id] = arg_3_0.count

		return
	end)
	_.each(arg_1_1.strategy_ids, function(arg_4_0)
		if pg.strategy_data_template[arg_4_0] then
			table.insert(var_1_3, arg_4_0)
		end

		return
	end)

	if not _.detect(var_1_3, function(arg_5_0)
		return pg.strategy_data_template[arg_5_0].type == ChapterConst.StgTypeForm
	end) then
		table.insert(var_1_3, self:getFormationStg())
	end

	self.stgPicked = var_1_1
	self.stgUsed = var_1_2
	self.stgIds = var_1_3
	self.line = {
		row = arg_1_1.pos.row,
		column = arg_1_1.pos.column
	}
	self.step = arg_1_1.step_count
	self.restAmmo = arg_1_1.bullet
	self.startPos = {
		row = arg_1_1.start_pos.row,
		column = arg_1_1.start_pos.column
	}

	self:prepareShips(arg_1_1.ship_list)
	self:updateShips(arg_1_1.ship_list)

	self.baseSpeed = self:calcBaseSpeed()
	self.rotation = Quaternion.identity
	self.slowSpeedFactor = arg_1_1.move_step_down
	self.defeatEnemies = arg_1_1.kill_count or 0
	self.visibleLevel = arg_1_1.vision_lv or 0

	self:updateCommanders(arg_1_1.commander_list)

	self.skills = {}

	self:updateCommanderSkills()

	return
end

function ChapterFleet:setup(arg_6_1)
	self.chapter = arg_6_1

	self:UpdateVisible()

	return
end

function ChapterFleet:UpdateVisible()
	if self:getFleetType() == FleetType.Normal then
		self.chapter:UpdateCellsVisible(self)
	end

	return
end

function ChapterFleet:GetFogVisibleLV()
	return self.visibleLevel, pg.chapter_model_fog[math.min(self.visibleLevel, #pg.chapter_model_fog.all)]
end

function ChapterFleet:GetVisibleRange(arg_9_1)
	arg_9_1 = arg_9_1 or self.line

	local var_9_0, var_9_1 = self:GetFogVisibleLV()

	return underscore.map(var_9_1.vision_range, function(arg_10_0)
		local var_10_0, var_10_1 = unpack(arg_10_0)

		return {
			row = arg_9_1.row + var_10_0,
			column = arg_9_1.column + var_10_1
		}
	end)
end

function ChapterFleet:fetchShipVO(arg_11_1)
	local var_11_0 = self.npcShipList[arg_11_1] and Clone(self.npcShipList[arg_11_1]) or getProxy(BayProxy):getShipById(arg_11_1)

	if self.staticsReady then
		var_11_0.triggers.TeamNumbers = self.statics[var_11_0:getTeamType()].count
	end

	return var_11_0
end

function ChapterFleet:updateNpcShipList(arg_12_1)
	self.npcShipList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		self.npcShipList[iter_12_1.id] = iter_12_1
	end

	return
end

function ChapterFleet:GetLine()
	return self.line
end

function ChapterFleet:SetLine(arg_14_1)
	self.line = {
		row = arg_14_1.row,
		column = arg_14_1.column
	}

	self:UpdateVisible()

	return
end

function ChapterFleet:updateCommanders(arg_15_1)
	self.commanders = {}

	local var_15_0 = getProxy(CommanderProxy)

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_1 = var_15_0:getCommanderById(iter_15_1.id)

		if var_15_1 then
			self.commanders[iter_15_1.pos] = var_15_1
		end
	end

	return
end

function ChapterFleet:getCommanders()
	return self.commanders or {}
end

function ChapterFleet:prepareShips(arg_17_1)
	self.statics = {}
	self.statics[TeamType.Vanguard] = {
		count = 0
	}
	self.statics[TeamType.Main] = {
		count = 0
	}
	self.statics[TeamType.Submarine] = {
		count = 0
	}

	_.each(arg_17_1 or {}, function(arg_18_0)
		local var_18_0 = self:fetchShipVO(arg_18_0.id)

		if var_18_0 then
			local var_18_1 = self.statics[var_18_0:getTeamType()]

			var_18_1.count = var_18_1.count + 1
		end

		return
	end)

	self.staticsReady = true

	return
end

function ChapterFleet:updateShips(arg_19_1)
	self[TeamType.Vanguard] = {}
	self[TeamType.Main] = {}
	self[TeamType.Submarine] = {}
	self.ships = {}

	_.each(arg_19_1 or {}, function(arg_20_0)
		local var_20_0 = self:fetchShipVO(arg_20_0.id)

		if var_20_0 then
			var_20_0.hpRant = arg_20_0.hp_rant
			self.ships[var_20_0.id] = var_20_0

			table.insert(self[var_20_0:getTeamType()], var_20_0)
		end

		return
	end)
	self:ResortShips()

	return
end

function ChapterFleet:ResortShips()
	_.each({
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}, function(arg_22_0)
		local var_22_0 = {}

		table.Ipairs(self[arg_22_0], function(arg_23_0, arg_23_1)
			var_22_0[arg_23_1] = arg_23_0

			return
		end)
		table.sort(self[arg_22_0], CompareFuncs({
			function(arg_24_0)
				return arg_24_0.hpRant > 0 and 0 or 1
			end,
			function(arg_25_0)
				return var_22_0[arg_25_0]
			end
		}))

		return
	end)

	return
end

function ChapterFleet:getTeamByName(arg_26_1)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self[arg_26_1]) do
		table.insert(var_26_0, iter_26_1.id)
	end

	return var_26_0
end

function ChapterFleet:flushShips()
	local var_27_0 = getProxy(FleetProxy):getFleetById(self.fleetId)

	if var_27_0 and var_27_0.name ~= "" then
		self.name = var_27_0.name or Fleet.DEFAULT_NAME[self.fleetId] or Fleet.DEFAULT_NAME[self.id]
	end

	for iter_27_0, iter_27_1 in ipairs((_.keys(self.ships))) do
		local var_27_1 = self:fetchShipVO(iter_27_1)

		if var_27_1 then
			var_27_1.hpRant = self.ships[iter_27_1].hpRant
		end

		self.ships[iter_27_1] = var_27_1
	end

	local var_27_2 = {}

	_.each(self[TeamType.Vanguard], function(arg_28_0)
		if self.ships[arg_28_0.id] then
			table.insert(var_27_2, self.ships[arg_28_0.id])
		end

		return
	end)

	self[TeamType.Vanguard] = var_27_2

	local var_27_3 = {}

	_.each(self[TeamType.Main], function(arg_29_0)
		if self.ships[arg_29_0.id] then
			table.insert(var_27_3, self.ships[arg_29_0.id])
		end

		return
	end)

	self[TeamType.Main] = var_27_3

	local var_27_4 = {}

	_.each(self[TeamType.Submarine], function(arg_30_0)
		if self.ships[arg_30_0.id] then
			table.insert(var_27_4, self.ships[arg_30_0.id])
		end

		return
	end)

	self[TeamType.Submarine] = var_27_4

	return
end

function ChapterFleet:updateShipHp(arg_31_1, arg_31_2)
	if self.ships[arg_31_1] then
		self.ships[arg_31_1].hpChange = arg_31_2 - self.ships[arg_31_1].hpRant
		self.ships[arg_31_1].hpRant = arg_31_2

		self:ResortShips()
	end

	return
end

function ChapterFleet:getShip(arg_32_1)
	return self.ships[arg_32_1]
end

function ChapterFleet:getShips(arg_33_1)
	local var_33_0 = {}
	local var_33_1 = self:getFleetType()

	if var_33_1 == FleetType.Normal then
		table.insertto(var_33_0, self:getShipsByTeam(TeamType.Main, arg_33_1))
		table.insertto(var_33_0, self:getShipsByTeam(TeamType.Vanguard, arg_33_1))
	elseif var_33_1 == FleetType.Submarine then
		table.insertto(var_33_0, self:getShipsByTeam(TeamType.Submarine, arg_33_1))
	elseif var_33_1 == FleetType.Support then
		for iter_33_0, iter_33_1 in ipairs({
			TeamType.Main,
			TeamType.Vanguard,
			TeamType.Submarine
		}) do
			table.insertto(var_33_0, self:getShipsByTeam(iter_33_1, arg_33_1))
		end
	end

	return var_33_0
end

function ChapterFleet:getShipsByTeam(arg_34_1, arg_34_2)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs(self[arg_34_1]) do
		if iter_34_1.hpRant > 0 then
			table.insert(var_34_0, iter_34_1)
		else
			table.insert(var_34_1, iter_34_1)
		end
	end

	if arg_34_2 then
		table.insertto(var_34_0, var_34_1)
	end

	return var_34_0
end

function ChapterFleet:containsShip(arg_35_1)
	return not not self.ships[arg_35_1]
end

function ChapterFleet:replaceShip(arg_36_1, arg_36_2)
	errorMsg("ChapterFleet replaceShip function used")

	if self.ships[arg_36_1] and not self.ships[arg_36_2.id] then
		local var_36_0 = self:fetchShipVO(arg_36_2.id)

		if var_36_0 then
			if var_36_0:getTeamType() == self.ships[arg_36_1]:getTeamType() then
				if not self.ships[arg_36_1]:isSameKind(var_36_0) and self:containsSameKind(var_36_0) then
					self:removeShip(arg_36_1)
				else
					var_36_0.hpRant = arg_36_2.hp_rant
					self.ships[arg_36_1] = nil
					self.ships[var_36_0.id] = var_36_0

					local var_36_1 = self[var_36_0:getTeamType()]

					for iter_36_0 = 1, #var_36_1 do
						if var_36_1[iter_36_0].id == arg_36_1 then
							var_36_1[iter_36_0] = var_36_0

							break
						end
					end
				end
			else
				self:removeShip(arg_36_1)
			end
		end
	end

	return
end

function ChapterFleet:addShip(arg_37_1)
	errorMsg("ChapterFleet addShip function used")

	if not self.ships[arg_37_1.id] then
		local var_37_0 = self:fetchShipVO(arg_37_1.id)

		if var_37_0 then
			var_37_0.hpRant = arg_37_1.hp_rant

			local var_37_1 = self[var_37_0:getTeamType()]

			if #var_37_1 < 3 then
				table.insert(var_37_1, var_37_0)

				self.ships[var_37_0.id] = var_37_0

				self:ResortShips()
			end
		end
	end

	return
end

function ChapterFleet:removeShip(arg_38_1)
	errorMsg("ChapterFleet removeShip function used")

	self.ships[arg_38_1] = nil

	local var_38_0 = {
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}

	for iter_38_0 = 1, #var_38_0 do
		for iter_38_1 = #self[var_38_0[iter_38_0]], 1, -1 do
			if self[var_38_0[iter_38_0]][iter_38_1].id == arg_38_1 then
				table.remove(self[var_38_0[iter_38_0]], iter_38_1)
			end
		end
	end

	return
end

function ChapterFleet:switchShip(arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = self:getShipsByTeam(arg_39_1, false)
	local var_39_1
	local var_39_2
	local var_39_3
	local var_39_4

	for iter_39_0, iter_39_1 in pairs(self.ships) do
		if iter_39_0 == var_39_0[arg_39_2].id then
			var_39_1 = iter_39_1:getTeamType()
			var_39_2 = table.indexof(self[var_39_1], iter_39_1)
		end

		if iter_39_0 == var_39_0[arg_39_3].id then
			var_39_3 = iter_39_1:getTeamType()
			var_39_4 = table.indexof(self[var_39_3], iter_39_1)
		end
	end

	assert(nil and nil)

	if var_39_1 == var_39_3 and nil ~= nil then
		self[var_39_1][var_39_2], self[var_39_3][var_39_4] = self[var_39_3][nil], self[var_39_1][nil]
	end

	return
end

function ChapterFleet:synchronousShipIndex(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs({
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}) do
		for iter_40_2 = 1, 3 do
			self[iter_40_1][iter_40_2] = arg_40_1[iter_40_1][iter_40_2] and self.ships[arg_40_1[iter_40_1][iter_40_2].id] or nil
		end
	end

	return
end

function ChapterFleet:isValid()
	local var_41_0 = self:getFleetType()

	if var_41_0 == FleetType.Normal then
		return _.any(self[TeamType.Vanguard], function(arg_42_0)
			return arg_42_0.hpRant > 0
		end) and _.any(self[TeamType.Main], function(arg_43_0)
			return arg_43_0.hpRant > 0
		end)
	elseif var_41_0 == FleetType.Submarine then
		return _.any(self[TeamType.Submarine], function(arg_44_0)
			return arg_44_0.hpRant > 0
		end)
	elseif var_41_0 == FleetType.Support then
		return true
	end

	return false
end

function ChapterFleet:getCost()
	local var_45_0 = {
		gold = 0,
		oil = 0
	}
	local var_45_1 = {
		gold = 0,
		oil = 0
	}

	_.each(self:getShips(false), function(arg_46_0)
		var_45_0.oil = var_45_0.oil + arg_46_0:getStartBattleExpend()
		var_45_1.oil = var_45_1.oil + arg_46_0:getEndBattleExpend()

		return
	end)

	return var_45_0, var_45_1
end

function ChapterFleet:getInvestSums(arg_47_1)
	return math.pow(_.reduce(self:getShips(arg_47_1), 0, function(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_1:getProperties(self:getCommanders())

		return arg_48_0 + var_48_0[AttributeType.Air] + var_48_0[AttributeType.Dodge]
	end), 0.6666666666666666)
end

function ChapterFleet:getDodgeSums()
	return math.pow(_.reduce(self:getShips(false), 0, function(arg_50_0, arg_50_1)
		return arg_50_0 + arg_50_1:getProperties(self:getCommanders())[AttributeType.Dodge]
	end), 0.6666666666666666)
end

function ChapterFleet:getAntiAircraftSums()
	return (_.reduce(self:getShips(false), 0, function(arg_52_0, arg_52_1)
		return arg_52_0 + arg_52_1:getProperties(self:getCommanders())[AttributeType.AntiAircraft]
	end))
end

function ChapterFleet:getAirSums(arg_53_1)
	return (_.reduce(self:getShips(arg_53_1), 0, function(arg_54_0, arg_54_1)
		return arg_54_0 + arg_54_1:getProperties(self:getCommanders())[AttributeType.Air]
	end))
end

function ChapterFleet:getShipAmmo()
	local var_55_0 = 0

	if self:getFleetType() == FleetType.Normal then
		for iter_55_0, iter_55_1 in pairs(self.ships) do
			var_55_0 = math.max(var_55_0, iter_55_1:getShipAmmo())
		end
	elseif self:getFleetType() == FleetType.Submarine then
		for iter_55_2, iter_55_3 in pairs(self.ships) do
			var_55_0 = var_55_0 + iter_55_3:getShipAmmo()
		end
	elseif self:getFleetType() == FleetType.Support then
		var_55_0 = 0
	end

	return var_55_0
end

function ChapterFleet:clearShipHpChange()
	for iter_56_0, iter_56_1 in pairs(self.ships) do
		self.ships[iter_56_1.id].hpChange = 0
	end

	return
end

function ChapterFleet:getEquipAmbushRateReduce()
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in pairs(self.ships) do
		for iter_57_2, iter_57_3 in pairs(iter_57_1:getActiveEquipments()) do
			if iter_57_3 then
				var_57_0 = math.max(var_57_0, iter_57_3:getConfig("equip_parameters").ambush_extra or 0)
			end
		end
	end

	return var_57_0 / 16
end

function ChapterFleet:getEquipDodgeRateUp()
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in pairs(self.ships) do
		for iter_58_2, iter_58_3 in pairs(iter_58_1:getActiveEquipments()) do
			if iter_58_3 then
				var_58_0 = math.max(var_58_0, iter_58_3:getConfig("equip_parameters").avoid_extra or 0)
			end
		end
	end

	return var_58_0 / 16
end

function ChapterFleet:isFormationDiffWith(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}) do
		for iter_59_2 = 1, math.max(#self[iter_59_1], #arg_59_1[iter_59_1]) do
			if self[iter_59_1][iter_59_2] ~= arg_59_1[iter_59_1][iter_59_2] and (self[iter_59_1][iter_59_2] == nil or arg_59_1[iter_59_1][iter_59_2] == nil or self[iter_59_1][iter_59_2].id ~= arg_59_1[iter_59_1][iter_59_2].id) then
				return true
			end
		end
	end

	return false
end

function ChapterFleet:getShipIds()
	local var_60_0 = {}
	local var_60_1 = self:getFleetType()

	if var_60_1 == FleetType.Normal then
		_.each(self[TeamType.Main], function(arg_61_0)
			table.insert(var_60_0, arg_61_0.id)

			return
		end)
		_.each(self[TeamType.Vanguard], function(arg_62_0)
			table.insert(var_60_0, arg_62_0.id)

			return
		end)
	elseif var_60_1 == FleetType.Submarine then
		_.each(self[TeamType.Submarine], function(arg_63_0)
			table.insert(var_60_0, arg_63_0.id)

			return
		end)
	elseif var_60_1 == FleetType.Support then
		for iter_60_0, iter_60_1 in pairs(self.ships) do
			table.insert(var_60_0, iter_60_1.id)
		end
	end

	return var_60_0
end

function ChapterFleet:containsSameKind(arg_64_1)
	return arg_64_1 and _.any(_.values(self.ships), function(arg_65_0)
		return arg_64_1:isSameKind(arg_65_0)
	end)
end

function ChapterFleet:increaseSlowSpeedFactor()
	self.slowSpeedFactor = self.slowSpeedFactor + 1

	return
end

function ChapterFleet:getSpeed()
	return math.max(self.baseSpeed + (self:triggerSkill(FleetSkill.TypeMoveSpeed) or 0) - self.slowSpeedFactor, 1)
end

function ChapterFleet:calcBaseSpeed()
	local var_68_0 = self:getShips(true)
	local var_68_1 = _.reduce(var_68_0, 0, function(arg_69_0, arg_69_1)
		return arg_69_0 + arg_69_1:getProperties()[AttributeType.Speed]
	end) / #var_68_0 * (1 - 0.02 * (#var_68_0 - 1))
	local var_68_2
	local var_68_3
	local var_68_4 = self:getFleetType()

	if var_68_4 == FleetType.Normal then
		var_68_2 = pg.gameset.chapter_move_speed_1.key_value
		var_68_3 = pg.gameset.chapter_move_speed_2.key_value
	elseif var_68_4 == FleetType.Submarine then
		var_68_2 = pg.gameset.submarine_move_speed_1.key_value
		var_68_3 = pg.gameset.submarine_move_speed_2.key_value
	elseif var_68_4 == FleetType.Support then
		var_68_2 = pg.gameset.chapter_move_speed_1.key_value
		var_68_3 = pg.gameset.chapter_move_speed_2.key_value
	end

	if var_68_1 <= var_68_2 then
		return 2
	elseif var_68_3 < var_68_1 then
		return 4
	else
		return 3
	end

	return
end

function ChapterFleet:getDefeatCount()
	return self.defeatEnemies
end

function ChapterFleet:getStrategies()
	local var_71_0 = self:getOwnStrategies()

	for iter_71_0, iter_71_1 in pairs(self.stgPicked) do
		var_71_0[iter_71_0] = (var_71_0[iter_71_0] or 0) + iter_71_1
	end

	for iter_71_2, iter_71_3 in pairs(self.stgUsed) do
		if var_71_0[iter_71_2] then
			var_71_0[iter_71_2] = math.max(0, var_71_0[iter_71_2] - iter_71_3)
		end
	end

	for iter_71_4, iter_71_5 in pairs(ChapterConst.StrategyPresents) do
		var_71_0[iter_71_5] = var_71_0[iter_71_5] or 0
	end

	local var_71_2 = {}

	for iter_71_6, iter_71_7 in pairs(var_71_0) do
		table.insert(var_71_2, {
			id = iter_71_6,
			count = iter_71_7
		})
	end

	return _.sort(var_71_2, function(arg_72_0, arg_72_1)
		return arg_72_0.id < arg_72_1.id
	end)
end

function ChapterFleet:getOwnStrategies()
	local var_73_0 = {}

	_.each(self:getShips(true), function(arg_74_0)
		_.each(arg_74_0:getConfig("strategy_list"), function(arg_75_0)
			var_73_0[arg_75_0[1]] = (var_73_0[arg_75_0[1]] or 0) + arg_75_0[2]

			return
		end)

		return
	end)

	local var_73_1 = self:triggerSkill(FleetSkill.TypeStrategy)

	if var_73_1 then
		_.each(var_73_1, function(arg_76_0)
			var_73_0[arg_76_0[1]] = (var_73_0[arg_76_0[1]] or 0) + arg_76_0[2]

			return
		end)
	end

	return var_73_0
end

function ChapterFleet:achievedStrategy(arg_77_1, arg_77_2)
	self.stgPicked[arg_77_1] = (self.stgPicked[arg_77_1] or 0) + arg_77_2

	return
end

function ChapterFleet:consumeOneStrategy(arg_78_1)
	local var_78_0 = self:getOwnStrategies()

	if var_78_0[arg_78_1] and var_78_0[arg_78_1] > 0 then
		self.stgUsed[arg_78_1] = (self.stgUsed[arg_78_1] or 0) + 1
	else
		local var_78_2 = self.stgPicked

		if self.stgPicked[arg_78_1] then
			var_78_2[arg_78_1] = math.max(0, var_78_2[arg_78_1] - 1)
		end
	end

	return
end

function ChapterFleet:GetStrategyCount(arg_79_1)
	local var_79_0 = _.detect(self:getStrategies(), function(arg_80_0)
		return arg_80_0.id == arg_79_1
	end)

	return (var_79_0 or nil) and (var_79_0.count or 0)
end

function ChapterFleet:getFormationStg()
	return PlayerPrefs.GetInt("team_formation_" .. self.id, 1)
end

function ChapterFleet:canUseStrategy(arg_82_1)
	if pg.strategy_data_template[arg_82_1.id].type == ChapterConst.StgTypeForm then
		if self:getFormationStg() == pg.strategy_data_template[arg_82_1.id].id then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_formation_active_already"))

			return false
		end
	elseif pg.strategy_data_template[arg_82_1.id].type == ChapterConst.StgTypeConsume or pg.strategy_data_template[arg_82_1.id].type == ChapterConst.StgTypeBindSupportConsume then
		if arg_82_1.count <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_not_enough"))

			return false
		end

		if pg.strategy_data_template[arg_82_1.id].id == ChapterConst.StrategyRepair and _.all(self:getShips(true), function(arg_83_0)
			return arg_83_0.hpRant == 0 or arg_83_0.hpRant == 16
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_full_hp"))

			return false
		end
	end

	return true
end

function ChapterFleet:getNextStgUser(arg_84_1)
	return self.id
end

function ChapterFleet:GetStatusStrategy()
	return self.stgIds
end

function ChapterFleet:getFleetType()
	assert(self.fleetType)

	return self.fleetType
end

function ChapterFleet:canClearTorpedo()
	return _.any(self:getShipsByTeam(TeamType.Vanguard, true), function(arg_88_0)
		return ShipType.IsTypeQuZhu(arg_88_0:getShipType())
	end)
end

function ChapterFleet:getHuntingRange(arg_89_1)
	if self:getFleetType() ~= FleetType.Submarine then
		assert(false)

		return {}
	end

	local var_89_0 = arg_89_1 or self.startPos
	local var_89_1 = self:getShipsByTeam(TeamType.Submarine, true)[1]

	return (_.map(var_89_1:getHuntingRange(var_89_1:getHuntingLv() + (self:triggerSkill(FleetSkill.TypeHuntingLv) or 0)), function(arg_90_0)
		return {
			row = var_89_0.row + arg_90_0[1],
			column = var_89_0.column + arg_90_0[2]
		}
	end))
end

function ChapterFleet:inHuntingRange(arg_91_1, arg_91_2)
	return _.any(self:getHuntingRange(), function(arg_92_0)
		return arg_92_0.row == arg_91_1 and arg_92_0.column == arg_91_2
	end)
end

function ChapterFleet:getSummonCost()
	return _.reduce(self:getShips(false), 0, function(arg_94_0, arg_94_1)
		return arg_94_0 + arg_94_1:getEndBattleExpend()
	end)
end

function ChapterFleet:getMapAura()
	local var_95_0 = {}

	for iter_95_0, iter_95_1 in pairs(self.ships) do
		for iter_95_2, iter_95_3 in ipairs((iter_95_1:getMapAuras())) do
			table.insert(var_95_0, iter_95_3)
		end
	end

	return var_95_0
end

function ChapterFleet:getMapAid()
	local var_96_0 = {}

	for iter_96_0, iter_96_1 in pairs(self.ships) do
		for iter_96_2, iter_96_3 in ipairs((iter_96_1:getMapAids())) do
			local var_96_1 = var_96_0[iter_96_1] or {}

			table.insert(var_96_1, iter_96_3)

			var_96_0[iter_96_1] = var_96_1
		end
	end

	return var_96_0
end

function ChapterFleet:updateCommanderSkills()
	for iter_97_0, iter_97_1 in pairs((self:getCommanders())) do
		_.each(iter_97_1:getSkills(), function(arg_98_0)
			_.each(arg_98_0:getTacticSkill(), function(arg_99_0)
				table.insert(self.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, arg_99_0))

				return
			end)

			return
		end)
	end

	return
end

function ChapterFleet:getSkills()
	return self.skills
end

function ChapterFleet:getSkill(arg_101_1)
	return _.detect(self:getSkills(), function(arg_102_0)
		return arg_102_0.id == arg_101_1
	end)
end

function ChapterFleet:findSkills(arg_103_1)
	return _.filter(self:getSkills(), function(arg_104_0)
		return arg_104_0:GetType() == arg_103_1
	end)
end

function ChapterFleet:triggerSkill(arg_105_1)
	return self.chapter:triggerSkill(self, arg_105_1)
end

function ChapterFleet:findCommanderBySkillId(arg_106_1)
	for iter_106_0, iter_106_1 in pairs((self:getCommanders())) do
		if _.any(iter_106_1:getSkills(), function(arg_107_0)
			return _.any(arg_107_0:getTacticSkill(), function(arg_108_0)
				return arg_108_0 == arg_106_1
			end)
		end) then
			return iter_106_1
		end
	end

	return
end

function ChapterFleet:getFleetAirDominanceValue()
	local var_109_0 = 0

	for iter_109_0, iter_109_1 in ipairs(self:getShips(false)) do
		var_109_0 = var_109_0 + calcAirDominanceValue(iter_109_1, self:getCommanders())
	end

	return var_109_0
end

function ChapterFleet:StaticTransformChapterFleet2Fleet(arg_110_1)
	local var_110_0 = _.pluck(self:getShipsByTeam(TeamType.Vanguard, arg_110_1), "id")

	table.insertto(var_110_0, _.pluck(self:getShipsByTeam(TeamType.Main, arg_110_1), "id"))

	local var_110_1 = {}

	for iter_110_0, iter_110_1 in pairs(self.commanders) do
		table.insert(var_110_1, {
			pos = iter_110_0,
			id = iter_110_1 and iter_110_1.id
		})
	end

	return TypedFleet.New({
		fleetType = FleetType.Normal,
		ship_list = var_110_0,
		commanders = var_110_1
	})
end

return ChapterFleet
