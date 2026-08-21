local var_0_0 = class("IslandShipDressHelperMiniGameNew", import(".IslandShipDressHelperNew"))

function var_0_0.SetShipId(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.super.SetShipId(arg_1_0, arg_1_1)

	if not arg_1_3 then
		arg_1_0.dataAfterRoleInit = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
			({
				id = iter_1_1
			}).colorId = 0

			for iter_1_2, iter_1_3 in ipairs(pg.gameset.bar_not_display_dress_type.description) do
				if pg.island_dress_template[iter_1_1].type ~= iter_1_3 and pg.island_dress_template[iter_1_1].type ~= var_0_0.DressType.Flotage then
					arg_1_0.dataAfterRoleInit[pg.island_dress_template[iter_1_1].type] = {
						id = iter_1_1
					}
				end
			end
		end
	end

	return
end

return var_0_0
