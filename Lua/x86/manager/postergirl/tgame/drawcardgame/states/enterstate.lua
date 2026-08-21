local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.EnterState", var_0_0)

function var_0_1.Enter(arg_1_0, arg_1_1)
	var_0_1.super.Enter(arg_1_0, arg_1_1)

	local var_1_0 = require("manager.posterGirl.tgame.DrawCardGame.States.Include").DrawCardState

	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	JumpTools.OpenPageByJump("DrawCardT0GameView")
	arg_1_1:DoAction("game_chair_enter_101", function()
		arg_1_1:GoToState(var_1_0)
	end, false)
	arg_1_1:PlayTalk("game_chair_enter")
end

return var_0_1
