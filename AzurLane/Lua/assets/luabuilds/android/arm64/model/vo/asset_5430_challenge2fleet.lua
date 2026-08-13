class = var_0_10000

local var_0_0 = "Challenge2Fleet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Fleet"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id

	arg_1_0:updateShips(arg_1_1.ships)

	arg_1_0.commanderList = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.commanders then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		local var_1_1 = arg_1_0.commanderList
		local var_1_2 = iter_1_1.pos

		Commander = var_1_10009
		var_1_1[var_1_2] = var_1_10009.New(iter_1_1.commanderinfo)
	end

	arg_1_0.skills = {}

	arg_1_0:updateCommanderSkills()

	return
end

function var_0_1.getShipsByTeam(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {}

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_0[arg_2_1]) do
		if iter_2_1.hpRant > 0 then
			var_2_0[#var_2_0 + 1] = iter_2_1
		end
	end

	if arg_2_2 then
		ipairs = var_4

		for iter_2_2, iter_2_3 in var_4(arg_2_0[arg_2_1]) do
			if iter_2_3.hpRant <= 0 then
				var_2_0[#var_2_0 + 1] = iter_2_3
			end
		end
	end

	return var_2_0
end

function var_0_1.getTeamByName(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0[arg_3_1]
	local var_3_1 = {}

	pairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(var_3_0) do
		table = var_1_10009

		var_1_10009.insert(var_3_1, iter_3_1.id)
	end

	return var_3_1
end

function var_0_1.getFleetType(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.ships) do
		local var_4_0 = iter_4_1:getTeamType()

		TeamType = var_1_10007

		if var_4_0 == var_1_10007.Submarine then
			FleetType = var_4_0

			return var_4_0.Submarine
		end
	end

	FleetType = var_1

	return var_1.Normal
end

function var_0_1.getShips(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = arg_5_0:getFleetType()

	FleetType = var_1_10004

	local var_5_2

	if var_5_1 == var_1_10004.Normal then
		_ = var_5_2
		var_5_2 = var_5_2.each

		local var_5_3 = arg_5_0
		local var_5_4 = arg_5_0.getShipsByTeam

		TeamType = var_1_10009

		var_5_2(var_5_4(var_5_3, var_1_10009.Main, arg_5_1), function(arg_6_0)
			table = var_2_10001

			var_2_10001.insert(var_5_0, arg_6_0)

			return
		end)

		_ = var_5_2
		var_5_2 = var_5_2.each

		local var_5_5 = arg_5_0
		local var_5_6 = arg_5_0.getShipsByTeam

		TeamType = var_1_10009

		var_5_2(var_5_6(var_5_5, var_1_10009.Vanguard, arg_5_1), function(arg_7_0)
			table = var_2_10001

			var_2_10001.insert(var_5_0, arg_7_0)

			return
		end)
	else
		FleetType = var_5_2

		if var_5_1 == var_5_2.Submarine then
			_ = var_4

			local var_5_7 = var_4.each
			local var_5_8 = arg_5_0
			local var_5_9 = arg_5_0.getShipsByTeam

			TeamType = var_1_10009

			var_5_7(var_5_9(var_5_8, var_1_10009.Submarine, arg_5_1), function(arg_8_0)
				table = var_2_10001

				var_2_10001.insert(var_5_0, arg_8_0)

				return
			end)
		end
	end

	return var_5_0
end

function var_0_1.updateShips(arg_9_0, arg_9_1)
	TeamType = var_1_10002
	arg_9_0[var_1_10002.Vanguard] = {}
	TeamType = var_2
	arg_9_0[var_2.Main] = {}
	TeamType = var_2
	arg_9_0[var_2.Submarine] = {}
	arg_9_0.ships = {}
	_ = var_2

	var_2.each(arg_9_1 or {}, function(arg_10_0)
		Ship = var_2_10001

		local var_10_0 = var_2_10001.New(arg_10_0.ship_info)

		var_10_0.hpRant = arg_10_0.hp_rant

		local var_10_1 = arg_9_0.ships

		var_10_1[var_10_0.id] = var_10_0
		table = var_10_1

		var_10_1.insert(arg_9_0[var_10_0:getTeamType()], var_10_0)

		return
	end)

	return
end

function var_0_1.updateShipsHP(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.ships[arg_11_1] then
		var_3.hpRant = arg_11_2

		return true
	else
		return false
	end

	return
end

function var_0_1.getCommanders(arg_12_0)
	return arg_12_0.commanderList
end

function var_0_1.switchShip(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getShipsByTeam(arg_13_1, false)[arg_13_2].id
	local var_13_1 = var_4[arg_13_3].id
	local var_13_2
	local var_13_3
	local var_13_4
	local var_13_5

	pairs = var_1_10011

	for iter_13_0, iter_13_1 in var_1_10011(arg_13_0.ships) do
		if iter_13_0 == var_13_0 then
			var_13_2 = iter_13_1:getTeamType()
			table = var_16
			var_13_3 = var_16.indexof(arg_13_0[var_13_2], iter_13_1)
		end

		if iter_13_0 == var_13_1 then
			var_13_4 = iter_13_1:getTeamType()
			table = var_16
			var_13_5 = var_16.indexof(arg_13_0[var_13_4], iter_13_1)
		end
	end

	if var_13_2 == var_13_4 and var_13_3 ~= var_13_5 then
		arg_13_0[var_13_2][var_13_3], arg_13_0[var_13_4][var_13_5] = arg_13_0[var_13_4][var_13_5], arg_13_0[var_13_2][var_13_3]
	end

	return
end

function var_0_1.buildBattleBuffList(arg_14_0)
	local var_14_0 = {}

	FleetSkill = var_1_10002

	local var_14_1 = var_1_10002.triggerMirrorSkill
	local var_14_2 = arg_14_0

	FleetSkill = var_1_10005

	local var_14_3, var_14_4 = var_14_1(var_14_2, var_1_10005.TypeBattleBuff)

	if var_14_3 then
		local var_14_5 = #var_14_3

		if 0 < var_14_5 then
			local var_14_6 = {}

			ipairs = var_5

			for iter_14_0, iter_14_1 in var_5(var_14_3) do
				var_1_10010 = var_14_4[iter_14_0]

				local var_14_7

				if not var_14_6[arg_14_0:findCommanderBySkillId(var_1_10010.id)] then
					var_14_7 = {}
				end

				var_14_6[var_1_10011] = var_14_7
				table = var_14_7

				var_14_7.insert(var_14_6[var_1_10011], iter_14_1)
			end

			pairs = var_5

			for iter_14_2, iter_14_3 in var_5(var_14_6) do
				table = var_1_10010

				var_1_10010.insert(var_14_0, {
					iter_14_2,
					iter_14_3
				})
			end
		end
	end

	local var_14_8 = arg_14_0:getCommanders()

	pairs = var_5

	for iter_14_4, iter_14_5 in var_5(var_14_8) do
		local var_14_9 = iter_14_5:getTalents()

		ipairs = var_1_10011

		for iter_14_6, iter_14_7 in var_1_10011(var_14_9) do
			local var_14_10 = #iter_14_7:getBuffsAddition()

			if 0 < var_14_10 then
				local var_14_11

				ipairs = var_18

				for iter_14_8, iter_14_9 in var_18(var_14_0) do
					if iter_14_9[1] == iter_14_5 then
						var_14_11 = iter_14_9[2]

						break
					end
				end

				if not var_14_11 then
					var_14_11 = {}
					table = var_18

					var_18.insert(var_14_0, {
						iter_14_5,
						var_14_11
					})
				end

				ipairs = var_18

				for iter_14_10, iter_14_11 in var_18(var_16) do
					table = var_1_10023

					var_1_10023.insert(var_14_11, iter_14_11)
				end
			end
		end
	end

	return var_14_0
end

return var_0_1
