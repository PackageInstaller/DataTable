class = var_0_10000

local var_0_0 = "IslandSharedMapDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.View.page.map.IslandBaseMapDescPage"))

function var_0_1.OnShow(arg_1_0, arg_1_1)
	var_0_1.super.OnShow(arg_1_0, arg_1_1)
	arg_1_0:UpdateProductionList(arg_1_1)

	return
end

function var_0_1.UpdateProductionList(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.island_map_details.get_id_list_by_belong_map[arg_2_1]
	local var_2_1 = arg_2_0:GetIsland()
	local var_2_2 = var_3.GetAblityAgency(var_2_1)

	_ = var_2_1

	local var_2_3 = var_2_1.select(var_2_0, function(arg_3_0)
		local var_3_0 = var_2_2
		local var_3_1 = var_1.HasAbility

		pg = var_2_10003

		return var_3_1(var_3_0, var_2_10003.island_map_details[arg_3_0].ability_id)
	end)
	local var_2_4 = arg_2_0.uiProductionList

	var_5.make(var_2_4, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = var_2_3[arg_4_1 + 1]

			pg = var_4

			local var_4_1 = var_4.island_map_details[var_4_0]

			GetImageSpriteFromAtlasAsync = var_2_10005

			var_2_10005("island/IslandMapRes", var_4_1.detail_icon, arg_4_2)

			setText = var_2_10005

			var_2_10005(arg_4_2:Find("Text"), var_4_1.name)

			setActive = var_2_10005

			var_2_10005(arg_4_2:Find("full"), false)
		end

		return
	end)

	local var_2_5 = arg_2_0.uiProductionList

	var_5.align(var_2_5, #var_2_3)

	return
end

return var_0_1
