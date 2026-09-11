local var_0_0 = class("DrawCardGameManager.MatchPointPerformanceState", (import("...StateBase")))

function var_0_0:Enter(arg_1_1)
	local var_1_0 = require("manager.posterGirl.tgame.DrawCardGame.States.Include").DrawCardState

	var_0_0.super.Enter(self, arg_1_1)

	arg_1_1.gameData.matchPoint = true

	arg_1_1.actors[2]:SetActive(true)
	arg_1_1.actors[2]:ChangeState({
		class = T0PosterGameTimelineState,
		args = {
			gameInst = arg_1_1
		}
	})
	arg_1_1:DoAction("game_chair_henshin_101", function()
		return
	end)
	arg_1_1:DoActionByActor(arg_1_1.actors[2], "game_chair_henshin_201", function()
		arg_1_1:SwapActor()
		arg_1_1:GoToState(var_1_0)
	end)
	arg_1_1:PlayTalk("game_chair_henshin")
end

function var_0_0:CanPlayNextAni()
	return true
end

return var_0_0
