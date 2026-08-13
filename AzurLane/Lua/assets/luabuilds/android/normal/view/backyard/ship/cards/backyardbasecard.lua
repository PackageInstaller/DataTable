class = var_0_10000

local var_0_0 = var_0_10000("BackYardBaseCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._content = arg_1_1:Find("content")

	arg_1_0:OnInit()

	Vector2 = var_3
	arg_1_0.startPos = var_3(135, -354)
	arg_1_0.space = 255

	return
end

function var_0_0.Disable(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0._go, false)

	return
end

function var_0_0.Enable(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0._go, true)

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
		local var_5_0 = arg_5_0.event

		var_1.emit(var_5_0, ...)
	end

	return
end

function var_0_0.Clone(arg_6_0)
	cloneTplTo = var_1_10001

	local var_6_0 = var_1_10001(arg_6_0._go, arg_6_0._go.parent)

	_G = var_2

	return var_2[arg_6_0.__cname].New(var_6_0, arg_6_0.event)
end

function var_0_0.SetSiblingIndex(arg_7_0, arg_7_1)
	arg_7_0._go.gameObject.name = arg_7_1

	local var_7_0 = arg_7_0.startPos.x + (arg_7_1 - 1) * arg_7_0.space
	local var_7_1 = arg_7_0._go

	Vector3 = var_4
	var_7_1.anchoredPosition3D = var_4(var_7_0, arg_7_0.startPos.y, 0)

	return
end

function var_0_0.Dispose(arg_8_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_8_0)
	arg_8_0:OnDispose()

	IsNil = var_1

	if not var_1(arg_8_0._go) then
		Object = var_1

		var_1.Destroy(arg_8_0._go.gameObject)
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
