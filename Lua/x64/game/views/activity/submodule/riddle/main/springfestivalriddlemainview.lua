local var_0_0 = class("RiddleMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Riddle/RiddleMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}
	arg_3_0.riddleUpdateHandler_ = handler(arg_3_0, arg_3_0.RefreshRiddle)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SPRING_FESTIVAL_RIDDLE_DESCRIPE")

	local var_4_0 = arg_4_0:GetActivityID()

	for iter_4_0, iter_4_1 in ipairs(ActivitySpringFestivalRiddleCfg.get_id_list_by_activity_id[var_4_0]) do
		if arg_4_0.itemList_[iter_4_0] == nil then
			arg_4_0.itemList_[iter_4_0] = SpringFestivalRiddleMainItem.New(arg_4_0[string.format("riddleGo%s_", iter_4_0)], var_4_0, iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.itemList_) do
		iter_4_3:OnEnter()
	end

	arg_4_0:AddTimer()
	arg_4_0:AddRefreshTimer()
	SpringFestivalRiddleAction.HideRedPoint(var_4_0)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_UPDATE, arg_4_0.riddleUpdateHandler_)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, arg_4_0.riddleUpdateHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_UPDATE, arg_5_0.riddleUpdateHandler_)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, arg_5_0.riddleUpdateHandler_)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList_) do
		iter_5_1:OnExit()
	end

	arg_5_0:StopTimer()
	arg_5_0:StopRefreshTimer()

	arg_5_0.lightState_ = nil
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.riddleUpdateHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.itemList_ = {}
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalRiddleReward", {
			activityID = arg_7_0:GetActivityID()
		})
	end)
end

function var_0_0.GetActivityID(arg_9_0)
	return ActivityConst.SPRING_FESTIVAL_RIDDLE
end

function var_0_0.RefreshItemList(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList_) do
		iter_10_1:RefreshState(arg_10_1)
	end
end

function var_0_0.RefreshRiddle(arg_11_0)
	arg_11_0:AddRefreshTimer()
end

function var_0_0.CheckLightRiddle(arg_12_0)
	local var_12_0 = arg_12_0:GetActivityID()
	local var_12_1 = ActivityData:GetActivityData(var_12_0).stopTime
	local var_12_2 = manager.time:GetServerTime()

	if var_12_1 <= var_12_2 then
		arg_12_0.lightState_ = false

		arg_12_0:RefreshItemList(arg_12_0.lightState_)
		arg_12_0:StopRefreshTimer()

		return
	end

	local var_12_3 = SpringFestivalRiddleData:GetLastAnswerTime(var_12_0)
	local var_12_4 = var_12_3 + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60
	local var_12_5 = GameSetting.refresh_time1.value[1][1]
	local var_12_6 = manager.time:GetNextTime(var_12_5, 0, 0)

	if var_12_6 < var_12_4 then
		var_12_4 = var_12_6
	end

	local var_12_7
	local var_12_8

	if SpringFestivalRiddleData:CanAnswer(var_12_0) then
		if var_12_4 <= var_12_2 or var_12_6 - var_12_3 > 86400 then
			var_12_8 = true
		else
			var_12_8 = false
		end
	else
		var_12_8 = false
	end

	if arg_12_0.lightState_ ~= var_12_8 then
		arg_12_0.lightState_ = var_12_8

		arg_12_0:RefreshItemList(arg_12_0.lightState_)
	end
end

function var_0_0.AddRefreshTimer(arg_13_0)
	arg_13_0:StopRefreshTimer()
	arg_13_0:CheckLightRiddle()

	arg_13_0.refreshTimer_ = Timer.New(function()
		arg_13_0:CheckLightRiddle()
	end, 1, -1)

	arg_13_0.refreshTimer_:Start()
end

function var_0_0.StopRefreshTimer(arg_15_0)
	if arg_15_0.refreshTimer_ then
		arg_15_0.refreshTimer_:Stop()

		arg_15_0.refreshTimer_ = nil
	end
end

function var_0_0.AddTimer(arg_16_0)
	local var_16_0 = arg_16_0:GetActivityID()

	arg_16_0.stopTime_ = ActivityData:GetActivityData(var_16_0).stopTime

	arg_16_0:StopTimer()

	if manager.time:GetServerTime() >= arg_16_0.stopTime_ then
		arg_16_0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_16_0.timeText_.text = manager.time:GetLostTimeStr(arg_16_0.stopTime_)
	arg_16_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_16_0.stopTime_ then
			arg_16_0:StopTimer()

			arg_16_0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_16_0.timeText_.text = manager.time:GetLostTimeStr(arg_16_0.stopTime_)
	end, 1, -1)

	arg_16_0.timer_:Start()
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

return var_0_0
