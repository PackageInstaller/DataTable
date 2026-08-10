local var_0_0 = class("SubPlotChessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return WarChessTools.GetSubPlotViewName(arg_1_0.params_.tag)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.InitBtns(arg_5_0)
	if not arg_5_0.chessView_ then
		arg_5_0.chessView_ = {}

		for iter_5_0, iter_5_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[arg_5_0.params_.tag]) do
			arg_5_0.chessView_[iter_5_1] = arg_5_0:GetChessItemView().New(arg_5_0[string.format("goStage%s_", iter_5_0)], iter_5_1)
		end
	end
end

function var_0_0.GetChessItemView(arg_6_0)
	return SubPlotChessItem
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_7_0:InitBtns()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.chessView_) do
		iter_7_1:OnEnter()
	end

	if arg_7_0.params_.chapterClientID == ChessConst.SUBPLOT_TAG.HELLA then
		SetActive(arg_7_0.timeGo_, false)
		SetActive(arg_7_0.buttonBtn_.gameObject, false)
	end
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.chessView_) do
		iter_9_1:Dispose()
	end

	arg_9_0.chessView_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
