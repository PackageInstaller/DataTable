local var_0_0 = class("ActivityNewbieTaskPhase", ReduxView)
local var_0_1 = {
	"lock",
	"receive",
	"received"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.stateCon_ = ControllerUtil.GetController(arg_1_0.transform_, "state")

	arg_1_0:BindCfgUI()
	arg_1_0:AddListener()

	arg_1_0.rewardItemList_ = {}
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_4_0.onSubmitTaskResponseHandle_)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		local var_6_0 = AssignmentCfg[arg_5_0.taskID_]
		local var_6_1 = var_6_0.phase
		local var_6_2 = TaskTools:GetNewbiePhaseTask()[var_6_1].progress >= var_6_0.need

		if TaskData2:GetAssignmentPhase() == var_6_1 and var_6_2 then
			-- block empty
		else
			return
		end

		TaskAction:SubmitTask(arg_5_0.taskID_)
	end)

	arg_5_0.onSubmitTaskResponseHandle_ = handler(arg_5_0, arg_5_0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_5_0.onSubmitTaskResponseHandle_)
end

function var_0_0.onSubmitTaskResponse(arg_7_0)
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
	arg_7_0.stateCon_:SetSelectedState("received")

	local var_7_0 = TaskTools:GetNewbiePhaseTask()
	local var_7_1 = TaskData2:GetAssignmentPhase()

	if var_7_1 > #var_7_0 then
		var_7_1 = #var_7_0
	end

	local var_7_2 = 1

	for iter_7_0 = 1, var_7_1 do
		if var_7_0[iter_7_0].id then
			var_7_2 = iter_7_0
		end
	end

	arg_7_0:SetData(var_7_0[var_7_2].id)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.taskID_ = arg_8_1

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshState()
	arg_9_0:RefreshReward()
	arg_9_0:RefreshProgress()
end

function var_0_0.RefreshState(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_]

	if var_10_0 then
		local var_10_1 = var_10_0.phase
		local var_10_2 = TaskTools:GetNewbiePhaseTask()[var_10_1].progress >= var_10_0.need

		if var_10_1 < TaskData2:GetAssignmentPhase() then
			arg_10_0.stateCon_:SetSelectedState("received")
		elseif TaskData2:GetAssignmentPhase() == var_10_1 and var_10_2 then
			arg_10_0.stateCon_:SetSelectedState("receive")
		else
			arg_10_0.stateCon_:SetSelectedState("lock")
		end
	end
end

function var_0_0.RefreshReward(arg_11_0)
	if not arg_11_0.taskID_ then
		return
	end

	if not AssignmentCfg[arg_11_0.taskID_] then
		return
	end

	local var_11_0 = AssignmentCfg[arg_11_0.taskID_].reward

	for iter_11_0 = 1, 2 do
		arg_11_0[string.format("textRewardCnt%s_", iter_11_0)].text = string.format("x%s", var_11_0[iter_11_0][2])
	end
end

function var_0_0.RefreshProgress(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = var_12_0.need
	local var_12_2 = TaskTools:GetNewbiePhaseTask()[var_12_0.phase].progress

	if var_12_1 < var_12_2 then
		var_12_2 = var_12_1
	end

	if TaskData2:GetAssignmentPhase() > var_12_0.phase then
		var_12_2 = var_12_1
	end

	arg_12_0.finishTasks_.text = var_12_2
	arg_12_0.allTasks_.text = "/" .. var_12_1
end

return var_0_0
