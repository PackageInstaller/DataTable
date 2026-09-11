local var_0_0 = singletonClass("ActivityVersionData")

function var_0_0.Init(arg_1_0)
	arg_1_0.selectActivityID_ = {}
	arg_1_0.reprintField_ = ""
	arg_1_0.firstEnterActivityIDList_ = {}
end

function var_0_0:SetSelectActivityID(arg_2_1, arg_2_2)
	self.selectActivityID_[arg_2_1] = self.selectActivityID_[arg_2_1] or {}
	self.selectActivityID_[arg_2_1] = arg_2_2
end

function var_0_0:GetSelectActivityID(arg_3_1)
	return self.selectActivityID_[arg_3_1]
end

function var_0_0.SetReprintField(arg_4_0, arg_4_1)
	arg_4_0.reprintField_ = arg_4_1
end

function var_0_0:GetReprintField()
	return self.reprintField_
end

function var_0_0:SetFirstEnterActivityFlag(arg_6_1)
	self.firstEnterActivityIDList_[arg_6_1] = true
end

function var_0_0:GetFirstEnterActivityFlag(arg_7_1)
	return self.firstEnterActivityIDList_[arg_7_1]
end

return var_0_0
