return {
	SetUpEatSnake = function()
		manager.uiInit()
		gameContext:SetSystemLayer("battle")
	end,
	OnStartGame = function()
		JumpTools.OpenPageByJump("eatSnakesGame", {
			id = EatSnakeData:GetSelectId()
		})
	end,
	OnEndGame = function()
		gameContext:SetSystemLayer("home")
	end,
	OverGame = function()
		LaunchQWorld(true)
		manager.windowBar:SetWhereTag("qworld")
	end
}
