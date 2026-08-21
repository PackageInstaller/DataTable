local var_0_0 = class("ActivityMainBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
	arg_3_0:InitSubmoduleButton()
end

function var_0_0.InitSubmoduleButton(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_5_0:RefreshUI()

	for iter_5_0, iter_5_1 in pairs(arg_5_0.submoduleBtnList_) do
		iter_5_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.submoduleBtnList_) do
		iter_6_1:OnExit()
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.submoduleBtnList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.submoduleBtnList_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	return
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = ActivityData:GetActivityData(arg_9_0:GetActivityID())
	local var_9_1 = var_9_0.startTime
	local var_9_2 = var_9_0.stopTime

	arg_9_0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_9_1, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_9_2, "!%Y.%m.%d %H:%M"))
end

function var_0_0.GetActivityID(arg_10_0)
	return
end

function var_0_0.AddTimer(arg_11_0)
	local var_11_0 = arg_11_0:GetActivityID()

	arg_11_0.stopTime_ = ActivityData:GetActivityData(var_11_0).stopTime

	arg_11_0:StopTimer()

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
