local var_0_0 = class("SectionExtraAttachBaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_0.OnEnter(arg_2_0)
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.OnExit(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.RefreshUI(arg_6_0)
	return
end

return var_0_0
