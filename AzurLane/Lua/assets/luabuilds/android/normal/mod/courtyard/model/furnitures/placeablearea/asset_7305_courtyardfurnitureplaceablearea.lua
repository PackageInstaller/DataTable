class = var_0_10000

local var_0_0 = "CourtYardFurniturePlaceableArea"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...map.CourtYardPlaceableArea"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.furniture = arg_1_2

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	return
end

function var_0_1.LegalPosition(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.furniture
	local var_2_1 = var_3.GetCanputonPosition(var_2_0)
	local var_2_2

	if var_0_1.super.IsEmptyPosition(arg_2_0, arg_2_1) then
		table = var_2_2
		var_2_2 = var_2_2.contains(var_2_1, arg_2_1)
	end

	return var_2_2
end

function var_0_1.AreaWithInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.GetAreaByPosition(var_3_0, arg_3_2)

	_ = var_3_0

	return var_3_0.map(var_3_1, function(arg_4_0)
		local var_4_1

		if not arg_3_4 then
			local var_4_0 = arg_3_0

			var_4_1 = var_1.LegalPosition(var_4_0, arg_4_0)
		end

		return {
			flag = var_4_1 and 3 or 2,
			position = arg_4_0,
			offset = arg_3_3
		}
	end)
end

return var_0_1
