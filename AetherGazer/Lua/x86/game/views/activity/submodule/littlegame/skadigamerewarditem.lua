local var_0_0 = class("LeviathanGameRewardItem", ReduxView)

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
	arg_3_0.receiveCon_ = {}
	arg_3_0.receiveCon_[1] = ControllerUtil.GetController(arg_3_0.statebtnTrs_1, "stateBtn")
	arg_3_0.receiveCon_[2] = ControllerUtil.GetController(arg_3_0.statebtnTrs_2, "stateBtn")
	arg_3_0.receiveCon_[3] = ControllerUtil.GetController(arg_3_0.statebtnTrs_3, "stateBtn")
end

function var_0_0.AddUIListeners(arg_4_0)
	for iter_4_0 = 1, 3 do
		arg_4_0:AddBtnListener(arg_4_0["statebtnBtn_" .. iter_4_0], nil, function()
			SummerLittleGameAction.GetSkadiReward(arg_4_0.activityID_, iter_4_0)
		end)
	end
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.textText_.text = GetI18NText(ActivityCrossWaveCfg[arg_7_0.activityID_].name)

	for iter_7_0 = 1, 3 do
		arg_7_0:RefreshReward(iter_7_0)
		arg_7_0:RefreshType(iter_7_0)
	end
end

function var_0_0.RefreshReward(arg_8_0, arg_8_1)
	local var_8_0 = ActivityCrossWaveCfg[arg_8_0.activityID_].reward_item_list[arg_8_1]

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.rewardList_[arg_8_1] then
			arg_8_0.rewardList_[arg_8_1] = {}
		end

		if not arg_8_0.rewardList_[arg_8_1][iter_8_0] then
			arg_8_0.rewardList_[arg_8_1][iter_8_0] = RewardItem.New(arg_8_0.rewardItem_, arg_8_0["rewardParent_" .. arg_8_1])

			arg_8_0.rewardList_[arg_8_1][iter_8_0]:UpdateCommonItemAni()
		end

		arg_8_0.rewardList_[arg_8_1][iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardList_[arg_8_1] do
		arg_8_0.rewardList_[arg_8_1][iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshType(arg_9_0, arg_9_1)
	local var_9_0 = SummerLittleGameData:GetSkadiStars(arg_9_0.activityID_)
	local var_9_1 = SummerLittleGameData:GetSkadiReward(arg_9_0.activityID_)

	if arg_9_1 > #var_9_0 then
		arg_9_0.receiveCon_[arg_9_1]:SetSelectedState("unfinished")
	elseif table.indexof(var_9_1, arg_9_1) then
		arg_9_0.receiveCon_[arg_9_1]:SetSelectedState("rewarded")
	else
		arg_9_0.receiveCon_[arg_9_1]:SetSelectedState("success")
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.rewardList_) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			iter_11_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
