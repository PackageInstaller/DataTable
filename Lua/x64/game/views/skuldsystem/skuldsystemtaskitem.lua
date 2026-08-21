local var_0_0 = class("SkuldSystemTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.rewardItemGos_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.RefreshTaskItem(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_0.taskID_ = arg_2_1
	arg_2_0.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshProgress()
	arg_2_0:RefreshUI()

	arg_2_0.isShow_ = true

	local var_2_0 = RedPointConst.SKULD_SYSTEM_TASK_ITEM .. arg_2_0.taskID_
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.isShow_ = false

	local var_3_0 = RedPointConst.SKULD_SYSTEM_TASK_ITEM .. arg_3_0.taskID_
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardItems_) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	arg_4_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	arg_5_0.controller_ = arg_5_0.allBtnController_:GetController("all")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		local var_7_0 = AssignmentCfg[arg_6_0.taskID_]

		if var_7_0.source then
			JumpTools.JumpToPage2(var_7_0.source)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			TaskAction:SubmitTask(arg_6_0.taskID_)
		else
			ShowTips("TIME_OUT")
		end
	end)
end

function var_0_0.RemoveListeners(arg_9_0)
	arg_9_0.goBtn_.onClick:RemoveAllListeners()
	arg_9_0.receiveBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_]

	arg_10_0.titleText_.text = GetI18NText(var_10_0.desc)

	local var_10_1 = var_10_0.reward or {}
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		var_10_2 = var_10_2 + 1

		if var_10_2 > 3 then
			break
		end

		local var_10_3 = formatReward(iter_10_1)
		local var_10_4 = rewardToItemTemplate(var_10_3, arg_10_0.itemData[iter_10_0])
		local var_10_5 = false

		if arg_10_0.rewardItems_[iter_10_0] == nil then
			arg_10_0.rewardItems_[iter_10_0] = CommonItemView.New(arg_10_0[string.format("awardItem%dObj_", iter_10_0)])

			local var_10_6 = true
		end

		var_10_4.grayFlag = arg_10_0.taskComplete_
		var_10_4.clickFun = handler(arg_10_0, arg_10_0.OnClickCommonItem)

		arg_10_0.rewardItems_[iter_10_0]:SetData(var_10_4)
	end

	for iter_10_2 = #var_10_0.reward + 1, #arg_10_0.rewardItems_ do
		if arg_10_0.rewardItems_[iter_10_2] then
			arg_10_0.rewardItems_[iter_10_2]:SetData(nil)
		end
	end

	if arg_10_0.rewardItems_[1] and arg_10_0.rewardItems_[1].transform_.parent then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.rewardItems_[1].transform_.parent)
	end
end

function var_0_0.RefreshProgress(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_]
	local var_11_1 = arg_11_0.taskProgress

	if arg_11_0.taskProgress > var_11_0.need then
		var_11_1 = var_11_0.need
	end

	arg_11_0.progressBar_.value = var_11_1 / var_11_0.need
	arg_11_0.progressText_.text = string.format("%s/%s", var_11_1, var_11_0.need)

	local var_11_2 = arg_11_0.taskProgress >= var_11_0.need

	if arg_11_0.taskComplete_ then
		arg_11_0.controller_:SetSelectedState("complete")
	elseif var_11_2 then
		arg_11_0.controller_:SetSelectedState("receive")
	else
		arg_11_0.controller_:SetSelectedState("go")
	end
end

function var_0_0.OnClickCommonItem(arg_12_0, arg_12_1)
	ShowPopItem(POP_ITEM, {
		arg_12_1.id,
		arg_12_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return var_0_0
