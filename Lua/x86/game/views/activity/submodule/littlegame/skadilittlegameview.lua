local var_0_0 = class("SkadiLittleGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerSkadiGameUI"
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
		JumpTools.OpenPageByJump("skadiGameReward")
	end)
end

function var_0_0.InitBtns(arg_6_0)
	if not arg_6_0.itemView_ then
		arg_6_0.itemView_ = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityCfg[arg_6_0.activityID_].sub_activity_list) do
			arg_6_0.itemView_[iter_6_1] = SkadiLittleGameItem.New(arg_6_0[string.format("item%dGo_", iter_6_0)], iter_6_1, arg_6_0.activityID_)
		end
	end
end

function var_0_0.OnTop(arg_7_0)
	local var_7_0 = ActivityTools.GetGameHelpKey(arg_7_0.activityID_)

	if var_7_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_7_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = ActivityConst.SIKADI_GAME

	arg_8_0:InitBtns()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.itemView_) do
		iter_8_1:OnEnter()
	end

	arg_8_0.stopTime_ = ActivityData:GetActivityData(arg_8_0.activityID_).stopTime
	arg_8_0.detailText_.text = GetTips("ACTIVITY__CROSSWAVE_CONTENT")

	arg_8_0:AddTimer()
	manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_LEVEL, 0)
	manager.redPoint:bindUIandKey(arg_8_0.buttonBtn_.transform, RedPointConst.SKADI_LITTLE_GAME_REWARD)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopTimer()
	manager.windowBar:HideBar()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.itemView_) do
		iter_9_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(arg_9_0.buttonBtn_.transform, RedPointConst.SKADI_LITTLE_GAME_REWARD)
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.itemView_) do
		iter_10_1:Dispose()
	end

	arg_10_0.itemView_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddTimer(arg_11_0)
	if manager.time:GetServerTime() >= arg_11_0.stopTime_ then
		arg_11_0.remainText_.text = GetTips("TIME_OVER")

		return
	end

	arg_11_0.remainText_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
	arg_11_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_11_0.stopTime_ then
			arg_11_0:StopTimer()

			arg_11_0.remainText_.text = GetTips("TIME_OVER")

			return
		end

		arg_11_0.remainText_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
	end, 0.5, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

return var_0_0
