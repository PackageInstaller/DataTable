class = var_0_10000

local var_0_0 = "ShamRival"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Rival"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id
	arg_1_0.level = arg_1_1.level
	arg_1_0.name = arg_1_1.name
	arg_1_0.vanguardShips = {}
	arg_1_0.mainShips = {}
	_ = var_2

	var_2.each(arg_1_1.ship_list, function(arg_2_0)
		Ship = var_2_10001

		local var_2_0 = var_2_10001.New(arg_2_0)
		local var_2_1 = var_1.getTeamType(var_2_0)

		TeamType = var_2_0

		if var_2_1 == var_2_0.Vanguard then
			table = var_3

			var_3.insert(arg_1_0.vanguardShips, var_1)
		else
			TeamType = var_3

			if var_2_1 == var_3.Main then
				table = var_3

				var_3.insert(arg_1_0.mainShips, var_1)
			end
		end

		return
	end)

	return
end

return var_0_1
