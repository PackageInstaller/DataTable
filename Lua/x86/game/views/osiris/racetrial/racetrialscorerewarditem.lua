local var_0_0 = class("RaceTrialScoreRewardItem", ReduxView)

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

	arg_3_0.rewardList_ = {}
	arg_3_0.receiveCon_ = ControllerUtil.GetController(arg_3_0.transform_, "receiveCon")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveScoreReward(arg_4_0.id_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.id_ = arg_7_1
	arg_7_0.activityID_ = arg_7_3
	arg_7_0.cfg_ = ActivityPointRewardCfg[arg_7_1]
	arg_7_0.data_ = RaceTrialData:GetScoreRewardByID(arg_7_0.id_)
	arg_7_0.score_ = arg_7_2

	arg_7_0:RefreshReward()
	arg_7_0:RefreshTitle()
	arg_7_0:RefreshState()
end

function var_0_0.RefreshTitle(arg_8_0)
	arg_8_0.title_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. arg_8_0.cfg_.need
end

function var_0_0.RefreshReward(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.cfg_.reward_item_list) do
		if arg_9_0.rewardList_[iter_9_0] == nil then
			arg_9_0.rewardList_[iter_9_0] = RewardItem.New(arg_9_0.rewardItem_, arg_9_0.rewardParent_, false)

			arg_9_0.rewardList_[iter_9_0]:UpdateCommonItemAni()
		end

		arg_9_0.rewardList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #arg_9_0.cfg_.reward_item_list + 1, #arg_9_0.rewardList_ do
		arg_9_0.rewardList_[iter_9_2]:Show(false)
	end
end

function var_0_0.RefreshState(arg_10_0)
	if arg_10_0.data_.receive_flag then
		arg_10_0.receiveCon_:SetSelectedState("received")
	elseif arg_10_0.score_ >= arg_10_0.cfg_.need then
		arg_10_0.receiveCon_:SetSelectedState("complete")
	else
		arg_10_0.receiveCon_:SetSelectedState("incomplete")
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0:DisposeRewardItems()
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.DisposeRewardItems(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.rewardList_ do
		arg_13_0.rewardList_[iter_13_0]:Dispose()

		arg_13_0.rewardList_[iter_13_0] = nil
	end

	arg_13_0.rewardList_ = nil
end

return var_0_0
