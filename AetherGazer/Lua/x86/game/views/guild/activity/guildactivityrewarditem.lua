local var_0_0 = class("GuildActivityRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardItemList_ = {}
	arg_2_0.rewardController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.levelController_ = ControllerUtil.GetController(arg_2_0.transform_, "level")
	arg_2_0.receiveHandler_ = handler(arg_2_0, arg_2_0.OnReceiveReward)
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

		GuildActivityAction.RequireReceive(arg_4_0.rateID_, arg_4_0.receiveHandler_)
	end)
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.rewardItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardItemList_ = nil
	arg_6_0.receiveHandler_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.rateID_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2
	arg_7_0.stopTime_ = ActivityData:GetActivityData(arg_7_0.activityID_).stopTime
	arg_7_0.rewardList_ = ActivityClubLevelSettingCfg[arg_7_1].reward_item_list

	arg_7_0:RefreshUI()
end

function var_0_0.setReceiveCallBack(arg_8_0, arg_8_1)
	arg_8_0.receiveCallBack_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = ActivityClubLevelSettingCfg[arg_9_0.rateID_]

	arg_9_0.descText_.text = string.format(GetTips("ACTIVITY_CLUB_REWARD"), var_9_0.user_level)

	arg_9_0.levelController_:SetSelectedState(tostring(var_9_0.user_level))
	arg_9_0:RefreshRewardItem()
	arg_9_0:RefreshRewardState()
end

function var_0_0.RefreshRewardItem(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.rewardList_) do
		if arg_10_0.rewardItemList_[iter_10_0] then
			arg_10_0.rewardItemList_[iter_10_0]:SetData(iter_10_1, false)
		else
			arg_10_0.rewardItemList_[iter_10_0] = RewardPoolItem.New(arg_10_0.rewardParent_, iter_10_1, true)
		end
	end

	for iter_10_2 = #arg_10_0.rewardList_ + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_2]:Show(false)
	end
end

function var_0_0.OnReceiveReward(arg_11_0)
	GuildActivityData:SetReceivedList(arg_11_0.activityID_, arg_11_0.rateID_)
	getReward(formatRewardCfgList(arg_11_0.rewardList_))
	arg_11_0:RefreshRewardState()

	if arg_11_0.receiveCallBack_ then
		arg_11_0.receiveCallBack_()
	end
end

function var_0_0.RefreshRewardState(arg_12_0)
	local var_12_0 = GuildActivityData:GetReceivedList()
	local var_12_1 = table.keyof(var_12_0, ActivityClubLevelSettingCfg[arg_12_0.rateID_].user_level) ~= nil
	local var_12_2 = ActivityClubLevelSettingCfg[GuildActivityData:GetCurRateID(arg_12_0.activityID_)].user_level

	if var_12_1 then
		arg_12_0.rewardController_:SetSelectedState("received")
	elseif var_12_2 >= ActivityClubLevelSettingCfg[arg_12_0.rateID_].user_level then
		arg_12_0.rewardController_:SetSelectedState("finish")
	else
		arg_12_0.rewardController_:SetSelectedState("unfinished")
	end
end

return var_0_0
