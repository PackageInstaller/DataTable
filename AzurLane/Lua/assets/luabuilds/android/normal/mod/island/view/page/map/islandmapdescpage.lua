class = var_0_10000

local var_0_0 = "IslandMapDescPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseMapDescPage"))

function var_0_1.OnLoaded(arg_1_0)
	var_0_1.super.OnLoaded(arg_1_0)

	arg_1_0.timers = {}

	return
end

function var_0_1.OnShow(arg_2_0, arg_2_1)
	var_0_1.super.OnShow(arg_2_0, arg_2_1)
	arg_2_0:UpdateProductionList(arg_2_1)

	return
end

function var_0_1.UpdateProductionList(arg_3_0, arg_3_1)
	pg = var_1_10002

	local var_3_0 = var_1_10002.island_map_details.get_id_list_by_belong_map[arg_3_1]
	local var_3_1 = arg_3_0:GetIsland()
	local var_3_2 = var_3.GetAblityAgency(var_3_1)

	_ = var_3_1

	local var_3_3 = var_3_1.select(var_3_0, function(arg_4_0)
		local var_4_0 = var_3_2
		local var_4_1 = var_1.HasAbility

		pg = var_2_10003

		return var_4_1(var_4_0, var_2_10003.island_map_details[arg_4_0].ability_id)
	end)
	local var_3_4 = arg_3_0.uiProductionList

	var_5.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = var_3_3[arg_5_1 + 1]

			pg = var_4

			local var_5_1 = var_4.island_map_details[var_5_0]

			GetImageSpriteFromAtlasAsync = var_2_10005

			var_2_10005("island/IslandMapRes", var_5_1.detail_icon, arg_5_2)

			setText = var_2_10005

			var_2_10005(arg_5_2:Find("Text"), var_5_1.name)

			local var_5_2 = arg_3_0

			var_5.AddTimer(var_5_2, arg_5_2, var_5_1.production_place_id)
		end

		return
	end)

	local var_3_5 = arg_3_0.uiProductionList

	var_5.align(var_3_5, #var_3_3)

	return
end

function var_0_1.AddTimer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.Find(var_6_0, "full")

	setActive = var_6_0

	var_6_0(var_6_1, false)

	local var_6_2 = arg_6_0

	arg_6_0.RemoveTimer(var_6_2, arg_6_2)

	if arg_6_2 <= 0 then
		return
	end

	getProxy = var_4
	IslandProxy = var_6_2

	local var_6_3 = var_4(var_6_2)
	local var_6_4 = var_4.GetIsland(var_6_3)
	local var_6_5 = var_4.GetBuildingAgency(var_6_4)
	local var_6_6

	if not var_4.GetBuilding(var_6_5, arg_6_2) or not var_5:GetMinRoleDeleGationTime() then
		var_6_6 = -1
	end

	if var_6_6 < 0 then
		return
	end

	pg = var_7

	local var_6_7 = var_7.TimeMgr.GetInstance()

	if var_6_6 <= var_7.GetServerTime(var_6_7) then
		setActive = var_6_7

		var_6_7(var_6_1, true)
		arg_6_0:UpdateAnyFullMark()

		return
	end

	local var_6_8 = var_6_6 - var_7
	local var_6_9 = arg_6_0.timers

	Timer = var_1_10010
	var_6_9[arg_6_2] = var_1_10010.New(function()
		setActive = var_2_10000

		var_2_10000(var_6_1, true)

		local var_7_0 = arg_6_0

		var_0.UpdateAnyFullMark(var_7_0)

		local var_7_1 = arg_6_0

		var_0.RemoveTimer(var_7_1, arg_6_2)

		return
	end, var_6_8, 1)

	local var_6_10 = arg_6_0.timers[arg_6_2]

	var_9.Start(var_6_10)

	return
end

function var_0_1.UpdateAnyFullMark(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.fullMark, true)

	return
end

function var_0_1.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1] then
		local var_9_0 = arg_9_0.timers[arg_9_1]

		var_2.Stop(var_9_0)

		arg_9_0.timers[arg_9_1] = nil
	end

	return
end

function var_0_1.OnHide(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.timers) do
		iter_10_1:Stop()
	end

	arg_10_0.timers = {}

	return
end

return var_0_1
