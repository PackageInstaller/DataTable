local var_0_0 = class("ChessBoardBattleChanceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_PlayPopUI"
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
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		local var_6_0 = ChessBoardChanceCfg[arg_5_0.chanceID_]

		if var_6_0.play_start_story > 0 then
			manager.story:StartChessStoryWithBackground(var_6_0.play_start_story, function(arg_7_0)
				manager.ChessBoardManager:BattleStart(arg_5_0.chanceID_)
				ChessBoardTools.StartChanceGame(arg_5_0.chanceID_)
			end)
		else
			manager.ChessBoardManager:BattleStart(arg_5_0.chanceID_)
			ChessBoardTools.StartChanceGame(arg_5_0.chanceID_)
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.chanceID_ = arg_8_0.params_.chanceID

	local var_8_0 = ChessBoardChanceCfg[arg_8_0.chanceID_]

	arg_8_0.titleText_.text = var_8_0.params_title[1]
	arg_8_0.desText_.text = var_8_0.params_des[1]
	arg_8_0.taskText_.text = var_8_0.target_des

	ChessBoardLuaBridge.SetInputEnable(false)
end

function var_0_0.OnTop(arg_9_0)
	JumpTools.RefreshGaussianBg()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/chessBoardExploreView")
	end)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	ChessBoardLuaBridge.SetInputEnable(true)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
