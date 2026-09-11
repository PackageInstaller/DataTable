local var_0_0 = singletonClass("BirthData")

function var_0_0.Init(arg_1_0)
	arg_1_0.isShowPop_ = false
end

function var_0_0.SetPopShowState(arg_2_0, arg_2_1)
	arg_2_0.isShowPop_ = arg_2_1
end

function var_0_0:GetPopShowState()
	return self.isShowPop_
end

return var_0_0
