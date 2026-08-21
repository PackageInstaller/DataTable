local var_0_0 = singletonClass("ActivityUnlockStateData")

function var_0_0.Init(arg_1_0)
	arg_1_0.unlockStateList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.opt_list) do
		arg_2_0.unlockStateList_[iter_2_1.id] = arg_2_0.unlockStateList_[iter_2_1.id] or {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.opt) do
			arg_2_0.unlockStateList_[iter_2_1.id][iter_2_3.key] = iter_2_3.value
		end
	end
end

function var_0_0.UpdateState(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.unlockStateList_[arg_3_1] = arg_3_0.unlockStateList_[arg_3_1] or {}
	arg_3_0.unlockStateList_[arg_3_1][arg_3_2] = arg_3_3
end

function var_0_0.GetUnlockState(arg_4_0, arg_4_1)
	return arg_4_0.unlockStateList_[arg_4_1] or {}
end

return var_0_0
