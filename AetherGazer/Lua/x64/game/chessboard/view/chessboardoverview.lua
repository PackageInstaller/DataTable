local var_0_0 = class("ChessBoardOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_OverPopUI"
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
	ChessBoardLuaBridge.SetInputEnable(false)

	local var_5_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	arg_5_0.title_.text = string.format(GetTips("CHESSBOARD_FINISH_MAP"), GetI18NText(ChessBoardLevelCfg[ChessBoardData:GetCurrentPlayingChessBoardLevelID()].name_level))

	SetActive(arg_5_0.newMapText_.gameObject, false)

	local var_5_1 = ChessBoardLevelCfg[var_5_0]

	if var_5_1.next_level > 0 then
		local var_5_2 = var_5_1.next_level
		local var_5_3 = ChessBoardLevelCfg[var_5_2]

		if var_5_3.unlock_condition > 0 then
			local var_5_4 = HistoryData:GetHistoryData(var_5_3.unlock_condition)

			if var_5_4 == 0 or var_5_4 == nil then
				SetActive(arg_5_0.newMapText_.gameObject, true)

				arg_5_0.newMapText_.text = string.format(GetTips("CHESSBOARD_UNLOCK_NEW_MAP"), GetI18NText(var_5_3.name_level))
			end
		end
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		ChessBoardAction.FinishCurrentBoard(function()
			local var_8_0 = ChessBoardData:GetTemporaryData("urlParams")

			if var_8_0 and var_8_0.selectLevelID then
				var_8_0.selectLevelID = nil
			end

			ChessBoardData:SetTemporaryData("urlParams", var_8_0)
			ChessBoardTools.ExitChessBoardScene(false)
		end)
	end)
end

function var_0_0.OnExitInput(arg_9_0)
	ChessBoardAction.FinishCurrentBoard(function()
		local var_10_0 = ChessBoardData:GetTemporaryData("urlParams")

		if var_10_0 and var_10_0.selectLevelID then
			var_10_0.selectLevelID = nil
		end

		ChessBoardData:SetTemporaryData("urlParams", var_10_0)
		ChessBoardTools.ExitChessBoardScene(false)
	end)

	return true
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
