local var_0_0 = class("SecondSummaryPage3", import(".SummaryAnimationPage"))

function var_0_0.OnInit(arg_1_0)
	setActive(arg_1_0._tf:Find("propose_panel"), arg_1_0.summaryInfoVO.isProPose)
	setActive(arg_1_0._tf:Find("un_panel"), not arg_1_0.summaryInfoVO.isProPose)

	if arg_1_0.summaryInfoVO.isProPose then
		local var_1_0 = arg_1_0._tf:Find("propose_panel")

		setPaintingPrefabAsync(var_1_0:Find("paint_panel/painting"), Ship.New({
			configId = arg_1_0.summaryInfoVO.firstLadyId
		}):getPainting(), "chuanwu")
		setText(var_1_0:Find("window_5/ship_name/Text"), arg_1_0.summaryInfoVO.firstProposeName)
		setText(var_1_0:Find("window_5/day/Text"), arg_1_0.summaryInfoVO.proposeTime)
		setText(var_1_0:Find("window_6/number/Text"), arg_1_0.summaryInfoVO.proposeCount)
		setText(var_1_0:Find("window_6/number_2/Text"), arg_1_0.summaryInfoVO.maxIntimacyNum)
	end

	return
end

function var_0_0.Show(arg_2_0, arg_2_1)
	var_0_0.super.Show(arg_2_0, arg_2_1, arg_2_0._tf:Find(arg_2_0.summaryInfoVO.isProPose and "propose_panel" or "un_panel"))

	return
end

return var_0_0
