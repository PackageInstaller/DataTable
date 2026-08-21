local var_0_0 = class("DeXiQianShaoPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	arg_1_0.awardTF = arg_1_0.bg:Find("switcher/phase2/Image/award")

	var_0_0.super.OnFirstFlush(arg_1_0)
	setActive(arg_1_0.displayBtn, false)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	arg_1_0.step = arg_1_0._tf:Find("AD/switcher/phase2/Image/step")
	arg_1_0.progress = arg_1_0._tf:Find("AD/switcher/phase2/Image/progress")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switcher/switch_btn")
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/Image/bar")
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
	LeanTween.moveLocal(go(arg_4_0.phases[1]), arg_4_0.phases[2].localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(arg_4_0.phases[1]:Find("label"), true)

		return
	end))
	LeanTween.value(go(arg_4_0.phases[1]), 1, 0, 0.4):setOnUpdate(System.Action_float(function(arg_6_0)
		var_4_0.alpha = arg_6_0

		return
	end)):setOnComplete(System.Action(function()
		var_4_0.alpha = 1

		setActive(arg_4_0.phases[1]:Find("Image"), false)

		return
	end))
	setActive(arg_4_0.phases[2]:Find("Image"), true)

	local var_4_1 = GetOrAddComponent(arg_4_0.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(arg_4_0.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_8_0)
		var_4_1.alpha = arg_8_0

		return
	end))
	setActive(arg_4_0.phases[2]:Find("label"), false)
	LeanTween.moveLocal(go(arg_4_0.phases[2]), arg_4_0.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		arg_4_0.isSwitching = nil
		arg_4_0.phases[1], arg_4_0.phases[2] = arg_4_0.phases[2], arg_4_0.phases[1]

		return
	end))
	arg_4_0:UpdateAwardGot()

	return
end

function var_0_0.UpdateAwardGot(arg_10_0)
	local var_10_0 = arg_10_0.ptData:CanGetAward()
	local var_10_1 = not arg_10_0.ptData:CanGetNextAward() and arg_10_0.inPhase2

	setActive(arg_10_0.bg:Find("switcher/phase2/got"), var_10_1)

	if var_10_1 or var_10_0 then
		setActive(arg_10_0.battleBtn, false)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	var_0_0.super.OnUpdateFlush(arg_11_0)
	setActive(arg_11_0.battleBtn, (pg.TimeMgr.GetInstance():inTime((arg_11_0.activity:getConfig("config_client")))))
	arg_11_0:UpdateAwardGot()

	local var_11_0, var_11_1, var_11_2 = arg_11_0.ptData:GetResProgress()
	local var_11_3 = var_11_2 >= 1 and setColorStr(var_11_0, "#487CFFFF") or var_11_0

	setText(arg_11_0.step, var_11_3)
	setText(arg_11_0.progress, "/" .. var_11_1)
	setFillAmount(arg_11_0.bar, var_11_0 / var_11_1)

	return
end

return var_0_0
