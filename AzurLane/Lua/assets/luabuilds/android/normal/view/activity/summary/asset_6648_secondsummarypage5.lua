class = var_0_10000

local var_0_0 = "SecondSummaryPage5"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	setText = var_1_10001

	local var_1_0 = arg_1_0._tf

	var_1_10001(var_2.Find(var_1_0, "window_share_1/name"), arg_1_0.summaryInfoVO.name)

	setText = var_1_10001

	local var_1_1 = arg_1_0._tf

	var_1_10001(var_2.Find(var_1_1, "window_share_1/time/Text"), "「" .. arg_1_0.summaryInfoVO.registerTime .. "」")

	setText = var_1_10001

	local var_1_2 = arg_1_0._tf

	var_1_10001(var_2.Find(var_1_2, "window_share_1/day/Text"), arg_1_0.summaryInfoVO.days)

	local var_1_3 = arg_1_0.summaryInfoVO
	local var_1_4 = var_1.hasGuild(var_1_3)

	setActive = var_1_3

	local var_1_5 = arg_1_0._tf

	var_1_3(var_3.Find(var_1_5, "window_share_2/has_guild"), var_1_4)

	setActive = var_1_3

	local var_1_6 = arg_1_0._tf

	var_1_3(var_3.Find(var_1_6, "window_share_2/without"), not var_1_4)

	if var_1_4 then
		local var_1_7 = arg_1_0._tf
		local var_1_8

		if not var_2.Find(var_1_7, "window_share_2/has_guild") then
			var_1_7 = arg_1_0._tf
			var_1_8 = var_2.Find(var_1_7, "window_share_2/without")
		end

		if var_1_4 then
			setText = var_1_7

			var_1_7(var_1_8:Find("guild_name/Text"), "「" .. arg_1_0.summaryInfoVO.guildName .. "」")
		end

		setText = var_1_7

		var_1_7(var_1_8:Find("chapter_name/Text"), "「" .. arg_1_0.summaryInfoVO.chapterName .. "」")

		setText = var_1_7

		var_1_7(var_1_8:Find("number/Text"), arg_1_0.summaryInfoVO.proposeCount)

		setText = var_1_7

		local var_1_9 = arg_1_0._tf

		var_1_7(var_4.Find(var_1_9, "window_share_3/number/Text"), arg_1_0.summaryInfoVO.medalCount)

		setText = var_1_7

		local var_1_10 = arg_1_0._tf

		var_1_7(var_4.Find(var_1_10, "window_share_3/count/Text"), arg_1_0.summaryInfoVO.furnitureCount)

		setText = var_1_7

		local var_1_11 = arg_1_0._tf

		var_1_7(var_4.Find(var_1_11, "window_share_3/coin/Text"), arg_1_0.summaryInfoVO.furnitureWorth)

		setText = var_1_7

		local var_1_12 = arg_1_0._tf

		var_1_7(var_4.Find(var_1_12, "window_share_3/collection/Text"), arg_1_0.summaryInfoVO.collectionNum)

		setText = var_1_7

		local var_1_13 = arg_1_0._tf

		var_1_7(var_4.Find(var_1_13, "window_share_3/skin/Text"), arg_1_0.summaryInfoVO.skinNum)

		return
	end
end

return var_0_1
