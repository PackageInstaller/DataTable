local var_0_0 = class("RaceTrialMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return RaceTrialTools.GetMainUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.battleList_ = {}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, arg_4_0:GetBattleItemClass())
	arg_4_0.receiveCon_ = ControllerUtil.GetController(arg_4_0.transform_, "receiveCon")
	arg_4_0.scoreRewardItem_ = CommonItem.New(arg_4_0.CommonItemGo_)

	arg_4_0.scoreRewardItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_4_0.reward_)
	end)
end

function var_0_0.GetBattleItemClass(arg_6_0)
	return RaceTrialTools.GetBattleItemClass(arg_6_0.activityID_)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(arg_7_0.battleList_[arg_7_1], arg_7_0.activityID_)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.firstRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = arg_8_0.activityID_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.scoreRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialScoreReward", {
			mainActivityID = arg_8_0.activityID_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveScoreReward(arg_8_0.curLv_)
	end)
	arg_8_0:AddBtnListener(arg_8_0.DivineBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("heroRaceTrialDetails")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.activityID_ = arg_13_0.params_.activityID or ActivityConst.OSIRIS_TRIAL

	arg_13_0:BindRedPointUI()
	arg_13_0:RefreshUI()
end

function var_0_0.BindRedPointUI(arg_14_0)
	manager.redPoint:bindUIandKey(arg_14_0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_14_0.params_.activityID))
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:GetCurLv()
	arg_15_0:RefreshTimeCnt()
	arg_15_0:RefreshList()
	arg_15_0:RefreshScoreItem()
end

function var_0_0.GetCurLv(arg_16_0)
	arg_16_0.curLv_ = RaceTrialData:GetCurLv(arg_16_0.activityID_)
	arg_16_0.data_ = RaceTrialData:GetScoreRewardByID(arg_16_0.curLv_)
end

function var_0_0.RefreshTimeCnt(arg_17_0)
	local var_17_0
	local var_17_1 = arg_17_0:GetActivityStartTime()
	local var_17_2 = arg_17_0:GetActivityEndTime()
	local var_17_3 = manager.time:GetServerTime()

	arg_17_0:StopTimer()

	if var_17_3 < var_17_1 then
		var_17_0 = var_17_1 - var_17_3
		arg_17_0.timeCntText_.text = GetTips("ERROR_ACTIVITY_NOT_OPEN")
		arg_17_0.timer_ = Timer.New(function()
			var_17_0 = var_17_1 - manager.time:GetServerTime()

			if var_17_0 <= 0 then
				arg_17_0:StopTimer()
				arg_17_0:RefreshUI()

				return
			end
		end, 1, -1)

		arg_17_0.timer_:Start()
	elseif var_17_3 < var_17_2 then
		var_17_0 = var_17_2 - var_17_3
		arg_17_0.timeCntText_.text = arg_17_0:GetTimeText(var_17_0)
		arg_17_0.timer_ = Timer.New(function()
			var_17_0 = var_17_2 - manager.time:GetServerTime()

			if var_17_0 <= 0 then
				arg_17_0:StopTimer()
				arg_17_0:RefreshUI()

				return
			end

			arg_17_0.timeCntText_.text = arg_17_0:GetTimeText(var_17_0)
		end, 1, -1)

		arg_17_0.timer_:Start()
	else
		arg_17_0.timeCntText_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.GetActivityStartTime(arg_20_0)
	return RaceTrialData:GetRaceTrialStartTime(arg_20_0.activityID_)
end

function var_0_0.GetActivityEndTime(arg_21_0)
	return RaceTrialData:GetRaceTrialEndTime(arg_21_0.activityID_)
end

function var_0_0.GetTimeText(arg_22_0, arg_22_1)
	local var_22_0 = ""

	if arg_22_1 / 86400 >= 1 then
		var_22_0 = math.ceil(arg_22_1 / 86400) .. GetTips("DAY")
	elseif arg_22_1 / 3600 >= 1 then
		var_22_0 = math.ceil(arg_22_1 / 3600) .. GetTips("HOUR")
	elseif arg_22_1 / 60 >= 1 then
		var_22_0 = math.ceil(arg_22_1 / 60) .. GetTips("MINUTE")
	else
		var_22_0 = 1 .. GetTips("MINUTE")
	end

	return var_22_0
end

function var_0_0.RefreshList(arg_23_0)
	arg_23_0.battleList_ = ActivityData:GetActivityData(arg_23_0.activityID_).subActivityIdList

	local var_23_0 = getData(string.format("RaceTrial_%d", arg_23_0.activityID_), "scrollPosX")
	local var_23_1 = Vector2(var_23_0, 1)

	arg_23_0.scrollHelper_:StartScrollByPosition(#arg_23_0.battleList_, var_23_1)
end

function var_0_0.RefreshScoreItem(arg_24_0)
	arg_24_0.rewardCfg_ = ActivityPointRewardCfg[arg_24_0.curLv_]

	local var_24_0 = RaceTrialData:GetTotalScore(arg_24_0.activityID_)

	arg_24_0.scoreNeedText_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. arg_24_0.rewardCfg_.need
	arg_24_0.scoreText_.text = var_24_0 .. "/" .. arg_24_0.rewardCfg_.need
	arg_24_0.progressBar_.fillAmount = var_24_0 / arg_24_0.rewardCfg_.need
	arg_24_0.reward_ = arg_24_0.rewardCfg_.reward_item_list[1]

	arg_24_0.scoreRewardItem_:RefreshData(formatReward(arg_24_0.rewardCfg_.reward_item_list[1]))

	if arg_24_0.data_.receive_flag then
		arg_24_0.receiveCon_:SetSelectedState("received")
	elseif var_24_0 >= arg_24_0.rewardCfg_.need then
		arg_24_0.receiveCon_:SetSelectedState("complete")
	else
		arg_24_0.receiveCon_:SetSelectedState("incomplete")
	end
end

function var_0_0.UnBindRedPointUI(arg_25_0)
	manager.redPoint:unbindUIandKey(arg_25_0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_25_0.params_.activityID))
end

function var_0_0.OnTop(arg_26_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
end

function var_0_0.OnPointReceive(arg_27_0)
	arg_27_0:GetCurLv()
	arg_27_0:RefreshScoreItem()
end

function var_0_0.OnExit(arg_28_0)
	manager.windowBar:HideBar()
	arg_28_0:UnBindRedPointUI()

	for iter_28_0, iter_28_1 in pairs(arg_28_0.scrollHelper_:GetItemList()) do
		iter_28_1:OnExit()
	end

	arg_28_0.scoreRewardItem_:OnExit()

	if arg_28_0.timer_ then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end

	local var_28_0 = arg_28_0.scrollHelper_:GetScrolledPosition()

	saveData(string.format("RaceTrial_%d", arg_28_0.activityID_), "scrollPosX", var_28_0.x)
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:RemoveAllListeners()
	arg_29_0.scrollHelper_:Dispose()
	arg_29_0.scoreRewardItem_:Dispose()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
