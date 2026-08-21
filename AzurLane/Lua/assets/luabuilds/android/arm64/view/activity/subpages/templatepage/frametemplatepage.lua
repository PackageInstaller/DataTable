local var_0_0 = class("FrameTemplatePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switch_btn")
	arg_1_0.phases = {
		arg_1_0._tf:Find("AD/switcher/phase1"),
		arg_1_0._tf:Find("AD/switcher/phase2")
	}
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/Image/barContent/bar")
	arg_1_0.step = arg_1_0._tf:Find("AD/switcher/phase2/Image/step")
	arg_1_0.progress = arg_1_0._tf:Find("AD/switcher/phase2/Image/progress")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		arg_2_0.ptData:Update(arg_2_0.activity)
	else
		arg_2_0.ptData = ActivityPtData.New(arg_2_0.activity)
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		local var_5_0 = arg_3_0.ptData:GetAward()

		if var_5_0.type == DROP_TYPE_RESOURCE and var_5_0.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_5_0.count) then
			table.insert({}, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			local var_7_0, var_7_1 = arg_3_0.ptData:GetResProgress()

			arg_3_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.ptData:GetId(),
				arg1 = var_7_1
			})

			return
		end)

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.switchBtn, function(arg_8_0)
		if arg_3_0.isSwitching then
			return
		end

		arg_3_0.inPhase2 = arg_8_0

		arg_3_0:Switch(arg_8_0)

		return
	end, SFX_PANEL)

	local var_3_0 = pg.TimeMgr.GetInstance():inTime((arg_3_0.activity:getConfig("config_client")))

	setActive(arg_3_0.battleBtn, var_3_0)

	arg_3_0.inPhase2 = var_3_0

	if var_3_0 then
		triggerToggle(arg_3_0.switchBtn, true)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	setActive(arg_9_0.getBtn, (arg_9_0.ptData:CanGetAward()))
	setActive(arg_9_0.gotBtn, not arg_9_0.ptData:CanGetNextAward())

	local var_9_0, var_9_1, var_9_2 = arg_9_0.ptData:GetResProgress()
	local var_9_3 = var_9_2 >= 1 and setColorStr(var_9_0, COLOR_GREEN) or var_9_0

	setText(arg_9_0.step, var_9_3)
	setText(arg_9_0.progress, "/" .. var_9_1)
	setFillAmount(arg_9_0.bar, var_9_0 / var_9_1)
	arg_9_0:UpdateAwardGot()

	return
end

function var_0_0.Switch(arg_10_0, arg_10_1)
	arg_10_0.isSwitching = true

	local var_10_0 = GetOrAddComponent(arg_10_0.phases[1], typeof(CanvasGroup))

	arg_10_0.phases[2]:SetAsLastSibling()
	setActive(arg_10_0.phases[1]:Find("Image"), false)
	LeanTween.moveLocal(go(arg_10_0.phases[1]), arg_10_0.phases[2].localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(arg_10_0.phases[1]:Find("label"), true)

		return
	end))
	LeanTween.value(go(arg_10_0.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_12_0)
		var_10_0.alpha = arg_12_0

		return
	end))
	setActive(arg_10_0.phases[2]:Find("Image"), true)

	local var_10_1 = GetOrAddComponent(arg_10_0.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(arg_10_0.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_13_0)
		var_10_1.alpha = arg_13_0

		return
	end))
	setActive(arg_10_0.phases[2]:Find("label"), false)
	LeanTween.moveLocal(go(arg_10_0.phases[2]), arg_10_0.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		arg_10_0.isSwitching = nil
		arg_10_0.phases[1], arg_10_0.phases[2] = arg_10_0.phases[2], arg_10_0.phases[1]

		return
	end))
	arg_10_0:UpdateAwardGot()

	return
end

function var_0_0.UpdateAwardGot(arg_15_0)
	local var_15_0 = not arg_15_0.ptData:CanGetNextAward() and arg_15_0.inPhase2

	setActive(arg_15_0.bg:Find("switcher/phase2/got"), var_15_0)

	if var_15_0 then
		setActive(arg_15_0.battleBtn, false)
	end

	return
end

function var_0_0.OnDestroy(arg_16_0)
	return
end

return var_0_0
