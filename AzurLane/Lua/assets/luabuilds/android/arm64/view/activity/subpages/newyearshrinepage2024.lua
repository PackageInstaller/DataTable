local var_0_0 = class("NewYearShrinePage2024", import(".NewYearShrinePage"))

var_0_0.GO_MINI_GAME_ID = 62
var_0_0.GO_BACKHILL_SCENE = SCENE.NEWYEAR_BACKHILL_2024

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_0.GO_MINI_GAME_ID, {
			callback = function()
				local var_3_0 = Context.New()

				SCENE.SetSceneInfo(var_3_0, var_0_0.GO_BACKHILL_SCENE)
				getProxy(ContextProxy):PushContext2Prev(var_3_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

return var_0_0
