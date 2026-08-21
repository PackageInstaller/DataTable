local var_0_0 = class("DayNightCutSceneLoadingDay", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/DayNightCutSceneLoading_Day"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:StopTimer()

	arg_3_0.timer = Timer.New(function()
		arg_3_0:StopTimer()
		JumpTools.OpenPageByJump("/summerPubStageView")
	end, 6, 1)

	arg_3_0.timer:Start()
end

function var_0_0.StopTimer(arg_5_0)
	if arg_5_0.timer then
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:StopTimer()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
