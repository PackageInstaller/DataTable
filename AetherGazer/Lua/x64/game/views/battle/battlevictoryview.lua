local var_0_0 = class("BattleVictoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleVictory"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.bg_screen_ = arg_4_0:FindCom(typeof(Image), "bg_screen")
	arg_4_0.bg_screen_.enabled = false
	arg_4_0.mask_ = arg_4_0:FindCom(typeof(Button), "bg")
	arg_4_0.timer_ = Timer.New(function()
		arg_4_0.timer_:Stop()
		arg_4_0:Back()
		manager.newPlayerGuide:FinishStep()
	end, 1.5, 1)

	arg_4_0.timer_:Start()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.mask_, nil, function()
		arg_6_0.timer_:Stop()
		arg_6_0:Back()
		manager.newPlayerGuide:FinishStep()
	end)
end

function var_0_0.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
