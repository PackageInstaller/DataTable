class = var_0_10000

local var_0_0 = "NewYearShrineBuffView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ShrineBuffView"))

function var_0_1.getUIName(arg_1_0)
	return "NewYearShrineBuff"
end

function var_0_1.initUI(arg_2_0)
	var_0_1.super.initUI(arg_2_0)

	GetComponent = var_1
	arg_2_0.dft = var_1(arg_2_0._tf, "DftAniEvent")

	local var_2_0 = arg_2_0.dft

	var_1.SetStartEvent(var_2_0, function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_2_0.backBtn, false)

		return
	end)

	local var_2_1 = arg_2_0.dft

	var_1.SetEndEvent(var_2_1, function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_2_0.backBtn, true)

		return
	end)

	return
end

return var_0_1
