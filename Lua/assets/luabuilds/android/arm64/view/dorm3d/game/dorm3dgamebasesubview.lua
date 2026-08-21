local var_0_0 = class("Dorm3dGameBaseSubView", import("view.base.BaseEventLogic"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0._tf = arg_1_1
	arg_1_0.go = arg_1_1.gameObject
	arg_1_0.contextData = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.Flush(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0)
	setActive(arg_4_0._tf, true)

	return
end

function var_0_0.Hide(arg_5_0)
	setActive(arg_5_0._tf, false)

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:cleanManagedTween()
	arg_6_0:disposeEvent()
	pg.DelegateInfo.Dispose(arg_6_0)

	return
end

return var_0_0
