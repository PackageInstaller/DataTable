local var_0_0 = import("...StateBase")
local var_0_1 = class("GuelGameAcion.EnterState", var_0_0)

function var_0_1.Enter(arg_1_0, arg_1_1)
	var_0_1.super.Enter(arg_1_0, arg_1_1)

	local var_1_0 = require("manager.posterGirl.tgame.GuelGame.States.Include")

	manager.notify:Invoke(HOME_BTN_VISIBE, false)
	arg_1_1:DoAction("game_tv_enter_101", function()
		manager.posterGirl:SetStateCanChange(false)

		local var_2_0 = manager.posterGirl:GetCurrentState()

		gameContext:Go("GuelGameSeclectView", {
			endGame = false
		})
	end, true)
end

return var_0_1
