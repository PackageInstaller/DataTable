local var_0_0 = class("AutoChessPVPMatchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_matchPanel"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListener()

	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.matchSuccessHandler_ = handler(arg_4_0, arg_4_0.OnMatchSuccess)
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnStop_, nil, function()
		AutoChessMatchAction.StopMatch()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.expectTimeText_.text = manager.time:DescCDTime4(arg_7_0.params_.expectTime)

	arg_7_0:StartMatchTimer()
	manager.notify:RegistListener(AUTO_CHESS_MATCH_SUCCESS, arg_7_0.matchSuccessHandler_)
end

function var_0_0.OnTop(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	AutoChessData:SetIsInMatch(false)
	manager.notify:RemoveListener(AUTO_CHESS_MATCH_SUCCESS, arg_9_0.matchSuccessHandler_)
	arg_9_0:CloseTimer()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:CloseTimer()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.StartMatchTimer(arg_11_0)
	local var_11_0, var_11_1 = AutoChessData:GetIsInMatch()

	if not var_11_0 or not var_11_1 then
		return
	end

	local var_11_2 = manager.time:GetServerTime() - var_11_1

	arg_11_0.matchTimeText_.text = manager.time:DescCDTime4(var_11_2)

	arg_11_0.statusController_:SetSelectedIndex(0)

	arg_11_0.matchTimer_ = Timer.New(function()
		local var_12_0, var_12_1 = AutoChessData:GetIsInMatch()

		if not var_12_0 or not var_12_1 or manager.time:GetServerTime() - var_12_1 < 0 then
			arg_11_0:CloseTimer()
		else
			manager.net:ForceReconnect()

			var_11_2 = manager.time:GetServerTime() - var_12_1
			arg_11_0.matchTimeText_.text = manager.time:DescCDTime4(var_11_2)
		end
	end, 1, -1)

	arg_11_0.matchTimer_:Start()
end

function var_0_0.OnMatchSuccess(arg_13_0)
	local var_13_0 = 3
	local var_13_1 = 3

	if not isNil(arg_13_0.enterTimeText_) then
		arg_13_0.enterTimeText_.text = var_13_0
	end

	arg_13_0.statusController_:SetSelectedIndex(1)

	arg_13_0.matchSuccessTimer_ = Timer.New(function()
		if not isNil(arg_13_0.enterTimeText_) then
			var_13_0 = var_13_0 - 1
			arg_13_0.enterTimeText_.text = var_13_0
		end
	end, 1, var_13_1)

	arg_13_0.matchSuccessTimer_:Start()
end

function var_0_0.CloseTimer(arg_15_0)
	if arg_15_0.matchTimer_ then
		arg_15_0.matchTimer_:Stop()

		arg_15_0.matchTimer_ = nil
	end

	if arg_15_0.matchSuccessTimer_ then
		arg_15_0.matchSuccessTimer_:Stop()

		arg_15_0.matchSuccessTimer_ = nil
	end
end

return var_0_0
