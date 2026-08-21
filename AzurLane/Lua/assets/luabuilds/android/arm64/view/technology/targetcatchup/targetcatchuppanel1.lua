local var_0_0 = class("TargetCatchupPanel1", import(".BaseTargetCatchupPanel"))

function var_0_0.getUIName(arg_1_0)
	return "TargetCatchupPanel1"
end

function var_0_0.init(arg_2_0)
	arg_2_0.tecID = 1

	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

return var_0_0
