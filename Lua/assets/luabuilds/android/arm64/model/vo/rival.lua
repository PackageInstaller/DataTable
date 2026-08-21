local var_0_0 = class("Rival", import(".PlayerAttire"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id
	arg_1_0.level = arg_1_1.level
	arg_1_0.name = arg_1_1.name
	arg_1_0.score = arg_1_1.score or 0
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.vanguardShips = {}
	arg_1_0.mainShips = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.vanguard_ship_list) do
		local var_1_0 = RivalShip.New(iter_1_1)

		var_1_0.isRival = true

		;(function(arg_2_0)
			if arg_2_0:getTeamType() == TeamType.Vanguard then
				table.insert(arg_1_0.vanguardShips, arg_2_0)
			elseif arg_2_0:getTeamType() == TeamType.Main then
				table.insert(arg_1_0.mainShips, arg_2_0)
			end

			return
		end)(var_1_0)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.main_ship_list) do
		local var_1_1 = RivalShip.New(iter_1_3)

		var_1_1.isRival = true

		;(function(arg_2_0)
			if arg_2_0:getTeamType() == TeamType.Vanguard then
				table.insert(arg_1_0.vanguardShips, arg_2_0)
			elseif arg_2_0:getTeamType() == TeamType.Main then
				table.insert(arg_1_0.mainShips, arg_2_0)
			end

			return
		end)(var_1_1)
	end

	arg_1_0.score = arg_1_0.score + SeasonInfo.INIT_POINT

	return
end

function var_0_0.getPainting(arg_3_0)
	if pg.ship_skin_template[arg_3_0.skinId] then
		return pg.ship_skin_template[arg_3_0.skinId].painting or "unknown"
	end
end

function var_0_0.getShips(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.vanguardShips) do
		table.insert({}, iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.mainShips) do
		table.insert({}, iter_4_3)
	end

	return {}
end

function var_0_0.GetGearScoreSum(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1 == "main" then
		var_5_0 = arg_5_0.mainShips
	elseif arg_5_1 == "vanguard" then
		var_5_0 = arg_5_0.vanguardShips
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		var_5_1 = var_5_1 + iter_5_1:getShipCombatPower()
	end

	return var_5_1
end

return var_0_0
