local var_0_0 = class("StrategyMatrixRwardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rewardItems_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	for iter_3_0 = 1, 2 do
		arg_3_0.rewardItems_[iter_3_0] = CommonItemView.New(arg_3_0["awardItem" .. iter_3_0 + 1 .. "Obj_"])
	end

	arg_3_0.stateController_ = arg_3_0.allBtnController_:GetController("all")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.taskID_ = arg_6_1.id
	arg_6_0.taskProgress = arg_6_1.progress
	arg_6_0.taskComplete_ = arg_6_1.complete_flag >= 1

	arg_6_0:RefreshUI()
	arg_6_0:RefreshProgress()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = AssignmentCfg[arg_7_0.taskID_]

	arg_7_0.titleText_.text = GetI18NText(var_7_0.desc)

	local var_7_1 = var_7_0.reward or {}

	for iter_7_0 = 1, 2 do
		local var_7_2 = var_7_1[iter_7_0]

		if var_7_2 then
			local var_7_3 = formatReward(var_7_2)
			local var_7_4 = false
			local var_7_5 = rewardToItemTemplate(var_7_3)

			var_7_5.completedFlag = arg_7_0.taskComplete_
			var_7_5.clickFun = handler(arg_7_0, arg_7_0.OnClickCommonItem)

			arg_7_0.rewardItems_[iter_7_0]:SetData(var_7_5)
		end
	end
end

function var_0_0.RefreshProgress(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]
	local var_8_1 = arg_8_0.taskProgress

	if arg_8_0.taskProgress > var_8_0.need then
		var_8_1 = var_8_0.need
	end

	arg_8_0.progressBar_.value = var_8_1 / var_8_0.need
	arg_8_0.progressText_.text = string.format("%s/%s", var_8_1, var_8_0.need)

	local var_8_2 = arg_8_0.taskProgress >= var_8_0.need

	if arg_8_0.taskComplete_ then
		arg_8_0.stateController_:SetSelectedState("complete")
	elseif var_8_2 then
		arg_8_0.stateController_:SetSelectedState("receive")
	else
		arg_8_0.stateController_:SetSelectedState("lock")
	end
end

function var_0_0.OnClickCommonItem(arg_9_0, arg_9_1)
	ShowPopItem(POP_ITEM, {
		arg_9_1.id,
		arg_9_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.rewardItems_) do
		if iter_10_1 then
			iter_10_1:Dispose()
		end
	end

	arg_10_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
