local var_0_0 = class("AlphaTaskItem", ReduxView)
local var_0_1 = {
	"complete",
	"incomplete",
	"lock",
	"finish"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.stateCon_ = ControllerUtil.GetController(arg_1_0.transform_, "state")

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rewardItems_ = {}
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		local var_4_0 = AssignmentCfg[arg_3_0:GetTaskID()]

		JumpTools.JumpToPage2(var_4_0.source)
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0:GetTaskID())
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.GetTaskID(arg_7_0)
	return arg_7_0.taskID_
end

function var_0_0.GetAlphaTaskStage(arg_8_0)
	return TaskData2:GetAssignmentPhase()
end

function var_0_0.GetTaskComplete(arg_9_0)
	local var_9_0 = TaskData2:GetTask(arg_9_0.taskID_)

	return var_9_0 == nil or var_9_0.complete_flag >= 1
end

function var_0_0.GetTaskProgress(arg_10_0)
	local var_10_0 = TaskData2:GetTask(arg_10_0.taskID_)

	return var_10_0 and var_10_0.progress or 0
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.taskID_ = arg_11_1
	end

	arg_11_0:RefreshTitle()
	arg_11_0:RefreshState()
	arg_11_0:RefreshReward()
	arg_11_0:RefreshProgress()
end

function var_0_0.RefreshTitle(arg_12_0)
	arg_12_0.titleText_.text = GetI18NText(AssignmentCfg[arg_12_0:GetTaskID()].desc)
end

function var_0_0.RefreshState(arg_13_0)
	arg_13_0.state_ = arg_13_0:GetItemState()

	arg_13_0:ChangeState(arg_13_0.state_)
end

function var_0_0.ChangeState(arg_14_0, arg_14_1)
	arg_14_0.stateCon_:SetSelectedState(arg_14_1)
end

function var_0_0.GetItemState(arg_15_0)
	if AssignmentCfg[arg_15_0:GetTaskID()].phase > arg_15_0:GetAlphaTaskStage() then
		return var_0_1[3]
	end

	if arg_15_0:GetTaskComplete() then
		return var_0_1[4]
	end

	if AssignmentCfg[arg_15_0:GetTaskID()].need > arg_15_0:GetTaskProgress() then
		return var_0_1[2]
	else
		return var_0_1[1]
	end
end

function var_0_0.RefreshReward(arg_16_0)
	local var_16_0 = AssignmentCfg[arg_16_0:GetTaskID()].reward

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if arg_16_0.rewardItems_[iter_16_0] == nil then
			arg_16_0.rewardItems_[iter_16_0] = RewardItem.New(arg_16_0.rewardTemplate_, arg_16_0.rewardParent_, true)

			arg_16_0.rewardItems_[iter_16_0]:UpdateCommonItemAni()
			arg_16_0.rewardItems_[iter_16_0].commonItem_:RegistCallBack(function()
				OperationRecorder.Record("test_activity", "test_item")
			end)
		end

		arg_16_0.rewardItems_[iter_16_0]:SetData(iter_16_1)
	end

	for iter_16_2 = #var_16_0 + 1, #arg_16_0.rewardItems_ do
		arg_16_0.rewardItems_[iter_16_2]:Show(false)
	end
end

function var_0_0.RefreshProgress(arg_18_0)
	local var_18_0 = AssignmentCfg[arg_18_0:GetTaskID()].need
	local var_18_1 = arg_18_0:GetTaskProgress()

	if var_18_0 < var_18_1 then
		var_18_1 = var_18_0
	end

	if arg_18_0:GetTaskComplete() then
		var_18_1 = var_18_0
	end

	arg_18_0.progressBar_.fillAmount = var_18_1 / var_18_0
	arg_18_0.progressText_.text = string.format("%s/%s", var_18_1, var_18_0)
end

function var_0_0.Hide(arg_19_0)
	SetActive(arg_19_0.gameObject_, false)
end

function var_0_0.OnExit(arg_20_0)
	return
end

function var_0_0.SetSiblingIndex(arg_21_0, arg_21_1)
	arg_21_0.transform_:SetSiblingIndex(arg_21_1)
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()

	if arg_22_0.rewardItems_ then
		for iter_22_0 = #arg_22_0.rewardItems_, 1, -1 do
			arg_22_0.rewardItems_[iter_22_0]:Dispose()

			arg_22_0.rewardItems_[iter_22_0] = nil
		end

		arg_22_0.rewardItems_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
