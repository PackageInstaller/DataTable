local var_0_0 = class("ValentineGameV2GameStartView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineStarUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.timer_ = Timer.New(function()
		arg_4_0:StopTimer()
		JumpTools.OpenPageByJump("/valentineGameV2HeroAnswerView", {
			activityID = arg_4_0.activityID_
		})
	end, 3, 1)

	arg_4_0.timer_:Start()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:StopTimer()
end

function var_0_0.StopTimer(arg_7_0)
	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:StopTimer()
	arg_8_0.super.Dispose(arg_8_0)
end

return var_0_0
