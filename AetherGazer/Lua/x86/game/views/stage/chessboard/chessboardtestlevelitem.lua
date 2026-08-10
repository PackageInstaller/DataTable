local var_0_0 = class("ChessBoardTestLevelItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.isOpen_ = false

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		local var_3_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

		if var_3_0 == 0 or var_3_0 == arg_2_0.chapterID_ then
			ChessBoardTools.EnterChessMap(arg_2_0.chapterID_)
		else
			ChessBoardTools.ChessBoardMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CHESSBOARD_ENTER_NEW_MAP"), ChessBoardLevelCfg[var_3_0].name_level),
				OkCallback = function()
					ChessBoardTools.EnterChessMap(arg_2_0.chapterID_)
				end
			})
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.chapterID_ = arg_5_1
	arg_5_0.cfg_ = ChessBoardLevelCfg[arg_5_1]

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.nametext_.text = arg_6_0.cfg_.name_level
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
