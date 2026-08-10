local var_0_0 = class("ValentineGameRewardItem", ReduxView)

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
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if ActivityData:GetActivityData(arg_4_0.activityID_):IsActivitying() then
			ValentineGameAction:GetReward(arg_4_0.activityID_)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0.activityID_ = arg_7_1

	arg_7_0:RefreshReward()
	arg_7_0:RefreshState()
end

function var_0_0.RefreshReward(arg_8_0)
	arg_8_0.cfg_ = ActivityValentineCfg[arg_8_0.activityID_]

	local var_8_0 = arg_8_0.cfg_.reward_item_list

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

	arg_8_0.text_.text = string.format(GetTips("ACTIVITY_VALENTINE_REWARD_NEED_DESC"), arg_8_0.cfg_.name)
end

function var_0_0.RefreshState(arg_9_0)
	local var_9_0 = ValentineGameData:GetData(arg_9_0.activityID_)

	if var_9_0 and var_9_0.isReward then
		arg_9_0.stateCon_:SetSelectedState("received")
	elseif var_9_0 and var_9_0.isClear then
		arg_9_0.stateCon_:SetSelectedState("complete")
	else
		arg_9_0.stateCon_:SetSelectedState("uncomplete")
	end
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0 = 1, #arg_11_0.rewardItems_ do
		arg_11_0.rewardItems_[iter_11_0]:Dispose()
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
