local var_0_0 = class("PreviewTaskItem", ReduxView)
local var_0_1 = import("game.tools.JumpTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.rewardItemGos_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityID_ = arg_2_2
	arg_2_0.taskID_ = arg_2_1
	arg_2_0.taskProgress = PreviewTaskData:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = PreviewTaskData:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveListeners()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.rewardItems_) do
		iter_3_1:Dispose()
	end

	arg_3_0.rewardItems_ = nil

	for iter_3_2, iter_3_3 in pairs(arg_3_0.rewardItemGos_) do
		Object.Destroy(iter_3_3)
	end

	arg_3_0.rewardItemGos_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = AssignmentCfg[arg_5_0.taskID_]

		var_0_1.JumpToPage2(var_6_0.source)
	end)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PreviewTaskAction.TryToSubmitTask(arg_5_0.taskID_)
	end)
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0.goBtn_.onClick:RemoveAllListeners()
	arg_8_0.receiveBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = AssignmentCfg[arg_9_0.taskID_]

	arg_9_0.titleText_.text = GetI18NText(var_9_0.name)
	arg_9_0.contentText_.text = GetI18NText(var_9_0.desc)

	local var_9_1 = var_9_0.reward or {}

	for iter_9_0 = 1, 3 do
		if arg_9_0.rewardItems_[iter_9_0] == nil then
			arg_9_0.rewardItems_[iter_9_0] = CommonItemPool.New(arg_9_0.rewardParent_)
		end

		if var_9_1[iter_9_0] then
			local var_9_2 = clone(ItemTemplateData)

			var_9_2.id = var_9_1[iter_9_0][1]
			var_9_2.number = var_9_1[iter_9_0][2]

			function var_9_2.clickFun(arg_10_0)
				ShowPopItem(POP_ITEM, {
					arg_10_0.id,
					arg_10_0.number,
					arg_10_0.timeValid
				})
			end

			arg_9_0.rewardItems_[iter_9_0]:SetData(var_9_2)
		else
			arg_9_0.rewardItems_[iter_9_0]:SetData()
		end
	end

	arg_9_0:RefreshTime()
	arg_9_0:RefreshProgress()
end

function var_0_0.RefreshProgress(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_]
	local var_11_1 = arg_11_0.taskProgress

	if arg_11_0.taskProgress > var_11_0.need then
		var_11_1 = var_11_0.need
	end

	arg_11_0.progressBar_.fillAmount = var_11_1 / var_11_0.need
	arg_11_0.progressText_.text = string.format("%s/%s", var_11_1, var_11_0.need)

	local var_11_2 = arg_11_0.taskProgress >= var_11_0.need

	if arg_11_0.taskComplete_ == true then
		arg_11_0.controller_:SetSelectedState("received")
	elseif var_11_2 then
		arg_11_0.controller_:SetSelectedState("completed")
	else
		arg_11_0.controller_:SetSelectedState("incomplete")
	end
end

function var_0_0.RefreshTime(arg_12_0)
	if AssignmentCfg[arg_12_0.taskID_].type == TaskConst.TASK_TYPE.PREVIEW_DAILY then
		local var_12_0 = GameSetting.refresh_time1.value[1][1]

		arg_12_0.endTime_ = manager.time:GetNextTime(var_12_0, 0, 0)
		arg_12_0.isDailyTask_ = true

		arg_12_0.typeController_:SetSelectedState("daily")
	else
		arg_12_0.isDailyTask_ = false

		arg_12_0.typeController_:SetSelectedState("normal")
	end
end

return var_0_0
