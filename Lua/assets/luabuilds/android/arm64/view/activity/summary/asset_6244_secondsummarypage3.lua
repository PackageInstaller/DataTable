local SecondSummaryPage3 = class("SecondSummaryPage3", import(".SummaryAnimationPage"))

function SecondSummaryPage3:OnInit()
	setActive(self._tf:Find("propose_panel"), self.summaryInfoVO.isProPose)
	setActive(self._tf:Find("un_panel"), not self.summaryInfoVO.isProPose)

	if self.summaryInfoVO.isProPose then
		local var_1_0 = self._tf:Find("propose_panel")

		setPaintingPrefabAsync(var_1_0:Find("paint_panel/painting"), Ship.New({
			configId = self.summaryInfoVO.firstLadyId
		}):getPainting(), "chuanwu")
		setText(var_1_0:Find("window_5/ship_name/Text"), self.summaryInfoVO.firstProposeName)
		setText(var_1_0:Find("window_5/day/Text"), self.summaryInfoVO.proposeTime)
		setText(var_1_0:Find("window_6/number/Text"), self.summaryInfoVO.proposeCount)
		setText(var_1_0:Find("window_6/number_2/Text"), self.summaryInfoVO.maxIntimacyNum)
	end

	return
end

function SecondSummaryPage3:Show(arg_2_1)
	SecondSummaryPage3.super.Show(self, arg_2_1, self._tf:Find(self.summaryInfoVO.isProPose and "propose_panel" or "un_panel"))

	return
end

return SecondSummaryPage3
