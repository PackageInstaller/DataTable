local var_0_0 = class("ActivityNewWarChessMainTaskItem", ReduxView)

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
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_6_0 = AssignmentCfg[arg_4_0.taskID_]

		JumpTools.JumpToPage2(var_6_0.source)
	end)
end

function var_0_0.GetTaskComplete(arg_7_0)
	local var_7_0 = TaskData2:GetTask(arg_7_0.taskID_)

	return var_7_0 == nil or var_7_0.complete_flag >= 1
end

function var_0_0.Refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.activityID_ = arg_8_2
	arg_8_0.cfg_ = AssignmentCfg[arg_8_1]
	arg_8_0.info_ = TaskData2:GetTask(arg_8_0.taskID_)

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshReward()
	arg_9_0:RefreshTask()
end

function var_0_0.RefreshReward(arg_10_0)
	local var_10_0 = arg_10_0.cfg_.reward

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if not arg_10_0.rewardItems_[iter_10_0] then
			arg_10_0.rewardItems_[iter_10_0] = RewardItem.New(arg_10_0.rewardItem_, arg_10_0.rewardParent_)

			arg_10_0.rewardItems_[iter_10_0]:UpdateCommonItemAni()
		end

		arg_10_0.rewardItems_[iter_10_0]:SetData(iter_10_1)
	end

	for iter_10_2 = #var_10_0 + 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_2]:Show(false)
	end
end

function var_0_0.RefreshTask(arg_11_0)
	arg_11_0.desc_.text = arg_11_0.cfg_.desc

	local var_11_0 = arg_11_0.info_.progress > arg_11_0.cfg_.need and arg_11_0.cfg_.need or arg_11_0.info_.progress

	if arg_11_0.info_.complete_flag >= 1 then
		var_11_0 = arg_11_0.cfg_.need
	end

	arg_11_0.progress_.text = var_11_0 .. "/" .. arg_11_0.cfg_.need
	arg_11_0.slider_.value = var_11_0 / arg_11_0.cfg_.need

	if arg_11_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_11_0.typeCon_:SetSelectedState("normal")
	else
		arg_11_0.typeCon_:SetSelectedState("challenge")
	end

	if arg_11_0.info_.complete_flag >= 1 then
		arg_11_0.stateCon_:SetSelectedState("received")
	elseif arg_11_0.info_.progress >= arg_11_0.cfg_.need then
		arg_11_0.stateCon_:SetSelectedState("complete")
	else
		arg_11_0.stateCon_:SetSelectedState("go")
	end
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	for iter_13_0 = 1, #arg_13_0.rewardItems_ do
		arg_13_0.rewardItems_[iter_13_0]:Dispose()
	end

	arg_13_0.rewardItems_ = {}

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
