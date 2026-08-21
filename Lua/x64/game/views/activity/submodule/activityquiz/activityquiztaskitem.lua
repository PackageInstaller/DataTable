local var_0_0 = class("ActivityQuizTaskItem", ReduxView)

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
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.lockCon_ = ControllerUtil.GetController(arg_3_0.transform_, "lock")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = AssignmentCfg[arg_4_0.taskID_]

		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.info_ = arg_6_1
	arg_6_0.taskID_ = arg_6_1.id
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.cfg_ = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshReward()
	arg_7_0:RefreshTask()
	arg_7_0:RefreshState()
end

function var_0_0.RefreshReward(arg_8_0)
	local var_8_0 = arg_8_0.cfg_.reward

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.rewardItems_[iter_8_0] then
			arg_8_0.rewardItems_[iter_8_0] = RewardItem.New(arg_8_0.rewardItem_, arg_8_0.rewardParent_)

			arg_8_0.rewardItems_[iter_8_0]:UpdateCommonItemAni()
		end

		arg_8_0.rewardItems_[iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshTask(arg_9_0)
	arg_9_0.desc_.text = arg_9_0.cfg_.desc

	local var_9_0 = arg_9_0.info_.progress > arg_9_0.cfg_.need and arg_9_0.cfg_.need or arg_9_0.info_.progress

	arg_9_0.progress_.text = var_9_0 .. "/" .. arg_9_0.cfg_.need
	arg_9_0.slider_.value = var_9_0 / arg_9_0.cfg_.need

	if arg_9_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_9_0.typeCon_:SetSelectedState("daily")
	else
		arg_9_0.typeCon_:SetSelectedState("challenge")
	end

	local var_9_1 = arg_9_0.cfg_.activity_id

	arg_9_0.startTime_ = ActivityData:GetActivityData(var_9_1).startTime
end

function var_0_0.RefreshState(arg_10_0)
	if arg_10_0.info_.complete_flag >= 1 then
		arg_10_0.stateCon_:SetSelectedState("received")
	elseif arg_10_0.info_.progress >= arg_10_0.cfg_.need then
		arg_10_0.stateCon_:SetSelectedState("completed")
	else
		arg_10_0.stateCon_:SetSelectedState("uncomplete")
	end
end

function var_0_0.RefreshTime(arg_11_0, arg_11_1)
	if arg_11_1 >= arg_11_0.startTime_ then
		arg_11_0.lockCon_:SetSelectedState("false")

		return
	end

	arg_11_0.lockCon_:SetSelectedState("true")

	arg_11_0.timeLable_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(arg_11_0.startTime_))
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.rewardItems_ do
		arg_13_0.rewardItems_[iter_13_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()

	for iter_14_0 = 1, #arg_14_0.rewardItems_ do
		arg_14_0.rewardItems_[iter_14_0]:Dispose()
	end

	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
