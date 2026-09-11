local var_0_0 = class("DrawCardGameManager.EnterState", (import("...StateBase")))

function var_0_0:Enter(arg_1_1)
	var_0_0.super.Enter(self, arg_1_1)
	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	JumpTools.OpenPageByJump("DanceGameView", {
		gameInst = arg_1_1
	})
	arg_1_1:DoAction("game_sofa_return_101", function()
		local var_2_0 = manager.notify:CallFirstUpdateFunc("OnEnterAnimationFinish", function()
			self:AfterCutscene(arg_1_1)
		end)
	end)
	arg_1_1:PlayTalk("game_sofa_return", "game_sofa_return_101")
end

function var_0_0:AfterCutscene(arg_4_1)
	local var_4_0 = manager.posterGirl.actor
	local var_4_1 = math.random(3)
	local Include = require("manager.posterGirl.tgame.DanceGame.States.Include")
	local var_4_3 = Include.PlayState

	arg_4_1:GoToState(Include.ActionState, "game_sofa_return_102", function()
		var_4_0:SetCameraParams(3)

		arg_4_1.randomIndex = var_4_1

		arg_4_1:InitGuideEffect()
		arg_4_1:GoToState(var_4_3, var_4_1)
	end, false)
	arg_4_1:PlayTalk("game_sofa_return", "game_sofa_return_102")

	arg_4_1.enter = true

	arg_4_1:SetZoomCam(manager.posterGirl.actor)
end

return var_0_0
