SummerChessView = import("game.views.activity.Submodule.Chess.summer.SummerChessView")

local var_0_0 = class("SummerChessRemasteredView", SummerChessView)

function var_0_0.GetChessItemView(arg_1_0)
	return SummerChessRemasteredItem
end

function var_0_0.OnEnter(arg_2_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_2_0:InitBtns()

	for iter_2_0, iter_2_1 in pairs(arg_2_0.chessView_) do
		iter_2_1:OnEnter()
	end

	SetActive(arg_2_0.goTime_, false)
end

function var_0_0.InitBtns(arg_3_0)
	if not arg_3_0.chessView_ then
		arg_3_0.chessView_ = {}

		for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[arg_3_0.params_.tag]) do
			arg_3_0.chessView_[iter_3_1] = arg_3_0:GetChessItemView().New(arg_3_0[string.format("goStage%s_", iter_3_0)], iter_3_1)
		end
	end
end

function var_0_0.OnExit(arg_4_0)
	manager.windowBar:HideBar()

	for iter_4_0, iter_4_1 in pairs(arg_4_0.chessView_) do
		iter_4_1:OnExit()
	end
end

return var_0_0
