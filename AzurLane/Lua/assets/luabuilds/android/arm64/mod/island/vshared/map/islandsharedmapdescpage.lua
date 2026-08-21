local var_0_0 = class("IslandSharedMapDescPage", import("Mod.Island.View.page.map.IslandBaseMapDescPage"))

function var_0_0.OnShow(arg_1_0, arg_1_1)
	var_0_0.super.OnShow(arg_1_0, arg_1_1)
	arg_1_0:UpdateProductionList(arg_1_1)

	return
end

function var_0_0.UpdateProductionList(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:GetIsland():GetAblityAgency()
	local var_2_1 = _.select(pg.island_map_details.get_id_list_by_belong_map[arg_2_1], function(arg_3_0)
		return var_2_0:HasAbility(pg.island_map_details[arg_3_0].ability_id)
	end)

	arg_2_0.uiProductionList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("island/IslandMapRes", pg.island_map_details[var_2_1[arg_4_1 + 1]].detail_icon, arg_4_2)
			setText(arg_4_2:Find("Text"), pg.island_map_details[var_2_1[arg_4_1 + 1]].name)
			setActive(arg_4_2:Find("full"), false)
		end

		return
	end)
	arg_2_0.uiProductionList:align(#_.select(pg.island_map_details.get_id_list_by_belong_map[arg_2_1], function(arg_3_0)
		return var_2_0:HasAbility(pg.island_map_details[arg_3_0].ability_id)
	end))

	return
end

return var_0_0
