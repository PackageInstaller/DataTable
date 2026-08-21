local var_0_0 = class("Challenge2Fleet", import(".Fleet"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id

	arg_1_0:updateShips(arg_1_1.ships)

	arg_1_0.commanderList = {}

	local var_1_0 = arg_1_1.commanders or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.commanderList[iter_1_1.pos] = Commander.New(iter_1_1.commanderinfo)
	end

	arg_1_0.skills = {}

	arg_1_0:updateCommanderSkills()

	return
end

function var_0_0.getShipsByTeam(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0[arg_2_1]) do
		if iter_2_1.hpRant > 0 then
			({})[#{} + 1] = iter_2_1
		end
	end

	if arg_2_2 then
		for iter_2_2, iter_2_3 in ipairs(arg_2_0[arg_2_1]) do
			if iter_2_3.hpRant <= 0 then
				({})[#{} + 1] = iter_2_3
			end
		end
	end

	return {}
end

function var_0_0.getTeamByName(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0[arg_3_1]) do
		table.insert({}, iter_3_1.id)
	end

	return {}
end

function var_0_0.getFleetType(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.ships) do
		if iter_4_1:getTeamType() == TeamType.Submarine then
			return FleetType.Submarine
		end
	end

	return FleetType.Normal
end

function var_0_0.getShips(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = arg_5_0:getFleetType()

	if var_5_1 == FleetType.Normal then
		_.each(arg_5_0:getShipsByTeam(TeamType.Main, arg_5_1), function(arg_6_0)
			table.insert(var_5_0, arg_6_0)

			return
		end)
		_.each(arg_5_0:getShipsByTeam(TeamType.Vanguard, arg_5_1), function(arg_7_0)
			table.insert(var_5_0, arg_7_0)

			return
		end)
	elseif var_5_1 == FleetType.Submarine then
		_.each(arg_5_0:getShipsByTeam(TeamType.Submarine, arg_5_1), function(arg_8_0)
			table.insert(var_5_0, arg_8_0)

			return
		end)
	end

	return {}
end

function var_0_0.updateShips(arg_9_0, arg_9_1)
	arg_9_0[TeamType.Vanguard] = {}
	arg_9_0[TeamType.Main] = {}
	arg_9_0[TeamType.Submarine] = {}
	arg_9_0.ships = {}

	_.each(arg_9_1 or {}, function(arg_10_0)
		local var_10_0 = Ship.New(arg_10_0.ship_info)

		var_10_0.hpRant = arg_10_0.hp_rant
		arg_9_0.ships[var_10_0.id] = var_10_0

		table.insert(arg_9_0[var_10_0:getTeamType()], var_10_0)

		return
	end)

	return
end

function var_0_0.updateShipsHP(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.ships[arg_11_1] then
		arg_11_0.ships[arg_11_1].hpRant = arg_11_2

		return true
	else
		return false
	end

	return
end

function var_0_0.getCommanders(arg_12_0)
	return arg_12_0.commanderList
end

function var_0_0.switchShip(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getShipsByTeam(arg_13_1, false)
	local var_13_1
	local var_13_2
	local var_13_3
	local var_13_4

	for iter_13_0, iter_13_1 in pairs(arg_13_0.ships) do
		if iter_13_0 == var_13_0[arg_13_2].id then
			var_13_1 = iter_13_1:getTeamType()
			var_13_2 = table.indexof(arg_13_0[var_13_1], iter_13_1)
		end

		if iter_13_0 == var_13_0[arg_13_3].id then
			var_13_3 = iter_13_1:getTeamType()
			var_13_4 = table.indexof(arg_13_0[var_13_3], iter_13_1)
		end
	end

	if var_13_1 == var_13_3 and nil ~= nil then
		arg_13_0[var_13_1][var_13_2], arg_13_0[var_13_3][var_13_4] = arg_13_0[var_13_3][nil], arg_13_0[var_13_1][nil]
	end

	return
end

function var_0_0.buildBattleBuffList(arg_14_0)
	local var_14_0, var_14_1 = FleetSkill.triggerMirrorSkill(arg_14_0, FleetSkill.TypeBattleBuff)

	if var_14_0 and #var_14_0 > 0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_2 = arg_14_0:findCommanderBySkillId(var_14_1[iter_14_0].id)
			local var_14_3 = ({})[var_14_2]

			if not ({})[var_14_2] then
				var_14_3 = {}
			end

			;({})[var_14_2] = var_14_3

			table.insert(({})[var_14_2], iter_14_1)
		end

		for iter_14_2, iter_14_3 in pairs({}) do
			table.insert({}, {
				iter_14_2,
				iter_14_3
			})
		end
	end

	for iter_14_4, iter_14_5 in pairs((arg_14_0:getCommanders())) do
		for iter_14_6, iter_14_7 in ipairs((iter_14_5:getTalents())) do
			local var_14_4 = iter_14_7:getBuffsAddition()

			if #var_14_4 > 0 then
				local var_14_5

				for iter_14_8, iter_14_9 in ipairs({}) do
					if iter_14_9[1] == iter_14_5 then
						var_14_5 = iter_14_9[2]

						break
					end
				end

				if not var_14_5 then
					var_14_5 = {}

					table.insert({}, {
						iter_14_5,
						{}
					})
				end

				for iter_14_10, iter_14_11 in ipairs(var_14_4) do
					table.insert(var_14_5, iter_14_11)
				end
			end
		end
	end

	return {}
end

return var_0_0
