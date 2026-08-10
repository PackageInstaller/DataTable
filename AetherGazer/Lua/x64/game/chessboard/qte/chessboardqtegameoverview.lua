local var_0_0 = class("ChessBoardQTEGameOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_QTEGameResultPopUI"
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

	arg_4_0.controller_ = arg_4_0.controllerexcollection_:GetController("winState")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		if arg_5_0.isCanClose then
			manager.ChessBoardManager:SetSmallGamePoint(0, arg_5_0.resultType)
			manager.ChessBoardManager:BattleFinish()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUi()

	arg_7_0.isCanClose = false
	arg_7_0.timer = Timer.New(function()
		arg_7_0.isCanClose = true
	end, 0.5)

	arg_7_0.timer:Start()
end

function var_0_0.RefreshUi(arg_9_0)
	arg_9_0.resultType = arg_9_0.params_.resultType
	arg_9_0.scoreValue = arg_9_0.params_.scoreValue
	arg_9_0.textscoreText_.text = arg_9_0.scoreValue

	if arg_9_0.resultType == ChessBoardQTEGameConst.QTEGameResult.Lose then
		arg_9_0.controller_:SetSelectedState("lose")
	elseif arg_9_0.resultType == ChessBoardQTEGameConst.QTEGameResult.Win then
		arg_9_0.controller_:SetSelectedState("win")
	else
		arg_9_0.controller_:SetSelectedState("perfect")
	end
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:StopTimer()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
