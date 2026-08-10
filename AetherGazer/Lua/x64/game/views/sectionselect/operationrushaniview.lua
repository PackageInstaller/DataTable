local var_0_0 = class("OperationRushAniView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BattleResult/Common/BattleResultRushAnimeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.timer_ = Timer.New(function()
		if arg_5_0.params_.callBack then
			arg_5_0.params_.callBack()
		end

		arg_5_0:StopTimer()
	end, 1.1, 1)

	arg_5_0.timer_:Start()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:StopTimer()
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.AddUIListener(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
	arg_10_0:StopTimer()
end

return var_0_0
