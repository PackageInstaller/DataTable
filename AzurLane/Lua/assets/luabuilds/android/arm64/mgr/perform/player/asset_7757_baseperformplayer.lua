class = var_0_10000

local var_0_0 = var_0_10000("BasePerformPlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007
	arg_1_0._anim = var_1_1(var_1_0, var_1_10005(var_1_10007))

	arg_1_0:Hide()

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	assert = var_1_10003

	var_1_10003(nil, "Play方法必须由子类实现")

	return
end

function var_0_0.Show(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0._go, true)

	return
end

function var_0_0.Hide(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0._go, false)

	return
end

function var_0_0.Clear(arg_5_0)
	assert = var_1_10001

	var_1_10001(nil, "Clear方法必须由子类实现")

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
