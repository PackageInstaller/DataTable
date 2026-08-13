class = var_0_10000

local var_0_0 = "MainVoteEntranceBtnMellowAdapt"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainCommonSpActBtnAdapt"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root

	return var_1.Find(var_1_0, "right")
end

function var_0_1.OnInit(arg_2_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_2_0._tf, {
		x = 208,
		y = 209
	})

	return
end

function var_0_1.InShowTime(arg_3_0)
	return false
end

return var_0_1
