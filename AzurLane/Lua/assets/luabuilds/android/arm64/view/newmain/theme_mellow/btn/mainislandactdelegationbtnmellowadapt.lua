local var_0_0 = class("MainIslandActDelegationBtnMellowAdapt", import(".MainCommonSpActBtnAdapt"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root:Find("right")
end

function var_0_0.OnInit(arg_2_0)
	setAnchoredPosition(arg_2_0._tf, {
		x = 178,
		y = 185
	})

	return
end

return var_0_0
