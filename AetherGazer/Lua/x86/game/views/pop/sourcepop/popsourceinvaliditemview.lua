local var_0_0 = class("PopSourceInvalidItemView", ReduxView)
local var_0_1 = import("game.tools.JumpTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.data_ = arg_1_3

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.btn_ = nil
	arg_3_0.sourceText_ = nil
	arg_3_0.sourceContent_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.sourceContent_.text, arg_4_0.sourceText_.text = var_0_1.GetName(arg_4_0.data_)
end

return var_0_0
