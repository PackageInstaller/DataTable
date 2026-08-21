local var_0_0 = class("RechargePageBase", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, ...)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init(...)
end

function var_0_0.Init(arg_2_0, ...)
	arg_2_0:InitUI(...)
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0, ...)
	return
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.UpdateBar(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Hide(arg_8_0)
	SetActive(arg_8_0.gameObject_, false)
end

function var_0_0.Show(arg_9_0)
	SetActive(arg_9_0.gameObject_, true)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

return var_0_0
