MatrixScoreExchangeView = import("game.views.matrix.matrixScoreExchange.MatrixScoreExchangeView")

local var_0_0 = class("MatrixScoreExchangeMiniView", MatrixScoreExchangeView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeMiniUI"
end

function var_0_0.OnTop(arg_3_0)
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

function var_0_0.OnMatrixSystemOverdue(arg_5_0)
	return
end

return var_0_0
