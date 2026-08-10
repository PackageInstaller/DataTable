local var_0_0 = class("ActivityRaceTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardItemList_ = {}
	arg_2_0.rewardController_ = ControllerUtil.GetController(arg_2_0.transform_, "reward")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if manager.time:GetServerTime() >= arg_4_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceAction.RequireReceive(arg_4_0.activityID_, arg_4_0.taskID_, function(arg_6_0)
			ActivityRaceData:SetReceivedTaskList(arg_4_0.activityID_, arg_4_0.taskID_)
			getReward2(arg_6_0.reward_list)
			arg_4_0:RefreshRewardState()
		end)
	end)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.rewardItemList_ = nil

	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.isAccumulated_ = arg_8_3
	arg_8_0.activityID_ = arg_8_2
	arg_8_0.stopTime_ = ActivityData:GetActivityData(arg_8_0.activityID_).stopTime
	arg_8_0.rewardList_ = ActivityPointRewardCfg[arg_8_1].reward_item_list

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	if arg_9_0.isAccumulated_ then
		arg_9_0.desctext_.text = string.format(GetTips("ACTIVITY_RACE_AMOUNT_REWARD"), tostring(ActivityPointRewardCfg[arg_9_0.taskID_].need))
	else
		arg_9_0.desctext_.text = string.format(GetTips("ACTIVITY_RACE_HIGHEST_REWARD"), tostring(ActivityPointRewardCfg[arg_9_0.taskID_].need))
	end

	arg_9_0:RefreshRewardItem()
	arg_9_0:RefreshRewardState()
end

function var_0_0.RefreshRewardItem(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.rewardList_) do
		if arg_10_0.rewardItemList_[iter_10_0] then
			arg_10_0.rewardItemList_[iter_10_0]:SetData(iter_10_1, false)
		else
			arg_10_0.rewardItemList_[iter_10_0] = RewardPoolItem.New(arg_10_0.goRewardPanel_, iter_10_1)
		end
	end

	for iter_10_2 = #arg_10_0.rewardList_ + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_2]:Show(false)
	end
end

function var_0_0.OnReceiveReward(arg_11_0, arg_11_1)
	ActivityRaceData:SetReceivedTaskList(arg_11_0.activityID_, arg_11_0.taskID_)
	getReward2(arg_11_1)
	arg_11_0:RefreshRewardState()
end

function var_0_0.RefreshRewardState(arg_12_0)
	local var_12_0 = ActivityRaceData:GetReceivedTaskList(arg_12_0.activityID_)[arg_12_0.taskID_]
	local var_12_1 = ActivityRaceData:GetStateList()[arg_12_0.activityID_]

	arg_12_0.score_ = 0

	if var_12_1 then
		if not arg_12_0.isAccumulated_ then
			arg_12_0.score_ = var_12_1.score
		else
			arg_12_0.score_ = tonumber(var_12_1.accumulativeScore)
		end
	end

	if var_12_0 then
		arg_12_0.rewardController_:SetSelectedState("received")
	elseif arg_12_0.score_ >= ActivityPointRewardCfg[arg_12_0.taskID_].need then
		arg_12_0.rewardController_:SetSelectedState("complete")
	elseif not arg_12_0.isAccumulated_ then
		arg_12_0.rewardController_:SetSelectedState("incomplete")
	else
		arg_12_0.rewardController_:SetSelectedState("accumulateIncomplete")

		arg_12_0.processText_.text = string.format("%d/%d", arg_12_0.score_, ActivityPointRewardCfg[arg_12_0.taskID_].need)
	end
end

return var_0_0
