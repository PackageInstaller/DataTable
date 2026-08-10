local var_0_0 = class("ArtifactView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummeDivinepersonalityUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddBtnListener(arg_3_0.startBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_ARTIFACT) then
			arg_3_0:Go("/artifactLevel")
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).stopTime then
			local var_4_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_4_0))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.stopTime_ = ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT).stopTime
	arg_6_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < arg_6_0.stopTime_ then
			arg_6_0.timeText_.text = manager.time:GetLostTimeStr(arg_6_0.stopTime_)
		else
			arg_6_0:StopTimer()

			arg_6_0.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, -1, 1)

	arg_6_0.timer_:Start()
	manager.redPoint:bindUIandKey(arg_6_0.startTrs_, string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT))
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SUMMER_ARTIFACT_DESCRIPE")
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_9_0.startTrs_, string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT))
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

return var_0_0
