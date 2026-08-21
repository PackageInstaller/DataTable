local var_0_0 = class("OsirisChessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisConnectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.chessView_ = {}

	for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_type[ActivityConst.OSIRIS_CHESS]) do
		arg_3_0.chessView_[iter_3_1] = OsirisChessBtnView.New(arg_3_0[string.format("goStage%s_", iter_3_0)], iter_3_1)
	end
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_4_0, iter_4_1 in pairs(arg_4_0.chessView_) do
		iter_4_1:OnEnter()
	end

	arg_4_0.stopTime_ = ActivityData:GetActivityData(ActivityConst.OSIRIS_CHESS).stopTime

	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in pairs(arg_5_0.chessView_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.chessView_) do
		iter_6_1:Dispose()
	end

	arg_6_0.chessView_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.AddTimer(arg_8_0)
	if manager.time:GetServerTime() >= arg_8_0.stopTime_ then
		arg_8_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_8_0.textTime_.text = manager.time:GetLostTimeStr(arg_8_0.stopTime_)
	arg_8_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_8_0.stopTime_ then
			arg_8_0:StopTimer()

			arg_8_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_8_0.textTime_.text = manager.time:GetLostTimeStr(arg_8_0.stopTime_)
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

return var_0_0
