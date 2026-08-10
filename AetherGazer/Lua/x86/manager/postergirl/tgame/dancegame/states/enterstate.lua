local var_0_0 = import("...StateBase")
local var_0_1 = class("DrawCardGameManager.EnterState", var_0_0)

function var_0_1.Enter(arg_1_0, arg_1_1)
	var_0_1.super.Enter(arg_1_0, arg_1_1)

	local var_1_0 = manager.posterGirl.actor

	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	JumpTools.OpenPageByJump("DanceGameView", {
		gameInst = arg_1_1
	})
	arg_1_1:DoAction("game_sofa_return_101", function()
		local var_2_0 = manager.notify:CallFirstUpdateFunc("OnEnterAnimationFinish", function()
			arg_1_0:AfterCutscene(arg_1_1)
		end)
	end)
	arg_1_1:PlayTalk("game_sofa_return", "game_sofa_return_101")
end

function var_0_1.AfterCutscene(arg_4_0, arg_4_1)
	local var_4_0 = manager.posterGirl.actor
	local var_4_1 = math.random(3)
	local var_4_2 = require("manager.posterGirl.tgame.DanceGame.States.Include")
	local var_4_3 = var_4_2.PlayState
	local var_4_4 = var_4_2.ActionState

	arg_4_1:GoToState(var_4_4, "game_sofa_return_102", function()
		var_4_0:SetCameraParams(3)

		arg_4_1.randomIndex = var_4_1

		arg_4_1:InitGuideEffect()
		arg_4_1:GoToState(var_4_3, var_4_1)
	end, false)
	arg_4_1:PlayTalk("game_sofa_return", "game_sofa_return_102")

	arg_4_1.enter = true

	arg_4_1:SetZoomCam(var_4_0)
end

return var_0_1
