local IslandSharedMapDescPage = class("IslandSharedMapDescPage", import("Mod.Island.View.page.map.IslandBaseMapDescPage"))

function IslandSharedMapDescPage:OnShow(arg_1_1)
	IslandSharedMapDescPage.super.OnShow(self, arg_1_1)
	self:UpdateProductionList(arg_1_1)

	return
end

function IslandSharedMapDescPage:UpdateProductionList(arg_2_1)
	local var_2_0 = self:GetIsland():GetAblityAgency()
	local var_2_1 = _.select(pg.island_map_details.get_id_list_by_belong_map[arg_2_1], function(arg_3_0)
		return var_2_0:HasAbility(pg.island_map_details[arg_3_0].ability_id)
	end)

	self.uiProductionList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("island/IslandMapRes", pg.island_map_details[var_2_1[arg_4_1 + 1]].detail_icon, arg_4_2)
			setText(arg_4_2:Find("Text"), pg.island_map_details[var_2_1[arg_4_1 + 1]].name)
			setActive(arg_4_2:Find("full"), false)
		end

		return
	end)
	self.uiProductionList:align(#var_2_1)

	return
end

return IslandSharedMapDescPage
