class = var_0_10000

local var_0_0 = "PlayerVitaeEducateBaseCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject

	return
end

function var_0_1.ShowOrHide(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._tf, arg_2_1)

	if not arg_2_1 then
		arg_2_0:Clear()
	end

	return
end

function var_0_1.Flush(arg_3_0)
	return
end

function var_0_1.Clear(arg_4_0)
	return
end

function var_0_1.Dispose(arg_5_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_5_0)
	arg_5_0:Clear()

	return
end

return var_0_1
