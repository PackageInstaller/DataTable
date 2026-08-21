local var_0_0 = class("ChapterFleet", import(".LevelCellData"))

var_0_0.DUTY_CLEANPATH = 1
var_0_0.DUTY_KILLBOSS = 2
var_0_0.DUTY_KILLALL = 3
var_0_0.DUTY_IDLE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:updateNpcShipList(arg_1_2)

	arg_1_0.id = arg_1_1.id
	arg_1_0.name = nil
	arg_1_0.fleetId = arg_1_1.fleet_id
	arg_1_0.fleetType = arg_1_1.fleetType

	if arg_1_1.fleet_id then
		local var_1_0 = getProxy(FleetProxy):getFleetById(arg_1_1.fleet_id)

		arg_1_0.name = var_1_0 and var_1_0:GetName() or Fleet.DEFAULT_NAME[arg_1_1.fleet_id]
	end

	arg_1_0.name = arg_1_0.name or Fleet.DEFAULT_NAME[arg_1_0.id]

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

	if not _.detect({}, function(arg_5_0)
		return pg.strategy_data_template[arg_5_0].type == ChapterConst.StgTypeForm
	end) then
		table.insert({}, arg_1_0:getFormationStg())
	end

	arg_1_0.stgPicked = {}
	arg_1_0.stgUsed = {}
	arg_1_0.stgIds = {}
	arg_1_0.line = {
		row = arg_1_1.pos.row,
		column = arg_1_1.pos.column
	}
	arg_1_0.step = arg_1_1.step_count
	arg_1_0.restAmmo = arg_1_1.bullet
	arg_1_0.startPos = {
		row = arg_1_1.start_pos.row,
		column = arg_1_1.start_pos.column
	}

	arg_1_0:prepareShips(arg_1_1.ship_list)
	arg_1_0:updateShips(arg_1_1.ship_list)

	arg_1_0.baseSpeed = arg_1_0:calcBaseSpeed()
	arg_1_0.rotation = Quaternion.identity
	arg_1_0.slowSpeedFactor = arg_1_1.move_step_down
	arg_1_0.defeatEnemies = arg_1_1.kill_count or 0
	arg_1_0.visibleLevel = arg_1_1.vision_lv or 0

	arg_1_0:updateCommanders(arg_1_1.commander_list)

	arg_1_0.skills = {}

	arg_1_0:updateCommanderSkills()

	return
end

function var_0_0.setup(arg_6_0, arg_6_1)
	arg_6_0.chapter = arg_6_1

	arg_6_0:UpdateVisible()

	return
end

function var_0_0.UpdateVisible(arg_7_0)
	if arg_7_0:getFleetType() == FleetType.Normal then
		arg_7_0.chapter:UpdateCellsVisible(arg_7_0)
	end

	return
end

function var_0_0.GetFogVisibleLV(arg_8_0)
	return arg_8_0.visibleLevel, pg.chapter_model_fog[math.min(arg_8_0.visibleLevel, #pg.chapter_model_fog.all)]
end

function var_0_0.GetVisibleRange(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or arg_9_0.line

	local var_9_0, var_9_1 = arg_9_0:GetFogVisibleLV()

	return underscore.map(var_9_1.vision_range, function(arg_10_0)
		local var_10_0, var_10_1 = unpack(arg_10_0)

		return {
			row = arg_9_1.row + var_10_0,
			column = arg_9_1.column + var_10_1
		}
	end)
end

function var_0_0.fetchShipVO(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.npcShipList[arg_11_1] and Clone(arg_11_0.npcShipList[arg_11_1]) or getProxy(BayProxy):getShipById(arg_11_1)

	if arg_11_0.staticsReady then
		var_11_0.triggers.TeamNumbers = arg_11_0.statics[var_11_0:getTeamType()].count
	end

	return var_11_0
end

function var_0_0.updateNpcShipList(arg_12_0, arg_12_1)
	arg_12_0.npcShipList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		arg_12_0.npcShipList[iter_12_1.id] = iter_12_1
	end

	return
end

function var_0_0.GetLine(arg_13_0)
	return arg_13_0.line
end

function var_0_0.SetLine(arg_14_0, arg_14_1)
	arg_14_0.line = {
		row = arg_14_1.row,
		column = arg_14_1.column
	}

	arg_14_0:UpdateVisible()

	return
end

function var_0_0.updateCommanders(arg_15_0, arg_15_1)
	arg_15_0.commanders = {}

	local var_15_0 = getProxy(CommanderProxy)

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_1 = var_15_0:getCommanderById(iter_15_1.id)

		if var_15_1 then
			arg_15_0.commanders[iter_15_1.pos] = var_15_1
		end
	end

	return
end

function var_0_0.getCommanders(arg_16_0)
	return arg_16_0.commanders or {}
end

function var_0_0.prepareShips(arg_17_0, arg_17_1)
	arg_17_0.statics = {}
	arg_17_0.statics[TeamType.Vanguard] = {
		count = 0
	}
	arg_17_0.statics[TeamType.Main] = {
		count = 0
	}
	arg_17_0.statics[TeamType.Submarine] = {
		count = 0
	}

	_.each(arg_17_1 or {}, function(arg_18_0)
		local var_18_0 = arg_17_0:fetchShipVO(arg_18_0.id)

		if var_18_0 then
			local var_18_1 = arg_17_0.statics[var_18_0:getTeamType()]

			var_18_1.count = var_18_1.count + 1
		end

		return
	end)

	arg_17_0.staticsReady = true

	return
end

function var_0_0.updateShips(arg_19_0, arg_19_1)
	arg_19_0[TeamType.Vanguard] = {}
	arg_19_0[TeamType.Main] = {}
	arg_19_0[TeamType.Submarine] = {}
	arg_19_0.ships = {}

	_.each(arg_19_1 or {}, function(arg_20_0)
		local var_20_0 = arg_19_0:fetchShipVO(arg_20_0.id)

		if var_20_0 then
			var_20_0.hpRant = arg_20_0.hp_rant
			arg_19_0.ships[var_20_0.id] = var_20_0

			table.insert(arg_19_0[var_20_0:getTeamType()], var_20_0)
		end

		return
	end)
	arg_19_0:ResortShips()

	return
end

function var_0_0.ResortShips(arg_21_0)
	_.each({
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}, function(arg_22_0)
		local var_22_0 = {}

		table.Ipairs(arg_21_0[arg_22_0], function(arg_23_0, arg_23_1)
			var_22_0[arg_23_1] = arg_23_0

			return
		end)
		table.sort(arg_21_0[arg_22_0], CompareFuncs({
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

function var_0_0.getTeamByName(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0[arg_26_1]) do
		table.insert({}, iter_26_1.id)
	end

	return {}
end

function var_0_0.flushShips(arg_27_0)
	local var_27_0 = getProxy(FleetProxy):getFleetById(arg_27_0.fleetId)

	if var_27_0 and var_27_0.name ~= "" then
		arg_27_0.name = var_27_0.name or Fleet.DEFAULT_NAME[arg_27_0.fleetId] or Fleet.DEFAULT_NAME[arg_27_0.id]

		for iter_27_0, iter_27_1 in ipairs((_.keys(arg_27_0.ships))) do
			local var_27_1 = arg_27_0:fetchShipVO(iter_27_1)

			if var_27_1 then
				var_27_1.hpRant = arg_27_0.ships[iter_27_1].hpRant
			end

			arg_27_0.ships[iter_27_1] = var_27_1
		end

		local var_27_2 = {}

		_.each(arg_27_0[TeamType.Vanguard], function(arg_28_0)
			if arg_27_0.ships[arg_28_0.id] then
				table.insert(var_27_2, arg_27_0.ships[arg_28_0.id])
			end

			return
		end)

		arg_27_0[TeamType.Vanguard] = {}

		local var_27_3 = {}

		_.each(arg_27_0[TeamType.Main], function(arg_29_0)
			if arg_27_0.ships[arg_29_0.id] then
				table.insert(var_27_3, arg_27_0.ships[arg_29_0.id])
			end

			return
		end)

		arg_27_0[TeamType.Main] = {}

		local var_27_4 = {}

		_.each(arg_27_0[TeamType.Submarine], function(arg_30_0)
			if arg_27_0.ships[arg_30_0.id] then
				table.insert(var_27_4, arg_27_0.ships[arg_30_0.id])
			end

			return
		end)

		arg_27_0[TeamType.Submarine] = {}

		return
	end
end

function var_0_0.updateShipHp(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.ships[arg_31_1] then
		arg_31_0.ships[arg_31_1].hpChange = arg_31_2 - arg_31_0.ships[arg_31_1].hpRant
		arg_31_0.ships[arg_31_1].hpRant = arg_31_2

		arg_31_0:ResortShips()
	end

	return
end

function var_0_0.getShip(arg_32_0, arg_32_1)
	return arg_32_0.ships[arg_32_1]
end

function var_0_0.getShips(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getFleetType()

	if var_33_0 == FleetType.Normal then
		table.insertto({}, arg_33_0:getShipsByTeam(TeamType.Main, arg_33_1))
		table.insertto({}, arg_33_0:getShipsByTeam(TeamType.Vanguard, arg_33_1))
	elseif var_33_0 == FleetType.Submarine then
		table.insertto({}, arg_33_0:getShipsByTeam(TeamType.Submarine, arg_33_1))
	elseif var_33_0 == FleetType.Support then
		for iter_33_0, iter_33_1 in ipairs({
			TeamType.Main,
			TeamType.Vanguard,
			TeamType.Submarine
		}) do
			table.insertto({}, arg_33_0:getShipsByTeam(iter_33_1, arg_33_1))
		end
	end

	return {}
end

function var_0_0.getShipsByTeam(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0[arg_34_1]) do
		if iter_34_1.hpRant > 0 then
			table.insert({}, iter_34_1)
		else
			table.insert({}, iter_34_1)
		end
	end

	if arg_34_2 then
		table.insertto({}, {})
	end

	return {}
end

function var_0_0.containsShip(arg_35_0, arg_35_1)
	return not not arg_35_0.ships[arg_35_1]
end

function var_0_0.replaceShip(arg_36_0, arg_36_1, arg_36_2)
	errorMsg("ChapterFleet replaceShip function used")

	if arg_36_0.ships[arg_36_1] and not arg_36_0.ships[arg_36_2.id] then
		local var_36_0 = arg_36_0:fetchShipVO(arg_36_2.id)

		if var_36_0 then
			if var_36_0:getTeamType() == arg_36_0.ships[arg_36_1]:getTeamType() then
				if not arg_36_0.ships[arg_36_1]:isSameKind(var_36_0) and arg_36_0:containsSameKind(var_36_0) then
					arg_36_0:removeShip(arg_36_1)
				else
					var_36_0.hpRant = arg_36_2.hp_rant
					arg_36_0.ships[arg_36_1] = nil
					arg_36_0.ships[var_36_0.id] = var_36_0

					local var_36_1 = arg_36_0[var_36_0:getTeamType()]

					for iter_36_0 = 1, #var_36_1 do
						if var_36_1[iter_36_0].id == arg_36_1 then
							var_36_1[iter_36_0] = var_36_0

							break
						end
					end
				end
			else
				arg_36_0:removeShip(arg_36_1)
			end
		end
	end

	return
end

function var_0_0.addShip(arg_37_0, arg_37_1)
	errorMsg("ChapterFleet addShip function used")

	if not arg_37_0.ships[arg_37_1.id] then
		local var_37_0 = arg_37_0:fetchShipVO(arg_37_1.id)

		if var_37_0 then
			var_37_0.hpRant = arg_37_1.hp_rant

			local var_37_1 = arg_37_0[var_37_0:getTeamType()]

			if #var_37_1 < 3 then
				table.insert(var_37_1, var_37_0)

				arg_37_0.ships[var_37_0.id] = var_37_0

				arg_37_0:ResortShips()
			end
		end
	end

	return
end

function var_0_0.removeShip(arg_38_0, arg_38_1)
	errorMsg("ChapterFleet removeShip function used")

	arg_38_0.ships[arg_38_1] = nil

	for iter_38_0 = 1, #{
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	} do
		for iter_38_1 = #arg_38_0[({
			TeamType.Vanguard,
			TeamType.Main,
			TeamType.Submarine
		})[iter_38_0]], 1, -1 do
			if arg_38_0[({
				TeamType.Vanguard,
				TeamType.Main,
				TeamType.Submarine
			})[iter_38_0]][iter_38_1].id == arg_38_1 then
				table.remove(arg_38_0[({
					TeamType.Vanguard,
					TeamType.Main,
					TeamType.Submarine
				})[iter_38_0]], iter_38_1)
			end
		end
	end

	return
end

function var_0_0.switchShip(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_0:getShipsByTeam(arg_39_1, false)
	local var_39_1
	local var_39_2
	local var_39_3
	local var_39_4

	for iter_39_0, iter_39_1 in pairs(arg_39_0.ships) do
		if iter_39_0 == var_39_0[arg_39_2].id then
			var_39_1 = iter_39_1:getTeamType()
			var_39_2 = table.indexof(arg_39_0[var_39_1], iter_39_1)
		end

		if iter_39_0 == var_39_0[arg_39_3].id then
			var_39_3 = iter_39_1:getTeamType()
			var_39_4 = table.indexof(arg_39_0[var_39_3], iter_39_1)
		end
	end

	assert(nil and nil)

	if var_39_1 == var_39_3 and nil ~= nil then
		arg_39_0[var_39_1][var_39_2], arg_39_0[var_39_3][var_39_4] = arg_39_0[var_39_3][nil], arg_39_0[var_39_1][nil]
	end

	return
end

function var_0_0.synchronousShipIndex(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs({
		TeamType.Vanguard,
		TeamType.Main,
		TeamType.Submarine
	}) do
		for iter_40_2 = 1, 3 do
			arg_40_0[iter_40_1][iter_40_2] = arg_40_1[iter_40_1][iter_40_2] and arg_40_0.ships[arg_40_1[iter_40_1][iter_40_2].id] or nil
		end
	end

	return
end

function var_0_0.isValid(arg_41_0)
	local var_41_0 = arg_41_0:getFleetType()

	if var_41_0 == FleetType.Normal then
		return _.any(arg_41_0[TeamType.Vanguard], function(arg_42_0)
			return arg_42_0.hpRant > 0
		end) and _.any(arg_41_0[TeamType.Main], function(arg_43_0)
			return arg_43_0.hpRant > 0
		end)
	elseif var_41_0 == FleetType.Submarine then
		return _.any(arg_41_0[TeamType.Submarine], function(arg_44_0)
			return arg_44_0.hpRant > 0
		end)
	elseif var_41_0 == FleetType.Support then
		return true
	end

	return false
end

function var_0_0.getCost(arg_45_0)
	local var_45_0 = {
		gold = 0,
		oil = 0
	}
	local var_45_1 = {
		gold = 0,
		oil = 0
	}

	_.each(arg_45_0:getShips(false), function(arg_46_0)
		var_45_0.oil = var_45_0.oil + arg_46_0:getStartBattleExpend()
		var_45_1.oil = var_45_1.oil + arg_46_0:getEndBattleExpend()

		return
	end)

	return {
		gold = 0,
		oil = 0
	}, {
		gold = 0,
		oil = 0
	}
end

function var_0_0.getInvestSums(arg_47_0, arg_47_1)
	return math.pow(_.reduce(arg_47_0:getShips(arg_47_1), 0, function(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_1:getProperties(arg_47_0:getCommanders())

		return arg_48_0 + var_48_0[AttributeType.Air] + var_48_0[AttributeType.Dodge]
	end), 0.6666666666666666)
end

function var_0_0.getDodgeSums(arg_49_0)
	return math.pow(_.reduce(arg_49_0:getShips(false), 0, function(arg_50_0, arg_50_1)
		return arg_50_0 + arg_50_1:getProperties(arg_49_0:getCommanders())[AttributeType.Dodge]
	end), 0.6666666666666666)
end

function var_0_0.getAntiAircraftSums(arg_51_0)
	return (_.reduce(arg_51_0:getShips(false), 0, function(arg_52_0, arg_52_1)
		return arg_52_0 + arg_52_1:getProperties(arg_51_0:getCommanders())[AttributeType.AntiAircraft]
	end))
end

function var_0_0.getAirSums(arg_53_0, arg_53_1)
	return (_.reduce(arg_53_0:getShips(arg_53_1), 0, function(arg_54_0, arg_54_1)
		return arg_54_0 + arg_54_1:getProperties(arg_53_0:getCommanders())[AttributeType.Air]
	end))
end

function var_0_0.getShipAmmo(arg_55_0)
	local var_55_0 = 0

	if arg_55_0:getFleetType() == FleetType.Normal then
		for iter_55_0, iter_55_1 in pairs(arg_55_0.ships) do
			var_55_0 = math.max(var_55_0, iter_55_1:getShipAmmo())
		end
	elseif arg_55_0:getFleetType() == FleetType.Submarine then
		for iter_55_2, iter_55_3 in pairs(arg_55_0.ships) do
			var_55_0 = var_55_0 + iter_55_3:getShipAmmo()
		end
	elseif arg_55_0:getFleetType() == FleetType.Support then
		var_55_0 = 0
	end

	return var_55_0
end

function var_0_0.clearShipHpChange(arg_56_0)
	for iter_56_0, iter_56_1 in pairs(arg_56_0.ships) do
		arg_56_0.ships[iter_56_1.id].hpChange = 0
	end

	return
end

function var_0_0.getEquipAmbushRateReduce(arg_57_0)
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in pairs(arg_57_0.ships) do
		for iter_57_2, iter_57_3 in pairs(iter_57_1:getActiveEquipments()) do
			if iter_57_3 then
				local var_57_1 = iter_57_3:getConfig("equip_parameters").ambush_extra or 0

				var_57_0 = math.max(var_57_0, var_57_1)
			end
		end
	end

	return var_57_0 / 16
end

function var_0_0.getEquipDodgeRateUp(arg_58_0)
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in pairs(arg_58_0.ships) do
		for iter_58_2, iter_58_3 in pairs(iter_58_1:getActiveEquipments()) do
			if iter_58_3 then
				local var_58_1 = iter_58_3:getConfig("equip_parameters").avoid_extra or 0

				var_58_0 = math.max(var_58_0, var_58_1)
			end
		end
	end

	return var_58_0 / 16
end

function var_0_0.isFormationDiffWith(arg_59_0, arg_59_1)
	for iter_59_0, iter_59_1 in ipairs({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}) do
		for iter_59_2 = 1, math.max(#arg_59_0[iter_59_1], #arg_59_1[iter_59_1]) do
			if arg_59_0[iter_59_1][iter_59_2] ~= arg_59_1[iter_59_1][iter_59_2] and (arg_59_0[iter_59_1][iter_59_2] == nil or arg_59_1[iter_59_1][iter_59_2] == nil or arg_59_0[iter_59_1][iter_59_2].id ~= arg_59_1[iter_59_1][iter_59_2].id) then
				return true
			end
		end
	end

	return false
end

function var_0_0.getShipIds(arg_60_0)
	local var_60_0 = {}
	local var_60_1 = arg_60_0:getFleetType()

	if var_60_1 == FleetType.Normal then
		_.each(arg_60_0[TeamType.Main], function(arg_61_0)
			table.insert(var_60_0, arg_61_0.id)

			return
		end)
		_.each(arg_60_0[TeamType.Vanguard], function(arg_62_0)
			table.insert(var_60_0, arg_62_0.id)

			return
		end)
	elseif var_60_1 == FleetType.Submarine then
		_.each(arg_60_0[TeamType.Submarine], function(arg_63_0)
			table.insert(var_60_0, arg_63_0.id)

			return
		end)
	elseif var_60_1 == FleetType.Support then
		for iter_60_0, iter_60_1 in pairs(arg_60_0.ships) do
			table.insert({}, iter_60_1.id)
		end
	end

	return {}
end

function var_0_0.containsSameKind(arg_64_0, arg_64_1)
	return arg_64_1 and _.any(_.values(arg_64_0.ships), function(arg_65_0)
		return arg_64_1:isSameKind(arg_65_0)
	end)
end

function var_0_0.increaseSlowSpeedFactor(arg_66_0)
	arg_66_0.slowSpeedFactor = arg_66_0.slowSpeedFactor + 1

	return
end

function var_0_0.getSpeed(arg_67_0)
	local var_67_0 = arg_67_0:triggerSkill(FleetSkill.TypeMoveSpeed) or 0

	return math.max(arg_67_0.baseSpeed + var_67_0 - arg_67_0.slowSpeedFactor, 1)
end

function var_0_0.calcBaseSpeed(arg_68_0)
	local var_68_0 = arg_68_0:getShips(true)
	local var_68_1 = _.reduce(var_68_0, 0, function(arg_69_0, arg_69_1)
		return arg_69_0 + arg_69_1:getProperties()[AttributeType.Speed]
	end) / #var_68_0 * (1 - 0.02 * (#var_68_0 - 1))
	local var_68_2
	local var_68_3
	local var_68_4 = arg_68_0:getFleetType()

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

function var_0_0.getDefeatCount(arg_70_0)
	return arg_70_0.defeatEnemies
end

function var_0_0.getStrategies(arg_71_0)
	local var_71_0 = arg_71_0:getOwnStrategies()

	for iter_71_0, iter_71_1 in pairs(arg_71_0.stgPicked) do
		local var_71_1 = var_71_0[iter_71_0] or 0

		var_71_0[iter_71_0] = var_71_1 + iter_71_1
	end

	for iter_71_2, iter_71_3 in pairs(arg_71_0.stgUsed) do
		if var_71_0[iter_71_2] then
			var_71_0[iter_71_2] = math.max(0, var_71_0[iter_71_2] - iter_71_3)
		end
	end

	for iter_71_4, iter_71_5 in pairs(ChapterConst.StrategyPresents) do
		var_71_0[iter_71_5] = var_71_0[iter_71_5] or 0
	end

	for iter_71_6, iter_71_7 in pairs(var_71_0) do
		table.insert({}, {
			id = iter_71_6,
			count = iter_71_7
		})
	end

	return _.sort({}, function(arg_72_0, arg_72_1)
		return arg_72_0.id < arg_72_1.id
	end)
end

function var_0_0.getOwnStrategies(arg_73_0)
	local var_73_0 = {}

	_.each(arg_73_0:getShips(true), function(arg_74_0)
		_.each(arg_74_0:getConfig("strategy_list"), function(arg_75_0)
			local var_75_0 = var_73_0[arg_75_0[1]] or 0

			var_73_0[arg_75_0[1]] = var_75_0 + arg_75_0[2]

			return
		end)

		return
	end)

	local var_73_1 = arg_73_0:triggerSkill(FleetSkill.TypeStrategy)

	if var_73_1 then
		_.each(var_73_1, function(arg_76_0)
			local var_76_0 = var_73_0[arg_76_0[1]] or 0

			var_73_0[arg_76_0[1]] = var_76_0 + arg_76_0[2]

			return
		end)
	end

	return {}
end

function var_0_0.achievedStrategy(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = arg_77_0.stgPicked[arg_77_1] or 0

	arg_77_0.stgPicked[arg_77_1] = var_77_0 + arg_77_2

	return
end

function var_0_0.consumeOneStrategy(arg_78_0, arg_78_1)
	local var_78_0 = arg_78_0:getOwnStrategies()

	if var_78_0[arg_78_1] and var_78_0[arg_78_1] > 0 then
		local var_78_1 = arg_78_0.stgUsed[arg_78_1] or 0

		arg_78_0.stgUsed[arg_78_1] = var_78_1 + 1
	else
		local var_78_2 = arg_78_0.stgPicked

		if arg_78_0.stgPicked[arg_78_1] then
			var_78_2[arg_78_1] = math.max(0, var_78_2[arg_78_1] - 1)
		end
	end

	return
end

function var_0_0.GetStrategyCount(arg_79_0, arg_79_1)
	local var_79_0 = _.detect(arg_79_0:getStrategies(), function(arg_80_0)
		return arg_80_0.id == arg_79_1
	end)

	if var_79_0 then
		return var_79_0.count or 0
	end
end

function var_0_0.getFormationStg(arg_81_0)
	return PlayerPrefs.GetInt("team_formation_" .. arg_81_0.id, 1)
end

function var_0_0.canUseStrategy(arg_82_0, arg_82_1)
	if pg.strategy_data_template[arg_82_1.id].type == ChapterConst.StgTypeForm then
		if arg_82_0:getFormationStg() == pg.strategy_data_template[arg_82_1.id].id then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_formation_active_already"))

			return false
		end
	elseif pg.strategy_data_template[arg_82_1.id].type == ChapterConst.StgTypeConsume or pg.strategy_data_template[arg_82_1.id].type == ChapterConst.StgTypeBindSupportConsume then
		if arg_82_1.count <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_not_enough"))

			return false
		end

		if pg.strategy_data_template[arg_82_1.id].id == ChapterConst.StrategyRepair and _.all(arg_82_0:getShips(true), function(arg_83_0)
			return arg_83_0.hpRant == 0 or arg_83_0.hpRant == 16
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("level_scene_full_hp"))

			return false
		end
	end

	return true
end

function var_0_0.getNextStgUser(arg_84_0, arg_84_1)
	return arg_84_0.id
end

function var_0_0.GetStatusStrategy(arg_85_0)
	return arg_85_0.stgIds
end

function var_0_0.getFleetType(arg_86_0)
	assert(arg_86_0.fleetType)

	return arg_86_0.fleetType
end

function var_0_0.canClearTorpedo(arg_87_0)
	return _.any(arg_87_0:getShipsByTeam(TeamType.Vanguard, true), function(arg_88_0)
		return ShipType.IsTypeQuZhu(arg_88_0:getShipType())
	end)
end

function var_0_0.getHuntingRange(arg_89_0, arg_89_1)
	if arg_89_0:getFleetType() ~= FleetType.Submarine then
		assert(false)

		return {}
	end

	local var_89_0 = arg_89_1 or arg_89_0.startPos
	local var_89_1 = arg_89_0:getShipsByTeam(TeamType.Submarine, true)[1]
	local var_89_2 = arg_89_0:triggerSkill(FleetSkill.TypeHuntingLv) or 0

	return (_.map(var_89_1:getHuntingRange(var_89_1:getHuntingLv() + var_89_2), function(arg_90_0)
		return {
			row = var_89_0.row + arg_90_0[1],
			column = var_89_0.column + arg_90_0[2]
		}
	end))
end

function var_0_0.inHuntingRange(arg_91_0, arg_91_1, arg_91_2)
	return _.any(arg_91_0:getHuntingRange(), function(arg_92_0)
		return arg_92_0.row == arg_91_1 and arg_92_0.column == arg_91_2
	end)
end

function var_0_0.getSummonCost(arg_93_0)
	return _.reduce(arg_93_0:getShips(false), 0, function(arg_94_0, arg_94_1)
		return arg_94_0 + arg_94_1:getEndBattleExpend()
	end)
end

function var_0_0.getMapAura(arg_95_0)
	for iter_95_0, iter_95_1 in pairs(arg_95_0.ships) do
		for iter_95_2, iter_95_3 in ipairs((iter_95_1:getMapAuras())) do
			table.insert({}, iter_95_3)
		end
	end

	return {}
end

function var_0_0.getMapAid(arg_96_0)
	for iter_96_0, iter_96_1 in pairs(arg_96_0.ships) do
		for iter_96_2, iter_96_3 in ipairs((iter_96_1:getMapAids())) do
			local var_96_0 = ({})[iter_96_1]

			if not ({})[iter_96_1] then
				var_96_0 = {}
			end

			table.insert(var_96_0, iter_96_3)

			;({})[iter_96_1] = var_96_0
		end
	end

	return {}
end

function var_0_0.updateCommanderSkills(arg_97_0)
	for iter_97_0, iter_97_1 in pairs((arg_97_0:getCommanders())) do
		_.each(iter_97_1:getSkills(), function(arg_98_0)
			_.each(arg_98_0:getTacticSkill(), function(arg_99_0)
				table.insert(arg_97_0.skills, FleetSkill.New(FleetSkill.SystemCommanderNeko, arg_99_0))

				return
			end)

			return
		end)
	end

	return
end

function var_0_0.getSkills(arg_100_0)
	return arg_100_0.skills
end

function var_0_0.getSkill(arg_101_0, arg_101_1)
	return _.detect(arg_101_0:getSkills(), function(arg_102_0)
		return arg_102_0.id == arg_101_1
	end)
end

function var_0_0.findSkills(arg_103_0, arg_103_1)
	return _.filter(arg_103_0:getSkills(), function(arg_104_0)
		return arg_104_0:GetType() == arg_103_1
	end)
end

function var_0_0.triggerSkill(arg_105_0, arg_105_1)
	return arg_105_0.chapter:triggerSkill(arg_105_0, arg_105_1)
end

function var_0_0.findCommanderBySkillId(arg_106_0, arg_106_1)
	for iter_106_0, iter_106_1 in pairs((arg_106_0:getCommanders())) do
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

function var_0_0.getFleetAirDominanceValue(arg_109_0)
	local var_109_0 = 0

	for iter_109_0, iter_109_1 in ipairs(arg_109_0:getShips(false)) do
		var_109_0 = var_109_0 + calcAirDominanceValue(iter_109_1, arg_109_0:getCommanders())
	end

	return var_109_0
end

function var_0_0.StaticTransformChapterFleet2Fleet(arg_110_0, arg_110_1)
	local var_110_0 = _.pluck(arg_110_0:getShipsByTeam(TeamType.Vanguard, arg_110_1), "id")

	table.insertto(var_110_0, _.pluck(arg_110_0:getShipsByTeam(TeamType.Main, arg_110_1), "id"))

	for iter_110_0, iter_110_1 in pairs(arg_110_0.commanders) do
		table.insert({}, {
			pos = iter_110_0,
			id = iter_110_1 and iter_110_1.id
		})
	end

	return TypedFleet.New({
		fleetType = FleetType.Normal,
		ship_list = var_110_0,
		commanders = {}
	})
end

return var_0_0
