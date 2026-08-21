local var_0_0 = class("WarChessLog", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessLog"
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

	arg_4_0.scrollHelper = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.viewportGo_, ChessLogItem)
end

function var_0_0.UpdateData(arg_5_0)
	arg_5_0.itemList_ = {}

	for iter_5_0, iter_5_1 in ipairs(WarChessData:GetLogs()) do
		arg_5_0.itemList_[iter_5_0] = iter_5_1.log
	end
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_1, arg_6_0.itemList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateData()
	arg_9_0.scrollHelper:StartScroll(#arg_9_0.itemList_)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
