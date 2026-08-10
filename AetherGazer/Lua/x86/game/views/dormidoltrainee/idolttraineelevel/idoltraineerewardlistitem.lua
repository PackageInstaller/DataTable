local var_0_0 = class("IdolTraineeRewardListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.rewardItems_ = {}
	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.taskID_ then
			TaskAction:SubmitTask(arg_3_0.taskID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.taskID_ = arg_5_1

	local var_5_0 = AssignmentCfg[arg_5_1]
	local var_5_1 = TaskData2:GetTaskComplete(arg_5_1)
	local var_5_2 = TaskData2:GetTaskProgress(arg_5_1)

	arg_5_0.desc_.text = var_5_0.desc

	if var_5_1 then
		arg_5_0.stateController_:SetSelectedState("received")
	elseif var_5_2 >= var_5_0.need then
		arg_5_0.stateController_:SetSelectedState("complete")
	else
		arg_5_0.stateController_:SetSelectedState("unfinish")
	end

	local var_5_3 = var_5_0.reward or {}

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		local var_5_4 = formatReward(iter_5_1)
		local var_5_5 = clone(ItemTemplateData)

		if arg_5_0.rewardItems_[iter_5_0] == nil then
			arg_5_0.rewardItems_[iter_5_0] = CommonItemView.New(arg_5_0[string.format("awardItem%dObj_", iter_5_0)])
			arg_5_0.rewardItems_[iter_5_0].ResetTransform = function()
				return
			end
		end

		var_5_5.id = var_5_4.id
		var_5_5.number = var_5_4.num
		var_5_5.timeValid = iter_5_1.timeValid or 0
		var_5_5.completedFlag = arg_5_0.taskComplete_
		var_5_5.clickFun = handler(arg_5_0, arg_5_0.OnClickCommonItem)

		arg_5_0.rewardItems_[iter_5_0]:SetData(var_5_5)
	end

	for iter_5_2 = #var_5_0.reward + 1, #arg_5_0.rewardItems_ do
		arg_5_0.rewardItems_[iter_5_2]:SetData(nil)
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
		iter_8_1:Dispose()
	end

	arg_8_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
