class = var_0_10000

local var_0_0 = var_0_10000("SummaryPage")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)
	pg = var_2

	var_2.DelegateInfo.New(arg_1_0)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.summaryInfoVO = arg_2_1

	arg_2_0:OnInit()

	return
end

function var_0_0.OnInit(arg_3_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._tf, true)

	if arg_4_1 then
		arg_4_1()
	end

	return
end

function var_0_0.Hide(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0._tf, false)

	if arg_5_1 then
		arg_5_1()
	end

	return
end

function var_0_0.inAnim(arg_6_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_0.Clear(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_8_0)
	arg_8_0:Clear()

	return
end

return var_0_0
