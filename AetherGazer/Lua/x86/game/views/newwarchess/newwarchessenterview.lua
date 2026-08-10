local var_0_0 = class("NewWarChessEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessGo"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.timer_ = Timer.New(function()
		arg_4_0:StopTimer()

		if NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN") == 0 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_START, {})
			manager.NewChessManager:StartExecuteEvent()
		end

		gameContext:Go("/newWarChessHome")
	end, 1.2, 1)

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
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
