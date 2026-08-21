local var_0_0 = class("ActivityChessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityTools.GetUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonBtn_, nil, function()
		local var_5_0 = ActivityCfg[arg_4_0.activityID_].activity_theme

		for iter_5_0, iter_5_1 in ipairs(ActivityCfg.get_id_list_by_activity_theme[var_5_0]) do
			if ActivityCfg[iter_5_1].activity_template == ActivityConst.SUBMODULE_TYPE.TALENT_TREE then
				ActivityTools.JumpToSubmodulePage(iter_5_1)

				return
			end
		end

		error("不存在对应的天赋界面")
	end)
end

function var_0_0.InitBtns(arg_6_0)
	if not arg_6_0.chessView_ then
		arg_6_0.chessView_ = {}

		for iter_6_0, iter_6_1 in ipairs(WarchessLevelCfg.get_id_list_by_type[arg_6_0.activityID_]) do
			arg_6_0.chessView_[iter_6_1] = arg_6_0:GetChessItemView().New(arg_6_0[string.format("goStage%s_", iter_6_0)], iter_6_1)
		end
	end
end

function var_0_0.GetChessItemView(arg_7_0)
	return ActivityChessItem
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:InitBtns()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.chessView_) do
		iter_8_1:OnEnter()
	end

	arg_8_0.stopTime_ = ActivityData:GetActivityData(arg_8_0.activityID_).stopTime

	arg_8_0:AddTimer()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopTimer()
	manager.windowBar:HideBar()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.chessView_) do
		iter_9_1:OnExit()
	end
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.chessView_) do
		iter_10_1:Dispose()
	end

	arg_10_0.chessView_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddTimer(arg_11_0)
	if manager.time:GetServerTime() >= arg_11_0.stopTime_ then
		arg_11_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_11_0.textTime_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
	arg_11_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_11_0.stopTime_ then
			arg_11_0:StopTimer()

			arg_11_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_11_0.textTime_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
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
