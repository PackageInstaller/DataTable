local var_0_0 = class("SecondSummaryPage5", import(".SummaryAnimationPage"))

function var_0_0.OnInit(arg_1_0)
	setText(arg_1_0._tf:Find("window_share_1/name"), arg_1_0.summaryInfoVO.name)
	setText(arg_1_0._tf:Find("window_share_1/time/Text"), "「" .. arg_1_0.summaryInfoVO.registerTime .. "」")
	setText(arg_1_0._tf:Find("window_share_1/day/Text"), arg_1_0.summaryInfoVO.days)

	local var_1_0 = arg_1_0.summaryInfoVO:hasGuild()

	setActive(arg_1_0._tf:Find("window_share_2/has_guild"), var_1_0)
	setActive(arg_1_0._tf:Find("window_share_2/without"), not var_1_0)

	if var_1_0 then
		local var_1_1 = arg_1_0._tf:Find("window_share_2/has_guild") or arg_1_0._tf:Find("window_share_2/without")

		if var_1_0 then
			setText(var_1_1:Find("guild_name/Text"), "「" .. arg_1_0.summaryInfoVO.guildName .. "」")
		end

		setText(var_1_1:Find("chapter_name/Text"), "「" .. arg_1_0.summaryInfoVO.chapterName .. "」")
		setText(var_1_1:Find("number/Text"), arg_1_0.summaryInfoVO.proposeCount)
		setText(arg_1_0._tf:Find("window_share_3/number/Text"), arg_1_0.summaryInfoVO.medalCount)
		setText(arg_1_0._tf:Find("window_share_3/count/Text"), arg_1_0.summaryInfoVO.furnitureCount)
		setText(arg_1_0._tf:Find("window_share_3/coin/Text"), arg_1_0.summaryInfoVO.furnitureWorth)
		setText(arg_1_0._tf:Find("window_share_3/collection/Text"), arg_1_0.summaryInfoVO.collectionNum)
		setText(arg_1_0._tf:Find("window_share_3/skin/Text"), arg_1_0.summaryInfoVO.skinNum)

		return
	end
end

return var_0_0
