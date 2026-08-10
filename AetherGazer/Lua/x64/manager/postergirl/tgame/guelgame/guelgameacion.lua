local var_0_0 = import("..T0GameManagerBase")
local var_0_1 = class("GuelGameAcion", var_0_0)
local var_0_2 = import(".States.Include")

function var_0_1.Init(arg_1_0)
	arg_1_0.gameData = {}
	arg_1_0.exit = false

	manager.windowBar:HideBar()
	arg_1_0:GoToState(var_0_2.EnterState)
end

function var_0_1.Reset(arg_2_0)
	arg_2_0.gameData = nil

	arg_2_0:RemoveAllStateEvents()
end

function var_0_1.StartGame()
	var_0_0.StartGameImpl(var_0_1)
end

local var_0_3 = {
	[GuelGameManager.GameResult.Win] = "game_tv_lose",
	[GuelGameManager.GameResult.Lose] = "game_tv_win"
}

function var_0_1.ExitGame(arg_4_0)
	local var_4_0 = manager.posterGirl.actor
	local var_4_1 = var_0_3[arg_4_0]

	if var_4_0 then
		local var_4_2 = var_4_0:GetCurrentState()

		if var_4_2.gameInst and not var_4_2.gameInst.exit then
			var_4_2.gameInst:GoToState(var_0_2.ExitState, var_4_1)
		end
	end
end

return var_0_1
