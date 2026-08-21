local var_0_0 = class("IchiBanEnterItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.rewardItems_ = {}
	arg_1_0.typeCon_ = arg_1_0.controllerEx_:GetController("type")
	arg_1_0.stateCon_ = arg_1_0.controllerEx_:GetController("state")
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.rewardItems_ do
		arg_2_0.rewardItems_[iter_2_0]:Dispose()
	end

	arg_2_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.taskID_ = arg_5_1
	arg_5_0.activityID_ = arg_5_2
	arg_5_0.taskActivityID_ = IchiBanTools.GetTaskActivityID(arg_5_0.activityID_)
	arg_5_0.info_ = TaskData2:GetTask(arg_5_0.taskID_)
	arg_5_0.cfg_ = AssignmentCfg[arg_5_1]

	arg_5_0:RefreshNormalTask()
end

function var_0_0.RefreshNormalTask(arg_6_0)
	local var_6_0 = TaskData2:GetTask(arg_6_0.taskID_)
	local var_6_1 = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0.desc_.text = var_6_1.desc

	if var_6_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_6_0.typeCon_:SetSelectedState("normal")
	else
		arg_6_0.typeCon_:SetSelectedState("challenge")
	end

	local var_6_2 = var_6_1.reward

	arg_6_0:RefreshReward(var_6_2)

	local var_6_3 = var_6_1.need
	local var_6_4 = var_6_3 < var_6_0.progress and var_6_3 or var_6_0.progress

	arg_6_0.progress_.text = var_6_4 .. "/" .. var_6_3
	arg_6_0.slider_.value = var_6_4 / var_6_3

	if var_6_0.complete_flag >= 1 then
		arg_6_0.stateCon_:SetSelectedState("received")
	elseif var_6_0.progress >= var_6_1.need then
		arg_6_0.stateCon_:SetSelectedState("complete")
	else
		arg_6_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshReward(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if not arg_7_0.rewardItems_[iter_7_0] then
			local var_7_0 = Object.Instantiate(arg_7_0.rewardItem_, arg_7_0.rewardParent_)

			arg_7_0.rewardItems_[iter_7_0] = CommonItemView.New(var_7_0, true)
		end

		local var_7_1 = cfgToItemTemplate(iter_7_1)

		function var_7_1.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id
			})
		end

		arg_7_0.rewardItems_[iter_7_0]:SetData(var_7_1)
		arg_7_0.rewardItems_[iter_7_0].countdownController_:SetSelectedState("false")
	end

	for iter_7_2 = #arg_7_1 + 1, #arg_7_0.rewardItems_ do
		arg_7_0.rewardItems_[iter_7_2]:Show(false)
	end
end

return var_0_0
