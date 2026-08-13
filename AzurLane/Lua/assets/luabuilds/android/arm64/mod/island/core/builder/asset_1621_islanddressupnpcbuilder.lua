class = var_0_10000

local var_0_0 = "IslandDressupNpcBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandNpcBuilder"))

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandDressupNpcUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.LoadOtherPart(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if not arg_2_3.shipId or var_5 == 0 then
		arg_2_4()

		return
	end

	seriesAsync = var_1_10006

	var_1_10006({
		function(arg_3_0)
			local var_3_0 = arg_2_0.view
			local var_3_1 = var_1.GetIsland(var_3_0)

			IslandShipDressHelperNew = var_2_10002

			local var_3_2 = var_2_10002.New(var_3_1)
			local var_3_3 = arg_2_2

			var_3.SetShipDressHelper(var_3_3, var_3_2)
			var_3_2:PreLoadShipDressupItem(arg_2_1, var_0, arg_3_0)

			return
		end
	}, function()
		existCall = var_2_10000

		var_2_10000(arg_2_4)

		return
	end)

	return
end

return var_0_1
