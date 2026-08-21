local var_0_0 = class("LimitedCalculationRewardItem", ReduxView)

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
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		ActivityAction.ReceivePointReward({
			arg_4_0.id_
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.info_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2
	arg_7_0.id_ = arg_7_1.id
	arg_7_0.cfg_ = ActivityPointRewardCfg[arg_7_0.id_]
	arg_7_0.score_ = LimitedCalculationData:GetScore(arg_7_0.activityID_)
	arg_7_0.need_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), arg_7_0.cfg_.need)

	arg_7_0:RefreshReward()
	arg_7_0:RefreshState()
end

function var_0_0.RefreshReward(arg_8_0)
	local var_8_0 = arg_8_0.cfg_.reward_item_list

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if arg_8_0.rewardItems_[iter_8_0] == nil then
			arg_8_0.rewardItems_[iter_8_0] = RewardItem.New(arg_8_0.rewardTemplate_, arg_8_0.rewardParent_, true)

			arg_8_0.rewardItems_[iter_8_0]:UpdateCommonItemAni()
		end

		arg_8_0.rewardItems_[iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshState(arg_9_0)
	if arg_9_0.info_.complete_flag == ActivityConst.LIMITED_CALCULATION_REWARD_STATE.UNFINISHED then
		if arg_9_0.cfg_.need <= arg_9_0.score_ then
			arg_9_0.stateCon_:SetSelectedState("success")
		else
			arg_9_0.stateCon_:SetSelectedState("unfinished")
		end
	else
		arg_9_0.stateCon_:SetSelectedState("rewarded")
	end
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0 = #arg_10_0.rewardItems_, 1, -1 do
		arg_10_0.rewardItems_[iter_10_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0 = #arg_11_0.rewardItems_, 1, -1 do
		arg_11_0.rewardItems_[iter_11_0]:Dispose()

		arg_11_0.rewardItems_[iter_11_0] = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
