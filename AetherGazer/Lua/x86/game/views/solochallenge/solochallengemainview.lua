local var_0_0 = class("SoloChallengeMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerSoloChallengeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.switchItemList_ = {}
	arg_3_0.rewardItemList_ = {}
	arg_3_0.onClickHandler_ = handler(arg_3_0, arg_3_0.OnClick)
	arg_3_0.adaptImg_ = arg_3_0:FindCom("SelfAdaptImage", nil, arg_3_0.roleTras_)
	arg_3_0.rewardState_ = ControllerUtil.GetController(arg_3_0.rewardTrans_, "rewardState")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.difficultyIndex_ = 1
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	arg_4_0:AddTimer()
	arg_4_0:RefreshUI()
	arg_4_0:RefreshActivityDesc()

	local var_4_0 = SoloChallengeData:GetContentPosX(arg_4_0.activityID_)

	if var_4_0 ~= nil then
		local var_4_1 = arg_4_0.switchPanelTrans_.localPosition

		var_4_1.x = var_4_0
		arg_4_0.switchPanelTrans_.localPosition = var_4_1
	end
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_CHALLENGE_DESCRIPE")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_6_0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.RequireReceive(arg_6_0.selectActivityID_, 1, function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				getReward2(mergeReward2(arg_8_0.reward_list))
				SoloChallengeData:SetReceivedActivityList(arg_6_0.selectActivityID_, arg_6_0.difficultyIndex_)
				arg_6_0:RefreshReward()
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_6_0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeData:SetSelectedDifficultyIndex(arg_6_0.selectActivityID_, arg_6_0.difficultyIndex_)
		SoloChallengeAction.SaveDifficulty(arg_6_0.selectActivityID_, arg_6_0.difficultyIndex_, handler(arg_6_0, arg_6_0.OnStart))
	end)
end

function var_0_0.OnStart(arg_10_0)
	arg_10_0:Go("/soloChallengeSelect", {
		activityID = arg_10_0.selectActivityID_,
		difficultyIndex = arg_10_0.difficultyIndex_
	})
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.subActivityList_ = ActivityCfg[arg_11_0.activityID_].sub_activity_list

	local var_11_0 = SoloChallengeData:GetSelectActivityID(arg_11_0.activityID_) or arg_11_0.subActivityList_[1]

	arg_11_0.selectActivityID_ = var_11_0

	if var_11_0 == nil then
		return
	end

	SoloChallengeData:SetSelectActivityID(arg_11_0.activityID_, var_11_0)
	arg_11_0:RefreshSwitchItem()
	arg_11_0:RefreshReward()
	arg_11_0:RefreshRoleImage()
	arg_11_0:RefreshDesc()
end

function var_0_0.RefreshSwitchItem(arg_12_0)
	local var_12_0 = arg_12_0.selectActivityID_
	local var_12_1 = arg_12_0.subActivityList_

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = arg_12_0:GetSwitchItemClass()

		if arg_12_0.switchItemList_[iter_12_0] == nil then
			arg_12_0.switchItemList_[iter_12_0] = var_12_2.New(arg_12_0.switchItem_, arg_12_0.switchPanel_, iter_12_1, arg_12_0.activityID_)

			arg_12_0.switchItemList_[iter_12_0]:RegisterClickListener(arg_12_0.onClickHandler_)
		end

		arg_12_0.switchItemList_[iter_12_0]:SetActivityID(iter_12_1, arg_12_0.activityID_)
	end

	for iter_12_2 = #arg_12_0.switchItemList_, #var_12_1 + 1, -1 do
		arg_12_0.switchItemList_[iter_12_2]:Dispose()

		arg_12_0.switchItemList_[iter_12_2] = nil
	end

	arg_12_0:RefreshSelectactivity(var_12_0)
end

function var_0_0.GetSwitchItemClass(arg_13_0)
	return SoloChallengeSwitchItem
end

function var_0_0.RefreshReward(arg_14_0)
	local var_14_0 = ActivitySoloChallengeCfg[arg_14_0.selectActivityID_].reward_item_list[arg_14_0.difficultyIndex_][2]

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if arg_14_0.rewardItemList_[iter_14_0] then
			arg_14_0.rewardItemList_[iter_14_0]:SetData(iter_14_1, false)
		else
			arg_14_0.rewardItemList_[iter_14_0] = RewardPoolItem.New(arg_14_0.goRewardPanel_, iter_14_1)
		end
	end

	for iter_14_2 = #var_14_0 + 1, #arg_14_0.rewardItemList_ do
		arg_14_0.rewardItemList_[iter_14_2]:Show(false)
	end

	local var_14_1 = SoloChallengeData:GetCompletedActivityList()
	local var_14_2 = SoloChallengeData:GetReceivedActivityList()
	local var_14_3 = table.keyof(var_14_1[arg_14_0.selectActivityID_], arg_14_0.difficultyIndex_) ~= nil
	local var_14_4 = table.keyof(var_14_2[arg_14_0.selectActivityID_], arg_14_0.difficultyIndex_) ~= nil

	if not var_14_3 then
		arg_14_0.rewardState_:SetSelectedState("uncompleted")
	elseif not var_14_4 then
		arg_14_0.rewardState_:SetSelectedState("unreceived")
	else
		arg_14_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.RefreshRoleImage(arg_15_0)
	arg_15_0.roleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SummerUI/" .. ActivitySoloChallengeCfg[arg_15_0.selectActivityID_].background)

	arg_15_0.adaptImg_:AdaptImg()
end

function var_0_0.RefreshActivityDesc(arg_16_0)
	arg_16_0.activityDescText_.text = GetTips("ACTIVITY_SOLO_CHALLENGE_CONTENT")
end

function var_0_0.RefreshDesc(arg_17_0)
	arg_17_0.nameText_.text = GetI18NText(ActivitySoloChallengeCfg[arg_17_0.selectActivityID_].name)
	arg_17_0.descText_.text = GetI18NText(ActivitySoloChallengeCfg[arg_17_0.selectActivityID_].desc)
end

function var_0_0.OnClick(arg_18_0)
	arg_18_0:RefreshUI()
end

function var_0_0.RefreshSelectactivity(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.switchItemList_) do
		iter_19_1:OnSelect(arg_19_1)
	end
end

function var_0_0.AddTimer(arg_20_0)
	if manager.time:GetServerTime() >= arg_20_0.stopTime_ then
		arg_20_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_20_0:StopTimer()

	if arg_20_0.switchItemList_ then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.switchItemList_) do
			iter_20_1:RefreshLock()
		end
	end

	arg_20_0.textTime_.text = manager.time:GetLostTimeStr(arg_20_0.stopTime_)
	arg_20_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_20_0.stopTime_ then
			arg_20_0:StopTimer()

			arg_20_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		if arg_20_0.switchItemList_ then
			for iter_21_0, iter_21_1 in ipairs(arg_20_0.switchItemList_) do
				iter_21_1:RefreshLock()
			end
		end

		arg_20_0.textTime_.text = manager.time:GetLostTimeStr(arg_20_0.stopTime_)
	end, 1, -1)

	arg_20_0.timer_:Start()
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_23_0)
	manager.windowBar:HideBar()
	arg_23_0:StopTimer()

	local var_23_0 = arg_23_0.switchPanelTrans_.localPosition

	SoloChallengeData:SetContentPosX(arg_23_0.activityID_, var_23_0.x)
end

function var_0_0.Dispose(arg_24_0)
	var_0_0.super.Dispose(arg_24_0)
	arg_24_0:StopTimer()

	arg_24_0.onClickHandler_ = nil

	for iter_24_0, iter_24_1 in pairs(arg_24_0.rewardItemList_) do
		iter_24_1:Dispose()
	end

	arg_24_0.rewardItemList_ = nil

	for iter_24_2, iter_24_3 in pairs(arg_24_0.switchItemList_) do
		iter_24_3:Dispose()
	end

	arg_24_0.switchItemList_ = nil
end

return var_0_0
