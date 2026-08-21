local var_0_0 = class("RyzaMainRePage", import("view.activity.CorePage.CorePreviewTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	arg_1_0.gameBtn = arg_1_0.btnList:Find("activity")
	arg_1_0.fightBtn = arg_1_0.btnList:Find("fight")
	arg_1_0.shopBtn = arg_1_0.btnList:Find("shop")

	onButton(arg_1_0, arg_1_0.gameBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 43)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.fightBtn, function()
		arg_1_0:emit(ActivityMediator.SKIP_ACTIVITY_MAP, 50042)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.shopBtn, function()
		arg_1_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
			actId = 50052,
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end, SFX_PANEL)

	return
end

return var_0_0
