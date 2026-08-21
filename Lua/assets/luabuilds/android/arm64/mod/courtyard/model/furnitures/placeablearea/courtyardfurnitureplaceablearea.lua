local var_0_0 = class("CourtYardFurniturePlaceableArea", import("...map.CourtYardPlaceableArea"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.furniture = arg_1_2

	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_3)

	return
end

function var_0_0.LegalPosition(arg_2_0, arg_2_1, arg_2_2)
	return var_0_0.super.IsEmptyPosition(arg_2_0, arg_2_1) and table.contains(arg_2_0.furniture:GetCanputonPosition(), arg_2_1)
end

function var_0_0.AreaWithInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return _.map(arg_3_1:GetAreaByPosition(arg_3_2), function(arg_4_0)
		local var_4_0 = arg_3_4 or arg_3_0:LegalPosition(arg_4_0)

		return {
			flag = var_4_0 and 3 or 2,
			position = arg_4_0,
			offset = arg_3_3
		}
	end)
end

return var_0_0
