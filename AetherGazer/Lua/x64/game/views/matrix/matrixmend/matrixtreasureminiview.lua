local var_0_0 = class("MatrixTreasureMiniView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/Matrix/Prepare/MatrixTreasureMiniUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
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
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.data = arg_8_0:GetArtifactList()

	table.sort(arg_8_0.data, function(arg_9_0, arg_9_1)
		local var_9_0 = MatrixItemCfg[arg_9_0.id]
		local var_9_1 = MatrixItemCfg[arg_9_1.id]

		if var_9_0.rare ~= var_9_1.rare then
			return var_9_0.rare > var_9_1.rare
		end

		return arg_9_0.id < arg_9_1.id
	end)

	local var_8_0 = #arg_8_0.data

	arg_8_0.list_:StartScroll(var_8_0)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.data[arg_10_1].id
	local var_10_1 = arg_10_0.data[arg_10_1].wins

	arg_10_2:Refresh(var_10_0, var_10_1)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.GetArtifactList(arg_12_0)
	return MatrixData:GetArtifactList()
end

return var_0_0
