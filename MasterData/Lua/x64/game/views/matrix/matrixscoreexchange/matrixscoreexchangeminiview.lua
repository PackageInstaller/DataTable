MatrixScoreExchangeView = import("game.views.matrix.matrixScoreExchange.MatrixScoreExchangeView")

local MatrixScoreExchangeMiniView = class("MatrixScoreExchangeMiniView", MatrixScoreExchangeView)

function MatrixScoreExchangeMiniView:UIBackCount()
	return 3
end

function MatrixScoreExchangeMiniView:UIName()
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeMiniUI"
end

function MatrixScoreExchangeMiniView:OnTop()
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

function MatrixScoreExchangeMiniView:OnMatrixSystemOverdue()
	return
end

return MatrixScoreExchangeMiniView
