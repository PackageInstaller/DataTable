local var_0_0 = singletonClass("ActivityVersionData")

function var_0_0.Init(arg_1_0)
	arg_1_0.selectActivityID_ = {}
	arg_1_0.reprintField_ = ""
	arg_1_0.firstEnterActivityIDList_ = {}
end

function var_0_0.SetSelectActivityID(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.selectActivityID_[arg_2_1] = arg_2_0.selectActivityID_[arg_2_1] or {}
	arg_2_0.selectActivityID_[arg_2_1] = arg_2_2
end

function var_0_0.GetSelectActivityID(arg_3_0, arg_3_1)
	return arg_3_0.selectActivityID_[arg_3_1]
end

function var_0_0.SetReprintField(arg_4_0, arg_4_1)
	arg_4_0.reprintField_ = arg_4_1
end

function var_0_0.GetReprintField(arg_5_0)
	return arg_5_0.reprintField_
end

function var_0_0.SetFirstEnterActivityFlag(arg_6_0, arg_6_1)
	arg_6_0.firstEnterActivityIDList_[arg_6_1] = true
end

function var_0_0.GetFirstEnterActivityFlag(arg_7_0, arg_7_1)
	return arg_7_0.firstEnterActivityIDList_[arg_7_1]
end

return var_0_0
