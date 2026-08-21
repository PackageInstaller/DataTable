local var_0_0 = class("YidaliV2framePage", import(".TemplatePage.PtTemplatePage"))

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

	arg_1_0.step = arg_1_0._tf:Find("AD/switcher/phase2/Image/step")
	arg_1_0.progress = arg_1_0._tf:Find("AD/switcher/phase2/Image/progress")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switch_btn")
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/Image/barContent/bar")
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
	setActive(arg_4_0.phases[1]:Find("Image"), false)
	setLocalPosition(go(arg_4_0.phases[1]), arg_4_0.phases[2].localPosition)
	setActive(arg_4_0.phases[1]:Find("label"), true)
	LeanTween.value(go(arg_4_0.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_5_0)
		var_4_0.alpha = arg_5_0

		return
	end))
	setActive(arg_4_0.phases[2]:Find("Image"), true)

	local var_4_1 = GetOrAddComponent(arg_4_0.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(arg_4_0.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_1.alpha = arg_6_0

		return
	end))
	setActive(arg_4_0.phases[2]:Find("label"), false)
	setLocalPosition(go(arg_4_0.phases[2]), arg_4_0.phases[1].localPosition)

	arg_4_0.isSwitching = nil
	arg_4_0.phases[1], arg_4_0.phases[2] = arg_4_0.phases[2], arg_4_0.phases[1]

	arg_4_0:UpdateAwardGot()

	return
end

function var_0_0.UpdateAwardGot(arg_7_0)
	local var_7_0 = not arg_7_0.ptData:CanGetNextAward() and arg_7_0.inPhase2

	setActive(arg_7_0.bg:Find("switcher/phase2/got"), var_7_0)
	setActive(arg_7_0.step, not var_7_0)
	setActive(arg_7_0.progress, not var_7_0)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	var_0_0.super.OnUpdateFlush(arg_8_0)

	local var_8_0 = isActive(arg_8_0.battleBtn) and pg.TimeMgr.GetInstance():inTime((arg_8_0.activity:getConfig("config_client")))

	setActive(arg_8_0.battleBtn, var_8_0)
	arg_8_0:UpdateAwardGot()

	local var_8_1, var_8_2, var_8_3 = arg_8_0.ptData:GetResProgress()
	local var_8_4 = var_8_3 >= 1 and setColorStr(var_8_1, COLOR_GREEN) or var_8_1

	setText(arg_8_0.step, var_8_4)
	setText(arg_8_0.progress, "/" .. var_8_2)
	setFillAmount(arg_8_0.bar, var_8_1 / var_8_2)

	return
end

return var_0_0
