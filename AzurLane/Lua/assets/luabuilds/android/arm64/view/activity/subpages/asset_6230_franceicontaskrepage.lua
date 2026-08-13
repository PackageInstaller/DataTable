class = var_0_10000

local var_0_0 = "FranceIconTaskRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_1, "slider")

	local var_1_2 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_2, "step")

	local var_1_3 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_3, "progress")

	local var_1_4 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_4, "display_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_5, "award")

	local var_1_6 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_6, "battle_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_7, "get_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_8, "got_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.displayBtn, false)

	setActive = var_1

	var_1(arg_2_0.awardTF, false)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	local var_2_3 = arg_2_0._tf

	arg_2_0.step = var_1.Find(var_2_3, "AD/switcher/phase2/Image/step")

	local var_2_4 = arg_2_0._tf

	arg_2_0.progress = var_1.Find(var_2_4, "AD/switcher/phase2/Image/progress")

	local var_2_5 = arg_2_0._tf

	arg_2_0.switchBtn = var_1.Find(var_2_5, "AD/switcher/switch_btn")

	local var_2_6 = arg_2_0._tf

	arg_2_0.bar = var_1.Find(var_2_6, "AD/switcher/phase2/Image/barContent/bar")

	local var_2_7 = {}
	local var_2_8 = arg_2_0._tf

	var_2_7[1] = var_2.Find(var_2_8, "AD/switcher/phase1")

	local var_2_9 = arg_2_0._tf

	var_2_7[2] = var_2.Find(var_2_9, "AD/switcher/phase2")
	arg_2_0.phases = var_2_7
	arg_2_0.inPhase2 = false
	onToggle = var_1

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.switchBtn

	local function var_2_12(arg_4_0)
		if arg_2_0.isSwitching then
			return
		end

		arg_2_0.inPhase2 = arg_4_0

		local var_4_0 = arg_2_0

		var_1.Switch(var_4_0, arg_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_10, var_2_11, var_2_12, var_1_10006)

	pg = var_1

	local var_2_13 = var_1.activity_event_avatarframe
	local var_2_14 = arg_2_0.activity
	local var_2_15 = var_2_13[var_2.getConfig(var_2_14, "config_id")].start_time

	pg = var_2

	local var_2_16 = var_2.TimeMgr.GetInstance()
	local var_2_17 = var_2.Table2ServerTime(var_2_16, {
		year = var_2_15[1][1],
		month = var_2_15[1][2],
		day = var_2_15[1][3],
		hour = var_2_15[2][1],
		min = var_2_15[2][2],
		sec = var_2_15[2][3]
	})

	pg = var_2_10

	local var_2_18 = var_2_10.TimeMgr.GetInstance()

	arg_2_0.inTime = var_3.GetServerTime(var_2_18) - var_2_17 > 0
	setActive = var_3

	local var_2_19 = arg_2_0.battleBtn

	isActive = var_6

	local var_2_20

	if var_6(arg_2_0.battleBtn) then
		var_2_20 = arg_2_0.inTime
	end

	var_3(var_2_19, var_2_20)

	if arg_2_0.inTime then
		triggerToggle = var_3

		var_3(arg_2_0.switchBtn, true)
	end

	return
end

function var_0_1.Switch(arg_5_0, arg_5_1)
	arg_5_0.isSwitching = true
	GetOrAddComponent = var_2

	local var_5_0 = arg_5_0.phases[1]

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_5_1 = var_2(var_5_0, var_1_10005(var_1_10007))
	local var_5_2 = arg_5_0.phases[1].localPosition
	local var_5_3 = arg_5_0.phases[2].localPosition
	local var_5_4 = arg_5_0.phases[2]

	var_5.SetAsLastSibling(var_5_4)

	setActive = var_5

	local var_5_5 = arg_5_0.phases[1]

	var_5(var_7.Find(var_5_5, "Image"), false)

	LeanTween = var_5

	local var_5_6 = var_5.moveLocal

	go = var_7

	local var_5_7 = var_5_6(var_7(arg_5_0.phases[1]), var_5_3, 0.4)
	local var_5_8 = var_5.setOnComplete

	System = var_8

	var_5_8(var_5_7, var_8.Action(function()
		setActive = var_2_10000

		local var_6_0 = arg_5_0.phases[1]

		var_2_10000(var_2.Find(var_6_0, "label"), true)

		return
	end))

	LeanTween = var_5_8

	local var_5_9 = var_5_8.value

	go = var_5_7

	local var_5_10 = var_5_9(var_5_7(arg_5_0.phases[1]), 0, 1, 0.4)
	local var_5_11 = var_5.setOnUpdate

	System = var_8

	var_5_11(var_5_10, var_8.Action_float(function(arg_7_0)
		var_5_1.alpha = arg_7_0

		return
	end))

	setActive = var_5_11

	local var_5_12 = arg_5_0.phases[2]

	var_5_11(var_7.Find(var_5_12, "Image"), true)

	GetOrAddComponent = var_5_11

	local var_5_13 = arg_5_0.phases[2]

	typeof = var_8
	CanvasGroup = var_10

	local var_5_14 = var_5_11(var_5_13, var_8(var_10))

	LeanTween = var_1_10006

	local var_5_15 = var_1_10006.value

	go = var_8

	local var_5_16 = var_5_15(var_8(arg_5_0.phases[2]), 0, 1, 0.4)
	local var_5_17 = var_6.setOnUpdate

	System = var_9

	var_5_17(var_5_16, var_9.Action_float(function(arg_8_0)
		var_5_14.alpha = arg_8_0

		return
	end))

	setActive = var_5_17

	local var_5_18 = arg_5_0.phases[2]

	var_5_17(var_8.Find(var_5_18, "label"), false)

	LeanTween = var_5_17

	local var_5_19 = var_5_17.moveLocal

	go = var_8

	local var_5_20 = var_5_19(var_8(arg_5_0.phases[2]), var_5_2, 0.4)
	local var_5_21 = var_6.setOnComplete

	System = var_9

	var_5_21(var_5_20, var_9.Action(function()
		arg_5_0.isSwitching = nil
		arg_5_0.phases[1], arg_5_0.phases[2] = arg_5_0.phases[2], arg_5_0.phases[1]

		return
	end))
	arg_5_0:UpdateAwardGot()

	onButton = var_6

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.getBtn

	local function var_5_24()
		local var_10_0 = arg_5_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_5_0.activity.id
		})

		return
	end

	SFX_PANEL = var_11

	var_6(var_5_22, var_5_23, var_5_24, var_11)

	return
end

function var_0_1.UpdateAwardGot(arg_11_0)
	local var_11_0 = arg_11_0.activity.data2 >= 1
	local var_11_1 = arg_11_0._tf
	local var_11_2 = var_2.Find(var_11_1, "AD/switcher/phase2/got")

	setActive = var_1_10003

	var_1_10003(var_11_2, var_11_0)

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	local var_12_0 = arg_12_0.activity

	setActive = var_1_10002

	local var_12_1 = arg_12_0.battleBtn

	isActive = var_1_10005

	local var_12_2

	if var_1_10005(arg_12_0.battleBtn) then
		var_12_2 = arg_12_0.inTime
	end

	var_1_10002(var_12_1, var_12_2)
	arg_12_0:UpdateAwardGot()

	local var_12_3 = arg_12_0.activity.data1

	pg = var_1_10003

	local var_12_4 = var_1_10003.activity_event_avatarframe
	local var_12_5 = arg_12_0.activity

	if var_12_4[var_4.getConfig(var_12_5, "config_id")].target < var_12_3 then
		var_12_3 = var_3
	end

	local var_12_6 = var_12_3 / var_3

	setText = var_12_2

	local var_12_7 = arg_12_0.step

	if 1 <= var_12_6 then
		setColorStr = var_8

		local var_12_8

		if not var_8(var_12_3, "#487CFFFF") then
			var_12_8 = var_12_3
		end

		var_12_2(var_12_7, var_12_8)

		setText = var_12_2

		var_12_2(arg_12_0.progress, "/" .. var_3)

		setFillAmount = var_12_2

		var_12_2(arg_12_0.bar, var_12_3 / var_3)

		local var_12_9 = var_3 <= var_12_3
		local var_12_10 = arg_12_0.activity.data2
		local var_12_11 = 1 <= var_12_10

		setActive = var_7

		var_7(arg_12_0.battleBtn, not var_12_11 and not var_12_9 and arg_12_0.inTime)

		setActive = var_7

		var_7(arg_12_0.getBtn, var_12_9 and not var_12_11)

		setActive = var_7

		var_7(arg_12_0.gotBtn, var_12_11)

		return
	end
end

return var_0_1
