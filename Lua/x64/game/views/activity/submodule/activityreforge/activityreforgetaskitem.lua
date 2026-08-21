local var_0_0 = class("ActivityReforgeTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rewardItems_ = {}

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	for iter_2_0 = 1, 3 do
		arg_2_0.rewardItems_[iter_2_0] = CommonItemView.New(arg_2_0["rewardItem" .. iter_2_0 .. "_"])
	end

	arg_2_0.statusController_ = arg_2_0.controllerEx_:GetController("status")
	arg_2_0.rewardNumController_ = arg_2_0.controllerEx_:GetController("reward")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0.taskID_ = arg_5_1
	arg_5_0.taskProgress = TaskData2:GetTaskProgress(arg_5_1)
	arg_5_0.taskComplete_ = TaskData2:GetTaskComplete(arg_5_1)

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0.descText_.text = GetI18NText(var_6_0.desc)

	local var_6_1 = arg_6_0.taskProgress >= var_6_0.need

	if arg_6_0.taskComplete_ then
		arg_6_0.statusController_:SetSelectedState("received")
	elseif var_6_1 then
		arg_6_0.statusController_:SetSelectedState("complete")
	else
		arg_6_0.statusController_:SetSelectedState("unfinish")
	end

	local var_6_2 = var_6_0.reward or {}

	arg_6_0.rewardNumController_:SetSelectedState(#var_6_2)

	for iter_6_0 = 1, 3 do
		local var_6_3 = var_6_2[iter_6_0]

		if var_6_3 then
			local var_6_4 = formatReward(var_6_3)
			local var_6_5 = false
			local var_6_6 = rewardToItemTemplate(var_6_4)

			var_6_6.completedFlag = arg_6_0.taskComplete_
			var_6_6.clickFun = handler(arg_6_0, arg_6_0.OnClickCommonItem)

			arg_6_0.rewardItems_[iter_6_0]:SetData(var_6_6)
		end
	end
end

function var_0_0.OnClickCommonItem(arg_7_0, arg_7_1)
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.rewardItems_) do
		if iter_8_1 then
			iter_8_1:Dispose()
		end
	end

	arg_8_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
