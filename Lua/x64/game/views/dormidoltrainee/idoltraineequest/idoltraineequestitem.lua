local var_0_0 = class("IdolTraineeQuestItem", ReduxView)

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
	arg_2_0.typeController_ = arg_2_0.mainControllerEx_:GetController("type")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.taskID_ then
			local var_4_0 = true
			local var_4_1 = getData("dorm_weekly_task", "tip_deadline")

			if var_4_1 and tonumber(var_4_1) > manager.time:GetServerTime() then
				var_4_0 = false
			end

			local var_4_2 = 100

			if GameSetting.house_task_points then
				var_4_2 = GameSetting.house_task_points.value[2]
			end

			if var_4_0 and var_4_2 <= TaskTools.GetTargetTaskReward({
				arg_3_0.taskID_
			}, 61) + IdolTraineeData:GetQuestWeeklyData() then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("DORM_TASK_WEEKLY_LIMIT_TIP"),
					toggleText = GetTips("WEEKLY_MUTE_TIP"),
					OkCallback = function()
						TaskAction:SubmitTask(arg_3_0.taskID_)
					end,
					ToggleCallback = function(arg_6_0)
						if arg_6_0 then
							saveData("dorm_weekly_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
						end
					end
				})
			else
				TaskAction:SubmitTask(arg_3_0.taskID_)
			end
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.taskID_ = arg_7_1

	local var_7_0 = AssignmentCfg[arg_7_1]

	arg_7_0.typeController_:SetSelectedState(var_7_0.type == TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY and "day" or "week")

	local var_7_1 = TaskData2:GetTaskComplete(arg_7_1)
	local var_7_2 = TaskData2:GetTaskProgress(arg_7_1)

	if var_7_2 > var_7_0.need then
		var_7_2 = var_7_0.need
	end

	arg_7_0.desc_.text = var_7_0.desc
	arg_7_0.slider_.value = var_7_2 / var_7_0.need
	arg_7_0.progress_.text = string.format("%s/%s", var_7_2, var_7_0.need)

	if var_7_1 then
		arg_7_0.stateController_:SetSelectedState("received")
	elseif var_7_2 >= var_7_0.need then
		arg_7_0.stateController_:SetSelectedState("complete")
	else
		arg_7_0.stateController_:SetSelectedState("unfinish")
	end

	local var_7_3 = var_7_0.reward or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_3) do
		local var_7_4 = formatReward(iter_7_1)
		local var_7_5 = clone(ItemTemplateData)

		if arg_7_0.rewardItems_[iter_7_0] == nil then
			arg_7_0.rewardItems_[iter_7_0] = CommonItemView.New(arg_7_0[string.format("awardItem%dObj_", iter_7_0)])
			arg_7_0.rewardItems_[iter_7_0].ResetTransform = function()
				return
			end
		end

		var_7_5.id = var_7_4.id
		var_7_5.number = var_7_4.num
		var_7_5.timeValid = iter_7_1.timeValid or 0
		var_7_5.completedFlag = arg_7_0.taskComplete_
		var_7_5.clickFun = handler(arg_7_0, arg_7_0.OnClickCommonItem)

		arg_7_0.rewardItems_[iter_7_0]:SetData(var_7_5)
	end

	for iter_7_2 = #var_7_0.reward + 1, #arg_7_0.rewardItems_ do
		arg_7_0.rewardItems_[iter_7_2]:SetData(nil)
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
		iter_10_1:Dispose()
	end

	arg_10_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
