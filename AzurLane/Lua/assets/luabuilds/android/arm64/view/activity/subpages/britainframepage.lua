local var_0_0 = class("BritainframePage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	setActive(arg_1_0.displayBtn, false)
	setActive(arg_1_0.awardTF, false)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	arg_1_0.step = arg_1_0._tf:Find("AD/switcher/phase2/background/step")
	arg_1_0.progress = arg_1_0._tf:Find("AD/switcher/phase2/background/progress")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switcher/switch_btn")
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/background/barContent/bar")
	arg_1_0.phases = {
		arg_1_0._tf:Find("AD/switcher/phase1"),
		arg_1_0._tf:Find("AD/switcher/phase2")
	}
	arg_1_0.inPhase2 = false

	onToggle(arg_1_0, arg_1_0.switchBtn, function(arg_3_0)
		if arg_1_0.isSwitching then
			return
		end

		arg_1_0.inPhase2 = arg_3_0

		arg_1_0:Switch(arg_3_0)

		return
	end, SFX_PANEL)

	if pg.TimeMgr.GetInstance():inTime((arg_1_0.activity:getConfig("config_client"))) then
		triggerToggle(arg_1_0.switchBtn, true)
	end

	return
end

function var_0_0.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true

	local var_4_0 = GetOrAddComponent(arg_4_0.phases[1], typeof(CanvasGroup))

	arg_4_0.phases[2]:SetAsLastSibling()
	setActive(arg_4_0.phases[1]:Find("background"), false)
	LeanTween.moveLocal(go(arg_4_0.phases[1]), arg_4_0.phases[2].localPosition, 0.4)
	LeanTween.value(go(arg_4_0.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_5_0)
		var_4_0.alpha = arg_5_0

		return
	end))
	setActive(arg_4_0.phases[2]:Find("background"), true)

	local var_4_1 = GetOrAddComponent(arg_4_0.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(arg_4_0.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_1.alpha = arg_6_0

		return
	end))
	LeanTween.moveLocal(go(arg_4_0.phases[2]), arg_4_0.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		arg_4_0.isSwitching = nil
		arg_4_0.phases[1], arg_4_0.phases[2] = arg_4_0.phases[2], arg_4_0.phases[1]

		return
	end))
	arg_4_0:UpdateAwardGot()

	return
end

function var_0_0.UpdateAwardGot(arg_8_0)
	local var_8_0 = not arg_8_0.ptData:CanGetNextAward() and arg_8_0.inPhase2

	setActive(arg_8_0.bg:Find("switcher/phase2/background/got"), var_8_0)

	local var_8_1 = arg_8_0.bg:Find("switcher/phase2/background")

	setActive(var_8_1:Find("progress"), not var_8_0)
	setActive(var_8_1:Find("step"), not var_8_0)

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	var_0_0.super.OnUpdateFlush(arg_9_0)

	local var_9_0 = isActive(arg_9_0.battleBtn) and pg.TimeMgr.GetInstance():inTime((arg_9_0.activity:getConfig("config_client")))

	setActive(arg_9_0.battleBtn, var_9_0)
	arg_9_0:UpdateAwardGot()

	local var_9_1, var_9_2, var_9_3 = arg_9_0.ptData:GetResProgress()
	local var_9_4 = var_9_3 >= 1 and setColorStr(var_9_1, "#487CFFFF") or var_9_1

	setText(arg_9_0.step, var_9_4)
	setText(arg_9_0.progress, "/" .. var_9_2)
	setFillAmount(arg_9_0.bar, var_9_1 / var_9_2)

	return
end

return var_0_0
