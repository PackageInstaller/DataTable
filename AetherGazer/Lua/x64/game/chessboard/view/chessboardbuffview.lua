local var_0_0 = class("ChessBoardBuffView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_StatusPopUI"
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

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cancelbtnBtn_, nil, function()
		gameContext:Go("/chessBoardHomeView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		gameContext:Go("/chessBoardHomeView")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.buffData_ = arg_8_0.params_.buffData
	arg_8_0.buffID = arg_8_0.buffData_:GetBuffPoolID()

	arg_8_0:Refresh()
end

function var_0_0.Refresh(arg_9_0)
	local var_9_0 = ChessBoardBuffPoolCfg[arg_9_0.buffID]

	arg_9_0.descText_.text = var_9_0.description
	arg_9_0.nameText_.text = var_9_0.name
	arg_9_0.iconImg_.sprite = ChessBoardTools.GetBuffImage(arg_9_0.buffID)

	local var_9_1 = arg_9_0.buffData_:GetRemainRound()

	if var_9_1 > 0 then
		SetActive(arg_9_0.remainRoundGo_, true)

		arg_9_0.remainRoundText_.text = string.format(GetTips("CHESSBOARD_BUFF_REMAINROUND"), var_9_1)
	else
		SetActive(arg_9_0.remainRoundGo_, false)
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
