local var_0_0 = class("ActivityPushBoxRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	arg_6_0.info_ = arg_6_1
	arg_6_0.taskID_ = arg_6_1.id
	arg_6_0.cfg_ = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshReward()
	arg_7_0:RefreshTask()
end

function var_0_0.RefreshReward(arg_8_0)
	local var_8_0 = arg_8_0.cfg_.reward

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.rewardItems_[iter_8_0] then
			arg_8_0.rewardItems_[iter_8_0] = RewardItem.New(arg_8_0.rewardItem_, arg_8_0.rewardParent_)

			arg_8_0.rewardItems_[iter_8_0]:UpdateCommonItemAni()
		end

		arg_8_0.rewardItems_[iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshTask(arg_9_0)
	arg_9_0.desc_.text = GetI18NText(arg_9_0.cfg_.desc)

	local var_9_0 = arg_9_0.info_.progress > arg_9_0.cfg_.need and arg_9_0.cfg_.need or arg_9_0.info_.progress

	arg_9_0.progress_.text = var_9_0 .. "/" .. arg_9_0.cfg_.need
	arg_9_0.slider_.value = var_9_0 / arg_9_0.cfg_.need

	if arg_9_0.info_.complete_flag >= 1 then
		arg_9_0.stateCon_:SetSelectedState("received")
	elseif arg_9_0.info_.progress >= arg_9_0.cfg_.need then
		arg_9_0.stateCon_:SetSelectedState("complete")
	else
		arg_9_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0 = 1, #arg_11_0.rewardItems_ do
		arg_11_0.rewardItems_[iter_11_0]:Dispose()
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
