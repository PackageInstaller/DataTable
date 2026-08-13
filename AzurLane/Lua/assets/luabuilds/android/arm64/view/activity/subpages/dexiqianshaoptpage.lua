class = var_0_10000

local var_0_0 = "DeXiQianShaoPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	local var_1_0 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_0, "switcher/phase2/Image/award")

	var_0_1.super.OnFirstFlush(arg_1_0)

	setActive = var_1

	var_1(arg_1_0.displayBtn, false)

	onButton = var_1

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.battleBtn

	local function var_1_3()
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

	var_1(var_1_1, var_1_2, var_1_3, var_1_10006)

	local var_1_4 = arg_1_0._tf

	arg_1_0.step = var_1.Find(var_1_4, "AD/switcher/phase2/Image/step")

	local var_1_5 = arg_1_0._tf

	arg_1_0.progress = var_1.Find(var_1_5, "AD/switcher/phase2/Image/progress")

	local var_1_6 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_6, "AD/switcher/switch_btn")

	local var_1_7 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_7, "AD/switcher/phase2/Image/bar")

	local var_1_8 = {}
	local var_1_9 = arg_1_0._tf

	var_1_8[1] = var_2.Find(var_1_9, "AD/switcher/phase1")

	local var_1_10 = arg_1_0._tf

	var_1_8[2] = var_2.Find(var_1_10, "AD/switcher/phase2")
	arg_1_0.phases = var_1_8
	arg_1_0.inPhase2 = false
	onToggle = var_1

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.switchBtn

	local function var_1_13(arg_3_0)
		if arg_1_0.isSwitching then
			return
		end

		arg_1_0.inPhase2 = arg_3_0

		local var_3_0 = arg_1_0

		var_1.Switch(var_3_0, arg_3_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_11, var_1_12, var_1_13, var_1_10006)

	local var_1_14 = arg_1_0.activity
	local var_1_15 = var_1.getConfig(var_1_14, "config_client")

	pg = var_2

	local var_1_16 = var_2.TimeMgr.GetInstance()

	if var_2.inTime(var_1_16, var_1_15) then
		triggerToggle = var_1_14

		var_1_14(arg_1_0.switchBtn, true)
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

	LeanTween = var_5

	local var_4_5 = var_5.moveLocal

	go = var_4_4

	local var_4_6 = var_4_5(var_4_4(arg_4_0.phases[1]), var_4_3, 0.4)
	local var_4_7 = var_5.setOnComplete

	System = var_8

	var_4_7(var_4_6, var_8.Action(function()
		setActive = var_2_10000

		local var_5_0 = arg_4_0.phases[1]

		var_2_10000(var_2.Find(var_5_0, "label"), true)

		return
	end))

	LeanTween = var_4_7

	local var_4_8 = var_4_7.value

	go = var_4_6

	local var_4_9 = var_4_8(var_4_6(arg_4_0.phases[1]), 1, 0, 0.4)
	local var_4_10 = var_5.setOnUpdate

	System = var_8

	local var_4_11 = var_4_10(var_4_9, var_8.Action_float(function(arg_6_0)
		var_4_1.alpha = arg_6_0

		return
	end))
	local var_4_12 = var_5.setOnComplete

	System = var_8

	var_4_12(var_4_11, var_8.Action(function()
		local var_7_0 = var_4_1

		var_7_0.alpha = 1
		setActive = var_7_0

		local var_7_1 = arg_4_0.phases[1]

		var_7_0(var_2.Find(var_7_1, "Image"), false)

		return
	end))

	setActive = var_4_12

	local var_4_13 = arg_4_0.phases[2]

	var_4_12(var_7.Find(var_4_13, "Image"), true)

	GetOrAddComponent = var_4_12

	local var_4_14 = arg_4_0.phases[2]

	typeof = var_8
	CanvasGroup = var_10

	local var_4_15 = var_4_12(var_4_14, var_8(var_10))

	LeanTween = var_1_10006

	local var_4_16 = var_1_10006.value

	go = var_8

	local var_4_17 = var_4_16(var_8(arg_4_0.phases[2]), 0, 1, 0.4)
	local var_4_18 = var_6.setOnUpdate

	System = var_9

	var_4_18(var_4_17, var_9.Action_float(function(arg_8_0)
		var_4_15.alpha = arg_8_0

		return
	end))

	setActive = var_4_18

	local var_4_19 = arg_4_0.phases[2]

	var_4_18(var_8.Find(var_4_19, "label"), false)

	LeanTween = var_4_18

	local var_4_20 = var_4_18.moveLocal

	go = var_8

	local var_4_21 = var_4_20(var_8(arg_4_0.phases[2]), var_4_2, 0.4)
	local var_4_22 = var_6.setOnComplete

	System = var_9

	var_4_22(var_4_21, var_9.Action(function()
		arg_4_0.isSwitching = nil
		arg_4_0.phases[1], arg_4_0.phases[2] = arg_4_0.phases[2], arg_4_0.phases[1]

		return
	end))
	arg_4_0:UpdateAwardGot()

	return
end

function var_0_1.UpdateAwardGot(arg_10_0)
	local var_10_0 = arg_10_0.bg
	local var_10_1 = var_1.Find(var_10_0, "switcher/phase2/got")
	local var_10_2 = arg_10_0.ptData
	local var_10_3 = var_2.CanGetAward(var_10_2)
	local var_10_4 = arg_10_0.ptData
	local var_10_5 = not var_3.CanGetNextAward(var_10_4) and arg_10_0.inPhase2

	setActive = var_10_2

	var_10_2(var_10_1, var_10_5)

	if var_10_5 or var_10_3 then
		setActive = var_10_2

		var_10_2(arg_10_0.battleBtn, false)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	var_0_1.super.OnUpdateFlush(arg_11_0)

	local var_11_0 = arg_11_0.activity
	local var_11_1 = var_1.getConfig(var_11_0, "config_client")

	pg = var_3

	local var_11_2 = var_3.TimeMgr.GetInstance()
	local var_11_3 = var_3.inTime(var_11_2, var_11_1)

	setActive = var_11_0

	var_11_0(arg_11_0.battleBtn, var_11_3)
	arg_11_0:UpdateAwardGot()

	local var_11_4 = arg_11_0.ptData
	local var_11_5, var_11_6, var_11_7 = var_4.GetResProgress(var_11_4)

	setText = var_7

	local var_11_8 = arg_11_0.step

	if 1 <= var_11_7 then
		setColorStr = var_10

		local var_11_9

		if not var_10(var_11_5, "#487CFFFF") then
			var_11_9 = var_11_5
		end

		var_7(var_11_8, var_11_9)

		setText = var_7

		var_7(arg_11_0.progress, "/" .. var_11_6)

		setFillAmount = var_7

		var_7(arg_11_0.bar, var_11_5 / var_11_6)

		return
	end
end

return var_0_1
