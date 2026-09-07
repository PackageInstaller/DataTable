local SecondSummaryPage6 = class("SecondSummaryPage6", import(".SummaryAnimationPage"))

function SecondSummaryPage6:OnInit()
	local var_1_0 = self.summaryInfoVO.skinId > 0

	setActive(self._tf:Find("skin_panel"), self.summaryInfoVO.skinId > 0)
	setActive(self._tf:Find("un_panel"), not var_1_0)

	if var_1_0 then
		local var_1_1 = self._tf:Find("skin_panel")

		setPaintingPrefabAsync(var_1_1:Find("paint_panel/painting"), pg.ship_skin_template[self.summaryInfoVO.skinId].painting, "chuanwu")
		setText(var_1_1:Find("window_7/count/Text"), self.summaryInfoVO.skinNum)
		setText(var_1_1:Find("window_7/ship/Text"), self.summaryInfoVO.skinShipNum)
	end

	return
end

function SecondSummaryPage6:Show(arg_2_1)
	SecondSummaryPage6.super.Show(self, arg_2_1, self._tf:Find(self.summaryInfoVO.skinId > 0 and "skin_panel" or "un_panel"))

	return
end

return SecondSummaryPage6
