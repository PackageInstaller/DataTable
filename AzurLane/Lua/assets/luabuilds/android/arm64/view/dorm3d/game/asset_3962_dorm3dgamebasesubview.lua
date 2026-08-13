class = var_0_10000

local var_0_0 = "Dorm3dGameBaseSubView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0._tf = arg_1_1
	arg_1_0.go = arg_1_1.gameObject
	arg_1_0.contextData = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	return
end

function var_0_1.Flush(arg_3_0)
	return
end

function var_0_1.Show(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0._tf, true)

	return
end

function var_0_1.Hide(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._tf, false)

	return
end

function var_0_1.Dispose(arg_6_0)
	arg_6_0:cleanManagedTween()
	arg_6_0:disposeEvent()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_6_0)

	return
end

return var_0_1
