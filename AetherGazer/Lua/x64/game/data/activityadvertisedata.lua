local var_0_0 = singletonClass("ActivityAdvertiseData")

function var_0_0.Init(arg_1_0)
	arg_1_0.openAdvertiseFlag_ = {}
	arg_1_0.defaultPrompt_ = true
end

function var_0_0.SetOpenAdvertiseFlag(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.openAdvertiseFlag_[arg_2_1] = arg_2_2
end

function var_0_0.GetOpenAdvertiseFlag(arg_3_0, arg_3_1)
	return arg_3_0.openAdvertiseFlag_[arg_3_1]
end

function var_0_0.SetDefaultPrompt(arg_4_0, arg_4_1)
	arg_4_0.defaultPrompt_ = arg_4_1
end

function var_0_0.GetDefaultPrompt(arg_5_0)
	return arg_5_0.defaultPrompt_
end

return var_0_0
