local var_0_0 = class("ClubTaskItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.JumpToPage2(arg_4_0.taskCfg_.source)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.info_ = TaskData2:GetTask(arg_8_0.taskID_)
	arg_8_0.taskCfg_ = AssignmentCfg[arg_8_0.taskID_]
	arg_8_0.titleText_.text = GetI18NText(arg_8_0.taskCfg_.desc)

	arg_8_0:RefreshType()
	arg_8_0:RefreshProgress()
	arg_8_0:RefreshReward()
end

function var_0_0.RefreshType(arg_9_0)
	return
end

function var_0_0.RefreshReward(arg_10_0)
	return
end

function var_0_0.RefreshProgress(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	for iter_12_0 = #arg_12_0.rewardItems_, 1, -1 do
		arg_12_0.rewardItems_[iter_12_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	for iter_13_0 = #arg_13_0.rewardItems_, 1, -1 do
		arg_13_0.rewardItems_[iter_13_0]:Dispose()

		arg_13_0.rewardItems_[iter_13_0] = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
