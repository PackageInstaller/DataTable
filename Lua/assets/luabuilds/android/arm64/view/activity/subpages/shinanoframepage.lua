local var_0_0 = class("ShinanoframePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.goBtn = arg_1_0.bg:Find("GoBtn")
	arg_1_0.getBtn = arg_1_0.bg:Find("GetBtn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("GotBtn")
	arg_1_0.switchBtn = arg_1_0.bg:Find("SwitchBtn")
	arg_1_0.phaseTF_1 = arg_1_0.bg:Find("Phase1")
	arg_1_0.phaseTF_2 = arg_1_0.bg:Find("Phase2")
	arg_1_0.gotTag = arg_1_0.bg:Find("Phase2/GotTag")
	arg_1_0.frameTF = arg_1_0.bg:Find("Phase2/Icon")
	arg_1_0.progressBar = arg_1_0.bg:Find("Phase2/Progress")
	arg_1_0.progressText = arg_1_0.bg:Find("Phase2/ProgressText")

	setActive(arg_1_0.goBtn, false)
	setActive(arg_1_0.getBtn, false)
	setActive(arg_1_0.gotBtn, false)
	setActive(arg_1_0.gotTag, false)
	setActive(arg_1_0.progressBar, false)
	setActive(arg_1_0.progressText, false)
	setActive(arg_1_0.phaseTF_2, false)

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
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		local var_5_0, var_5_1 = arg_3_0.ptData:GetResProgress()

		arg_3_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.switchBtn, function()
		setActive(arg_3_0.phaseTF_1, not isActive(arg_3_0.phaseTF_1))
		setActive(arg_3_0.phaseTF_2, not isActive(arg_3_0.phaseTF_2))

		return
	end, SFX_PANEL)
	setParent(LoadAndInstantiateSync("IconFrame", (tostring(arg_3_0.ptData.dropList[1][2]))), arg_3_0.frameTF, false)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SHINANO_EXP_ACT_ID)

	if not var_7_0 or var_7_0:isEnd() then
		setActive(arg_7_0.phaseTF_1, false)
		setActive(arg_7_0.phaseTF_2, true)

		local var_7_1, var_7_2, var_7_3 = arg_7_0.ptData:GetResProgress()

		setText(arg_7_0.progressText, var_7_1 .. "/" .. var_7_2)
		setSlider(arg_7_0.progressBar, 0, 1, var_7_3)
		setActive(arg_7_0.progressBar, true)
		setActive(arg_7_0.progressText, true)

		local var_7_4 = arg_7_0.ptData:CanGetAward()
		local var_7_5 = arg_7_0.ptData:CanGetNextAward()

		setActive(arg_7_0.goBtn, arg_7_0.ptData:CanGetMorePt() and not var_7_4 and var_7_5)
		setActive(arg_7_0.getBtn, var_7_4)
		setActive(arg_7_0.gotBtn, not var_7_5)
		setActive(arg_7_0.gotTag, not var_7_5)
	else
		setActive(arg_7_0.phaseTF_1, true)
		setActive(arg_7_0.phaseTF_2, false)

		local var_7_6, var_7_7, var_7_8 = arg_7_0.ptData:GetResProgress()

		setText(arg_7_0.progressText, var_7_6 .. "/" .. var_7_7)
		setSlider(arg_7_0.progressBar, 0, 1, var_7_8)
		setActive(arg_7_0.progressBar, true)
		setActive(arg_7_0.progressText, true)
	end

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
