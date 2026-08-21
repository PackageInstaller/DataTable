local var_0_0 = class("IslandProductCostHelper")

function var_0_0.GetReducePercentInPlace(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = getProxy(IslandProxy)
	local var_1_1 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0.GetIsland(var_1_9000):GetCharacterAgency():GetShipById(arg_1_0).GetSkill(var_1_0):GetUnlockShipEffectIds()) do
		if pg.island_buff_template[iter_1_1].buff_type == IslandBuffType.SHIP_PRODUCT_POWER_COST then
			if underscore.any(pg.island_buff_template[iter_1_1].type_use[1], function(arg_2_0)
				return arg_2_0 == arg_1_1
			end) then
				var_1_1 = var_1_1 + pg.island_buff_template[iter_1_1].type_use[2]
			end
		end
	end

	return var_1_1 * 0.01
end

return var_0_0
