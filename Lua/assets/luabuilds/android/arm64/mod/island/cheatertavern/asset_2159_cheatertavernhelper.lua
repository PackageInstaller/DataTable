local CheaterTavernHelper = class("CheaterTavernHelper")

function CheaterTavernHelper:GetModelDataByViewData()
	local var_1_0 = pg.island_chara_template[self.ship_id].unit_id
	local var_1_1 = self.skin_id or 0

	if var_1_1 ~= 0 then
		if not pg.island_skin_template[var_1_1] then
			warning(var_1_1 .. "island_skin_template")
		end

		var_1_0 = pg.island_skin_template[var_1_1].model

		local var_1_2 = self.color or 0

		if var_1_2 ~= 0 then
			var_1_0 = pg.island_skin_colordiff_template[var_1_2].model
		end
	end

	local var_1_3 = pg.island_unit_character[var_1_0]

	if not pg.island_unit_character[var_1_0] then
		warning(var_1_1 .. "island_skin_template")
	end

	return {
		model = var_1_3.model,
		animator = var_1_3.animator,
		unitId = var_1_0
	}
end

return CheaterTavernHelper
