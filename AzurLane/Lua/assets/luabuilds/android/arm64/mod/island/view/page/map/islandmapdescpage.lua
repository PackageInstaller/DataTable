local var_0_0 = class("IslandMapDescPage", import(".IslandBaseMapDescPage"))

function var_0_0.OnLoaded(arg_1_0)
	var_0_0.super.OnLoaded(arg_1_0)

	arg_1_0.timers = {}

	return
end

function var_0_0.OnShow(arg_2_0, arg_2_1)
	var_0_0.super.OnShow(arg_2_0, arg_2_1)
	arg_2_0:UpdateProductionList(arg_2_1)

	return
end

function var_0_0.UpdateProductionList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:GetIsland():GetAblityAgency()
	local var_3_1 = _.select(pg.island_map_details.get_id_list_by_belong_map[arg_3_1], function(arg_4_0)
		return var_3_0:HasAbility(pg.island_map_details[arg_4_0].ability_id)
	end)

	arg_3_0.uiProductionList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("island/IslandMapRes", pg.island_map_details[var_3_1[arg_5_1 + 1]].detail_icon, arg_5_2)
			setText(arg_5_2:Find("Text"), pg.island_map_details[var_3_1[arg_5_1 + 1]].name)
			arg_3_0:AddTimer(arg_5_2, pg.island_map_details[var_3_1[arg_5_1 + 1]].production_place_id)
		end

		return
	end)
	arg_3_0.uiProductionList:align(#_.select(pg.island_map_details.get_id_list_by_belong_map[arg_3_1], function(arg_4_0)
		return var_3_0:HasAbility(pg.island_map_details[arg_4_0].ability_id)
	end))

	return
end

function var_0_0.AddTimer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_9000
	local var_6_0 = arg_6_1:Find("full")

	setActive(var_6_0, false)
	arg_6_0:RemoveTimer(arg_6_2)

	if arg_6_2 <= 0 then
		return
	end

	local var_6_1 = getProxy(IslandProxy):GetIsland()
	local var_6_2 = var_6_1.GetBuildingAgency(var_6_9000):GetBuilding(arg_6_2)
	local var_6_3 = var_6_2 and var_6_2:GetMinRoleDeleGationTime() or -1

	if var_6_1 < 0 then
		return
	end

	local var_6_4 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_6_3 <= var_6_4 then
		setActive(var_6_0, true)
		arg_6_0:UpdateAnyFullMark()

		return
	end

	arg_6_0.timers[arg_6_2] = Timer.New(function()
		setActive(var_6_0, true)
		arg_6_0:UpdateAnyFullMark()
		arg_6_0:RemoveTimer(arg_6_2)

		return
	end, var_6_3 - var_6_4, 1)

	arg_6_0.timers[arg_6_2]:Start()

	return
end

function var_0_0.UpdateAnyFullMark(arg_8_0)
	setActive(arg_8_0.fullMark, true)

	return
end

function var_0_0.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1] then
		arg_9_0.timers[arg_9_1]:Stop()

		arg_9_0.timers[arg_9_1] = nil
	end

	return
end

function var_0_0.OnHide(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.timers) do
		iter_10_1:Stop()
	end

	arg_10_0.timers = {}

	return
end

return var_0_0
