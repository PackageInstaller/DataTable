local var_0_0 = class("ValentineGameLoadingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ValentineGameTools.GetLoadingUIName(arg_1_0.params_.activityId)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:StopTimer()

	arg_7_0.timer_ = TimeTools.StartAfterSeconds(GameDisplayCfg.activity_valentine_wait_time.value[1], function()
		JumpTools.OpenPageByJump("/valentineGame", {
			mainActivityID = arg_7_0.params_.mainActivityID,
			activityID = arg_7_0.params_.activityID
		})
	end, {})
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:StopTimer()

	arg_11_0.canvasGroup_.alpha = 0
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
