class = var_0_10000

local var_0_0 = "SummaryAnimationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryPage"))

function var_0_1.OnInit(arg_1_0)
	assert = var_1_10001

	var_1_10001(false, "must be overwrite")

	return
end

function var_0_1.Show(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or arg_2_0._tf
	setActive = var_1_10003

	var_1_10003(arg_2_0._tf, true)

	arg_2_0.inAniming = true

	local var_2_0 = arg_2_2
	local var_2_1 = arg_2_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10006

	local var_2_2 = var_2_1(var_2_0, var_5(var_1_10006))

	var_3.SetEndEvent(var_2_2, function(arg_3_0)
		arg_2_0.inAniming = nil

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function var_0_1.inAnim(arg_4_0)
	return arg_4_0.inAniming
end

return var_0_1
