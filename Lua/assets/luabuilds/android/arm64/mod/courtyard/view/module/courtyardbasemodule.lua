local var_0_0 = class("CourtYardBaseModule")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.state = var_0_1

	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_2
	arg_1_0._tf = arg_1_2.transform
	arg_1_0.data = arg_1_1
	arg_1_0.callbacks = {}

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	if arg_2_0.state == var_0_1 then
		arg_2_0.state = var_0_2

		arg_2_0:OnInit()
		arg_2_0:AddListeners()
	end

	return
end

function var_0_0.IsInit(arg_3_0)
	return arg_3_0.state == var_0_2
end

function var_0_0.AddListener(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.callbacks[arg_4_2] = function(arg_5_0, arg_5_1, ...)
		arg_4_2(arg_4_0, ...)

		return
	end

	arg_4_0.data:AddListener(arg_4_1, function(arg_5_0, arg_5_1, ...)
		arg_4_2(arg_4_0, ...)

		return
	end)

	return
end

function var_0_0.RemoveListener(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.callbacks[arg_6_2] then
		arg_6_0.data:RemoveListener(arg_6_1, arg_6_0.callbacks[arg_6_2])

		arg_6_0.callbacks[arg_6_0.callbacks[arg_6_2]] = nil
	end

	return
end

function var_0_0.GetController(arg_7_0)
	return arg_7_0.data:GetHost()
end

function var_0_0.GetView(arg_8_0)
	return arg_8_0:GetController():GetBridge():GetView()
end

function var_0_0.Emit(arg_9_0, arg_9_1, ...)
	arg_9_0:GetController():Receive(arg_9_1, ...)

	return
end

function var_0_0.Dispose(arg_10_0)
	pg.DelegateInfo.Dispose(arg_10_0)

	if arg_10_0.state == var_0_2 then
		arg_10_0:RemoveListeners()
		arg_10_0:OnDispose()
	end

	arg_10_0.state = var_0_3

	arg_10_0:OnDestroy()

	arg_10_0._go = nil
	arg_10_0.callbacks = nil

	return
end

function var_0_0.IsExit(arg_11_0)
	return arg_11_0.state == var_0_3 or IsNil(arg_11_0._go) or IsNil(arg_11_0._tf)
end

function var_0_0.OnInit(arg_12_0)
	return
end

function var_0_0.AddListeners(arg_13_0)
	return
end

function var_0_0.RemoveListeners(arg_14_0)
	return
end

function var_0_0.OnDispose(arg_15_0)
	return
end

function var_0_0.OnDestroy(arg_16_0)
	return
end

return var_0_0
