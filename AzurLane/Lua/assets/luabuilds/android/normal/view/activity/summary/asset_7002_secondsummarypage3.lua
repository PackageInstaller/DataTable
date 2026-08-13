class = var_0_10000

local var_0_0 = "SecondSummaryPage3"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	setActive = var_1_10001

	local var_1_0 = arg_1_0._tf

	var_1_10001(var_2.Find(var_1_0, "propose_panel"), arg_1_0.summaryInfoVO.isProPose)

	setActive = var_1_10001

	local var_1_1 = arg_1_0._tf

	var_1_10001(var_2.Find(var_1_1, "un_panel"), not arg_1_0.summaryInfoVO.isProPose)

	if arg_1_0.summaryInfoVO.isProPose then
		Ship = var_1

		local var_1_2 = var_1.New({
			configId = arg_1_0.summaryInfoVO.firstLadyId
		})
		local var_1_3 = var_1.getPainting(var_1_2)
		local var_1_4 = arg_1_0._tf
		local var_1_5 = var_2.Find(var_1_4, "propose_panel")

		setPaintingPrefabAsync = var_1_4

		var_1_4(var_1_5:Find("paint_panel/painting"), var_1_3, "chuanwu")

		setText = var_1_4

		var_1_4(var_1_5:Find("window_5/ship_name/Text"), arg_1_0.summaryInfoVO.firstProposeName)

		setText = var_1_4

		var_1_4(var_1_5:Find("window_5/day/Text"), arg_1_0.summaryInfoVO.proposeTime)

		setText = var_1_4

		var_1_4(var_1_5:Find("window_6/number/Text"), arg_1_0.summaryInfoVO.proposeCount)

		setText = var_1_4

		var_1_4(var_1_5:Find("window_6/number_2/Text"), arg_1_0.summaryInfoVO.maxIntimacyNum)
	end

	return
end

function var_0_1.Show(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1.super.Show
	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_1
	local var_2_3 = arg_2_0._tf

	var_2_0(var_2_1, var_2_2, var_5.Find(var_2_3, arg_2_0.summaryInfoVO.isProPose and "propose_panel" or "un_panel"))

	return
end

return var_0_1
