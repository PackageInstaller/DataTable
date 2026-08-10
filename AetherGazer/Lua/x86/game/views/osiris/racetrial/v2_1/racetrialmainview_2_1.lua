local var_0_0 = class("RaceTrialMainView_2_1", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return RaceTrialTools.GetMainUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.battleList_ = {}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, arg_3_0:GetBattleItemClass())
	arg_3_0.receiveCon_ = ControllerUtil.GetController(arg_3_0.transform_, "receiveCon")
	arg_3_0.scoreRewardItem_ = CommonItem.New(arg_3_0.CommonItemGo_)

	arg_3_0.scoreRewardItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_3_0.reward_)
	end)

	arg_3_0.receivePointRewardHandler_ = handler(arg_3_0, arg_3_0.OnReceivePoint)
end

function var_0_0.GetBattleItemClass(arg_5_0)
	return RaceTrialTools.GetBattleItemClass(arg_5_0.activityID_)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_0.battleList_[arg_6_1], arg_6_0.activityID_)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.firstRewardBtn_, nil, function()
		if not arg_7_0:IsActivityTime(arg_7_0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = arg_7_0.activityID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.scoreRewardBtn_, nil, function()
		if not arg_7_0:IsActivityTime(arg_7_0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("volumeRaceTrialScoreRewardPop", {
			mainActivityID = arg_7_0.activityID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		if not arg_7_0:IsActivityTime(arg_7_0.activityID_) then
			return
		end

		RaceTrialAction:ReceiveScoreReward(arg_7_0.curLv_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.DivineBtn_, nil, function()
		if not arg_7_0:IsActivityTime(arg_7_0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("volumeHeroRaceTrialDetails")
	end)
	arg_7_0:AddBtnListener(arg_7_0.descBtn_, nil, function()
		local var_12_0 = GetTips("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_12_0
		})
	end)
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)

	if arg_13_1 == true then
		arg_13_0:RefreshUI()
		arg_13_0:BindRedPointUI()
		arg_13_0:RegistEventListener(RACE_TRIAL_POINT_RECEIVE, arg_13_0.receivePointRewardHandler_)
	else
		for iter_13_0, iter_13_1 in pairs(arg_13_0.scrollHelper_:GetItemList()) do
			iter_13_1:OnExit()
		end

		arg_13_0.scoreRewardItem_:OnExit()

		local var_13_0 = arg_13_0.scrollHelper_:GetScrolledPosition()

		saveData(string.format("RaceTrial_%d", arg_13_0.activityID_), "scrollPosX", var_13_0.x)
		arg_13_0:UnBindRedPointUI()
		arg_13_0:RemoveAllEventListener()
	end
end

function var_0_0.OnReceivePoint(arg_14_0)
	arg_14_0:GetCurLv()
	arg_14_0:RefreshScoreItem()
end

function var_0_0.BindRedPointUI(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_15_0.activityID_))
end

function var_0_0.UnBindRedPointUI(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_16_0.activityID_))
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0:GetCurLv()
	arg_17_0:RefreshList()
	arg_17_0:RefreshScoreItem()
end

function var_0_0.GetCurLv(arg_18_0)
	arg_18_0.curLv_ = RaceTrialData:GetCurLv(arg_18_0.activityID_)
	arg_18_0.data_ = RaceTrialData:GetScoreRewardByID(arg_18_0.curLv_)
end

function var_0_0.RefreshList(arg_19_0)
	arg_19_0.battleList_ = ActivityData:GetActivityData(arg_19_0.activityID_).subActivityIdList

	local var_19_0 = getData(string.format("RaceTrial_%d", arg_19_0.activityID_), "scrollPosX")
	local var_19_1 = Vector2(var_19_0, 1)

	arg_19_0.scrollHelper_:StartScrollByPosition(#arg_19_0.battleList_, var_19_1)
end

function var_0_0.RefreshScoreItem(arg_20_0)
	arg_20_0.rewardCfg_ = ActivityPointRewardCfg[arg_20_0.curLv_]

	local var_20_0 = RaceTrialData:GetTotalScore(arg_20_0.activityID_)

	arg_20_0.curScoreText_.text = var_20_0
	arg_20_0.needScoreText_.text = "/" .. arg_20_0.rewardCfg_.need
	arg_20_0.reward_ = arg_20_0.rewardCfg_.reward_item_list[1]

	arg_20_0.scoreRewardItem_:RefreshData(formatReward(arg_20_0.rewardCfg_.reward_item_list[1]))

	if arg_20_0.data_.receive_flag then
		arg_20_0.receiveCon_:SetSelectedState("received")
	elseif var_20_0 >= arg_20_0.rewardCfg_.need then
		arg_20_0.receiveCon_:SetSelectedState("complete")
	else
		arg_20_0.receiveCon_:SetSelectedState("incomplete")
	end
end

function var_0_0.OnPointReceive(arg_21_0)
	arg_21_0:GetCurLv()
	arg_21_0:RefreshScoreItem()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()
	arg_22_0.scrollHelper_:Dispose()
	arg_22_0.scoreRewardItem_:Dispose()

	arg_22_0.receivePointRewardHandler_ = nil

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
