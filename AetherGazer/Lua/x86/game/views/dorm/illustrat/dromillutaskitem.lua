local var_0_0 = class("DromIlluTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.rewardItemGos_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.ReEnter(arg_2_0, arg_2_1)
	arg_2_0.taskID_ = arg_2_1
	arg_2_0.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshProgress()
	arg_2_0:RefreshUI()

	arg_2_0.isShow_ = true
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.isShow_ = false
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
	arg_5_0.controller_ = arg_5_0.mainControllerEx_:GetController("state")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		OperationRecorder.Record(arg_6_0.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(arg_6_0.taskID_, TaskConst.TASK_TYPE.DORM_ILLU, function()
			local var_8_0 = AssignmentCfg[arg_6_0.taskID_]

			DormRedPointTools:UpdateDormIlluRedPoint(var_8_0.condition)
		end)
	end)
end

function var_0_0.RemoveListeners(arg_9_0)
	arg_9_0.btn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_]

	arg_10_0.titleText_.text = GetI18NText(var_10_0.desc)

	local var_10_1 = var_10_0.reward or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = formatReward(iter_10_1)
		local var_10_3 = arg_10_0.itemData[iter_10_0]
		local var_10_4 = false

		if arg_10_0.rewardItems_[iter_10_0] == nil then
			arg_10_0.rewardItems_[iter_10_0] = CommonItemView.New(arg_10_0[string.format("awardItem%dObj_", iter_10_0)])
			arg_10_0.rewardItems_[iter_10_0].ResetTransform = function()
				return
			end

			local var_10_5 = true
		end

		var_10_3.id = var_10_2.id
		var_10_3.number = var_10_2.num
		var_10_3.timeValid = iter_10_1.timeValid or 0
		var_10_3.grayFlag = arg_10_0.taskComplete_
		var_10_3.clickFun = handler(arg_10_0, arg_10_0.OnClickCommonItem)

		arg_10_0.rewardItems_[iter_10_0]:SetData(var_10_3)
	end

	for iter_10_2 = #var_10_0.reward + 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_2]:SetData(nil)
	end
end

function var_0_0.RefreshProgress(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = arg_12_0.taskProgress

	if arg_12_0.taskProgress > var_12_0.need then
		var_12_1 = var_12_0.need
	end

	arg_12_0.progressBar_.value = var_12_1 / var_12_0.need
	arg_12_0.progressText_.text = string.format("%s/%s", var_12_1, var_12_0.need)

	local var_12_2 = arg_12_0.taskProgress >= var_12_0.need

	if arg_12_0.taskComplete_ then
		arg_12_0.controller_:SetSelectedState("received")
	elseif var_12_2 then
		arg_12_0.controller_:SetSelectedState("complete")
	else
		arg_12_0.controller_:SetSelectedState("unfinish")
	end
end

function var_0_0.SetSibling(arg_13_0, arg_13_1)
	local var_13_0 = AssignmentCfg[arg_13_0.taskID_]
end

function var_0_0.OnClickCommonItem(arg_14_0, arg_14_1)
	ShowPopItem(POP_ITEM, {
		arg_14_1.id,
		arg_14_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return var_0_0
