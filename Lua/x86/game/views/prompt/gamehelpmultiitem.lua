local var_0_0 = class("GameHelpMultiItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.titleText_.text = arg_3_1
	arg_3_0.contentText_.text = arg_3_2
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transfrom_ = nil
	arg_5_0.gameObject_ = nil
end

return var_0_0
