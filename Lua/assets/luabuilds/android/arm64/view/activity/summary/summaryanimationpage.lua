local var_0_0 = class("SummaryAnimationPage", import(".SummaryPage"))

function var_0_0.OnInit(arg_1_0)
	assert(false, "must be overwrite")

	return
end

function var_0_0.Show(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or arg_2_0._tf

	setActive(arg_2_0._tf, true)

	arg_2_0.inAniming = true

	arg_2_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_3_0)
		arg_2_0.inAniming = nil

		if arg_2_1 then
			arg_2_1()
		end

		return
	end)

	return
end

function var_0_0.inAnim(arg_4_0)
	return arg_4_0.inAniming
end

return var_0_0
