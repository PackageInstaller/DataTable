local var_0_0 = class("MatrixTreasureAtlasView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Prepare/MatrixTreasureAtlasUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	local var_3_0 = MatrixItemCfg.get_id_list_by_matrix_item_type[MatrixConst.ITEM_TYPE.TREASURE]

	arg_3_0.data = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if MatrixItemCfg[iter_3_1].show_altas then
			table.insert(arg_3_0.data, iter_3_1)
		end
	end

	table.sort(arg_3_0.data, function(arg_4_0, arg_4_1)
		local var_4_0 = MatrixItemCfg[arg_4_0]
		local var_4_1 = MatrixItemCfg[arg_4_1]

		if var_4_0.rare ~= var_4_1.rare then
			return var_4_0.rare > var_4_1.rare
		end

		return arg_4_0 < arg_4_1
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.list_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_list, MatrixTreasureAtlasItem)
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.list_:StartScroll(#arg_7_0.data)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.data[arg_9_1]

	arg_9_2:Refresh(var_9_0)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
