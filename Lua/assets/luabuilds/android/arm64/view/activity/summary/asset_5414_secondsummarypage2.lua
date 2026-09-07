local SecondSummaryPage2 = class("SecondSummaryPage2", import(".SummaryAnimationPage"))

function SecondSummaryPage2:OnInit()
	setPaintingPrefabAsync(self._tf:Find("paint_panel/painting"), Ship.New({
		configId = self.summaryInfoVO.flagShipId
	}):getPainting(), "chuanwu")
	setText(self._tf:Find("window_1/name"), self.summaryInfoVO.name)
	setText(self._tf:Find("window_1/time/Text"), "「" .. self.summaryInfoVO.registerTime .. "」")
	setText(self._tf:Find("window_1/server/Text"), "「" .. self.summaryInfoVO.serverName .. "」")
	setText(self._tf:Find("window_1/day/Text"), self.summaryInfoVO.days)

	local var_1_0 = self.summaryInfoVO:hasGuild()

	setActive(self._tf:Find("window_2/has_guild"), var_1_0)
	setActive(self._tf:Find("window_2/without"), not var_1_0)

	local var_1_1 = self._tf:Find("window_2/" .. (var_1_0 and "has_guild" or "without"))

	if var_1_0 then
		setText(var_1_1:Find("guild_name/Text"), "「" .. self.summaryInfoVO.guildName .. "」")
	end

	setText(var_1_1:Find("chapter_name/Text"), "「" .. self.summaryInfoVO.chapterName .. "」")

	if self.summaryInfoVO.worldProgressTask > 0 then
		setText(var_1_1:Find("world_name/Text"), "「" .. pg.world_task_data[self.summaryInfoVO.worldProgressTask].name .. "」")
	else
		setText(var_1_1:Find("world_name/Text"), i18n("five_shujuhuigu"))
	end

	setText(self._tf:Find("window_3/count/Text"), self.summaryInfoVO.furnitureCount)
	setText(self._tf:Find("window_3/coin/Text"), self.summaryInfoVO.furnitureWorth)
	setText(self._tf:Find("window_4/collection/Text"), self.summaryInfoVO.collectionNum)
	setText(self._tf:Find("window_4/power/Text"), self.summaryInfoVO.powerRaw)
	setText(self._tf:Find("window_4/ship/Text"), self.summaryInfoVO.totalShipNum)
	setText(self._tf:Find("window_4/top_ship/Text"), self.summaryInfoVO.topShipNum)
	setText(self._tf:Find("window_4/best_ship/Text"), self.summaryInfoVO.bestShipNum)

	return
end

return SecondSummaryPage2
