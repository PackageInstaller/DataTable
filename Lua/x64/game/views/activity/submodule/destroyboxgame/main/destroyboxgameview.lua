local var_0_0 = class("DestroyBoxGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = DestroyBoxGameUICfg.get_id_list_by_main_activity_id[arg_1_0.params_.activityID][1]

	return DestroyBoxGameUICfg[var_1_0].main_prefab
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.viewList_ = {
		DestroyBoxGameNormalView.New(arg_3_0.challengeGo3_),
		DestroyBoxGameChallengeView.New(arg_3_0.challengeGo1_, 1),
		DestroyBoxGameChallengeView.New(arg_3_0.challengeGo2_, 2)
	}
	arg_3_0.switchSelectItemHandler_ = handler(arg_3_0, arg_3_0.SwitchSelectItem)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.mainActivityID_ = arg_4_0.params_.activityID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_4_0 = DestroyBoxGameUICfg.get_id_list_by_main_activity_id[arg_4_0.mainActivityID_][1]
	local var_4_1 = DestroyBoxGameUICfg[var_4_0].desc

	manager.windowBar:SetGameHelpKey(var_4_1)
	arg_4_0:RefreshTime()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.viewList_) do
		iter_4_1:OnEnter(arg_4_0.mainActivityID_)
	end

	arg_4_0:SwitchSelectItem()
	manager.notify:RegistListener(DESTROY_BOX_GAME_SELECT_STAGE, arg_4_0.switchSelectItemHandler_)
	manager.redPoint:bindUIandKey(arg_4_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, arg_4_0.mainActivityID_))
end

function var_0_0.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, arg_5_0.mainActivityID_))
	manager.notify:RemoveListener(DESTROY_BOX_GAME_SELECT_STAGE, arg_5_0.switchSelectItemHandler_)
	manager.windowBar:HideBar()
	arg_5_0:StopTimer()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.viewList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.switchSelectHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.viewList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.viewList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("destroyBoxGameReward", {
			mainActivityID = arg_7_0.mainActivityID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.rankingBtn_, nil, function()
		arg_7_0:Go("/DestroyBoxRankView", {
			type = RankBaseConst.RANK_TYPE.ALL,
			subType = RankBaseConst.SUB_TYPE.SCORE,
			activityID = arg_7_0.mainActivityID_
		})
	end)
end

function var_0_0.SwitchSelectItem(arg_10_0)
	local var_10_0 = DestroyBoxGameData:GetSelectID(arg_10_0.mainActivityID_)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.viewList_) do
		iter_10_1:SwitchSelectItem(var_10_0)
	end
end

function var_0_0.RefreshTime(arg_11_0)
	arg_11_0:StopTimer()

	local var_11_0 = ActivityData:GetActivityData(arg_11_0.mainActivityID_).stopTime

	arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0)
	arg_11_0.timer_ = Timer.New(function()
		arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0)
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

return var_0_0
