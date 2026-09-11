local var_0_0 = {
	GetFurnitureIsHideUntilObtained = function(arg_1_0)
		if BackHomeFurniture[arg_1_0].is_hide == 1 then
			return true
		end

		if BackHomeFurniture[arg_1_0].hero_id ~= 0 and HeroTools.GetIsHide(BackHomeFurniture[arg_1_0].hero_id) then
			return true
		end

		return false
	end
}

function var_0_0.GetFurnitureIsHide(arg_2_0)
	if var_0_0.GetFurnitureIsHideUntilObtained(arg_2_0) and DormData:GetFurNumInfo(arg_2_0).num <= 0 then
		return true
	end

	return false
end

function var_0_0.GetFurList(arg_3_0)
	local var_3_0 = {}

	for iter_3_0 = 1, #BackHomeFurnitureThemeCfg[arg_3_0].theme_id do
		for iter_3_1, iter_3_2 in ipairs(BackHomeFurniture.get_id_list_by_theme[BackHomeFurnitureThemeCfg[arg_3_0].theme_id[iter_3_0]]) do
			if not var_0_0.GetFurnitureIsHide(iter_3_2) then
				table.insert(var_3_0, iter_3_2)
			end
		end
	end

	for iter_3_3 = #var_3_0, 1, -1 do
		if BackHomeFurniture[var_3_0[iter_3_3]].scene_id[1] == 1 then
			table.remove(var_3_0, iter_3_3)
		end
	end

	return var_3_0
end

function var_0_0.GetThemeID(arg_4_0)
	local var_4_0 = -1

	if BackHomeFurniture[arg_4_0] then
		for iter_4_0, iter_4_1 in ipairs(BackHomeFurnitureThemeCfg.all) do
			for iter_4_2, iter_4_3 in ipairs(BackHomeFurnitureThemeCfg[iter_4_1].theme_id) do
				if iter_4_3 == BackHomeFurniture[arg_4_0].theme then
					var_4_0 = iter_4_1

					break
				end
			end
		end
	end

	return var_4_0
end

return var_0_0
