local var_0_0 = class("ActivityTaskBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rewardItems_ = {}

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = ControllerUtil.GetController(arg_1_0.transform_, "conName")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	arg_2_0:StopTimer()

	for iter_2_0, iter_2_1 in pairs(arg_2_0.rewardItems_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardItem_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnGo_, nil, function()
		local var_4_0 = AssignmentCfg[arg_3_0.taskID_]

		JumpTools.JumpToPage2(var_4_0.source)
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnReceive_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.taskID_ = arg_6_1

	arg_6_0:RefreshUI()
	arg_6_0:RefreshReward(arg_6_1)
	arg_6_0:RefreshState()
	arg_6_0:AddTimer()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = arg_7_0.taskID_
	local var_7_1 = AssignmentCfg[var_7_0]

	arg_7_0.textContent_.text = GetI18NText(var_7_1.name)
	arg_7_0.textDesc_.text = GetI18NText(var_7_1.desc)

	local var_7_2 = TaskData2:GetTask(var_7_0).progress or 0
	local var_7_3 = var_7_1.need

	if var_7_3 < var_7_2 then
		var_7_2 = var_7_3
	end

	arg_7_0.imageProgress_.fillAmount = var_7_2 / var_7_3
	arg_7_0.textProgress_.text = string.format("%s/%s", var_7_2, var_7_3)

	if var_7_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_7_0.typeController_:SetSelectedState("daily")
	else
		arg_7_0.typeController_:SetSelectedState("challenge")
	end
end

function var_0_0.RefreshReward(arg_8_0, arg_8_1)
	local var_8_0 = AssignmentCfg[arg_8_1].reward

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if arg_8_0.rewardItems_[iter_8_0] == nil then
			arg_8_0.rewardItems_[iter_8_0] = arg_8_0:GetRewardItem(iter_8_1)
		else
			arg_8_0.rewardItems_[iter_8_0]:SetData(iter_8_1)
		end
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:Show(false)
	end
end

function var_0_0.GetRewardItem(arg_9_0, arg_9_1)
	return RewardPoolItem.New(arg_9_0.goItemParent_, arg_9_1)
end

function var_0_0.RefreshState(arg_10_0)
	local var_10_0 = arg_10_0:GetItemState()

	arg_10_0.stateController_:SetSelectedState(var_10_0)
end

function var_0_0.GetItemState(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_]
	local var_11_1 = TaskData2:GetTask(arg_11_0.taskID_)
	local var_11_2 = var_11_1.progress or 0

	if var_11_1.complete_flag >= 1 then
		return 2
	end

	if var_11_2 >= var_11_0.need then
		return 1
	else
		return 0
	end
end

function var_0_0.AddTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0:StopTimer()
	end

	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = TaskData2:GetTask(arg_12_0.taskID_)
	local var_12_2 = GameSetting.refresh_time1.value[1][1]
	local var_12_3 = manager.time:GetNextTime(var_12_2, 0, 0)
	local var_12_4 = var_12_1.expired_timestamp

	if var_12_4 == nil or var_12_4 == 0 then
		var_12_4 = var_12_3
	end

	if arg_12_0.textTime_ then
		arg_12_0.textTime_.text = manager.time:GetLostTimeStr(var_12_4)
	end

	arg_12_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_12_4 then
			if var_12_1 and var_12_1.expired_timestamp then
				var_12_4 = var_12_1.expired_timestamp
			else
				var_12_4 = manager.time:GetNextTime(var_12_2, 0, 0)
			end
		end

		if arg_12_0.textTime_ then
			arg_12_0.textTime_.text = manager.time:GetLostTimeStr(var_12_4)
		end
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

return var_0_0
