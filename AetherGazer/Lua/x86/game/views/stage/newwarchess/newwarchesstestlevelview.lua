local var_0_0 = class("NewWarChessTestLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessEntryUI"
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

	arg_4_0.newChessList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, NewWarChessLevelItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = NewWarChessLevelCfg.all[arg_5_1]

	arg_5_2:SetData(var_5_0)
	arg_5_2:SetEventListener()
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_NEWWARCHESS_MOVEPOINT_PACKAGE
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_NEWWARCHESS_MOVEPOINT_PACKAGE, true)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.newChessList_:StartScroll(#NewWarChessLevelCfg.all)

	arg_8_0.tipsText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_RECOVER"), NewChessTools.GetNewWarChessGameSetting("new_warchess_recover")[1])
end

function var_0_0.OnNewWarChessLevelInfoUpdate(arg_9_0)
	arg_9_0.newChessList_:Refresh()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()

	local var_10_0 = arg_10_0.newChessList_:GetItemList()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		iter_10_1:RemoveEventListener()
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.newChessList_ then
		arg_11_0.newChessList_:Dispose()

		arg_11_0.newChessList_ = nil
	end

	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
