local var_0_0 = class("RaceTrialFirstRewardItem", ReduxView)

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
		if not ActivityData:GetActivityIsOpen(arg_4_0.id) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveFirstReward(arg_4_0.mainActivityID_, arg_4_0.id_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id_ = arg_7_1
	arg_7_0.mainActivityID_ = arg_7_2
	arg_7_0.cfg_ = ActivityRaceTrialCfg[arg_7_1]
	arg_7_0.data_ = RaceTrialData:GetBattleData(arg_7_0.id_)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.cfg_.reward_item_list) do
		if arg_7_0.rewardList_[iter_7_0] == nil then
			arg_7_0.rewardList_[iter_7_0] = RewardItem.New(arg_7_0.rewardItem_, arg_7_0.rewardParent_, false)

			arg_7_0.rewardList_[iter_7_0]:UpdateCommonItemAni()
		end

		arg_7_0.rewardList_[iter_7_0]:SetData(iter_7_1)
	end

	for iter_7_2 = #arg_7_0.cfg_.reward_item_list + 1, #arg_7_0.rewardList_ do
		arg_7_0.rewardList_[iter_7_2]:Show(false)
	end

	arg_7_0.title_.text = GetI18NText(arg_7_0.cfg_.reward_desc)

	if arg_7_0.data_.state == 1 then
		arg_7_0.receiveCon_:SetSelectedState("incomplete")
	elseif arg_7_0.data_.state == 2 then
		arg_7_0.receiveCon_:SetSelectedState("complete")
	elseif arg_7_0.data_.state == 3 then
		arg_7_0.receiveCon_:SetSelectedState("received")
	end
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	arg_9_0:DisposeRewardItems()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.DisposeRewardItems(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.rewardList_ do
		arg_10_0.rewardList_[iter_10_0]:Dispose()

		arg_10_0.rewardList_[iter_10_0] = nil
	end

	arg_10_0.rewardList_ = nil
end

return var_0_0
