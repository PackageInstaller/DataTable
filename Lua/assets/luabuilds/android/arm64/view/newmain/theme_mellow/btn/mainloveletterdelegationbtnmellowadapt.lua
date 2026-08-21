local var_0_0 = class("MainLoveLetterDelegationBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root:Find("right")
end

function var_0_0.OnInit(arg_2_0)
	setAnchoredPosition(arg_2_0._tf, {
		x = 168,
		y = 198
	})

	return
end

function var_0_0.InShowTime(arg_3_0)
	return false
end

return var_0_0
