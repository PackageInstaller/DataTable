local var_0_0 = class("OtherWorldMainPage", import(".TemplatePage.PreviewTemplatePage"))
local var_0_1 = 0.45
local var_0_2 = 0.2
local var_0_3 = 1.2

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.effectBlankScreen = arg_1_0.bg:Find("blank_screen_effect")
	arg_1_0.effectOpen = arg_1_0.bg:Find("open_effect")
	arg_1_0.effectBlink = arg_1_0.bg:Find("blink_effect")
	arg_1_0.effectClick = arg_1_0.bg:Find("click_effect")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.skinshopBtn = arg_2_0.btnList:Find("skinshop")

	onButton(arg_2_0, arg_2_0.skinshopBtn, function()
		arg_2_0:PlayClickEffect(arg_2_0.skinshopBtn, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

			return
		end)

		return
	end, SFX_PANEL)

	arg_2_0.mountainBtn = arg_2_0.btnList:Find("mountain")

	onButton(arg_2_0, arg_2_0.mountainBtn, function()
		arg_2_0:PlayClickEffect(arg_2_0.mountainBtn, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_BACKHILL)

			return
		end)

		return
	end, SFX_PANEL)

	arg_2_0.buildBtn = arg_2_0.btnList:Find("build")

	onButton(arg_2_0, arg_2_0.buildBtn, function()
		arg_2_0:PlayClickEffect(arg_2_0.buildBtn, function()
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})

			return
		end)

		return
	end, SFX_PANEL)

	arg_2_0.fightBtn = arg_2_0.btnList:Find("fight")

	onButton(arg_2_0, arg_2_0.fightBtn, function()
		arg_2_0:PlayClickEffect(arg_2_0.fightBtn, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_MAP)

			return
		end)

		return
	end, SFX_PANEL)
	arg_2_0:PlayOpenEffect()

	return
end

function var_0_0.PlayOpenEffect(arg_11_0)
	setActive(arg_11_0.effectBlankScreen, true)
	setActive(arg_11_0.effectOpen, false)
	arg_11_0:managedTween(LeanTween.delayedCall, function()
		setActive(arg_11_0.effectOpen, true)

		return
	end, var_0_2, nil)
	arg_11_0:managedTween(LeanTween.delayedCall, function()
		setActive(arg_11_0.effectBlankScreen, false)

		return
	end, var_0_1, nil)
	arg_11_0:managedTween(LeanTween.delayedCall, function()
		setActive(arg_11_0.effectOpen, false)
		setActive(arg_11_0.effectBlink, true)

		return
	end, var_0_2 + var_0_3, nil)

	return
end

function var_0_0.PlayClickEffect(arg_15_0, arg_15_1, arg_15_2)
	local var_15_9000
	local var_15_0 = pg.UIMgr.GetInstance().OverlayEffect
	local var_15_1 = var_15_0.GetChild(var_15_9000, 0)
	local var_15_2 = var_15_1 and var_15_1.localPosition:Sub((Vector3(192, 60, 0))) or arg_15_1.localPosition

	setLocalPosition(arg_15_0.effectClick, var_15_0)
	setActive(arg_15_0.effectClick, true)
	arg_15_0:managedTween(LeanTween.delayedCall, function()
		setActive(arg_15_0.effectClick, false)

		if arg_15_2 then
			arg_15_2()
		end

		return
	end, 0.3, nil)

	return
end

function var_0_0.OnDestroy(arg_17_0)
	arg_17_0:cleanManagedTween()

	return
end

return var_0_0
