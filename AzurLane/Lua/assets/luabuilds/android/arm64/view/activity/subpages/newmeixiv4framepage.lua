class = var_0_10000

local var_0_0 = "NewMeixiV4framePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	setActive = var_1

	var_1(arg_1_0.displayBtn, false)

	setActive = var_1

	var_1(arg_1_0.awardTF, false)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	local var_1_3 = arg_1_0._tf

	arg_1_0.step = var_1.Find(var_1_3, "AD/switcher/phase2/Image/step")

	local var_1_4 = arg_1_0._tf

	arg_1_0.progress = var_1.Find(var_1_4, "AD/switcher/phase2/Image/progress")

	local var_1_5 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_5, "AD/switch_btn")

	local var_1_6 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_6, "AD/switcher/phase2/Image/barContent/bar")

	local var_1_7 = {}
	local var_1_8 = arg_1_0._tf

	var_1_7[1] = var_2.Find(var_1_8, "AD/switcher/phase1")

	local var_1_9 = arg_1_0._tf

	var_1_7[2] = var_2.Find(var_1_9, "AD/switcher/phase2")
	arg_1_0.phases = var_1_7
	arg_1_0.inPhase2 = false
	onToggle = var_1

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.switchBtn

	local function var_1_12(arg_3_0)
		if arg_1_0.isSwitching then
			return
		end

		arg_1_0.inPhase2 = arg_3_0

		local var_3_0 = arg_1_0

		var_1.Switch(var_3_0, arg_3_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_10, var_1_11, var_1_12, var_1_10006)

	local var_1_13 = arg_1_0.activity
	local var_1_14 = var_1.getConfig(var_1_13, "config_client")

	pg = var_2

	local var_1_15 = var_2.TimeMgr.GetInstance()

	if var_2.inTime(var_1_15, var_1_14) then
		triggerToggle = var_1_13

		var_1_13(arg_1_0.switchBtn, true)
	end

	return
end

function var_0_1.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true
	GetOrAddComponent = var_2

	local var_4_0 = arg_4_0.phases[1]

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_4_1 = var_2(var_4_0, var_1_10005(var_1_10007))
	local var_4_2 = arg_4_0.phases[1].localPosition
	local var_4_3 = arg_4_0.phases[2].localPosition
	local var_4_4 = arg_4_0.phases[2]

	var_5.SetAsLastSibling(var_4_4)

	setActive = var_5

	local var_4_5 = arg_4_0.phases[1]

	var_5(var_7.Find(var_4_5, "Image"), false)

	setLocalPosition = var_5
	go = var_7

	var_5(var_7(arg_4_0.phases[1]), var_4_3)

	setActive = var_5

	local var_4_6 = arg_4_0.phases[1]

	var_5(var_7.Find(var_4_6, "label"), true)

	LeanTween = var_5

	local var_4_7 = var_5.value

	go = var_7

	local var_4_8 = var_4_7(var_7(arg_4_0.phases[1]), 0, 1, 0.4)
	local var_4_9 = var_5.setOnUpdate

	System = var_8

	var_4_9(var_4_8, var_8.Action_float(function(arg_5_0)
		var_4_1.alpha = arg_5_0

		return
	end))

	setActive = var_4_9

	local var_4_10 = arg_4_0.phases[2]

	var_4_9(var_7.Find(var_4_10, "Image"), true)

	GetOrAddComponent = var_4_9

	local var_4_11 = arg_4_0.phases[2]

	typeof = var_8
	CanvasGroup = var_10

	local var_4_12 = var_4_9(var_4_11, var_8(var_10))

	LeanTween = var_1_10006

	local var_4_13 = var_1_10006.value

	go = var_8

	local var_4_14 = var_4_13(var_8(arg_4_0.phases[2]), 0, 1, 0.4)
	local var_4_15 = var_6.setOnUpdate

	System = var_9

	var_4_15(var_4_14, var_9.Action_float(function(arg_6_0)
		var_4_12.alpha = arg_6_0

		return
	end))

	setActive = var_4_15

	local var_4_16 = arg_4_0.phases[2]

	var_4_15(var_8.Find(var_4_16, "label"), false)

	setLocalPosition = var_4_15
	go = var_8

	var_4_15(var_8(arg_4_0.phases[2]), var_4_2)

	arg_4_0.isSwitching = nil
	arg_4_0.phases[1], arg_4_0.phases[2] = arg_4_0.phases[2], arg_4_0.phases[1]

	arg_4_0:UpdateAwardGot()

	return
end

function var_0_1.UpdateAwardGot(arg_7_0)
	local var_7_0 = arg_7_0.bg
	local var_7_1 = var_1.Find(var_7_0, "switcher/phase2/got")
	local var_7_2 = arg_7_0.ptData
	local var_7_3 = not var_2.CanGetNextAward(var_7_2) and arg_7_0.inPhase2

	setActive = var_7_0

	var_7_0(var_7_1, var_7_3)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	var_0_1.super.OnUpdateFlush(arg_8_0)

	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_1.getConfig(var_8_0, "config_client")

	pg = var_3

	local var_8_2 = var_3.TimeMgr.GetInstance()
	local var_8_3 = var_3.inTime(var_8_2, var_8_1)

	setActive = var_8_0

	local var_8_4 = arg_8_0.battleBtn

	isActive = var_1_10007

	local var_8_5

	if var_1_10007(arg_8_0.battleBtn) then
		var_8_5 = var_8_3
	end

	var_8_0(var_8_4, var_8_5)
	arg_8_0:UpdateAwardGot()

	local var_8_6 = arg_8_0.ptData
	local var_8_7, var_8_8, var_8_9 = var_4.GetResProgress(var_8_6)

	setText = var_8_5

	local var_8_10 = arg_8_0.step

	if 1 <= var_8_9 then
		setColorStr = var_10

		local var_8_11

		if not var_10(var_8_7, "#92C1F1FF") then
			var_8_11 = var_8_7
		end

		var_8_5(var_8_10, var_8_11)

		setText = var_8_5

		var_8_5(arg_8_0.progress, "/" .. var_8_8)

		setFillAmount = var_8_5

		var_8_5(arg_8_0.bar, var_8_7 / var_8_8)

		return
	end
end

return var_0_1
