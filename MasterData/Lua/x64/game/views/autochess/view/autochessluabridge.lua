return {
	SetUpAutoChess = function()
		manager.uiInit()
		gameContext:SetSystemLayer("battle")
	end,
	OnStartGame = function()
		local var_2_0 = AutoChessData:GetCurGameType()

		AutoChessTools.GotoPrepareView(var_2_0, false, var_2_0 == AutoChessConst.GAME_TYPE.PVE)
	end,
	OnEndGame = function()
		gameContext:SetSystemLayer("home")
	end
}
