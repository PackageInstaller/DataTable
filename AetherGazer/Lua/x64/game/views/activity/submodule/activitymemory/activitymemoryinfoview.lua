local var_0_0 = class("ActivityMemoryInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityMemoryTools.GetInfoUIName(arg_1_0.params_.activityId)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItems_ = {}
	arg_4_0.rewardCon_ = {}
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		TaskAction.SubmitTask(arg_5_0.taskID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_7_0 = arg_5_0.cfg_.activity_jump_id
		local var_7_1 = ActivityData:GetActivityData(var_7_0)
		local var_7_2 = var_7_1.startTime
		local var_7_3 = var_7_1.stopTime
		local var_7_4 = manager.time:GetServerTime()

		if var_7_4 < var_7_2 then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		if var_7_3 <= var_7_4 then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(arg_5_0.taskCfg_.source)
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI()
	arg_9_0:RefreshReward()
	arg_9_0:RefreshState()
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_9_0, arg_9_0.RefreshState))
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.id_ = arg_10_0.params_.id
	arg_10_0.activityID_ = arg_10_0.params_.activityId
	arg_10_0.cfg_ = SpringFestivalMemoryCfg[arg_10_0.id_]
	arg_10_0.taskID_ = arg_10_0.cfg_.task_id
	arg_10_0.taskCfg_ = AssignmentCfg[arg_10_0.taskID_]

	local var_10_0 = ActivityMemoryTools.GetTaskActivityID(arg_10_0.activityID_)

	arg_10_0.info_ = TaskData2:GetTask(arg_10_0.taskID_)
	arg_10_0.desc_.text = arg_10_0.cfg_.des
	arg_10_0.taskDes_.text = arg_10_0.taskCfg_.desc
	arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas(arg_10_0.cfg_.icon)
end

function var_0_0.RefreshState(arg_11_0)
	if not arg_11_0.info_ then
		arg_11_0.progress_.text = 0 .. "/" .. arg_11_0.taskCfg_.need

		arg_11_0.stateCon_:SetSelectedState("unfinish")
	end

	local var_11_0 = arg_11_0.info_.progress > arg_11_0.taskCfg_.need and arg_11_0.taskCfg_.need or arg_11_0.info_.progress

	arg_11_0.progress_.text = var_11_0 .. "/" .. arg_11_0.taskCfg_.need

	if arg_11_0.info_.complete_flag >= 1 then
		arg_11_0.stateCon_:SetSelectedState("received")

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.rewardCon_) do
			arg_11_0.rewardCon_[iter_11_0]:SetSelectedState("true")
		end
	elseif arg_11_0.info_.progress >= arg_11_0.taskCfg_.need then
		arg_11_0.stateCon_:SetSelectedState("complete")

		for iter_11_2, iter_11_3 in ipairs(arg_11_0.rewardCon_) do
			arg_11_0.rewardCon_[iter_11_2]:SetSelectedState("false")
		end
	else
		arg_11_0.stateCon_:SetSelectedState("unfinish")
		arg_11_0.animator_:Play("IndiaRecallPopUI")

		for iter_11_4, iter_11_5 in ipairs(arg_11_0.rewardCon_) do
			arg_11_0.rewardCon_[iter_11_4]:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshReward(arg_12_0)
	local var_12_0 = arg_12_0.taskCfg_.reward

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not arg_12_0.rewardItems_[iter_12_0] then
			arg_12_0.rewardItems_[iter_12_0] = RewardItem.New(arg_12_0.rewardItem_, arg_12_0.rewardParent_)

			arg_12_0.rewardItems_[iter_12_0]:UpdateCommonItemAni()

			arg_12_0.rewardCon_[iter_12_0] = ControllerUtil.GetController(arg_12_0.rewardItems_[iter_12_0].transform_, "completed")
		end

		arg_12_0.rewardItems_[iter_12_0]:SetData(iter_12_1)
	end

	for iter_12_2 = #var_12_0 + 1, #arg_12_0.rewardItems_ do
		arg_12_0.rewardItems_[iter_12_2]:Show(false)
	end
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.rewardItems_) do
		iter_13_1:OnExit()
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.rewardItems_) do
		iter_14_1:Dispose()
	end

	arg_14_0.rewardItems_ = {}
	arg_14_0.rewardCon_ = {}

	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
