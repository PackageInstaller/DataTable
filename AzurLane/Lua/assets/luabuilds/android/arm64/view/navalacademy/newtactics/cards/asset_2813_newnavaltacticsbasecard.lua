class = var_0_10000

local var_0_0 = var_0_10000("NewNavalTacticsBaseCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject

	arg_1_0:OnInit()

	return
end

function var_0_0.emit(arg_2_0, ...)
	if arg_2_0.event then
		local var_2_0 = arg_2_0.event

		var_1.emit(var_2_0, ...)
	end

	return
end

function var_0_0.UpdatePosition(arg_3_0, arg_3_1)
	local var_3_0 = -493
	local var_3_1 = 0
	local var_3_2 = arg_3_0._tf.sizeDelta.x
	local var_3_3 = arg_3_0._tf.anchoredPosition3D
	local var_3_4 = var_3_0 + (arg_3_1 - 1) * (var_3_2 + var_3_1)
	local var_3_5 = arg_3_0._tf

	Vector3 = var_1_10008
	var_3_5.anchoredPosition3D = var_1_10008(var_3_4, var_3_3.y, 0)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index = arg_4_1

	arg_4_0:UpdatePosition(arg_4_1)
	arg_4_0:OnUpdate(arg_4_2)

	return
end

function var_0_0.Enable(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._go, true)

	return
end

function var_0_0.Disable(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0._go, false)

	return
end

function var_0_0.Dispose(arg_7_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_7_0)

	Object = var_1

	var_1.Destroy(arg_7_0._go)
	arg_7_0:OnDispose()

	return
end

function var_0_0.Clone(arg_8_0)
	Object = var_1_10001

	local var_8_0 = var_1_10001.Instantiate(arg_8_0._go, arg_8_0._tf.parent)

	assert = var_1_10002

	var_1_10002(var_8_0)

	_G = var_1_10002

	return var_1_10002[arg_8_0.__cname].New(var_8_0.transform, arg_8_0.event)
end

function var_0_0.OnInit(arg_9_0)
	return
end

function var_0_0.OnUpdate(arg_10_0, arg_10_1)
	return
end

function var_0_0.OnDispose(arg_11_0)
	return
end

return var_0_0
