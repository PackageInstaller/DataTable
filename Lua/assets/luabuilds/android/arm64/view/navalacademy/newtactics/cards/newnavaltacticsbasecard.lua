local var_0_0 = class("NewNavalTacticsBaseCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject

	arg_1_0:OnInit()

	return
end

function var_0_0.emit(arg_2_0, ...)
	if arg_2_0.event then
		arg_2_0.event:emit(...)
	end

	return
end

function var_0_0.UpdatePosition(arg_3_0, arg_3_1)
	arg_3_0._tf.anchoredPosition3D = Vector3(-493 + (arg_3_1 - 1) * (arg_3_0._tf.sizeDelta.x + 0), arg_3_0._tf.anchoredPosition3D.y, 0)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index = arg_4_1

	arg_4_0:UpdatePosition(arg_4_1)
	arg_4_0:OnUpdate(arg_4_2)

	return
end

function var_0_0.Enable(arg_5_0)
	setActive(arg_5_0._go, true)

	return
end

function var_0_0.Disable(arg_6_0)
	setActive(arg_6_0._go, false)

	return
end

function var_0_0.Dispose(arg_7_0)
	pg.DelegateInfo.Dispose(arg_7_0)
	Object.Destroy(arg_7_0._go)
	arg_7_0:OnDispose()

	return
end

function var_0_0.Clone(arg_8_0)
	local var_8_0 = Object.Instantiate(arg_8_0._go, arg_8_0._tf.parent)

	assert(var_8_0)

	return _G[arg_8_0.__cname].New(var_8_0.transform, arg_8_0.event)
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
