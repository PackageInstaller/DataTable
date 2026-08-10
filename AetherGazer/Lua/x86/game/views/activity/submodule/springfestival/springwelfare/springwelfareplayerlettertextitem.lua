local var_0_0 = class("SpringWelfarePlayerLetterTextItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.richText_ = arg_1_0:FindCom("RichText", "", arg_1_1.transform)
	arg_1_0.buttonUpAudio_ = arg_1_0:FindCom("ButtonUpAudio", "", arg_1_1.transform)
	arg_1_0.buttonUpAudio_.enabled = false
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.SetText(arg_3_0, arg_3_1)
	arg_3_0.richText_.text = arg_3_1
end

return var_0_0
