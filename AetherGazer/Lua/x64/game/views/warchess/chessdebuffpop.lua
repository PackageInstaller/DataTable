local var_0_0 = class("ChessDebuffPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessDeBuffUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.showItem_ = ChessChooseItem.New(arg_4_0.battleflagitemGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
		manager.ChessManager:DoNextEvent()
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.showItem_:RefreshUI(1, arg_7_0.params_.data)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.data_ = arg_8_0.params_.data

	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.showItem_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
