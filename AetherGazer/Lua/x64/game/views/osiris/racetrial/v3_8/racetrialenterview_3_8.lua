local var_0_0 = class("RaceTrailEnterView_3_8", ReduxView)

function var_0_0.UIName(arg_1_0)
	return RaceTrialTools.GetPageUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.layzyInit = false
	arg_3_0.scoreReward = CommonItemView.New(arg_3_0.scoreReward_, true)
	arg_3_0.recieveController = arg_3_0.controllers_:GetController("scoreRewardState")

	arg_3_0:AddUIListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID = arg_4_0.params_.activityID or ActivityConst.OSIRIS_TRIAL

	if not arg_4_0.layzyInit then
		arg_4_0:LazyInit()
	end

	arg_4_0.battleItemList:StartScroll(#ActivityData:GetActivityData(arg_4_0.activityID).subActivityIdList)
	arg_4_0:BindRedPointUI()
	arg_4_0:RefreshUI()
	arg_4_0:ScrollToRecommendItem()
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
	arg_6_0:UnBindRedPointUI()
	arg_6_0.battleItemList:UpdateUIList(0)
end

function var_0_0.LazyInit(arg_7_0)
	arg_7_0.layzyInit = true
	arg_7_0.battleItemList = LuaList.New(handler(arg_7_0, arg_7_0.RenderItem), arg_7_0.battleItemList_, RaceTrialTools.GetBattleItemClass(arg_7_0.activityID))
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	arg_8_0.scoreReward:Dispose()
	arg_8_0.battleItemList:Dispose()
end

function var_0_0.AddUIListeners(arg_9_0)
	arg_9_0:AddBtnListenerScale(arg_9_0.helpBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	arg_9_0:AddBtnListener(arg_9_0.firstRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_9_0.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = arg_9_0.activityID
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.scoreRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_9_0.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrialScoreReward", {
			mainActivityID = arg_9_0.activityID
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_9_0.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_9_0.curLv then
			RaceTrialAction:ReceiveAllScoreReward(arg_9_0.activityID)
		end
	end)
end

function var_0_0.OnPointReceive(arg_14_0)
	arg_14_0:RefreshScore()
end

function var_0_0.BindRedPointUI(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_15_0.activityID))
	manager.redPoint:bindUIandKey(arg_15_0.scoreRewardBtn_.transform, string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_15_0.activityID))
end

function var_0_0.UnBindRedPointUI(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_16_0.activityID))
	manager.redPoint:unbindUIandKey(arg_16_0.scoreRewardBtn_.transform, string.format("%s_%s_PointReward", RedPointConst.ACTIVITY_RACE_TRIAL, arg_16_0.activityID))
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0:RefreshScore()
	arg_17_0:RefreshList()
end

function var_0_0.RefreshScore(arg_18_0)
	local var_18_0 = arg_18_0.activityID
	local var_18_1 = RaceTrialData:GetCurLv(var_18_0)

	arg_18_0.curLv = var_18_1

	local var_18_2 = RaceTrialData:GetScoreRewardByID(var_18_1)
	local var_18_3 = RaceTrialData:GetTotalScore(var_18_0)
	local var_18_4 = ActivityPointRewardCfg[var_18_1]
	local var_18_5 = var_18_4.reward_item_list[1]

	arg_18_0.curScore_.text = var_18_3
	arg_18_0.needScore_.text = "/" .. var_18_4.need

	local var_18_6 = rewardToItemTemplate(formatReward(var_18_5), nil, true)

	arg_18_0.scoreReward:SetData(var_18_6)

	if var_18_2.receive_flag then
		arg_18_0.recieveController:SetSelectedState("recieved")
	elseif var_18_3 >= var_18_4.need then
		arg_18_0.recieveController:SetSelectedState("complete")
	else
		arg_18_0.recieveController:SetSelectedState("incomplete")
	end
end

function var_0_0.RefreshList(arg_19_0)
	arg_19_0.battleItemList:Refresh()
end

function var_0_0.RenderItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = ActivityData:GetActivityData(arg_20_0.activityID).subActivityIdList[arg_20_1]

	arg_20_2:RefreshUI(var_20_0, arg_20_0.activityID)
end

local function var_0_1(arg_21_0)
	local var_21_0 = ActivityData:GetActivityData(arg_21_0.activityID).subActivityIdList
	local var_21_1 = 1
	local var_21_2 = math.huge

	for iter_21_0 = 1, #var_21_0 do
		local var_21_3 = var_21_0[iter_21_0]

		if manager.redPoint:getTipBoolean(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_21_0.activityID, var_21_3)) then
			return iter_21_0
		end

		local var_21_4 = (RaceTrialData:GetBattleData(var_21_3) or {}).point or 0

		if var_21_4 < var_21_2 then
			var_21_1 = iter_21_0
			var_21_2 = var_21_4
		end
	end

	return var_21_1
end

function var_0_0.ScrollToRecommendItem(arg_22_0)
	arg_22_0.battleItemList:ScrollToIndex(var_0_1(arg_22_0))
end

return var_0_0
