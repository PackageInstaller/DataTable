class = var_0_10000

local var_0_0 = "IslandShipDressHelperMiniGameNew"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandShipDressHelperNew"))

function var_0_1.SetShipId(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.super.SetShipId(arg_1_0, arg_1_1)

	if not arg_1_3 then
		arg_1_0.dataAfterRoleInit = {}
		ipairs = var_4

		for iter_1_0, iter_1_1 in var_4(arg_1_2) do
			local var_1_0 = {
				id = iter_1_1
			}

			var_1_0.colorId = 0
			pg = var_10

			local var_1_1 = var_10.island_dress_template[iter_1_1].type

			ipairs = var_1_10011
			pg = var_1_10012

			for iter_1_2, iter_1_3 in var_1_10011(var_1_10012.gameset.bar_not_display_dress_type.description) do
				if var_1_1 ~= iter_1_3 and var_1_1 ~= var_0_1.DressType.Flotage then
					arg_1_0.dataAfterRoleInit[var_1_1] = var_1_0
				end
			end
		end
	end

	return
end

return var_0_1
