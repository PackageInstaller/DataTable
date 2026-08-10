local var_0_0 = class("AlphaStageTaskItem", ReduxView)
local var_0_1 = {
	"lock",
	"receive",
	"received"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.stateCon_ = ControllerUtil.GetController(arg_1_0.transform_, "state")

	arg_1_0:InitUI()
	arg_1_0:AddUIListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rewardItemS_ = {}
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
		arg_3_0:ChangeState("received")
	end)
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.GetTaskID(arg_6_0)
	return arg_6_0.taskID_
end

function var_0_0.GetTaskProgress(arg_7_0)
	local var_7_0 = TaskData2:GetTask(arg_7_0.taskID_)

	return var_7_0 and var_7_0.progress or 0
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	arg_8_0.taskID_ = arg_8_1

	SetActive(arg_8_0.gameObject_, true)
	arg_8_0:RefreshState()
	arg_8_0:RefreshReward()
	arg_8_0:RefreshProgress()
end

function var_0_0.RefreshState(arg_9_0)
	arg_9_0.stage_ = AssignmentCfg[arg_9_0.taskID_].phase

	if TaskData2:GetAssignmentPhase() > arg_9_0.stage_ then
		arg_9_0:ChangeState("received")
	elseif TaskData2:GetAssignmentPhase() == arg_9_0.stage_ and arg_9_0:IsTaskFinish() then
		arg_9_0:ChangeState("receive")
	else
		arg_9_0:ChangeState("lock")
	end
end

function var_0_0.ChangeState(arg_10_0, arg_10_1)
	arg_10_0.stateCon_:SetSelectedState(arg_10_1)
end

function var_0_0.IsTaskFinish(arg_11_0)
	return TaskData2:GetTask(arg_11_0.taskID_).progress >= AssignmentCfg[arg_11_0.taskID_].need
end

function var_0_0.RefreshReward(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0:GetTaskID()].reward

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if arg_12_0.rewardItemS_[iter_12_0] == nil then
			arg_12_0.rewardItemS_[iter_12_0] = RewardItem.New(arg_12_0.rewardTemplates_, arg_12_0.rewardParent_, true)

			arg_12_0.rewardItemS_[iter_12_0]:UpdateCommonItemAni()
		end

		arg_12_0.rewardItemS_[iter_12_0]:SetData(iter_12_1)
	end

	for iter_12_2 = #var_12_0 + 1, #arg_12_0.rewardItemS_ do
		arg_12_0.rewardItemS_[iter_12_2]:Show(false)
	end
end

function var_0_0.RefreshProgress(arg_13_0)
	local var_13_0 = AssignmentCfg[arg_13_0:GetTaskID()].need
	local var_13_1 = arg_13_0:GetTaskProgress()

	if var_13_0 < var_13_1 then
		var_13_1 = var_13_0
	end

	if TaskData2:GetAssignmentPhase() > arg_13_0.stage_ then
		var_13_1 = var_13_0
	end

	arg_13_0.finishTasks_.text = var_13_1
	arg_13_0.allTasks_.text = "/" .. var_13_0
end

function var_0_0.OnSubcribe(arg_14_0)
	arg_14_0:RefreshProgress()
	arg_14_0:RefreshState()
end

function var_0_0.OnExit(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()

	for iter_16_0 = 1, 3 do
		arg_16_0[var_0_1[iter_16_0]] = nil
	end

	for iter_16_1 = 1, #arg_16_0.rewardItemS_ do
		arg_16_0.rewardItemS_[iter_16_1]:Dispose()

		arg_16_0.rewardItemS_[iter_16_1] = nil
	end

	arg_16_0.rewardItemS_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
