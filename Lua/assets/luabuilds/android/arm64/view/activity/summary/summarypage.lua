local var_0_0 = class("SummaryPage")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)

	pg.DelegateInfo.New(arg_1_0)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.summaryInfoVO = arg_2_1

	arg_2_0:OnInit()

	return
end

function var_0_0.OnInit(arg_3_0)
	assert(false)

	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	setActive(arg_4_0._tf, true)

	if arg_4_1 then
		arg_4_1()
	end

	return
end

function var_0_0.Hide(arg_5_0, arg_5_1)
	setActive(arg_5_0._tf, false)

	if arg_5_1 then
		arg_5_1()
	end

	return
end

function var_0_0.inAnim(arg_6_0)
	assert(false)

	return
end

function var_0_0.Clear(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	pg.DelegateInfo.Dispose(arg_8_0)
	arg_8_0:Clear()

	return
end

return var_0_0
