local var_0_0 = import("game.views.matrix.matrixPrepare.MatrixSelectBeaconItem")
local var_0_1 = class("MatrixTreasureMiniView", ReduxView)

function var_0_1.UIBackCount(arg_1_0)
	return 3
end

function var_0_1.UIName(arg_2_0)
	return "UI/Matrix/Prepare/MatrixBeaconMiniUI"
end

function var_0_1.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.list_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexBeaconItem), arg_5_0.m_list, var_0_0)
	arg_5_0.stateController_ = ControllerUtil.GetController(arg_5_0.transform_, "state")
end

function var_0_1.OnTop(arg_6_0)
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

function var_0_1.OnEnter(arg_8_0)
	arg_8_0.beaconData = MatrixData:GetUseBeaconList()

	local var_8_0 = #arg_8_0.beaconData

	arg_8_0.list_:StartScroll(var_8_0)
	arg_8_0.stateController_:SetSelectedIndex(var_8_0 == 0 and 1 or 0)
end

function var_0_1.IndexBeaconItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.beaconData[arg_9_1]

	arg_9_2:Refresh(var_9_0)
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0.list_:Dispose()
	var_0_1.super.Dispose(arg_10_0)
end

return var_0_1
