local SecondSummaryPage5 = class("SecondSummaryPage5", import(".SummaryAnimationPage"))

function SecondSummaryPage5:OnInit()
	setText(self._tf:Find("window_share_1/name"), self.summaryInfoVO.name)
	setText(self._tf:Find("window_share_1/time/Text"), "「" .. self.summaryInfoVO.registerTime .. "」")
	setText(self._tf:Find("window_share_1/day/Text"), self.summaryInfoVO.days)

	local var_1_0 = self.summaryInfoVO:hasGuild()

	setActive(self._tf:Find("window_share_2/has_guild"), var_1_0)
	setActive(self._tf:Find("window_share_2/without"), not var_1_0)

	local var_1_1

	if var_1_0 then
		var_1_1 = self._tf:Find("window_share_2/has_guild") or self._tf:Find("window_share_2/without")

		if var_1_0 then
			setText(var_1_1:Find("guild_name/Text"), "「" .. self.summaryInfoVO.guildName .. "」")
		end
	end

	setText(var_1_1:Find("chapter_name/Text"), "「" .. self.summaryInfoVO.chapterName .. "」")
	setText(var_1_1:Find("number/Text"), self.summaryInfoVO.proposeCount)
	setText(self._tf:Find("window_share_3/number/Text"), self.summaryInfoVO.medalCount)
	setText(self._tf:Find("window_share_3/count/Text"), self.summaryInfoVO.furnitureCount)
	setText(self._tf:Find("window_share_3/coin/Text"), self.summaryInfoVO.furnitureWorth)
	setText(self._tf:Find("window_share_3/collection/Text"), self.summaryInfoVO.collectionNum)
	setText(self._tf:Find("window_share_3/skin/Text"), self.summaryInfoVO.skinNum)

	return
end

return SecondSummaryPage5
