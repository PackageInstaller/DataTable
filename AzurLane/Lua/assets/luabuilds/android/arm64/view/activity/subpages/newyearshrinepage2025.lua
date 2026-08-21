local var_0_0 = class("NewYearShrinePage2025", import(".NewYearShrinePage"))

var_0_0.GO_MINI_GAME_ID = 71

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_0.GO_MINI_GAME_ID, {})

		return
	end, SFX_PANEL)

	return
end

return var_0_0
