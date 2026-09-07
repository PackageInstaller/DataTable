local NewYearShrinePage2023 = class("NewYearShrinePage2023", import(".NewYearShrinePage"))

NewYearShrinePage2023.GO_MINI_GAME_ID = 45
NewYearShrinePage2023.GO_BACKHILL_SCENE = SCENE.NEWYEAR_BACKHILL_2023

function NewYearShrinePage2023:OnFirstFlush()
	NewYearShrinePage2023.super.OnFirstFlush(self)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, NewYearShrinePage2023.GO_MINI_GAME_ID, {
			callback = function()
				local var_3_0 = Context.New()

				SCENE.SetSceneInfo(var_3_0, NewYearShrinePage2023.GO_BACKHILL_SCENE)
				getProxy(ContextProxy):PushContext2Prev(var_3_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

return NewYearShrinePage2023
