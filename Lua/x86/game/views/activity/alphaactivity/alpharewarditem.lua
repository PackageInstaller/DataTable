local var_0_0 = class("AlphaRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rewardItems_ = {}
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	return
end

function var_0_0.GetTaskID(arg_5_0)
	return arg_5_0.taskID_
end

function var_0_0.RefreshReward(arg_6_0, arg_6_1)
	arg_6_0.taskID_ = arg_6_1
	arg_6_0.titleText_.text = GetI18NText(AssignmentCfg[arg_6_1].desc)

	local var_6_0 = AssignmentCfg[arg_6_1].reward

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if arg_6_0.rewardItems_[iter_6_0] == nil then
			arg_6_0.rewardItems_[iter_6_0] = RewardItem.New(arg_6_0.rewardTemplate_, arg_6_0.rewardParent_, true)

			arg_6_0.rewardItems_[iter_6_0]:UpdateCommonItemAni()
		end

		arg_6_0.rewardItems_[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #var_6_0 + 1, #arg_6_0.rewardItems_ do
		arg_6_0.rewardItems_[iter_6_2]:Show(false)
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()

	for iter_8_0 = 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_0]:Dispose()

		arg_8_0.rewardItems_[iter_8_0] = nil
	end

	arg_8_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
