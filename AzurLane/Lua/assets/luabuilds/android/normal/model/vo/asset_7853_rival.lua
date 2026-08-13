class = var_0_10000

local var_0_0 = "Rival"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PlayerAttire"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id
	arg_1_0.level = arg_1_1.level
	arg_1_0.name = arg_1_1.name

	local var_1_0

	if not arg_1_1.score then
		var_1_0 = 0
	end

	arg_1_0.score = var_1_0
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.vanguardShips = {}
	arg_1_0.mainShips = {}

	local function var_1_1(arg_2_0)
		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.getTeamType(var_2_0)

		TeamType = var_2_0

		if var_2_1 == var_2_0.Vanguard then
			table = var_2_1

			var_2_1.insert(arg_1_0.vanguardShips, arg_2_0)
		else
			local var_2_2 = arg_2_0
			local var_2_3 = arg_2_0.getTeamType(var_2_2)

			TeamType = var_2_2

			if var_2_3 == var_2_2.Main then
				table = var_2_3

				var_2_3.insert(arg_1_0.mainShips, arg_2_0)
			end
		end

		return
	end

	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_1.vanguard_ship_list) do
		RivalShip = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_1)
		var_1_10008.isRival = true

		var_1_1(var_1_10008)
	end

	ipairs = var_3

	for iter_1_2, iter_1_3 in var_3(arg_1_1.main_ship_list) do
		RivalShip = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_3)
		var_1_10008.isRival = true

		var_1_1(var_1_10008)
	end

	local var_1_2 = arg_1_0.score

	SeasonInfo = var_4
	arg_1_0.score = var_1_2 + var_4.INIT_POINT

	return
end

function var_0_1.getPainting(arg_3_0)
	pg = var_1_10001

	local var_3_0

	if not var_1_10001.ship_skin_template[arg_3_0.skinId] or not var_1.painting then
		var_3_0 = "unknown"
	end

	return var_3_0
end

function var_0_1.getShips(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.vanguardShips) do
		table = var_1_10007

		var_1_10007.insert(var_4_0, iter_4_1)
	end

	ipairs = var_2

	for iter_4_2, iter_4_3 in var_2(arg_4_0.mainShips) do
		table = var_1_10007

		var_1_10007.insert(var_4_0, iter_4_3)
	end

	return var_4_0
end

function var_0_1.GetGearScoreSum(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1 == "main" then
		var_5_0 = arg_5_0.mainShips
	elseif arg_5_1 == "vanguard" then
		var_5_0 = arg_5_0.vanguardShips
	end

	local var_5_1 = 0

	ipairs = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10004(var_5_0) do
		var_5_1 = var_5_1 + iter_5_1:getShipCombatPower()
	end

	return var_5_1
end

return var_0_1
