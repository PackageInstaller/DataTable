class = var_0_10000

local var_0_0 = var_0_10000("IslandProductCostHelper")

function var_0_0.GetReducePercentInPlace(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = var_2.GetIsland(var_1_0)
	local var_1_2 = var_2.GetCharacterAgency(var_1_1)
	local var_1_3 = var_3.GetShipById(var_1_2, arg_1_0)
	local var_1_4 = 0

	ipairs = var_6

	local var_1_5 = var_1_3:GetSkill()

	for iter_1_0, iter_1_1 in var_6(var_7.GetUnlockShipEffectIds(var_1_5)) do
		pg = var_1_10011

		local var_1_6 = var_1_10011.island_buff_template[iter_1_1].buff_type

		IslandBuffType = var_1_10013

		if var_1_6 == var_1_10013.SHIP_PRODUCT_POWER_COST then
			var_1_10013 = var_1_10011.type_use[1]
			underscore = var_1_10014

			if var_1_10014.any(var_1_10013, function(arg_2_0)
				return arg_2_0 == arg_1_1
			end) then
				var_1_4 = var_1_4 + var_12[2]
			end
		end
	end

	return var_1_4 * 0.01
end

return var_0_0
