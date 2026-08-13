class = var_0_10000

local var_0_0 = "ChapterFleet"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".LevelCellData"))

var_0_1.DUTY_CLEANPATH = 1
var_0_1.DUTY_KILLBOSS = 2
var_0_1.DUTY_KILLALL = 3
var_0_1.DUTY_IDLE = 4

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0

	arg_1_0.updateNpcShipList(var_1_0, arg_1_2)

	arg_1_0.id = arg_1_1.id
	arg_1_0.name = nil
	arg_1_0.fleetId = arg_1_1.fleet_id
	arg_1_0.fleetType = arg_1_1.fleetType

	if arg_1_1.fleet_id then
		getProxy = var_3
		FleetProxy = var_1_0

		local var_1_1 = var_3(var_1_0)

		if not var_3.getFleetById(var_1_1, arg_1_1.fleet_id) or not var_3:GetName() then
			Fleet = var_1_1
			var_1_1 = var_1_1.DEFAULT_NAME[arg_1_1.fleet_id]
		end

		arg_1_0.name = var_1_1
	end

	local var_1_2

	if not arg_1_0.name then
		Fleet = var_1_2
		var_1_2 = var_1_2.DEFAULT_NAME[arg_1_0.id]
	end

	arg_1_0.name = var_1_2

	local var_1_3 = {}
	local var_1_4 = {}
	local var_1_5 = {}

	_ = var_1_10006

	var_1_10006.each(arg_1_1.box_strategy_list, function(arg_2_0)
		var_1_3[arg_2_0.id] = arg_2_0.count

		return
	end)

	_ = var_6

	var_6.each(arg_1_1.ship_strategy_list, function(arg_3_0)
		var_1_4[arg_3_0.id] = arg_3_0.count

		return
	end)

	_ = var_6

	var_6.each(arg_1_1.strategy_ids, function(arg_4_0)
		pg = var_2_10001

		if var_2_10001.strategy_data_template[arg_4_0] then
			table = var_1

			var_1.insert(var_1_5, arg_4_0)
		end

		return
	end)

	_ = var_6

	if not var_6.detect(var_1_5, function(arg_5_0)
		pg = var_2_10001

		local var_5_0 = var_2_10001.strategy_data_template[arg_5_0].type

		ChapterConst = var_2_10002

		return var_5_0 == var_2_10002.StgTypeForm
	end) then
		table = var_6

		var_6.insert(var_1_5, arg_1_0:getFormationStg())
	end

	arg_1_0.stgPicked = var_1_3
	arg_1_0.stgUsed = var_1_4
	arg_1_0.stgIds = var_1_5
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
	Quaternion = var_6
	arg_1_0.rotation = var_6.identity
	arg_1_0.slowSpeedFactor = arg_1_1.move_step_down

	local var_1_6

	if not arg_1_1.kill_count then
		var_1_6 = 0
	end

	arg_1_0.defeatEnemies = var_1_6

	local var_1_7

	if not arg_1_1.vision_lv then
		var_1_7 = 0
	end

	arg_1_0.visibleLevel = var_1_7

	arg_1_0:updateCommanders(arg_1_1.commander_list)

	arg_1_0.skills = {}

	arg_1_0:updateCommanderSkills()

	return
end

function var_0_1.setup(arg_6_0, arg_6_1)
	arg_6_0.chapter = arg_6_1

	arg_6_0:UpdateVisible()

	return
end

function var_0_1.UpdateVisible(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getFleetType(var_7_0)

	FleetType = var_7_0

	if var_7_1 == var_7_0.Normal then
		local var_7_2 = arg_7_0.chapter

		var_1.UpdateCellsVisible(var_7_2, arg_7_0)
	end

	return
end

function var_0_1.GetFogVisibleLV(arg_8_0)
	pg = var_1_10001

	local var_8_0 = #var_1_10001.chapter_model_fog.all
	local var_8_1 = arg_8_0.visibleLevel

	pg = var_1_10003

	local var_8_2 = var_1_10003.chapter_model_fog

	math = var_1_10004

	return var_8_1, var_8_2[var_1_10004.min(arg_8_0.visibleLevel, var_8_0)]
end

function var_0_1.GetVisibleRange(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or arg_9_0.line

	local var_9_0, var_9_1 = arg_9_0:GetFogVisibleLV()

	underscore = var_1_10004

	return var_1_10004.map(var_9_1.vision_range, function(arg_10_0)
		unpack = var_2_10001

		local var_10_0, var_10_1 = var_2_10001(arg_10_0)

		return {
			row = arg_9_1.row + var_10_0,
			column = arg_9_1.column + var_10_1
		}
	end)
end

function var_0_1.fetchShipVO(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_0.npcShipList[arg_11_1] then
		Clone = var_3
		var_11_0 = var_3(arg_11_0.npcShipList[arg_11_1])
	else
		getProxy = var_3
		BayProxy = var_1_10004

		local var_11_1 = var_3(var_1_10004)

		var_11_0 = var_3.getShipById(var_11_1, arg_11_1)
	end

	if arg_11_0.staticsReady then
		var_11_0.triggers.TeamNumbers = arg_11_0.statics[var_11_0:getTeamType()].count
	end

	return var_11_0
end

function var_0_1.updateNpcShipList(arg_12_0, arg_12_1)
	arg_12_0.npcShipList = {}
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_1) do
		arg_12_0.npcShipList[iter_12_1.id] = iter_12_1
	end

	return
end

function var_0_1.GetLine(arg_13_0)
	return arg_13_0.line
end

function var_0_1.SetLine(arg_14_0, arg_14_1)
	arg_14_0.line = {
		row = arg_14_1.row,
		column = arg_14_1.column
	}

	arg_14_0:UpdateVisible()

	return
end

function var_0_1.updateCommanders(arg_15_0, arg_15_1)
	arg_15_0.commanders = {}
	getProxy = var_2
	CommanderProxy = var_1_10003

	local var_15_0 = var_2(var_1_10003)

	ipairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(arg_15_1) do
		local var_15_1 = iter_15_1.id

		if var_15_0:getCommanderById(var_15_1) then
			arg_15_0.commanders[iter_15_1.pos] = var_9
		end
	end

	return
end

function var_0_1.getCommanders(arg_16_0)
	local var_16_0

	if not arg_16_0.commanders then
		var_16_0 = {}
	end

	return var_16_0
end

function var_0_1.prepareShips(arg_17_0, arg_17_1)
	arg_17_0.statics = {}

	local var_17_0 = arg_17_0.statics

	TeamType = var_1_10003
	var_17_0[var_1_10003.Vanguard] = {
		count = 0
	}

	local var_17_1 = arg_17_0.statics

	TeamType = var_3
	var_17_1[var_3.Main] = {
		count = 0
	}

	local var_17_2 = arg_17_0.statics

	TeamType = var_3
	var_17_2[var_3.Submarine] = {
		count = 0
	}
	_ = var_17_2

	var_17_2.each(arg_17_1 or {}, function(arg_18_0)
		local var_18_0 = arg_17_0

		if var_1.fetchShipVO(var_18_0, arg_18_0.id) then
			var_2.count = arg_17_0.statics[var_1:getTeamType()].count + 1
		end

		return
	end)

	arg_17_0.staticsReady = true

	return
end

function var_0_1.updateShips(arg_19_0, arg_19_1)
	TeamType = var_1_10002
	arg_19_0[var_1_10002.Vanguard] = {}
	TeamType = var_2
	arg_19_0[var_2.Main] = {}
	TeamType = var_2
	arg_19_0[var_2.Submarine] = {}
	arg_19_0.ships = {}
	_ = var_2

	var_2.each(arg_19_1 or {}, function(arg_20_0)
		local var_20_0 = arg_19_0

		if var_1.fetchShipVO(var_20_0, arg_20_0.id) then
			var_1.hpRant = arg_20_0.hp_rant

			local var_20_1 = arg_19_0.ships

			var_20_1[var_1.id] = var_1
			table = var_20_1

			var_20_1.insert(arg_19_0[var_1:getTeamType()], var_1)
		end

		return
	end)
	arg_19_0:ResortShips()

	return
end

function var_0_1.ResortShips(arg_21_0)
	local var_21_0 = {}

	TeamType = var_1_10002
	var_21_0[1] = var_1_10002.Vanguard
	TeamType = var_2
	var_21_0[2] = var_2.Main
	TeamType = var_2
	var_21_0[3] = var_2.Submarine
	_ = var_2

	var_2.each(var_21_0, function(arg_22_0)
		local var_22_0 = arg_21_0[arg_22_0]
		local var_22_1 = {}

		table = var_2_10003

		var_2_10003.Ipairs(var_22_0, function(arg_23_0, arg_23_1)
			var_22_1[arg_23_1] = arg_23_0

			return
		end)

		table = var_3

		local var_22_2 = var_3.sort
		local var_22_3 = var_22_0

		CompareFuncs = var_5

		var_22_2(var_22_3, var_5({
			function(arg_24_0)
				return arg_24_0.hpRant > 0 and 0 or 1
			end,
			function(arg_25_0)
				return var_22_1[arg_25_0]
			end
		}))

		return
	end)

	return
end

function var_0_1.getTeamByName(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = arg_26_0[arg_26_1]

	ipairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(var_26_1) do
		table = var_1_10009

		var_1_10009.insert(var_26_0, iter_26_1.id)
	end

	return var_26_0
end

function var_0_1.flushShips(arg_27_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10002

	local var_27_0 = var_1_10001(var_1_10002)

	if not var_1.getFleetById(var_27_0, arg_27_0.fleetId) or var_2.name == "" or not var_2.name then
		Fleet = var_27_0

		if not var_27_0.DEFAULT_NAME[arg_27_0.fleetId] then
			Fleet = var_27_0
			var_27_0 = var_27_0.DEFAULT_NAME[arg_27_0.id]
		end
	end

	arg_27_0.name = var_27_0
	_ = var_27_0

	local var_27_1 = var_27_0.keys(arg_27_0.ships)

	ipairs = var_4

	for iter_27_0, iter_27_1 in var_4(var_27_1) do
		if arg_27_0:fetchShipVO(iter_27_1) then
			var_9.hpRant = arg_27_0.ships[iter_27_1].hpRant
		end

		arg_27_0.ships[iter_27_1] = var_9
	end

	local var_27_2 = {}

	_ = var_5

	local var_27_3 = var_5.each

	TeamType = var_6

	var_27_3(arg_27_0[var_6.Vanguard], function(arg_28_0)
		if arg_27_0.ships[arg_28_0.id] then
			table = var_1

			var_1.insert(var_27_2, arg_27_0.ships[arg_28_0.id])
		end

		return
	end)

	TeamType = var_27_3
	arg_27_0[var_27_3.Vanguard] = var_27_2

	local var_27_4 = {}

	_ = var_6

	local var_27_5 = var_6.each

	TeamType = var_7

	var_27_5(arg_27_0[var_7.Main], function(arg_29_0)
		if arg_27_0.ships[arg_29_0.id] then
			table = var_1

			var_1.insert(var_27_4, arg_27_0.ships[arg_29_0.id])
		end

		return
	end)

	TeamType = var_27_5
	arg_27_0[var_27_5.Main] = var_27_4

	local var_27_6 = {}

	_ = var_7

	local var_27_7 = var_7.each

	TeamType = var_8

	var_27_7(arg_27_0[var_8.Submarine], function(arg_30_0)
		if arg_27_0.ships[arg_30_0.id] then
			table = var_1

			var_1.insert(var_27_6, arg_27_0.ships[arg_30_0.id])
		end

		return
	end)

	TeamType = var_27_7
	arg_27_0[var_27_7.Submarine] = var_27_6

	return
end

function var_0_1.updateShipHp(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.ships[arg_31_1] then
		var_3.hpChange = arg_31_2 - var_3.hpRant
		var_3.hpRant = arg_31_2

		arg_31_0:ResortShips()
	end

	return
end

function var_0_1.getShip(arg_32_0, arg_32_1)
	return arg_32_0.ships[arg_32_1]
end

function var_0_1.getShips(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = arg_33_0
	local var_33_2 = arg_33_0.getFleetType(var_33_1)

	FleetType = var_33_1

	local var_33_3

	if var_33_2 == var_33_1.Normal then
		table = var_33_3
		var_33_3 = var_33_3.insertto

		local var_33_4 = var_33_0
		local var_33_5 = arg_33_0

		var_1_10006 = arg_33_0.getShipsByTeam
		TeamType = var_1_10008

		var_33_3(var_33_4, var_1_10006(var_33_5, var_1_10008.Main, arg_33_1))

		table = var_33_3
		var_33_3 = var_33_3.insertto

		local var_33_6 = var_33_0
		local var_33_7 = arg_33_0

		var_1_10006 = arg_33_0.getShipsByTeam
		TeamType = var_1_10008

		var_33_3(var_33_6, var_1_10006(var_33_7, var_1_10008.Vanguard, arg_33_1))
	else
		FleetType = var_33_3

		local var_33_8

		if var_33_2 == var_33_3.Submarine then
			table = var_33_8
			var_33_8 = var_33_8.insertto

			local var_33_9 = var_33_0
			local var_33_10 = arg_33_0

			var_1_10006 = arg_33_0.getShipsByTeam
			TeamType = var_1_10008

			var_33_8(var_33_9, var_1_10006(var_33_10, var_1_10008.Submarine, arg_33_1))
		else
			FleetType = var_33_8

			if var_33_2 == var_33_8.Support then
				ipairs = var_4

				local var_33_11 = {}

				TeamType = var_1_10006
				var_33_11[1] = var_1_10006.Main
				TeamType = var_6
				var_33_11[2] = var_6.Vanguard
				TeamType = var_6
				var_33_11[3] = var_6.Submarine

				for iter_33_0, iter_33_1 in var_4(var_33_11) do
					table = var_1_10009

					var_1_10009.insertto(var_33_0, arg_33_0:getShipsByTeam(iter_33_1, arg_33_1))
				end
			end
		end
	end

	return var_33_0
end

function var_0_1.getShipsByTeam(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {}
	local var_34_1 = {}

	ipairs = var_1_10005

	for iter_34_0, iter_34_1 in var_1_10005(arg_34_0[arg_34_1]) do
		if iter_34_1.hpRant > 0 then
			table = var_10

			var_10.insert(var_34_0, iter_34_1)
		else
			table = var_10

			var_10.insert(var_34_1, iter_34_1)
		end
	end

	if arg_34_2 then
		table = var_5

		var_5.insertto(var_34_0, var_34_1)
	end

	return var_34_0
end

function var_0_1.containsShip(arg_35_0, arg_35_1)
	return arg_35_0.ships[arg_35_1] and true or false
end

function var_0_1.replaceShip(arg_36_0, arg_36_1, arg_36_2)
	errorMsg = var_1_10003

	var_1_10003("ChapterFleet replaceShip function used")

	if arg_36_0.ships[arg_36_1] and not arg_36_0.ships[arg_36_2.id] then
		local var_36_0 = arg_36_0.ships[arg_36_1]

		if arg_36_0:fetchShipVO(arg_36_2.id) then
			if var_4:getTeamType() == var_36_0:getTeamType() then
				if not var_36_0:isSameKind(var_4) and arg_36_0:containsSameKind(var_4) then
					arg_36_0:removeShip(arg_36_1)
				else
					var_4.hpRant = arg_36_2.hp_rant
					arg_36_0.ships[arg_36_1] = nil
					arg_36_0.ships[var_4.id] = var_4

					local var_36_1 = arg_36_0[var_4:getTeamType()]

					for iter_36_0 = 1, #var_36_1 do
						if var_36_1[iter_36_0].id == arg_36_1 then
							var_36_1[iter_36_0] = var_4

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

function var_0_1.addShip(arg_37_0, arg_37_1)
	errorMsg = var_1_10002

	var_1_10002("ChapterFleet addShip function used")

	if not arg_37_0.ships[arg_37_1.id] and arg_37_0:fetchShipVO(arg_37_1.id) then
		var_2.hpRant = arg_37_1.hp_rant

		if #arg_37_0[var_2:getTeamType()] < 3 then
			table = var_4

			var_4.insert(var_3, var_2)

			arg_37_0.ships[var_2.id] = var_2

			arg_37_0:ResortShips()
		end
	end

	return
end

function var_0_1.removeShip(arg_38_0, arg_38_1)
	errorMsg = var_1_10002

	var_1_10002("ChapterFleet removeShip function used")

	arg_38_0.ships[arg_38_1] = nil

	local var_38_0 = {}

	TeamType = var_3
	var_38_0[1] = var_3.Vanguard
	TeamType = var_3
	var_38_0[2] = var_3.Main
	TeamType = var_3
	var_38_0[3] = var_3.Submarine

	for iter_38_0 = 1, #var_38_0 do
		for iter_38_1 = #arg_38_0[var_38_0[iter_38_0]], 1, -1 do
			if var_7[iter_38_1].id == arg_38_1 then
				table = var_12

				var_12.remove(var_7, iter_38_1)
			end
		end
	end

	return
end

function var_0_1.switchShip(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_0:getShipsByTeam(arg_39_1, false)[arg_39_2].id
	local var_39_1 = var_4[arg_39_3].id
	local var_39_2
	local var_39_3
	local var_39_4
	local var_39_5

	pairs = var_1_10011

	for iter_39_0, iter_39_1 in var_1_10011(arg_39_0.ships) do
		if iter_39_0 == var_39_0 then
			var_39_2 = iter_39_1:getTeamType()
			table = var_16
			var_39_3 = var_16.indexof(arg_39_0[var_39_2], iter_39_1)
		end

		if iter_39_0 == var_39_1 then
			var_39_4 = iter_39_1:getTeamType()
			table = var_16
			var_39_5 = var_16.indexof(arg_39_0[var_39_4], iter_39_1)
		end
	end

	assert = var_11

	var_11(var_39_3 and var_39_5)

	if var_39_2 == var_39_4 and var_39_3 ~= var_39_5 then
		arg_39_0[var_39_2][var_39_3], arg_39_0[var_39_4][var_39_5] = arg_39_0[var_39_4][var_39_5], arg_39_0[var_39_2][var_39_3]
	end

	return
end

function var_0_1.synchronousShipIndex(arg_40_0, arg_40_1)
	local var_40_0 = {}

	TeamType = var_1_10003
	var_40_0[1] = var_1_10003.Vanguard
	TeamType = var_3
	var_40_0[2] = var_3.Main
	TeamType = var_3
	var_40_0[3] = var_3.Submarine
	ipairs = var_3

	for iter_40_0, iter_40_1 in var_3(var_40_0) do
		for iter_40_2 = 1, 3 do
			if arg_40_1[iter_40_1][iter_40_2] then
				local var_40_1 = arg_40_1[iter_40_1][iter_40_2].id

				arg_40_0[iter_40_1][iter_40_2] = arg_40_0.ships[var_40_1]
			else
				arg_40_0[iter_40_1][iter_40_2] = nil
			end
		end
	end

	return
end

function var_0_1.isValid(arg_41_0)
	local var_41_0 = arg_41_0
	local var_41_1 = arg_41_0.getFleetType(var_41_0)

	FleetType = var_41_0

	local var_41_2

	if var_41_1 == var_41_0.Normal then
		_ = var_41_2
		var_41_2 = var_41_2.any
		TeamType = var_1_10003

		if var_41_2(arg_41_0[var_1_10003.Vanguard], function(arg_42_0)
			return arg_42_0.hpRant > 0
		end) then
			_ = var_41_2
			var_41_2 = var_41_2.any
			TeamType = var_1_10003
			var_41_2 = var_41_2(arg_41_0[var_1_10003.Main], function(arg_43_0)
				return arg_43_0.hpRant > 0
			end)
		end

		return var_41_2
	else
		FleetType = var_41_2

		local var_41_3

		if var_41_1 == var_41_2.Submarine then
			_ = var_41_3
			var_41_3 = var_41_3.any
			TeamType = var_1_10003

			return var_41_3(arg_41_0[var_1_10003.Submarine], function(arg_44_0)
				return arg_44_0.hpRant > 0
			end)
		else
			FleetType = var_41_3

			if var_41_1 == var_41_3.Support then
				return true
			end
		end
	end

	return false
end

function var_0_1.getCost(arg_45_0)
	local var_45_0 = {
		gold = 0,
		oil = 0
	}
	local var_45_1 = {
		gold = 0,
		oil = 0
	}
	local var_45_2 = arg_45_0
	local var_45_3 = arg_45_0.getShips(var_45_2, false)

	_ = var_45_2

	var_45_2.each(var_45_3, function(arg_46_0)
		var_45_0.oil = var_45_0.oil + arg_46_0:getStartBattleExpend()
		var_45_1.oil = var_45_1.oil + arg_46_0:getEndBattleExpend()

		return
	end)

	return var_45_0, var_45_1
end

function var_0_1.getInvestSums(arg_47_0, arg_47_1)
	local function var_47_0(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_1
		local var_48_1 = arg_48_1.getProperties
		local var_48_2 = arg_47_0
		local var_48_3 = var_48_1(var_48_0, var_4.getCommanders(var_48_2))

		AttributeType = var_48_0

		local var_48_4 = arg_48_0 + var_48_3[var_48_0.Air]

		AttributeType = var_4

		return var_48_4 + var_48_3[var_4.Dodge]
	end

	_ = var_1_10003

	local var_47_1 = var_1_10003.reduce(arg_47_0:getShips(arg_47_1), 0, var_47_0)

	math = var_4

	return var_4.pow(var_47_1, 0.6666666666666666)
end

function var_0_1.getDodgeSums(arg_49_0)
	local function var_49_0(arg_50_0, arg_50_1)
		local var_50_0 = arg_50_1
		local var_50_1 = arg_50_1.getProperties
		local var_50_2 = arg_49_0
		local var_50_3 = var_50_1(var_50_0, var_4.getCommanders(var_50_2))

		AttributeType = var_50_0

		return arg_50_0 + var_50_3[var_50_0.Dodge]
	end

	_ = var_1_10002

	local var_49_1 = var_1_10002.reduce(arg_49_0:getShips(false), 0, var_49_0)

	math = var_3

	return var_3.pow(var_49_1, 0.6666666666666666)
end

function var_0_1.getAntiAircraftSums(arg_51_0)
	local function var_51_0(arg_52_0, arg_52_1)
		local var_52_0 = arg_52_1
		local var_52_1 = arg_52_1.getProperties
		local var_52_2 = arg_51_0
		local var_52_3 = var_52_1(var_52_0, var_4.getCommanders(var_52_2))

		AttributeType = var_52_0

		return arg_52_0 + var_52_3[var_52_0.AntiAircraft]
	end

	_ = var_1_10002

	return (var_1_10002.reduce(arg_51_0:getShips(false), 0, var_51_0))
end

function var_0_1.getAirSums(arg_53_0, arg_53_1)
	local function var_53_0(arg_54_0, arg_54_1)
		local var_54_0 = arg_54_1
		local var_54_1 = arg_54_1.getProperties
		local var_54_2 = arg_53_0
		local var_54_3 = var_54_1(var_54_0, var_4.getCommanders(var_54_2))

		AttributeType = var_54_0

		return arg_54_0 + var_54_3[var_54_0.Air]
	end

	_ = var_1_10003

	return (var_1_10003.reduce(arg_53_0:getShips(arg_53_1), 0, var_53_0))
end

function var_0_1.getShipAmmo(arg_55_0)
	local var_55_0 = 0
	local var_55_1 = arg_55_0
	local var_55_2 = arg_55_0.getFleetType(var_55_1)

	FleetType = var_55_1

	if var_55_2 == var_55_1.Normal then
		pairs = var_55_2

		for iter_55_0, iter_55_1 in var_55_2(arg_55_0.ships) do
			math = var_1_10007
			var_55_0 = var_1_10007.max(var_55_0, iter_55_1:getShipAmmo())
		end
	else
		local var_55_3 = arg_55_0
		local var_55_4 = arg_55_0.getFleetType(var_55_3)

		FleetType = var_55_3

		if var_55_4 == var_55_3.Submarine then
			pairs = var_55_4

			for iter_55_2, iter_55_3 in var_55_4(arg_55_0.ships) do
				var_55_0 = var_55_0 + iter_55_3:getShipAmmo()
			end
		else
			local var_55_5 = arg_55_0
			local var_55_6 = arg_55_0.getFleetType(var_55_5)

			FleetType = var_55_5

			if var_55_6 == var_55_5.Support then
				var_55_0 = 0
			end
		end
	end

	return var_55_0
end

function var_0_1.clearShipHpChange(arg_56_0)
	pairs = var_1_10001

	for iter_56_0, iter_56_1 in var_1_10001(arg_56_0.ships) do
		arg_56_0.ships[iter_56_1.id].hpChange = 0
	end

	return
end

function var_0_1.getEquipAmbushRateReduce(arg_57_0)
	local var_57_0 = 0

	pairs = var_1_10002

	for iter_57_0, iter_57_1 in var_1_10002(arg_57_0.ships) do
		pairs = var_1_10007

		for iter_57_2, iter_57_3 in var_1_10007(iter_57_1:getActiveEquipments()) do
			if iter_57_3 then
				math = var_1_10012
				var_1_10012 = var_1_10012.max

				local var_57_1 = var_57_0
				local var_57_2

				if not iter_57_3:getConfig("equip_parameters").ambush_extra then
					var_57_2 = 0
				end

				var_57_0 = var_1_10012(var_57_1, var_57_2)
			end
		end
	end

	return var_57_0 / 16
end

function var_0_1.getEquipDodgeRateUp(arg_58_0)
	local var_58_0 = 0

	pairs = var_1_10002

	for iter_58_0, iter_58_1 in var_1_10002(arg_58_0.ships) do
		pairs = var_1_10007

		for iter_58_2, iter_58_3 in var_1_10007(iter_58_1:getActiveEquipments()) do
			if iter_58_3 then
				math = var_1_10012
				var_1_10012 = var_1_10012.max

				local var_58_1 = var_58_0
				local var_58_2

				if not iter_58_3:getConfig("equip_parameters").avoid_extra then
					var_58_2 = 0
				end

				var_58_0 = var_1_10012(var_58_1, var_58_2)
			end
		end
	end

	return var_58_0 / 16
end

function var_0_1.isFormationDiffWith(arg_59_0, arg_59_1)
	local var_59_0 = {}

	TeamType = var_1_10003
	var_59_0[1] = var_1_10003.Main
	TeamType = var_3
	var_59_0[2] = var_3.Vanguard
	TeamType = var_3
	var_59_0[3] = var_3.Submarine
	ipairs = var_3

	for iter_59_0, iter_59_1 in var_3(var_59_0) do
		local var_59_1 = arg_59_0[iter_59_1]
		local var_59_2 = arg_59_1[iter_59_1]
		local var_59_3 = 1

		math = var_1_10011

		for iter_59_2 = var_59_3, var_1_10011.max(#var_59_1, #var_59_2) do
			if var_59_1[iter_59_2] ~= var_59_2[iter_59_2] and (var_59_1[iter_59_2] == nil or var_59_2[iter_59_2] == nil or var_59_1[iter_59_2].id ~= var_59_2[iter_59_2].id) then
				return true
			end
		end
	end

	return false
end

function var_0_1.getShipIds(arg_60_0)
	local var_60_0 = {}
	local var_60_1 = arg_60_0
	local var_60_2 = arg_60_0.getFleetType(var_60_1)

	FleetType = var_60_1

	local var_60_3

	if var_60_2 == var_60_1.Normal then
		_ = var_60_3
		var_60_3 = var_60_3.each
		TeamType = var_1_10004

		var_60_3(arg_60_0[var_1_10004.Main], function(arg_61_0)
			table = var_2_10001

			var_2_10001.insert(var_60_0, arg_61_0.id)

			return
		end)

		_ = var_60_3
		var_60_3 = var_60_3.each
		TeamType = var_1_10004

		var_60_3(arg_60_0[var_1_10004.Vanguard], function(arg_62_0)
			table = var_2_10001

			var_2_10001.insert(var_60_0, arg_62_0.id)

			return
		end)
	else
		FleetType = var_60_3

		local var_60_4

		if var_60_2 == var_60_3.Submarine then
			_ = var_60_4
			var_60_4 = var_60_4.each
			TeamType = var_1_10004

			var_60_4(arg_60_0[var_1_10004.Submarine], function(arg_63_0)
				table = var_2_10001

				var_2_10001.insert(var_60_0, arg_63_0.id)

				return
			end)
		else
			FleetType = var_60_4

			if var_60_2 == var_60_4.Support then
				pairs = var_3

				for iter_60_0, iter_60_1 in var_3(arg_60_0.ships) do
					table = var_1_10008

					var_1_10008.insert(var_60_0, iter_60_1.id)
				end
			end
		end
	end

	return var_60_0
end

function var_0_1.containsSameKind(arg_64_0, arg_64_1)
	local var_64_0

	if arg_64_1 then
		::label_64_0::

		_ = var_64_0
		var_64_0 = var_64_0.any
		_ = var_1_10003
		var_64_0 = var_64_0(var_1_10003.values(arg_64_0.ships), function(arg_65_0)
			local var_65_0 = arg_64_1

			return var_1.isSameKind(var_65_0, arg_65_0)
		end)
	end

	return var_64_0
end

function var_0_1.increaseSlowSpeedFactor(arg_66_0)
	arg_66_0.slowSpeedFactor = arg_66_0.slowSpeedFactor + 1

	return
end

function var_0_1.getSpeed(arg_67_0)
	local var_67_0 = arg_67_0
	local var_67_1 = arg_67_0.triggerSkill

	FleetSkill = var_1_10003

	local var_67_2

	if not var_67_1(var_67_0, var_1_10003.TypeMoveSpeed) then
		var_67_2 = 0
	end

	math = var_67_0

	return var_67_0.max(arg_67_0.baseSpeed + var_67_2 - arg_67_0.slowSpeedFactor, 1)
end

function var_0_1.calcBaseSpeed(arg_68_0)
	local var_68_0 = arg_68_0
	local var_68_1 = arg_68_0.getShips(var_68_0, true)

	_ = var_68_0

	local var_68_2 = var_68_0.reduce(var_68_1, 0, function(arg_69_0, arg_69_1)
		local var_69_0 = arg_69_1
		local var_69_1 = arg_69_1.getProperties(var_69_0)

		AttributeType = var_69_0

		return arg_69_0 + var_69_1[var_69_0.Speed]
	end) / #var_68_1 * (1 - 0.02 * (#var_68_1 - 1))
	local var_68_3
	local var_68_4
	local var_68_5 = arg_68_0
	local var_68_6 = arg_68_0.getFleetType(var_68_5)

	FleetType = var_68_5

	if var_68_6 == var_68_5.Normal then
		pg = var_6
		var_68_3 = var_6.gameset.chapter_move_speed_1.key_value
		pg = var_6
		var_68_4 = var_6.gameset.chapter_move_speed_2.key_value
	else
		FleetType = var_6

		if var_68_6 == var_6.Submarine then
			pg = var_6
			var_68_3 = var_6.gameset.submarine_move_speed_1.key_value
			pg = var_6
			var_68_4 = var_6.gameset.submarine_move_speed_2.key_value
		else
			FleetType = var_6

			if var_68_6 == var_6.Support then
				pg = var_6
				var_68_3 = var_6.gameset.chapter_move_speed_1.key_value
				pg = var_6
				var_68_4 = var_6.gameset.chapter_move_speed_2.key_value
			end
		end
	end

	if var_68_2 <= var_68_3 then
		return 2
	elseif var_68_4 < var_68_2 then
		return 4
	else
		return 3
	end

	return
end

function var_0_1.getDefeatCount(arg_70_0)
	return arg_70_0.defeatEnemies
end

function var_0_1.getStrategies(arg_71_0)
	local var_71_0 = arg_71_0
	local var_71_1 = arg_71_0.getOwnStrategies(var_71_0)

	pairs = var_71_0

	for iter_71_0, iter_71_1 in var_71_0(arg_71_0.stgPicked) do
		local var_71_2

		if not var_71_1[iter_71_0] then
			var_71_2 = 0
		end

		var_71_1[iter_71_0] = var_71_2 + iter_71_1
	end

	pairs = var_2

	for iter_71_2, iter_71_3 in var_2(arg_71_0.stgUsed) do
		if var_71_1[iter_71_2] then
			math = var_7
			var_71_1[iter_71_2] = var_7.max(0, var_71_1[iter_71_2] - iter_71_3)
		end
	end

	pairs = var_2
	ChapterConst = var_3

	for iter_71_4, iter_71_5 in var_2(var_3.StrategyPresents) do
		local var_71_3

		if not var_71_1[iter_71_5] then
			var_71_3 = 0
		end

		var_71_1[iter_71_5] = var_71_3
	end

	local var_71_4 = {}

	pairs = var_3

	for iter_71_6, iter_71_7 in var_3(var_71_1) do
		table = var_1_10008

		var_1_10008.insert(var_71_4, {
			id = iter_71_6,
			count = iter_71_7
		})
	end

	_ = var_3

	return var_3.sort(var_71_4, function(arg_72_0, arg_72_1)
		return arg_72_0.id < arg_72_1.id
	end)
end

function var_0_1.getOwnStrategies(arg_73_0)
	local var_73_0 = {}
	local var_73_1 = arg_73_0
	local var_73_2 = arg_73_0.getShips(var_73_1, true)

	_ = var_73_1

	var_73_1.each(var_73_2, function(arg_74_0)
		local var_74_0 = arg_74_0
		local var_74_1 = arg_74_0.getConfig(var_74_0, "strategy_list")

		_ = var_74_0

		var_74_0.each(var_74_1, function(arg_75_0)
			local var_75_0 = var_73_0
			local var_75_1 = arg_75_0[1]
			local var_75_2

			if not var_73_0[arg_75_0[1]] then
				var_75_2 = 0
			end

			var_75_0[var_75_1] = var_75_2 + arg_75_0[2]

			return
		end)

		return
	end)

	local var_73_3 = arg_73_0
	local var_73_4 = arg_73_0.triggerSkill

	FleetSkill = var_5

	if var_73_4(var_73_3, var_5.TypeStrategy) then
		_ = var_73_3

		var_73_3.each(var_3, function(arg_76_0)
			local var_76_0 = var_73_0
			local var_76_1 = arg_76_0[1]
			local var_76_2

			if not var_73_0[arg_76_0[1]] then
				var_76_2 = 0
			end

			var_76_0[var_76_1] = var_76_2 + arg_76_0[2]

			return
		end)
	end

	return var_73_0
end

function var_0_1.achievedStrategy(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = arg_77_0.stgPicked
	local var_77_1

	if not arg_77_0.stgPicked[arg_77_1] then
		var_77_1 = 0
	end

	var_77_0[arg_77_1] = var_77_1 + arg_77_2

	return
end

function var_0_1.consumeOneStrategy(arg_78_0, arg_78_1)
	if arg_78_0:getOwnStrategies()[arg_78_1] and var_2[arg_78_1] > 0 then
		local var_78_0

		if not arg_78_0.stgUsed[arg_78_1] then
			var_78_0 = 0
		end

		var_3[arg_78_1] = var_78_0 + 1
	elseif arg_78_0.stgPicked[arg_78_1] then
		math = var_4
		var_3[arg_78_1] = var_4.max(0, var_3[arg_78_1] - 1)
	end

	return
end

function var_0_1.GetStrategyCount(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.getStrategies(var_79_0)

	_ = var_79_0

	local var_79_2

	if not var_79_0.detect(var_79_1, function(arg_80_0)
		return arg_80_0.id == arg_79_1
	end) or not var_3.count then
		var_79_2 = 0
	end

	return var_79_2
end

function var_0_1.getFormationStg(arg_81_0)
	PlayerPrefs = var_1_10001

	return var_1_10001.GetInt("team_formation_" .. arg_81_0.id, 1)
end

function var_0_1.canUseStrategy(arg_82_0, arg_82_1)
	pg = var_1_10002

	local var_82_0 = var_1_10002.strategy_data_template[arg_82_1.id].type

	ChapterConst = var_1_10004

	local var_82_1

	if var_82_0 == var_1_10004.StgTypeForm then
		var_82_1 = arg_82_0

		if arg_82_0.getFormationStg(var_82_1) == var_2.id then
			pg = var_3
			var_82_1 = var_3.TipsMgr.GetInstance()

			local var_82_2 = var_3.ShowTips

			i18n = var_1_10005

			var_82_2(var_82_1, var_1_10005("level_scene_formation_active_already"))

			return false
		end

		goto label_82_0
	end

	local var_82_3 = var_2.type

	ChapterConst = var_82_1

	if var_82_3 ~= var_82_1.StgTypeConsume then
		do
			local var_82_4 = var_2.type

			ChapterConst = var_4

			if var_82_4 == var_4.StgTypeBindSupportConsume then
				local var_82_5

				if arg_82_1.count <= 0 then
					pg = var_3
					var_82_5 = var_3.TipsMgr.GetInstance()

					local var_82_6 = var_3.ShowTips

					i18n = var_1_10005

					var_82_6(var_82_5, var_1_10005("level_scene_not_enough"))

					return false
				end

				local var_82_7 = var_2.id

				ChapterConst = var_82_5

				if var_82_7 == var_82_5.StrategyRepair then
					_ = var_82_7

					if var_82_7.all(arg_82_0:getShips(true), function(arg_83_0)
						return arg_83_0.hpRant == 0 or arg_83_0.hpRant == 16
					end) then
						pg = var_3

						local var_82_8 = var_3.TipsMgr.GetInstance()
						local var_82_9 = var_3.ShowTips

						i18n = var_5

						var_82_9(var_82_8, var_5("level_scene_full_hp"))

						return false
					end
				end
			end
		end

		::label_82_0::

		return true
	end
end

function var_0_1.getNextStgUser(arg_84_0, arg_84_1)
	return arg_84_0.id
end

function var_0_1.GetStatusStrategy(arg_85_0)
	return arg_85_0.stgIds
end

function var_0_1.getFleetType(arg_86_0)
	assert = var_1_10001

	var_1_10001(arg_86_0.fleetType)

	return arg_86_0.fleetType
end

function var_0_1.canClearTorpedo(arg_87_0)
	local var_87_0 = arg_87_0
	local var_87_1 = arg_87_0.getShipsByTeam

	TeamType = var_1_10003

	local var_87_2 = var_87_1(var_87_0, var_1_10003.Vanguard, true)

	_ = var_87_0

	return var_87_0.any(var_87_2, function(arg_88_0)
		ShipType = var_2_10001

		return var_2_10001.IsTypeQuZhu(arg_88_0:getShipType())
	end)
end

function var_0_1.getHuntingRange(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_0
	local var_89_1 = arg_89_0.getFleetType(var_89_0)

	FleetType = var_89_0

	if var_89_1 ~= var_89_0.Submarine then
		assert = var_89_1

		var_89_1(false)

		return {}
	end

	local var_89_2 = arg_89_1 or arg_89_0.startPos
	local var_89_3 = arg_89_0
	local var_89_4 = arg_89_0.getShipsByTeam

	TeamType = var_1_10005

	local var_89_5 = var_89_4(var_89_3, var_1_10005.Submarine, true)[1]
	local var_89_6 = arg_89_0
	local var_89_7 = arg_89_0.triggerSkill

	FleetSkill = var_6

	local var_89_8

	if not var_89_7(var_89_6, var_6.TypeHuntingLv) then
		var_89_8 = 0
	end

	local var_89_9 = var_89_5
	local var_89_10 = var_89_5.getHuntingRange(var_89_9, var_89_5:getHuntingLv() + var_89_8)

	_ = var_89_9

	return (var_89_9.map(var_89_10, function(arg_90_0)
		return {
			row = var_89_2.row + arg_90_0[1],
			column = var_89_2.column + arg_90_0[2]
		}
	end))
end

function var_0_1.inHuntingRange(arg_91_0, arg_91_1, arg_91_2)
	_ = var_1_10003

	return var_1_10003.any(arg_91_0:getHuntingRange(), function(arg_92_0)
		return arg_92_0.row == arg_91_1 and arg_92_0.column == arg_91_2
	end)
end

function var_0_1.getSummonCost(arg_93_0)
	local var_93_0 = arg_93_0
	local var_93_1 = arg_93_0.getShips(var_93_0, false)

	_ = var_93_0

	return var_93_0.reduce(var_93_1, 0, function(arg_94_0, arg_94_1)
		return arg_94_0 + arg_94_1:getEndBattleExpend()
	end)
end

function var_0_1.getMapAura(arg_95_0)
	local var_95_0 = {}

	pairs = var_1_10002

	for iter_95_0, iter_95_1 in var_1_10002(arg_95_0.ships) do
		local var_95_1 = iter_95_1
		local var_95_2 = iter_95_1.getMapAuras(var_95_1)

		ipairs = var_95_1

		for iter_95_2, iter_95_3 in var_95_1(var_95_2) do
			table = var_1_10013

			var_1_10013.insert(var_95_0, iter_95_3)
		end
	end

	return var_95_0
end

function var_0_1.getMapAid(arg_96_0)
	local var_96_0 = {}

	pairs = var_1_10002

	for iter_96_0, iter_96_1 in var_1_10002(arg_96_0.ships) do
		local var_96_1 = iter_96_1
		local var_96_2 = iter_96_1.getMapAids(var_96_1)

		ipairs = var_96_1

		for iter_96_2, iter_96_3 in var_96_1(var_96_2) do
			local var_96_3

			if not var_96_0[iter_96_1] then
				var_96_3 = {}
			end

			table = var_1_10014

			var_1_10014.insert(var_96_3, iter_96_3)

			var_96_0[iter_96_1] = var_96_3
		end
	end

	return var_96_0
end

function var_0_1.updateCommanderSkills(arg_97_0)
	local var_97_0 = arg_97_0
	local var_97_1 = arg_97_0.getCommanders(var_97_0)

	pairs = var_97_0

	for iter_97_0, iter_97_1 in var_97_0(var_97_1) do
		_ = var_1_10007

		var_1_10007.each(iter_97_1:getSkills(), function(arg_98_0)
			_ = var_2_10001

			var_2_10001.each(arg_98_0:getTacticSkill(), function(arg_99_0)
				table = var_3_10001

				local var_99_0 = var_3_10001.insert
				local var_99_1 = arg_97_0.skills

				FleetSkill = var_3_10003

				local var_99_2 = var_3_10003.New

				FleetSkill = var_3_10004

				var_99_0(var_99_1, var_99_2(var_3_10004.SystemCommanderNeko, arg_99_0))

				return
			end)

			return
		end)
	end

	return
end

function var_0_1.getSkills(arg_100_0)
	return arg_100_0.skills
end

function var_0_1.getSkill(arg_101_0, arg_101_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_101_0:getSkills(), function(arg_102_0)
		return arg_102_0.id == arg_101_1
	end)
end

function var_0_1.findSkills(arg_103_0, arg_103_1)
	_ = var_1_10002

	return var_1_10002.filter(arg_103_0:getSkills(), function(arg_104_0)
		return arg_104_0:GetType() == arg_103_1
	end)
end

function var_0_1.triggerSkill(arg_105_0, arg_105_1)
	local var_105_0 = arg_105_0.chapter

	return var_2.triggerSkill(var_105_0, arg_105_0, arg_105_1)
end

function var_0_1.findCommanderBySkillId(arg_106_0, arg_106_1)
	local var_106_0 = arg_106_0
	local var_106_1 = arg_106_0.getCommanders(var_106_0)

	pairs = var_106_0

	for iter_106_0, iter_106_1 in var_106_0(var_106_1) do
		_ = var_1_10008

		if var_1_10008.any(iter_106_1:getSkills(), function(arg_107_0)
			_ = var_2_10001

			return var_2_10001.any(arg_107_0:getTacticSkill(), function(arg_108_0)
				return arg_108_0 == arg_106_1
			end)
		end) then
			return iter_106_1
		end
	end

	return
end

function var_0_1.getFleetAirDominanceValue(arg_109_0)
	local var_109_0 = 0

	ipairs = var_1_10002

	for iter_109_0, iter_109_1 in var_1_10002(arg_109_0:getShips(false)) do
		calcAirDominanceValue = var_1_10007
		var_109_0 = var_109_0 + var_1_10007(iter_109_1, arg_109_0:getCommanders())
	end

	return var_109_0
end

function var_0_1.StaticTransformChapterFleet2Fleet(arg_110_0, arg_110_1)
	_ = var_1_10002

	local var_110_0 = var_1_10002.pluck
	local var_110_1 = arg_110_0
	local var_110_2 = arg_110_0.getShipsByTeam

	TeamType = var_1_10005

	local var_110_3 = var_110_0(var_110_2(var_110_1, var_1_10005.Vanguard, arg_110_1), "id")

	table = var_3

	local var_110_4 = var_3.insertto
	local var_110_5 = var_110_3

	_ = var_5

	local var_110_6 = var_5.pluck
	local var_110_7 = arg_110_0
	local var_110_8 = arg_110_0.getShipsByTeam

	TeamType = var_1_10008

	var_110_4(var_110_5, var_110_6(var_110_8(var_110_7, var_1_10008.Main, arg_110_1), "id"))

	local var_110_9 = {}

	pairs = var_110_5

	for iter_110_0, iter_110_1 in var_110_5(arg_110_0.commanders) do
		table = var_9

		var_9.insert(var_110_9, {
			pos = iter_110_0,
			id = iter_110_1 and iter_110_1.id
		})
	end

	TypedFleet = var_4

	local var_110_10 = var_4.New
	local var_110_11 = {}

	FleetType = var_6
	var_110_11.fleetType = var_6.Normal
	var_110_11.ship_list = var_110_3
	var_110_11.commanders = var_110_9

	return var_110_10(var_110_11)
end

return var_0_1
