local NewYearShrinePage2024 = class("NewYearShrinePage2024", import(".NewYearShrinePage"))

NewYearShrinePage2024.GO_MINI_GAME_ID = 62
NewYearShrinePage2024.GO_BACKHILL_SCENE = SCENE.NEWYEAR_BACKHILL_2024

function NewYearShrinePage2024:OnFirstFlush()
	NewYearShrinePage2024.super.OnFirstFlush(self)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, NewYearShrinePage2024.GO_MINI_GAME_ID, {
			callback = function()
				local var_3_0 = Context.New()

				SCENE.SetSceneInfo(var_3_0, NewYearShrinePage2024.GO_BACKHILL_SCENE)
				getProxy(ContextProxy):PushContext2Prev(var_3_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

return NewYearShrinePage2024
