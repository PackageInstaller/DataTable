local var_0_0 = class("ActivityPtScrollTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.typeCon_ = arg_3_0.itemCon_:GetController("type")
	arg_3_0.stateCon_ = arg_3_0.itemCon_:GetController("state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.taskID_ == 0 then
			ActivityPtScrollAction.TryToSubmitScrollTask(arg_4_0.activityID_)
		else
			TaskAction:SubmitTask(arg_4_0.taskID_)
		end
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.taskActivityID_ = ActivityPtScrollTools.GetTaskActivityID(arg_6_0.activityID_)
	arg_6_0.info_ = TaskData2:GetTask(arg_6_0.taskID_)
	arg_6_0.cfg_ = AssignmentCfg[arg_6_1]

	if arg_6_0.taskID_ == 0 then
		arg_6_0:RefreshInfinityTask()
	else
		arg_6_0:RefreshNormalTask()
	end
end

function var_0_0.RefreshInfinityTask(arg_7_0)
	local var_7_0 = GameSetting.activity_pt_roulette_task_times.value[1]
	local var_7_1 = ActivityPtScrollData:GetClearTime(arg_7_0.activityID_)

	if ActivityConst.ACTIVITY_PTSCROLL_4_2 == arg_7_0.activityID_ then
		arg_7_0.desc_.text = string.format(GetTips("ACTIVITY_GODEATER_ROULETTE_TASK_DESC"), var_7_0)
	else
		arg_7_0.desc_.text = string.format(GetTips("ACTIVITY_ROULETTE_TASK_DESC"), var_7_0)
	end

	arg_7_0.typeCon_:SetSelectedState("infinity")

	local var_7_2
	local var_7_3
	local var_7_4 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_7_0.activityID_]

	for iter_7_0, iter_7_1 in ipairs(var_7_4) do
		local var_7_5 = ActivityPtRouletteStageCfg[iter_7_1]

		if var_7_5.mode == 2 then
			local var_7_6 = var_7_5.cost

			var_7_2, var_7_3 = var_7_6[1], var_7_6[2]

			break
		end
	end

	local var_7_7 = {
		{
			var_7_2,
			var_7_3
		}
	}

	arg_7_0:RefreshReward(var_7_7)

	arg_7_0.progress_.text = var_7_1 .. "/" .. var_7_0
	arg_7_0.slider_.value = var_7_0 < var_7_1 and 1 or var_7_1 / var_7_0

	if var_7_0 <= var_7_1 then
		arg_7_0.stateCon_:SetSelectedState("complete")
	else
		arg_7_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshNormalTask(arg_8_0)
	local var_8_0 = TaskData2:GetTask(arg_8_0.taskID_)
	local var_8_1 = AssignmentCfg[arg_8_0.taskID_]

	arg_8_0.desc_.text = var_8_1.desc

	if var_8_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_8_0.typeCon_:SetSelectedState("normal")
	else
		arg_8_0.typeCon_:SetSelectedState("challenge")
	end

	local var_8_2 = var_8_1.reward

	arg_8_0:RefreshReward(var_8_2)

	local var_8_3 = var_8_1.need
	local var_8_4 = var_8_3 < var_8_0.progress and var_8_3 or var_8_0.progress

	arg_8_0.progress_.text = var_8_4 .. "/" .. var_8_3
	arg_8_0.slider_.value = var_8_4 / var_8_3

	if var_8_0.complete_flag >= 1 then
		arg_8_0.stateCon_:SetSelectedState("received")
	elseif var_8_0.progress >= var_8_1.need then
		arg_8_0.stateCon_:SetSelectedState("complete")
	else
		arg_8_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshReward(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if not arg_9_0.rewardItems_[iter_9_0] then
			local var_9_0 = Object.Instantiate(arg_9_0.rewardItem_, arg_9_0.rewardParent_)

			arg_9_0.rewardItems_[iter_9_0] = CommonItemView.New(var_9_0, true)
		end

		local var_9_1 = cfgToItemTemplate(iter_9_1)

		function var_9_1.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id
			})
		end

		arg_9_0.rewardItems_[iter_9_0]:SetData(var_9_1)
		arg_9_0.rewardItems_[iter_9_0].countdownController_:SetSelectedState("false")
	end

	for iter_9_2 = #arg_9_1 + 1, #arg_9_0.rewardItems_ do
		arg_9_0.rewardItems_[iter_9_2]:Show(false)
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0 = 1, #arg_12_0.rewardItems_ do
		arg_12_0.rewardItems_[iter_12_0]:Dispose()
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
