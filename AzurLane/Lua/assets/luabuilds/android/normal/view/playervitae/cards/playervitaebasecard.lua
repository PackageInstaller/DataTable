class = var_0_10000

local var_0_0 = var_0_10000("PlayerVitaeBaseCard")
local var_0_1 = 160
local var_0_2 = 25

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_2
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)
	arg_1_0:Init(arg_1_1)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform
	arg_2_0.width = arg_2_0._tf.sizeDelta.x

	local var_2_0 = arg_2_0._tf

	arg_2_0.mask = var_2.Find(var_2_0, "mask")

	arg_2_0:OnInit()

	return
end

function var_0_0.UpdatePosition(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1 + (arg_3_0.width + var_0_2) * (arg_3_1 - 1)
	local var_3_1 = arg_3_0._tf

	Vector3 = var_4
	var_3_1.anchoredPosition3D = var_4(var_3_0, 0, 0)

	local var_3_2 = arg_3_0._tf

	var_3.SetSiblingIndex(var_3_2, arg_3_1 - 1)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0:OnUpdate(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0:UpdatePosition(arg_4_1)

	return
end

function var_0_0.Enable(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._tf, true)

	return
end

function var_0_0.Disable(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0._tf, false)

	return
end

function var_0_0.Clone(arg_7_0)
	cloneTplTo = var_1_10001

	local var_7_0 = var_1_10001(arg_7_0._go, arg_7_0._go.parent)

	_G = var_2

	return var_2[arg_7_0.__cname].New(var_7_0, arg_7_0.event)
end

function var_0_0.emit(arg_8_0, ...)
	if arg_8_0.event then
		local var_8_0 = arg_8_0.event

		var_1.emit(var_8_0, ...)
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_9_0)
	arg_9_0:OnDispose()

	return
end

function var_0_0.OnInit(arg_10_0)
	return
end

function var_0_0.OnUpdate(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	return
end

function var_0_0.OnDispose(arg_12_0)
	return
end

return var_0_0
