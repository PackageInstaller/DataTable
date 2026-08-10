local var_0_0 = class("MoonCakeTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.transform_, "type")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			arg_3_0.taskID_
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.activityID_ = arg_5_2
	arg_5_0.taskID_ = arg_5_1
	arg_5_0.taskProgress_ = TaskData2:GetTask(arg_5_1).progress
	arg_5_0.taskComplete_ = TaskData2:GetTaskComplete(arg_5_1)

	arg_5_0:RefreshUI()
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.rewardItems_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = AssignmentCfg[arg_7_0.taskID_]

	arg_7_0.descText_.text = var_7_0.desc

	local var_7_1 = var_7_0.reward or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if arg_7_0.rewardItems_[iter_7_0] == nil then
			arg_7_0.rewardItems_[iter_7_0] = RewardPoolItem.New(arg_7_0.rewardParent_)
		end

		arg_7_0.rewardItems_[iter_7_0]:SetData(iter_7_1, false)
	end

	for iter_7_2 = #var_7_1 + 1, #arg_7_0.rewardItems_ do
		arg_7_0.rewardItems_[iter_7_2]:Show(false)
	end

	arg_7_0:RefreshProgress()
end

function var_0_0.RefreshProgress(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]
	local var_8_1 = arg_8_0.taskProgress_

	if arg_8_0.taskProgress_ > var_8_0.need then
		var_8_1 = var_8_0.need
	end

	arg_8_0.progressBar_.value = var_8_1 / var_8_0.need
	arg_8_0.progressText_.text = string.format("%s/%s", var_8_1, var_8_0.need)

	local var_8_2 = arg_8_0.taskProgress_ >= var_8_0.need

	if arg_8_0.taskComplete_ == true then
		arg_8_0.statusController_:SetSelectedState("received")
	elseif var_8_2 then
		arg_8_0.statusController_:SetSelectedState("completed")
	else
		arg_8_0.statusController_:SetSelectedState("uncomplete")
	end

	if var_8_0.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_8_0.typeController_:SetSelectedState("daily")
	else
		arg_8_0.typeController_:SetSelectedState("challenge")
	end
end

return var_0_0
