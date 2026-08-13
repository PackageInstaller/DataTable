class = var_0_10000

local var_0_0 = "SecondSummaryPage6"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SummaryAnimationPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0.summaryInfoVO.skinId
	local var_1_1 = 0 < var_1_0

	setActive = var_2

	local var_1_2 = arg_1_0._tf

	var_2(var_4.Find(var_1_2, "skin_panel"), var_1_1)

	setActive = var_2

	local var_1_3 = arg_1_0._tf

	var_2(var_4.Find(var_1_3, "un_panel"), not var_1_1)

	if var_1_1 then
		pg = var_2

		local var_1_4 = var_2.ship_skin_template[arg_1_0.summaryInfoVO.skinId].painting
		local var_1_5 = arg_1_0._tf
		local var_1_6 = var_3.Find(var_1_5, "skin_panel")

		setPaintingPrefabAsync = var_4

		var_4(var_1_6:Find("paint_panel/painting"), var_1_4, "chuanwu")

		setText = var_4

		var_4(var_1_6:Find("window_7/count/Text"), arg_1_0.summaryInfoVO.skinNum)

		setText = var_4

		var_4(var_1_6:Find("window_7/ship/Text"), arg_1_0.summaryInfoVO.skinShipNum)
	end

	return
end

function var_0_1.Show(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1.super.Show
	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_1
	local var_2_3 = arg_2_0._tf

	var_2_0(var_2_1, var_2_2, var_6.Find(var_2_3, arg_2_0.summaryInfoVO.skinId > 0 and "skin_panel" or "un_panel"))

	return
end

return var_0_1
