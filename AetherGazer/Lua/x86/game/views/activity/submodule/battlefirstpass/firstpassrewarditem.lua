local var_0_0 = class("FirstPassRewardItem", ReduxView)

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
		BattleFirstPassAction:ReceiveReward(arg_4_0.activiteID_, arg_4_0.id_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activiteID_ = arg_7_1
	arg_7_0.info_ = arg_7_2
	arg_7_0.id_ = arg_7_0.info_.battleID
	arg_7_0.cfg_ = ActivityFirstClearCfg[arg_7_0.id_]

	arg_7_0:RefreshTitle()
	arg_7_0:RefreshReward()
	arg_7_0:RefreshType()
end

function var_0_0.RefreshTitle(arg_8_0)
	arg_8_0.title_.text = GetI18NText(arg_8_0.cfg_.reward_desc)
end

function var_0_0.RefreshReward(arg_9_0)
	local var_9_0 = arg_9_0.cfg_.reward_item_list or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not arg_9_0.rewardList_[iter_9_0] then
			arg_9_0.rewardList_[iter_9_0] = RewardItem.New(arg_9_0.rewardItem_, arg_9_0.rewardParent_, true)

			arg_9_0.rewardList_[iter_9_0]:UpdateCommonItemAni()
		end

		arg_9_0.rewardList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #var_9_0 + 1, #arg_9_0.rewardList_ do
		arg_9_0.rewardList_[iter_9_2]:Show(false)
	end
end

function var_0_0.RefreshType(arg_10_0)
	if arg_10_0.info_.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
		arg_10_0.receiveCon_:SetSelectedState("unfinished")
	elseif arg_10_0.info_.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
		arg_10_0.receiveCon_:SetSelectedState("success")
	elseif arg_10_0.info_.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED then
		arg_10_0.receiveCon_:SetSelectedState("rewarded")
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardList_) do
		iter_12_1:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
