class = var_0_10000

local var_0_0 = "SecondSummaryPage2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	Ship = var_1_10001

	local var_1_0 = var_1_10001.New({
		configId = arg_1_0.summaryInfoVO.flagShipId
	})
	local var_1_1 = var_1.getPainting(var_1_0)

	setPaintingPrefabAsync = var_1_10002

	local var_1_2 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_2, "paint_panel/painting"), var_1_1, "chuanwu")

	setText = var_1_10002

	local var_1_3 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_3, "window_1/name"), arg_1_0.summaryInfoVO.name)

	setText = var_1_10002

	local var_1_4 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_4, "window_1/time/Text"), "「" .. arg_1_0.summaryInfoVO.registerTime .. "」")

	setText = var_1_10002

	local var_1_5 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_5, "window_1/server/Text"), "「" .. arg_1_0.summaryInfoVO.serverName .. "」")

	setText = var_1_10002

	local var_1_6 = arg_1_0._tf

	var_1_10002(var_4.Find(var_1_6, "window_1/day/Text"), arg_1_0.summaryInfoVO.days)

	local var_1_7 = arg_1_0.summaryInfoVO
	local var_1_8 = var_2.hasGuild(var_1_7)

	setActive = var_1_0

	local var_1_9 = arg_1_0._tf

	var_1_0(var_5.Find(var_1_9, "window_2/has_guild"), var_1_8)

	setActive = var_1_0

	local var_1_10 = arg_1_0._tf

	var_1_0(var_5.Find(var_1_10, "window_2/without"), not var_1_8)

	local var_1_11 = arg_1_0._tf
	local var_1_12 = var_3.Find(var_1_11, "window_2/" .. (var_1_8 and "has_guild" or "without"))

	if var_1_8 then
		setText = var_1_7

		var_1_7(var_1_12:Find("guild_name/Text"), "「" .. arg_1_0.summaryInfoVO.guildName .. "」")
	end

	setText = var_1_7

	var_1_7(var_1_12:Find("chapter_name/Text"), "「" .. arg_1_0.summaryInfoVO.chapterName .. "」")

	local var_1_13

	if arg_1_0.summaryInfoVO.worldProgressTask > 0 then
		pg = var_1_13
		var_1_13 = var_1_13.world_task_data[arg_1_0.summaryInfoVO.worldProgressTask].name
		setText = var_5

		var_5(var_1_12:Find("world_name/Text"), "「" .. var_1_13 .. "」")
	else
		setText = var_1_13

		local var_1_14 = var_1_12:Find("world_name/Text")

		i18n = var_7

		var_1_13(var_1_14, var_7("five_shujuhuigu"))
	end

	setText = var_1_13

	local var_1_15 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_15, "window_3/count/Text"), arg_1_0.summaryInfoVO.furnitureCount)

	setText = var_1_13

	local var_1_16 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_16, "window_3/coin/Text"), arg_1_0.summaryInfoVO.furnitureWorth)

	setText = var_1_13

	local var_1_17 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_17, "window_4/collection/Text"), arg_1_0.summaryInfoVO.collectionNum)

	setText = var_1_13

	local var_1_18 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_18, "window_4/power/Text"), arg_1_0.summaryInfoVO.powerRaw)

	setText = var_1_13

	local var_1_19 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_19, "window_4/ship/Text"), arg_1_0.summaryInfoVO.totalShipNum)

	setText = var_1_13

	local var_1_20 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_20, "window_4/top_ship/Text"), arg_1_0.summaryInfoVO.topShipNum)

	setText = var_1_13

	local var_1_21 = arg_1_0._tf

	var_1_13(var_6.Find(var_1_21, "window_4/best_ship/Text"), arg_1_0.summaryInfoVO.bestShipNum)

	return
end

return var_0_1
