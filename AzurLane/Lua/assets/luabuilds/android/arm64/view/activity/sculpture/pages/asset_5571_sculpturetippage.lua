class = var_0_10000

local var_0_0 = "SculptureTipPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SculptureTipUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tip = var_1.Find(var_2_0, "tip")

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.Show(arg_4_0)
	var_0_1.super.Show(arg_4_0)

	setActive = var_1

	var_1(arg_4_0.tip, true)

	onDelayTick = var_1

	var_1(function()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end, 2)

	return
end

function var_0_1.Hide(arg_6_0)
	var_0_1.super.Hide(arg_6_0)

	setActive = var_1

	var_1(arg_6_0.tip, false)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
