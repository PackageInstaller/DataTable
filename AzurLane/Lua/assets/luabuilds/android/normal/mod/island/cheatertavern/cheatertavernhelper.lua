class = var_0_10000

local var_0_0 = var_0_10000("CheaterTavernHelper")

function var_0_0.GetModelDataByViewData(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.island_chara_template[arg_1_0.ship_id].unit_id
	local var_1_1

	if not arg_1_0.skin_id then
		var_1_1 = 0
	end

	if var_1_1 ~= 0 then
		pg = var_1_10003

		if not var_1_10003.island_skin_template[var_1_1] then
			warning = var_1_10004

			var_1_10004(var_1_1 .. "island_skin_template")
		end

		pg = var_1_10004
		var_1_0 = var_1_10004.island_skin_template[var_1_1].model

		if not arg_1_0.color then
			var_1_10004 = 0
		end

		if var_1_10004 ~= 0 then
			pg = var_1_10005
			var_1_0 = var_1_10005.island_skin_colordiff_template[var_1_10004].model
		end
	end

	pg = var_1_10003

	if not var_1_10003.island_unit_character[var_1_0] then
		warning = var_1_10004

		var_1_10004(var_1_1 .. "island_skin_template")
	end

	return {
		model = var_3.model,
		animator = var_3.animator,
		unitId = var_1_0
	}
end

return var_0_0
