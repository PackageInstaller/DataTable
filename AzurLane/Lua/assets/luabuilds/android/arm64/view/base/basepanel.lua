local var_0_0 = class("BasePanel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	assert(arg_1_1)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	function arg_1_0.emit()
		assert(false, "can not emit event beforce attach to a parent ui.")

		return
	end

	bindComponent(arg_1_0, arg_1_0._go)
	arg_1_0:init()

	return
end

function var_0_0.init(arg_3_0)
	return
end

function var_0_0.attach(arg_4_0, arg_4_1)
	assert(arg_4_1)

	arg_4_0.exited = false
	arg_4_0.parent = arg_4_1
	arg_4_0.contextData = arg_4_1.contextData

	function arg_4_0.emit(arg_5_0, arg_5_1, ...)
		if arg_5_0.parent then
			arg_5_0.parent:emit(arg_5_1, ...)
		end

		return
	end

	function arg_4_0.bind(arg_6_0, ...)
		if arg_6_0.parent then
			arg_6_0.parent:bind(...)
		end

		return
	end

	function arg_4_0.disconnect(arg_7_0, arg_7_1)
		if arg_7_0.parent then
			arg_7_0.parent:disconnect(arg_7_1)
		end

		return
	end

	setActive(arg_4_0._go, true)
	pg.DelegateInfo.New(arg_4_0)

	return
end

function var_0_0.detach(arg_8_0)
	if not arg_8_0.exited then
		setActive(arg_8_0._go, false)
		pg.DelegateInfo.Dispose(arg_8_0)
		arg_8_0:clear()
		bindComponent(arg_8_0, arg_8_0._go, true)

		arg_8_0.parent = nil
		arg_8_0.emit = nil
		arg_8_0.bind = nil
		arg_8_0.disconnect = nil
		arg_8_0.exited = true
	end

	return
end

function var_0_0.getTpl(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:Find(arg_9_1)

	var_9_0:SetParent(arg_9_0._tf, false)
	SetActive(var_9_0, false)

	return var_9_0
end

function var_0_0.clear(arg_10_0)
	return
end

return var_0_0
