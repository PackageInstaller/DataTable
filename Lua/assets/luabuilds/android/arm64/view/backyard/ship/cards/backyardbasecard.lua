local var_0_0 = class("BackYardBaseCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._content = arg_1_1:Find("content")

	arg_1_0:OnInit()

	arg_1_0.startPos = Vector2(135, -354)
	arg_1_0.space = 255

	return
end

function var_0_0.Disable(arg_2_0)
	setActive(arg_2_0._go, false)

	return
end

function var_0_0.Enable(arg_3_0)
	setActive(arg_3_0._go, true)

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.type = arg_4_1
	arg_4_0.ship = arg_4_2

	arg_4_0:OnFlush()

	return
end

function var_0_0.emit(arg_5_0, ...)
	if arg_5_0.event then
		arg_5_0.event:emit(...)
	end

	return
end

function var_0_0.Clone(arg_6_0)
	return _G[arg_6_0.__cname].New(cloneTplTo(arg_6_0._go, arg_6_0._go.parent), arg_6_0.event)
end

function var_0_0.SetSiblingIndex(arg_7_0, arg_7_1)
	arg_7_0._go.gameObject.name = arg_7_1
	arg_7_0._go.anchoredPosition3D = Vector3(arg_7_0.startPos.x + (arg_7_1 - 1) * arg_7_0.space, arg_7_0.startPos.y, 0)

	return
end

function var_0_0.Dispose(arg_8_0)
	pg.DelegateInfo.Dispose(arg_8_0)
	arg_8_0:OnDispose()

	if not IsNil(arg_8_0._go) then
		Object.Destroy(arg_8_0._go.gameObject)
	end

	return
end

function var_0_0.OnInit(arg_9_0)
	return
end

function var_0_0.OnFlush(arg_10_0)
	return
end

function var_0_0.OnDispose(arg_11_0)
	return
end

return var_0_0
