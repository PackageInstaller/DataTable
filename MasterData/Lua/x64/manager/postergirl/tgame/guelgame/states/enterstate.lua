local var_0_0 = class("GuelGameAcion.EnterState", (import("...StateBase")))

function var_0_0:Enter(arg_1_1)
	var_0_0.super.Enter(self, arg_1_1)

	local Include = require("manager.posterGirl.tgame.GuelGame.States.Include")

	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	arg_1_1:DoAction("game_tv_enter_101", function()
		manager.posterGirl:SetStateCanChange(false)

		local var_2_0 = manager.posterGirl:GetCurrentState()

		gameContext:Go("GuelGameSeclectView", {
			endGame = false
		})
	end, true)
end

return var_0_0
