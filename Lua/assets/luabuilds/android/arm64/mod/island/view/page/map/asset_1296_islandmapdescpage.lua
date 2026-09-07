local IslandMapDescPage = class("IslandMapDescPage", import(".IslandBaseMapDescPage"))

function IslandMapDescPage:OnLoaded()
	IslandMapDescPage.super.OnLoaded(self)

	self.timers = {}

	return
end

function IslandMapDescPage:OnShow(arg_2_1)
	IslandMapDescPage.super.OnShow(self, arg_2_1)
	self:UpdateProductionList(arg_2_1)

	return
end

function IslandMapDescPage:UpdateProductionList(arg_3_1)
	local var_3_0 = self:GetIsland():GetAblityAgency()
	local var_3_1 = _.select(pg.island_map_details.get_id_list_by_belong_map[arg_3_1], function(arg_4_0)
		return var_3_0:HasAbility(pg.island_map_details[arg_4_0].ability_id)
	end)

	self.uiProductionList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("island/IslandMapRes", pg.island_map_details[var_3_1[arg_5_1 + 1]].detail_icon, arg_5_2)
			setText(arg_5_2:Find("Text"), pg.island_map_details[var_3_1[arg_5_1 + 1]].name)
			self:AddTimer(arg_5_2, pg.island_map_details[var_3_1[arg_5_1 + 1]].production_place_id)
		end

		return
	end)
	self.uiProductionList:align(#var_3_1)

	return
end

function IslandMapDescPage:AddTimer(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:Find("full")

	setActive(var_6_0, false)
	self:RemoveTimer(arg_6_2)

	if arg_6_2 <= 0 then
		return
	end

	local var_6_1 = getProxy(IslandProxy):GetIsland()
	local var_6_2 = var_6_1:GetBuildingAgency():GetBuilding(arg_6_2)
	local var_6_3 = var_6_2 and var_6_2:GetMinRoleDeleGationTime() or -1

	if var_6_1 < 0 then
		return
	end

	local var_6_4 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_6_3 <= var_6_4 then
		setActive(var_6_0, true)
		self:UpdateAnyFullMark()

		return
	end

	self.timers[arg_6_2] = Timer.New(function()
		setActive(var_6_0, true)
		self:UpdateAnyFullMark()
		self:RemoveTimer(arg_6_2)

		return
	end, var_6_3 - var_6_4, 1)

	self.timers[arg_6_2]:Start()

	return
end

function IslandMapDescPage:UpdateAnyFullMark()
	setActive(self.fullMark, true)

	return
end

function IslandMapDescPage:RemoveTimer(arg_9_1)
	if self.timers[arg_9_1] then
		self.timers[arg_9_1]:Stop()

		self.timers[arg_9_1] = nil
	end

	return
end

function IslandMapDescPage:OnHide()
	for iter_10_0, iter_10_1 in pairs(self.timers) do
		iter_10_1:Stop()
	end

	self.timers = {}

	return
end

return IslandMapDescPage
