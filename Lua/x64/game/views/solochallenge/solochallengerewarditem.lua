local var_0_0 = class("SoloChallengeRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardItemList_ = {}
	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	arg_3_0.activityID_ = arg_3_1.activityID
	arg_3_0.difficultyIndex_ = arg_3_1.difficultyIndex

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.RequireReceive(arg_5_0.activityID_, arg_5_0.difficultyIndex_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				getReward(formatRewardCfgList(ActivitySoloChallengeCfg[arg_5_0.activityID_].reward_item_list[arg_5_0.difficultyIndex_][2]))
				SoloChallengeData:SetReceivedActivityList(arg_5_0.activityID_, arg_5_0.difficultyIndex_)
				arg_5_0:RefreshState()
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ""

	if arg_8_0.difficultyIndex_ == 1 then
		var_8_0 = GetTips("CLEAR_NORMAL_DIFFICULTY")
	elseif arg_8_0.difficultyIndex_ == 2 then
		var_8_0 = GetTips("CLEAR_DIFFICULTY")
	else
		var_8_0 = GetTips("CLEAR_EXTREME_DIFFICULTY")
	end

	arg_8_0.descText_.text = GetI18NText(var_8_0)

	arg_8_0:RefreshState()
	arg_8_0:RefreshItem()
end

function var_0_0.RefreshState(arg_9_0)
	local var_9_0 = SoloChallengeData:GetCompletedActivityList()
	local var_9_1 = SoloChallengeData:GetReceivedActivityList()
	local var_9_2 = table.keyof(var_9_0[arg_9_0.activityID_], arg_9_0.difficultyIndex_) ~= nil
	local var_9_3 = table.keyof(var_9_1[arg_9_0.activityID_], arg_9_0.difficultyIndex_) ~= nil

	if not var_9_2 then
		arg_9_0.rewardState_:SetSelectedState("uncompleted")
	elseif not var_9_3 then
		arg_9_0.rewardState_:SetSelectedState("unreceived")
	else
		arg_9_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.RefreshItem(arg_10_0)
	local var_10_0 = ActivitySoloChallengeCfg[arg_10_0.activityID_].reward_item_list[arg_10_0.difficultyIndex_][2]

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if arg_10_0.rewardItemList_[iter_10_0] then
			arg_10_0.rewardItemList_[iter_10_0]:SetData(iter_10_1, false)
		else
			arg_10_0.rewardItemList_[iter_10_0] = arg_10_0:GetRewardItem().New(arg_10_0.goRewardPanel_, iter_10_1, true)
		end
	end

	for iter_10_2 = #var_10_0 + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_2]:Show(false)
	end
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.rewardCfg_[arg_11_1]

	arg_11_2:SetData(var_11_0, POP_ITEM)
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardItemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.GetRewardItem(arg_13_0)
	return RewardPoolFactoryItem
end

function var_0_0.GetCommonItem(arg_14_0, arg_14_1)
	return arg_14_1:GetCommonItem()
end

return var_0_0
