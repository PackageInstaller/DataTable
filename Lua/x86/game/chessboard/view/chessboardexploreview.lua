local var_0_0 = class("ChessBoardExploreView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_ExplorePopUI"
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
	arg_5_0:AddBtnListener(arg_5_0.summer2024_redbtnBtn_, nil, function()
		ChessBoardTools.ChessBoardMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CHESSBOARD_CHOOSE_EXIT_MAP_CHECK"),
			OkCallback = function()
				ChessBoardTools.ExitChessBoardScene(false)
				ChessBoardAction.FinishCurrentBoard()
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cancelbtnBtn_, nil, function()
		ChessBoardTools.ExitChessBoardScene(false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		JumpTools.Back()

		if arg_5_0.blockState then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
		end
	end)
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:OnChessBoardBlockShow()
end

function var_0_0.OnChessBoardBlockShow(arg_11_0)
	arg_11_0.blockState = manager.ChessBoardManager.blockerManager_:CheckIsShowBlocker()

	if arg_11_0.blockState then
		manager.ChessBoardManager.blockerManager_:HideBlocker()
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:Refresh()
end

function var_0_0.Refresh(arg_13_0)
	local var_13_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

	arg_13_0.titleText_.text = ChessBoardLevelCfg[var_13_0].name_level

	local var_13_1 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_PROGRESS")
	local var_13_2 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_CURRENT_PROGRESS")
	local var_13_3 = math.min(var_13_2, var_13_1) / var_13_1

	arg_13_0.progressValueText_.text = math.floor(var_13_3 * 100)
	arg_13_0.sliexploreImg_.fillAmount = var_13_3
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
